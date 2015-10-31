using System.Web.Mvc;

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
        public ActionResult Create()
        {
            return View();
        }
    }
}