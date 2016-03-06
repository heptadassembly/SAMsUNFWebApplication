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
    public class EditStudentController : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> EditStudent(string id)
        {

            StudentCollection coll = new StudentCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new StudentRepository(connection).GetStudent(id);

                //get all possible values
                var result1 = new StudentRepository(connection).GetStudent(id);
                var result2 = new GradeRepository(connection).GetSortedGrades(result.Result.First().grade_id.ToString());
                var result3 = new SchoolRepository(connection).GetSortedSchools(result.Result.First().school_id.ToString());
                var result4 = new GenderRepository(connection).GetSortedGenders(result.Result.First().gender.ToString());
                var result5 = new HomeRoomRepository(connection).GetSortedHomeRooms(result.Result.First().homeroom_id.ToString());

                coll.singleStudent = (IEnumerable <Models.Student>)result1.Result.ToArray();
                coll.allGrades = (IEnumerable<Models.Grade>)result2.Result.ToArray();
                coll.allSchools = (IEnumerable<Models.School>)result3.Result.ToArray();
                coll.allGenders = (IEnumerable<Models.Gender>)result4.Result.ToArray();
                coll.allHomeRooms = (IEnumerable<Models.HomeRoom>)result5.Result.ToArray();

                coll.gradeselectlist = new SelectList(result2.Result.ToList(), "grade_id", "grade_value", new { id = "TxtGrade", @required = "required" });
                coll.schoolselectlist = new SelectList(result3.Result.ToList(), "school_id", "name", new { id = "TxtSchool", @required = "required" });
                coll.genderselectlist = new SelectList(result4.Result.ToList(), "gender", "gender", new { id = "TxtGender", @required = "required" });
                coll.homeroomselectlist = new SelectList(result5.Result.ToList(), "homeroom_id", "homeroom_name", new { id = "TxtHomeroom", @required = "required" });

            }
            return View(coll);
        }


        public ActionResult EditChild(StudentCollection model, string actionRequest)
        {

            return RedirectToAction("Student", "Student");
        }
    }
}