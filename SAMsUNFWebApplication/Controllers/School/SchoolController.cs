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
    public class SchoolController : Controller
    {
        [Authorize]
        // GET: School
        public ActionResult Index()
        {
            return View();
        }
        public async System.Threading.Tasks.Task<ActionResult> School()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new SchoolRepository(connection).GetSchools();
                return View(result);
            }
        }
        public async System.Threading.Tasks.Task<ActionResult> GetSchool(string id)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new SchoolRepository(connection).GetSchool(id);
                return View(result);
            }
        }
        public System.Web.Mvc.RedirectResult CreateSchool(string SchoolName)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new SchoolRepository(connection).CreateSchool(SchoolName);
                if (result == "success")
                {
                    return Redirect("School/School/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("School/School/?error=invalidfile");
                }
            }
        }

        public System.Web.Mvc.RedirectResult EditSchool(string SchoolID, string SchoolName)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new SchoolRepository(connection).EditSchool(SchoolID, SchoolName);
                if (result == "success")
                {
                    return Redirect("School/School/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("School/School/?error=invalidfile");
                }
            }
        }
    }
}