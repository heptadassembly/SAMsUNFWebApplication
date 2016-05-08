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
    [Authorize]
    public class AddOfficeVisitController : Controller
    {
        // GET: AddOfficeVisit
        [HttpGet]
        public ActionResult AddOfficeVisit()
        {

            OfficeVisitCollection ovcoll = new OfficeVisitCollection();

            ovcoll = PopulateAddOfficeVisit();

            return View(ovcoll);
        }

        OfficeVisitCollection PopulateAddOfficeVisit()
        {
            OfficeVisitCollection coll = new OfficeVisitCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {

                var result = new StudentRepository(connection).GetStudents();
                var result2 = new ContactRepository(connection).GetContacts();
                var result3 = new ContentCourseRepository(connection).GetContentCourses();
                var result4 = new CodeOfConductViolationRepository(connection).GetCodeOfConductViolations();
                var result5 = new HomeRoomRepository(connection).GetHomeRooms();
                var result6 = new RemedialActionRepository(connection).GetRemedialActions();


                coll.allStudents = (IEnumerable<Models.Student>)result.Result.ToArray();
                coll.allReporters = coll.allHandledBys = (IEnumerable<Models.Contact>)result2.Result.ToArray();
                coll.allLocations = (IEnumerable<Models.ContentCourse>)result3.Result.ToArray();
                coll.allCodeViolations = (IEnumerable<Models.CodeOfConductViolation>)result4.Result.ToArray();
                coll.allHomeRooms = (IEnumerable<Models.HomeRoom>)result5.Result.ToArray();
                coll.allRemedials = (IEnumerable<Models.RemedialAction>)result6.Result.ToArray();

                coll.StudentSelectList = new SelectList(coll.allStudents, "student_id", "student_name", null);
                coll.ReportersSelectList = new SelectList(coll.allReporters, "contact_id", "contact_name", null);
                coll.HomeRoomSelectList = new SelectList(coll.allHomeRooms, "homeroom_id", "homeroom_name", null);
                coll.HandleBySelectList = new SelectList(coll.allHandledBys, "contact_id", "contact_name", null);
                coll.LocationSelectList = new SelectList(coll.allLocations, "content_course_id", "name", null);
                coll.RemedialSelectList = new SelectList(coll.allRemedials, "remedial_action_id", "name", null);
                coll.ViolationSelectList = new SelectList(coll.allCodeViolations, "code_of_conduct_violation_id", "name", null);

                Session["AddVisitModel"] = coll;
            }
            return coll;
        }
[HttpPost]
        public ActionResult AddVisit(OfficeVisitCollection model, string studentSelect, string sentbySelect, string homeroomSelect, string remedialSelect,
            string violationSelect, string handledbySelect, string locationSelect)
        {
            OfficeVisitCollection coll = (OfficeVisitCollection)Session["AddVisitModel"];

            if (ValidateData(model, studentSelect, sentbySelect, homeroomSelect, remedialSelect, violationSelect, handledbySelect, locationSelect))
            {
                /* validation and transpose */
                using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
                {
                      bool sucessful = new OfficeVisitRepository(connection).InsertOfficeVisit(model);
                }

                /* Add message . clear and  return back to add page */
                ModelState.Clear();
                ViewBag.Success = true;
                ModelState.AddModelError(string.Empty,"Office Visit has successully been added");
                coll.arrival_dt = DateTime.Now;
                coll.office_visit_dt = DateTime.Now;
                coll.comments = null;
                coll.nap = false;
                coll.StudentSelectList = new SelectList(coll.allStudents, "student_id", "student_name", null );
                coll.ReportersSelectList = new SelectList(coll.allReporters, "contact_id", "contact_name", null);
                coll.HomeRoomSelectList = new SelectList(coll.allHomeRooms, "homeroom_id", "homeroom_name", null);
                coll.HandleBySelectList = new SelectList(coll.allHandledBys, "contact_id", "contact_name", null);
                coll.LocationSelectList = new SelectList(coll.allLocations, "content_course_id", "name", null);
                coll.RemedialSelectList = new SelectList(coll.allRemedials, "remedial_action_id", "name", null);
                coll.ViolationSelectList = new SelectList(coll.allCodeViolations, "code_of_conduct_violation_id", "name", null);

            }
            else
            {

               
                ViewBag.Success = false;
                ModelState.AddModelError(string.Empty, "Student, Homeroom, Violation, Location and SentBy are required to save an Office Visit.");
       
                coll.arrival_dt = model.arrival_dt;
                coll.office_visit_dt = model.office_visit_dt;
                coll.comments = model.comments;
                coll.nap = model.nap;
                coll.StudentSelectList = new SelectList(coll.allStudents, "student_id", "student_name", studentSelect);
                coll.ReportersSelectList = new SelectList(coll.allReporters, "contact_id", "contact_name", sentbySelect);
                coll.HomeRoomSelectList = new SelectList(coll.allHomeRooms, "homeroom_id", "homeroom_name", homeroomSelect);
                coll.HandleBySelectList = new SelectList(coll.allHandledBys, "contact_id", "contact_name", handledbySelect);
                coll.LocationSelectList = new SelectList(coll.allLocations, "content_course_id", "name", locationSelect);
                coll.RemedialSelectList = new SelectList(coll.allRemedials, "remedial_action_id", "name", remedialSelect);
                coll.ViolationSelectList = new SelectList(coll.allCodeViolations, "code_of_conduct_violation_id", "name", violationSelect);


            }
            return View("AddOfficeVisit",coll);
        }


        private bool ValidateData(OfficeVisitCollection model, string studentSelect, string sentbySelect, string homeroomSelect, string remedialSelect,
           string violationSelect, string handledbySelect, string locationSelect)
        {
            bool successful = false;

            
            if (ModelState.IsValid && !String.IsNullOrEmpty(studentSelect) && !String.IsNullOrEmpty(homeroomSelect) && !String.IsNullOrEmpty(sentbySelect) &&
                !String.IsNullOrEmpty(violationSelect) && !String.IsNullOrEmpty(locationSelect))
            {
                if (Session["ProfileContactId"] != null)
                    model.last_update_contact_id = Convert.ToInt32(Session["ProfileContactId"]);
                model.student_id = Convert.ToInt32(studentSelect);
                model.homeroom_id = Convert.ToInt32(homeroomSelect);
                model.sent_by_contact_id = Convert.ToInt32(sentbySelect);
                if(!String.IsNullOrEmpty(handledbySelect))
                    model.handled_by_contact_id = Convert.ToInt32(handledbySelect);
                model.content_course_id = Convert.ToInt32(locationSelect);
                model.last_update_dt = DateTime.Now;
                successful = true;
            }
            return successful;
        }
    }
}