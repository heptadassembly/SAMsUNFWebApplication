using System.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CsvHelper;
using System.IO;

namespace SAMsUNFWebApplication.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Dashboard()
        {
            return View();
        }
        public ActionResult CodeOfConductViolation()
        {
            return View();
        }
        public ActionResult CreateCOCV()
        {
            return View();
        }
        public ActionResult OfficeVisit()
        {
            return View();
        }

        public ActionResult Student()
        {
            return View();
        }

        public ActionResult AddStudent()
        {
            return View();
        }

        public ActionResult EditStudent()
        {
            return View();
        }
        public ActionResult Import()
        {
            return View();
        }
    }
}