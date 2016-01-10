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
           
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();

                var result = new StudentRepository(connection).GetStudents();
                var result2 = new ContactRepository(connection).GetContacts();
                var result3 = new ContentCourseRepository(connection).GetContentCourses();
                var result4 = new CodeOfConductViolationRepository(connection).GetCodeOfConductViolations();
                var result5 = new HomeRoomRepository(connection).GetHomeRooms();
                var result6 = new RemedialActionRepository(connection).GetRemedialActions();


                coll.allStudents =  (IEnumerable<Models.Student>) result.Result.ToArray();
                coll.allReporters = coll.allHandledBys = (IEnumerable<Models.Contact>)result2.Result.ToArray();
                coll.allLocations = (IEnumerable<Models.ContentCourse>)result3.Result.ToArray();
                coll.allCodeViolations = (IEnumerable<Models.CodeOfConductViolation>)result4.Result.ToArray();
                coll.allHomeRooms = (IEnumerable<Models.HomeRoom>)result5.Result.ToArray();
                coll.allRemedials = (IEnumerable<Models.RemedialAction>)result6.Result.ToArray();
            }

            return View(coll);
        }

        public ActionResult AddVisit(OfficeVisitCollection model, string actionRequest)
        {

            return RedirectToAction("OfficeVisit", "OfficeVisit");
        }
    }
}