using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Hospital.Models;
using System.Web.Mvc;
using System.Globalization;

using System.Text;
using System.Web.Security;

namespace Hospital.Controllers
{
    public class HomeController : Controller
    {
        hdata context = new hdata();

        // GET: Home
        public ActionResult Index()
        {
            int docs = context.tbl_Doctors.Count();
            int dep = context.tbl_Skills.Count();
            int awards = context.tbl_Awards.Count();
            int research = context.tbl_Research.Count();

            ViewBag.docs = docs;
            ViewBag.dep = dep;
            ViewBag.awards = awards;
            ViewBag.research = research;


            return View();
        }

        public ActionResult getVisitTypes()
        {
            var visittype_3 = context.tbl_VisitType.Where(x => x.pkID !=null).Select(x => new {x.pkID, x.Type}).ToList();


            return Json(visittype_3, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult getdep()
        {
            var dep = context.tbl_Skills.Where(x=> x.pkID!=6).Select(x=> new {x.pkID, x.Skill}).ToList();

            return Json(dep, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult getdocs(int dep)
        {
            var docs = context.tbl_Doctors.Where(x => x.fkSkill == dep).Select(x => new { x.pkID, x.Name, x.Family }).ToList();

            return Json(docs, JsonRequestBehavior.AllowGet);
        }
        public ActionResult getvisit(int doc)
        {
            var visit = context.View_Visit.Where(x => x.fkDocID == doc && x.fkPID == null).Select(x => new { x.pkID, x.PDate, x.PTime }).ToList();

            return Json(visit, JsonRequestBehavior.AllowGet);
        }

        public ActionResult setvisit(int vn, string namee, string phone, string family)
        {
            var c = context.tbl_Visit.Where(x => x.pkID == vn).SingleOrDefault();

            int statee = 0;

            if (c.fkPID == null)
            {

                int pid = 0;
                var p = context.tbl_Patient.Where(x => x.Mobile == phone).SingleOrDefault();

                if (p == null)
                {
                    tbl_Patient newp = new tbl_Patient();

                    newp.Name = namee;
                    newp.Family = family;
                    newp.Mobile = phone;

                    context.tbl_Patient.Add(newp);
                    context.SaveChanges();

                    var np = context.tbl_Patient.Where(x => x.Mobile == phone).SingleOrDefault();
                    pid = np.pkID;
                }
                else
                {
                    pid = p.pkID;
                }

                var v = context.tbl_Visit.Where(x => x.pkID == vn).SingleOrDefault();

                v.fkPID = pid;
                v.fkVTID = 1;
                v.EDate = v.SDate.AddMinutes(20);

                context.SaveChanges();
                statee = 2; //نوبت دهی انجام شد
            }
            else
            {
                statee = 1; //نوبت پر است
            }

            return Json(statee, JsonRequestBehavior.AllowGet);

        }

        public ActionResult recept()
        {
            //Session.Timeout = 60;
            ViewBag.title = Hospital.res.res1.m_dashbord;
            return View();
        }
        public ActionResult visit_management()
        {
            ViewBag.title = Hospital.res.res1.m_visit;
            return View();
        }

        public ActionResult login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login_check(int pn, string pass)
        {
            Session.Timeout = 30;
            int status = 0;
            var user = context.tbl_Doctors.Where(x => x.PersonalNum == pn).SingleOrDefault();
            if (user != null)
            {
                if (user.Password == pass)
                {
                    // Session["userid"] = user.pkID;

                        var cookieText = Encoding.UTF8.GetBytes(user.pkID.ToString());
                        var encryptedValue = Convert.ToBase64String(MachineKey.Protect(cookieText, "alirezaomg"));

                    Response.Cookies["iid"].Value = encryptedValue;
                    Response.Cookies["iid"].Expires = DateTime.Now.AddDays(500);

                    status = 1;//login ok
                }
                else
                {
                    status = 2;//wrong pass
                }
            }
            else
            {
                status = 3; //dosen't match pn
            }
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getvisits()
        {
            var visits = context.View_Visit.ToList();

            foreach (var item in visits)
            {
                var idText = Encoding.UTF8.GetBytes(item.pkID.ToString());
                var encryptedID = Convert.ToBase64String(MachineKey.Protect(idText, "alirezaomg"));
                item.hashid = encryptedID;
            }

            return Json(visits, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getstatus()
        {
            var status=context.tbl_VisitStatus.Select(x=> new {x.pkID, x.VisitStatus}).ToList();

            return Json(status, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult setstatus(int state, string sid)
        {
            var bytes = Convert.FromBase64String(sid);
            var output = MachineKey.Unprotect(bytes, "alirezaomg");
            string result = Encoding.UTF8.GetString(output);

            int id = int.Parse(result);

            int status = 0;

            string sname = "";
            var visit = context.tbl_Visit.Where(x => x.pkID == id).SingleOrDefault();
            if (visit != null)
            {
                visit.fkVisitStatus= state;
                context.SaveChanges();
                status = 1; //ok

                sname=context.tbl_VisitStatus.Where(x=> x.pkID == state).Select(x=> x.VisitStatus).SingleOrDefault();
            }
            return Json(new { status = status, sname = sname }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult removevisit(string vid)
        {
            var bytes = Convert.FromBase64String(vid);
            var output = MachineKey.Unprotect(bytes, "alirezaomg");
            string result = Encoding.UTF8.GetString(output);

            int id=int.Parse(result);
            var visit = context.tbl_Visit.Where(x => x.pkID == id).SingleOrDefault();

            context.tbl_Visit.Remove(visit);
            context.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult addvisit(int docid, int visitid, string visitdatetime, string pid)
        {
            int intpid = 0;

            if (pid != "")
            {
                var p = context.tbl_Patient.Where(x => x.NationalCode == pid).SingleOrDefault();
                if (p == null)
                {
                    return Json(new { status = 2, nv = 0 }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    intpid = p.pkID;
                }
            }

            string[] vdatetime = visitdatetime.Split(' ');
            string[] vdate = vdatetime[0].Split('/');
            string[] vtime = vdatetime[1].Split(':');

            int y = MyExtensions.PersianToEnglish(vdate[0]);
            int m = MyExtensions.PersianToEnglish(vdate[1]);
            int d = MyExtensions.PersianToEnglish(vdate[2]);
            int h = MyExtensions.PersianToEnglish(vtime[0]);
            int min = MyExtensions.PersianToEnglish(vtime[1]);

            PersianCalendar pc = new PersianCalendar();

            DateTime a = pc.ToDateTime(y, m, d, h, min, 0, 0);

            double duration = context.View_VisitPerDoctors.Where(x => x.fkDocID == docid && x.fkVisitID == visitid).Select(x => x.Duration).Single();

            tbl_Visit nv = new tbl_Visit();

            nv.fkDocID = docid;
            nv.SDate = a;
            nv.EDate = a.AddMinutes(duration);
            if (pid == "")
            {
                nv.fkPID = null;
            }
            else
            {
                nv.fkPID = intpid;
            }
            nv.fkVTID = visitid;
            nv.fkVisitStatus = 1;

            context.tbl_Visit.Add(nv);
            context.SaveChanges();

            var thisvisit = context.View_Visit.Where(x => x.fkDocID == docid && x.SDate == nv.SDate && x.EDate == nv.EDate).SingleOrDefault();

            var idtext = Encoding.UTF8.GetBytes(thisvisit.pkID.ToString());
            var encryptedID = Convert.ToBase64String(MachineKey.Protect(idtext, "alirezaomg"));

            return Json(new { status = 1, nv = thisvisit }, JsonRequestBehavior.AllowGet);
        }

        public void logout()
        {
            Response.Cookies["iid"].Expires = DateTime.Now.AddDays(-1);
            Session.Abandon();

            Response.Redirect("/Home/index");
        }

        public void setname()
        {
            var bytes = Convert.FromBase64String(Request.Cookies["iid"].Value);
            var output = MachineKey.Unprotect(bytes, "alirezaomg");
            string result = Encoding.UTF8.GetString(output);

            int userid = int.Parse(result);

            var user=context.tbl_Doctors.Where(x=> x.pkID == userid).SingleOrDefault();

            Session["username"] = user.Name + " " + user.Family;
        }



    }

    // This class will convert unicod to ASCII
    public static class MyExtensions
    {
        public static int PersianToEnglish (this string persianStr)
        {
            Dictionary<char, char> LettersDictionary = new Dictionary<char, char>
            {
                ['۰'] = '0',
                ['۱'] = '1',
                ['۲'] = '2',
                ['۳'] = '3',
                ['۴'] = '4',
                ['۵'] = '5',
                ['۶'] = '6',
                ['۷'] = '7',
                ['۸'] = '8',
                ['۹'] = '9',
            };
            foreach(var item in persianStr)
            {
                persianStr = persianStr.Replace(item, LettersDictionary[item]);
            }
            return int.Parse(persianStr);
        }
    }
}