using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Hospital.Models;
using System.Web.Mvc;

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

        [HttpPost]
        public ActionResult getdep()
        {
            var dep = context.tbl_Skills.Select(x => new { x.pkID, x.Skill }).ToList();

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

        public ActionResult getvisits()
        {
            var visits = context.View_Visit.ToList();
            return Json(visits, JsonRequestBehavior.AllowGet);
        }

        public ActionResult login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login_check(int pn, string pass)
        {
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
}