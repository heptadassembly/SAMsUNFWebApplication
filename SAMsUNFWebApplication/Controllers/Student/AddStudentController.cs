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

                var result2 = new GradeRepository(connection).GetGrades();
                var result3 = new SchoolRepository(connection).GetSchools();
                var result4 = new GenderRepository(connection).GetGenders();
                var result5 = new HomeRoomRepository(connection).GetHomeRooms();

                coll.allGrades = (IEnumerable<Models.Grade>)result2.Result.ToArray();
                coll.allSchools = (IEnumerable<Models.School>)result3.Result.ToArray();
                coll.allGenders = (IEnumerable<Models.Gender>)result4.Result.ToArray();
                coll.allHomeRooms = (IEnumerable<Models.HomeRoom>)result5.Result.ToArray();
            }

            return View(coll);
        }

        public ActionResult AddChild(StudentCollection model, string actionRequest)
        {

            return RedirectToAction("Student", "Student");
        }
        
    }
}