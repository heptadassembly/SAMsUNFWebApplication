using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.School
{
    public class EditSchoolController : Controller
    {
        // GET: EditSchool
        public ActionResult Index()
        {
            return View();
        }
        public async System.Threading.Tasks.Task<ActionResult> EditSchool(string id)
        {

            SchoolCollection coll = new SchoolCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new SchoolRepository(connection).GetSchool(id);
                var result2 = new SchoolRepository(connection).GetSchools();

                coll.singleSchool = (IEnumerable<Models.School>)result.Result.ToArray();
                coll.allSchools = (IEnumerable<Models.School>)result2.Result.ToArray();
                coll.schoolselectlist = new SelectList(result2.Result.ToList(), "school_id", "name", new { id = "SchoolID", @required = "required" });
            }

            return View(coll);
        }
        public ActionResult GetSchool(SchoolCollection model, string actionRequest)
        {
            return RedirectToAction("School", "School");
        }
    }
}