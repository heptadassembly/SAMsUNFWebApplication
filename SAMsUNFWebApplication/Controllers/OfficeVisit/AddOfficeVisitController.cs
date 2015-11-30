using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.OfficeVisit
{
    public class AddOfficeVisitController : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> AddOfficeVisit()
        {
     
            OfficeVisitCollection coll = new OfficeVisitCollection();
            List<SelectListItem> students = new List<SelectListItem>();

            Session["Students"] = null;
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();

                var result = new StudentRepository(connection).GetStudents();
                var result2 = new ContactRepository(connection).GetContacts();
                var result3 = new ContentCourseRepository(connection).GetContentCourses();
                var result4 = new CodeOfConductViolationRepository(connection).GetCodeOfConductViolations();


                coll.AllStudents =  (IEnumerable<Student>) result.Result.ToArray();
                coll.AllContacts = (IEnumerable<Models.Contact>)result2.Result.ToArray();
                coll.AllLocations = (IEnumerable<Models.ContentCourse>)result3.Result.ToArray();
                coll.AllCodeViolations = (IEnumerable<Models.CodeOfConductViolation>)result4.Result.ToArray();
             }

            return View(coll);
        }

        private List<SelectListItem> GetStudentListItem(IEnumerable<Student> students)
        {
            List<SelectListItem> items = new List<SelectListItem>();
    
            foreach(Student item in students)
                {
                    items.Add(new SelectListItem() { Text = item.student_name, Value = item.student_id.ToString() });
                }
            return (items);
            
        }
        public ActionResult AddVisit()
        {
            return RedirectToAction("OfficeVisit", "OfficeVisit");
        }
    }
}