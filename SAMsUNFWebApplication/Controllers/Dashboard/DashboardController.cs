using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;

namespace SAMsUNFWebApplication.Controllers.Dashboard
{
    public class DashboardController : Controller
    {
        // GET: Dashboard
        public ActionResult Index()
        {
            return View();
        }



        public async System.Threading.Tasks.Task<ActionResult> Dashboard()
        {


            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new StudentRepository(connection).GetStudents();
                return View(result);
            }

        }
    }
}