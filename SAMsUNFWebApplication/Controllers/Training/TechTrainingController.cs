using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace SAMsUNFWebApplication.Controllers.Training
{
    [Authorize]
    public class TechTrainingController : Controller
    {
        // GET: TechTraining
        public ActionResult TechTraining()
        {
            return View();
        }
     }
}