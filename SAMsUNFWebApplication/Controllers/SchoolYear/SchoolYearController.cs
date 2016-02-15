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

namespace SAMsUNFWebApplication.Controllers.CodeOfConductViolation
{
    public class SchoolYearController : Controller
    {
        // GET: SchoolYear
        public async System.Threading.Tasks.Task<ActionResult> SchoolYear()
        {
            SchoolYearCollection coll = new SchoolYearCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new SchoolYearRepository(connection).GetSchoolYears();
                coll.allSchoolYears = (IEnumerable<Models.SchoolYear>)result.Result.ToArray();
            }
            return View(coll);
        }

        public System.Web.Mvc.RedirectResult SetSchoolYear(string allSchoolYears)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new SchoolYearRepository(connection).SetSchoolYear(allSchoolYears);
                if (result == true)
                {
                    return Redirect("SchoolYear");
                }
                else
                {
                    return Redirect("SchoolYear");
                }
            }
        }

    }
}