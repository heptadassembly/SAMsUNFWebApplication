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
    [Authorize]
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
        public ActionResult CreateSchool()
        {
            return View();
        }
        public ActionResult GetSchool()
        {
            return View();
        }
        public ActionResult EditSchool()
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

        public ActionResult Contact()
        {
            return View();
        }

        public ActionResult EditContact()
        {
            return View();
        }

        public ActionResult AddContact()
        {
            return View();
        }

        public ActionResult HomeRoom()
        {
            return View();
        }

        public ActionResult AddHomeRoom()
        {
            return View();
        }
        public ActionResult EditHomeRoom()
        {
            return View();
        }

        public ActionResult Profile()
        {
            return View();
        }
        public ActionResult AddProfile()
        {
            return View();
        }
        public ActionResult EditProfile()
        {
            return View();
        }
       
        public ActionResult RemedialAction()
        {
            return View();
        }
        public ActionResult CreateRemedialAction()
        {
            return View();
        }


    }
}