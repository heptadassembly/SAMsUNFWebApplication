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

namespace SAMsUNFWebApplication.Controllers.Student
{
    [Authorize]
    public class StudentController : Controller
    {
        // GET: Student
        public async System.Threading.Tasks.Task<ActionResult> Student()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new StudentRepository(connection).GetStudents();
                //var result2 = await new GradeRepository(connection).GetGrades();
                return View(result);
            }
        }

        public async System.Threading.Tasks.Task<ActionResult> GetStudent(string id)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new StudentRepository(connection).GetStudent(id);
                return View(result);
            }
        }

        public System.Web.Mvc.RedirectResult AddChild(string TxtID, string TxtFirstName, string TxtLastName, string allSchools, string allGrades, string allGenders, string allHomerooms)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new StudentRepository(connection).AddChild(TxtID, TxtFirstName, TxtLastName, allSchools, allGrades, allGenders, allHomerooms);
                if (result == "success")
                {
                    return Redirect("Student/Student/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("Student/Student/?error=invalidfile");
                }
            }
        }

        public System.Web.Mvc.RedirectResult EditChild(string STUDENTID, string TxtID, string TxtFirstName, string TxtLastName, string schoolselectlist, string gradeselectlist, string genderselectlist, string homeroomselectlist)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new StudentRepository(connection).EditChild(STUDENTID, TxtID, TxtFirstName, TxtLastName, schoolselectlist, gradeselectlist, genderselectlist, homeroomselectlist);
                if (result == "success")
                {
                    return Redirect("Student/Student/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("Student/Student/?error=invalidfile");
                }
            }
        }
    }
}