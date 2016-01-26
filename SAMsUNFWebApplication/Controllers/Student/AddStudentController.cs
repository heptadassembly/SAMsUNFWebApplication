using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.Student
{
    public class AddStudentController : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> AddStudent()
        {

            StudentCollection coll = new StudentCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();

                var result = new GradeRepository(connection).GetGrades();

                coll.allGrades = (IEnumerable<Models.Grade>)result.Result.ToArray();
            }

            return View(coll);
        }

        public ActionResult AddChild(StudentCollection model, string actionRequest)
        {

            return RedirectToAction("Student", "Student");
        }
    }
}