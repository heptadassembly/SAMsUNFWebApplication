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
    public class EditOfficeVisitController : Controller
    {
        // GET: AddOfficeVisit
        [HttpGet]
        public async System.Threading.Tasks.Task<ActionResult> EditOfficeVisit(string id)
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
                var result7 = new OfficeVisitRepository(connection).GetOfficeVisitByID(Convert.ToInt32(id));

                coll.officeVisit = result7.Result;
                
                coll.allStudents = (IEnumerable<Models.Student>)result.Result.ToArray();
                coll.allReporters = coll.allHandledBys = (IEnumerable<Models.Contact>)result2.Result.ToArray();
                coll.allLocations = (IEnumerable<Models.ContentCourse>)result3.Result.ToArray();
                coll.allCodeViolations = (IEnumerable<Models.CodeOfConductViolation>)result4.Result.ToArray();
                coll.allHomeRooms = (IEnumerable<Models.HomeRoom>)result5.Result.ToArray();
                coll.allRemedials = (IEnumerable<Models.RemedialAction>)result6.Result.ToArray();

                coll.remedialAction = new OfficeVisitRepository(connection).GetOfficeVisitRemedyAction(coll.officeVisit.office_visit_id);
                coll.CodeViolation = new OfficeVisitRepository(connection).GetOfficeVisitCodeViolation(coll.officeVisit.office_visit_id);

                coll.office_visit_id = coll.officeVisit.office_visit_id;
                coll.arrival_dt = coll.officeVisit.arrival_dt;
                coll.office_visit_dt = coll.officeVisit.office_visit_dt;
                coll.nap = coll.officeVisit.nap;
                coll.comments = coll.officeVisit.comments;

                coll.StudentSelectList =  new SelectList(coll.allStudents, "student_id", "student_name", coll.officeVisit.student_id);
                coll.ReportersSelectList = new SelectList(coll.allReporters, "contact_id", "contact_name", coll.officeVisit.sent_by_contact_id);
                coll.HomeRoomSelectList = new SelectList(coll.allHomeRooms, "homeroom_id", "homeroom_name", coll.officeVisit.homeroom_id);
                coll.HandleBySelectList = new SelectList(coll.allHandledBys, "contact_id", "contact_name", coll.officeVisit.handled_by_contact_id);
                coll.LocationSelectList = new SelectList(coll.allLocations, "content_course_id", "name", coll.officeVisit.content_course_id);
                
                coll.RemedialSelectList = new SelectList(coll.allRemedials, "remedial_action_id", "name", coll.remedialAction);
                coll.ViolationSelectList = new SelectList(coll.allCodeViolations, "code_of_conduct_violation_id", "name", coll.CodeViolation);
                Session["OfficeVisitId"] = id;
            }

            return View(coll);
        }


        [HttpPost]

        public ActionResult EditVisit(OfficeVisitCollection model, string studentSelect, string sentbySelect, string homeroomSelect, string remedialSelect,
            string violationSelect, string handledbySelect, string locationSelect, string EditAction)
        {
          
            switch (EditAction)
            {
                case "Save":
                    ValidateData(model, studentSelect, sentbySelect, homeroomSelect, remedialSelect, violationSelect, handledbySelect, locationSelect);
                    SaveOfficeVisit(model);
                    //Message
                    break;
                  case "Cancel":
                    Session["OfficeVisitId"] = null;
                    break;
            }


            return RedirectToAction("OfficeVisit", "OfficeVisit");
        }

        private bool ValidateData(OfficeVisitCollection model, string studentSelect, string sentbySelect, string homeroomSelect, string remedialSelect,
            string violationSelect, string handledbySelect, string locationSelect)
        {
            bool successful = true;

            if (Session["OfficeVisitId"] != null)
                model.office_visit_id = Convert.ToInt32(Session["OfficeVisitId"]);
            if(Session["ProfileContactId"] != null)
                model.last_update_contact_id = Convert.ToInt32(Session["ProfileContactId"]);

            if (!String.IsNullOrEmpty(studentSelect))
                model.student_id = Convert.ToInt32(studentSelect);
            if (!String.IsNullOrEmpty(homeroomSelect))
                model.homeroom_id = Convert.ToInt32(homeroomSelect);
            if (!String.IsNullOrEmpty(sentbySelect))
                model.sent_by_contact_id = Convert.ToInt32(sentbySelect);
            if (!String.IsNullOrEmpty(handledbySelect))
                model.handled_by_contact_id = Convert.ToInt32(handledbySelect);
            if (!String.IsNullOrEmpty(locationSelect))
                model.content_course_id = Convert.ToInt32(locationSelect);
       
            model.last_update_dt = DateTime.Now;

            return successful;
        }
        public bool SaveOfficeVisit(OfficeVisitCollection model)
        {
            bool sucessful = false;
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                sucessful = new OfficeVisitRepository(connection).UpdateOfficeVisit(model);
            }
            return sucessful;
        }
    }

    /* validation and transpose */

}
