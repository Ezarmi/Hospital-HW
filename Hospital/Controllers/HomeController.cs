using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Hospital.Models;
using System.Web.Mvc;

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

        public ActionResult getdep()
        {
            var dep = context.tbl_Skills.Select(x => new {x.pkID,x.Skill}).ToList();

            return Json(dep, JsonRequestBehavior.AllowGet);
        }
        public ActionResult getdocs(int dep)
        {
            var docs =context.tbl_Doctors.Where(x=> x.fkSkill==dep).Select(x=> new { x.pkID, x.Name, x.Family }).ToList();

            return Json(docs, JsonRequestBehavior.AllowGet);
        }
    }
}