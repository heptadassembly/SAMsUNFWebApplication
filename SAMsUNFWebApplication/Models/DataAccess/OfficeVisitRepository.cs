using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using SAMsUNFWebApplication.Models;
using System.Web;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System;

namespace SAMsUNFWebApplication.Models.DataAccess
{
    public class OfficeVisitRepository
    {
        private MySqlConnection _openConnection;


        public OfficeVisitRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<IEnumerable<OfficeVisit>> GetALLOfficeVisits()
        {
            // Read the user by their username in the database. 
            IEnumerable<OfficeVisit> results = await this._openConnection.QueryAsync<OfficeVisit>(@" SELECT * FROM  vw_office_visit ORDER BY office_visit_dt desc");

            return results;
        }

        public async Task<OfficeVisit> GetOfficeVisitByID(int officeVisitID)
        {
            // Read the user by their username in the database. 
            var results = await this._openConnection.QueryAsync<OfficeVisit>(@" SELECT * FROM  vw_office_visit WHERE office_visit_id = @officeVisitID",
                    new { officeVisitID = officeVisitID });
            return results.FirstOrDefault(); ;
        }

        public bool InsertOfficeVisit(OfficeVisitCollection officeVisit)
        {
            bool success = false;

            try
            {
                var queryString = @"INSERT INTO office_visit(school_year_id, student_id, total_visits, content_course_id, sent_by_contact_id, office_visit_dt, arrival_dt," +
                              "handled_by_contact_id, nap, comments, last_update_contact_id, last_update_dt, homeroom_id)" +
                              "VALUES(samsjacksonville.fn_getSchoolYear(1)," + officeVisit.student_id + ",samsjacksonville.fn_getTotalVisits(" + officeVisit.student_id + ")," + officeVisit.content_course_id +
                              "," + officeVisit.sent_by_contact_id + ",'" + officeVisit.office_visit_dt.ToString("yyyy-MM-dd HH:mm:ss") + "','" + officeVisit.arrival_dt.ToString("yyyy-MM-dd HH:mm:ss") + "'," + (officeVisit.handled_by_contact_id == 0 ? -1: officeVisit.handled_by_contact_id) +
                              "," + Convert.ToInt16(officeVisit.nap) +",'" + officeVisit.comments + "'," + officeVisit.last_update_contact_id + ",'"+ DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "'," + officeVisit.homeroom_id + ");"
                              + "SELECT LAST_INSERT_ID();";
           

                var id = _openConnection.Query<int>(queryString).Single();

                //Add Violation
                if (!String.IsNullOrEmpty(officeVisit.violationSelect))
                {
                    queryString = @"INSERT INTO office_visit_offense_assn(office_visit_id,code_of_conduct_violation_id) VALUE (" + id + "," + officeVisit.violationSelect + ");";
                    _openConnection.Execute(queryString);
                }

                // Add remedy

                if (!String.IsNullOrEmpty(officeVisit.remedialSelect))
                {
                    queryString = @"INSERT INTO office_visit_remedial_action_assn(office_visit_id,remedial_action_id) VALUE(" + id + "," + officeVisit.remedialSelect + ");";
                    _openConnection.Execute(queryString);
                }

                success = true;

            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return success;
        }

        public bool UpdateOfficeVisit(OfficeVisitCollection officeVisit)
        {
            bool success = false;

            var queryString = @"UPDATE  office_visit SET student_id = @student_id ,content_course_id = @content_course_id,"+
                                "sent_by_contact_id = @sent_by_contact_id, office_visit_dt = @office_visit_dt, arrival_dt = @arrival_dt,"+
                                "handled_by_contact_id = @handled_by_contact_id, nap = @nap, comments = @comments, last_update_contact_id = @last_update_contact_id,"+
                                "is_deleted = 0, homeroom_id = @homeroom_id,last_update_dt = @last_update_dt  WHERE office_visit_id = @office_visit_id";

            try
            {
                this._openConnection.Execute(queryString, new
                {
                    office_visit_id = officeVisit.office_visit_id,
                    student_id = officeVisit.student_id,
                    content_course_id = officeVisit.content_course_id,
                    sent_by_contact_id = officeVisit.sent_by_contact_id,
                    office_visit_dt = officeVisit.office_visit_dt.ToString("yyyy-MM-dd HH:mm:ss"),
                    arrival_dt = officeVisit.arrival_dt.ToString("yyyy-MM-dd HH:mm:ss"),
                    handled_by_contact_id = officeVisit.handled_by_contact_id == 0 ? -1: officeVisit.handled_by_contact_id,
                    nap = Convert.ToInt16(officeVisit.nap),
                    comments = officeVisit.comments,
                    last_update_contact_id = officeVisit.last_update_contact_id,
                    homeroom_id = officeVisit.homeroom_id,
                    last_update_dt = officeVisit.last_update_dt.ToString("yyyy-MM-dd HH:mm:ss")
                });
                if(!String.IsNullOrEmpty(officeVisit.remedialSelect))
                    UpdatetOfficeVisitRemedyAction(officeVisit.office_visit_id, officeVisit.remedialSelect);
                if (!String.IsNullOrEmpty(officeVisit.violationSelect))
                    UpdateOfficeVisitCodeViolation(officeVisit.office_visit_id, officeVisit.violationSelect);


            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return success;
        }

        public int GetOfficeVisitRemedyAction(int officeVisit)
        {
    
            dynamic result = _openConnection.Query (@" SELECT remedial_action_id FROM vw_office_visit_remedial_action_assn WHERE office_visit_id = @officeVisit;",
            new { officeVisit = officeVisit }).SingleOrDefault();
            return result != null ? result.remedial_action_id:0;

            }
        public int GetOfficeVisitCodeViolation(int officeVisit)
        {
           dynamic result = _openConnection.Query(@" SELECT code_of_conduct_violation_id FROM  vw_office_visit_offense_assn WHERE office_visit_id = @officeVisit;",
                      new { officeVisit = officeVisit }).SingleOrDefault();
            return  result != null ? result.code_of_conduct_violation_id : 0; ;

        }

        public void UpdatetOfficeVisitRemedyAction(int officeVisit,  string remedialAction)
        {
            _openConnection.Execute(@"DELETE from office_visit_remedial_action_assn WHERE office_visit_id = @officeVisit;",
            new { officeVisit = officeVisit });

            _openConnection.Execute(@"INSERT INTO office_visit_remedial_action_assn (office_visit_id, remedial_action_id) VALUES(@officeVisit,@remedialActionId);",
           new { officeVisit = officeVisit, remedialActionID = Convert.ToInt32(remedialAction)});


        }
        public void UpdateOfficeVisitCodeViolation(int officeVisit, string codeViolationId)
        {
            
                   _openConnection.Execute(@"DELETE from office_visit_offense_assn WHERE office_visit_id = @officeVisit;",
            new { officeVisit = officeVisit });


            _openConnection.Execute(@"INSERT INTO office_visit_offense_assn ( office_visit_id, code_of_conduct_violation_id) VALUES(@officeVisit,@codeViolationId);",
      new { officeVisit = officeVisit, codeViolationId = Convert.ToInt32(codeViolationId) });


        }
        public async Task<IEnumerable<OfficeVisitsByHomeroom>> GetOfficeVisitsByHomeroom()
        {
            IEnumerable<OfficeVisitsByHomeroom> results = await this._openConnection.QueryAsync<OfficeVisitsByHomeroom>(@" SELECT * FROM  vw_office_visits_by_homeroom");
            return results;
        }

        public async Task<IEnumerable<OfficeVisitsByTeacher>> GetOfficeVisitsByTeacher()
        {
            IEnumerable<OfficeVisitsByTeacher> results = await this._openConnection.QueryAsync<OfficeVisitsByTeacher>(@" SELECT * FROM  vw_office_visits_by_teacher");
            return results;
        }

        public async Task<IEnumerable<OfficeVisitsByOffenseType>> GetOfficeVisitsByOffenseType()
        {
            IEnumerable<OfficeVisitsByOffenseType> results = await this._openConnection.QueryAsync<OfficeVisitsByOffenseType>(@" SELECT * FROM  vw_office_visits_by_offense_type");
            return results;

        }

        public async Task<IEnumerable<OfficeVisitsCountsByWeek>> GetOfficeVisitsCountByWeek()
        {
            IEnumerable<OfficeVisitsCountsByWeek> results = await this._openConnection.QueryAsync<OfficeVisitsCountsByWeek>(@" SELECT * FROM  vw_office_visits_by_weekly_count");
            return results;

        }
    }
}