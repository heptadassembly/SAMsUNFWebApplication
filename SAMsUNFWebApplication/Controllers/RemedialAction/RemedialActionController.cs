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
using Dapper;

namespace SAMsUNFWebApplication.Controllers.School
{
    public class RemedialActionController : Controller
    {
        // GET: School
        public ActionResult Index()
        {
            return View();
        }
        public async System.Threading.Tasks.Task<ActionResult> RemedialAction()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new RemedialActionRepository(connection).GetRemedialActions();
                //var result2 = await new GradeRepository(connection).GetGrades();
                return View(result);
            }
        }
        public async System.Threading.Tasks.Task<ActionResult> GetRemedialAction(string id)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new RemedialActionRepository(connection).GetRemedialAction(id);
                return View(result);
            }
        }
        public System.Web.Mvc.RedirectResult CreateRemedialAction(string RemedialActionName)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new RemedialActionRepository(connection).CreateRemedialAction(RemedialActionName);
                if (result == "success")
                {
                    return Redirect("RemedialAction/RemedialAction/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("RemedialAction/RemedialAction/?error=invalidfile");
                }
            }
        }

        public System.Web.Mvc.RedirectResult EditRemedialAction(string RemedialActionID, string RemedialActionName)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new RemedialActionRepository(connection).EditRemedialAction(RemedialActionID, RemedialActionName);
                if (result == "success")
                {
                    return Redirect("RemedialAction/RemedialAction/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("RemedialAction/RemedialAction/?error=invalidfile");
                }
            }
        }
    }
}