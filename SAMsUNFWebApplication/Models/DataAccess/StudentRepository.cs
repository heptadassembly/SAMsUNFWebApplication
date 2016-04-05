using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using SAMsUNFWebApplication.Models;
using System.Web;
using System.Configuration;

namespace SAMsUNFWebApplication.Models.DataAccess
{
    public class StudentRepository
    {
        private MySqlConnection _openConnection;

        public StudentRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public string CreateStudent(string TxtId, string TxtLast, string TxtFirst, string TxtGrade, string TxtSchool, string TxtGender)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            var current_user = HttpContext.Current.User.Identity.Name;
            var queryString = @"INSERT INTO etl.student (studentid, last, first, grade, school, gender,create_contact_id,create_dt,last_update_contact_id,last_update_dt) VALUES ('" + TxtId + "','" + TxtLast + "','" + "','" + TxtFirst + "','" + TxtGrade + "','" + TxtSchool + "','" + TxtGender + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
            try
            {

                this._openConnection.Execute(queryString);
                var newString = @"CALL samsjacksonville.import_student();";
                this._openConnection.Execute(newString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";

            }
        }

        public async Task<IEnumerable<Student>> GetStudents()
        {
            // Read the user by their username in the database. 
            IEnumerable<Student> result = await this._openConnection.QueryAsync<Student>(@" SELECT * FROM  samsjacksonville.vw_student order by last_name");
            return result;
        }

        public async Task<IEnumerable<Student>> GetStudent(string id)
        {
            // Read the user by their username in the database. 
            IEnumerable<Student> result = await this._openConnection.QueryAsync<Student>(@"Select * from samsjacksonville.student where student_id = " + id + ";");
            return result;
        }

        public string ImportStudents(List<CSVStudent> csvStudent)
        {
            var current_user = HttpContext.Current.User.Identity.Name;
            var queryString = @"INSERT INTO etl.student values(@StudentID ,@Last,@First,@Grade,@School,@Gender,'" + current_user + "')";

            try
            {

                this._openConnection.Execute(queryString, csvStudent);
                var newString = @"CALL samsjacksonville.import_student();";
                this._openConnection.Execute(newString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string AddChild(string TxtID, string TxtFirstName, string TxtLastName, string allSchools, string allGrades, string allGenders, string allHomerooms)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"INSERT INTO student (school_year_id, student_id_nk, first_name, last_name, school_id, grade_id, gender, homeroom_id,create_contact_id,create_dt,last_update_contact_id,last_update_dt) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + TxtID + "','" + TxtFirstName + "','" + TxtLastName + "','" + allSchools + "','" + allGrades + "','" + allGenders + "','" + allHomerooms + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string EditChild(string STUDENTID, string TxtID, string TxtFirstName, string TxtLastName, string schoolselectlist, string gradeselectlist, string genderselectlist, string homeroomselectlist)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"update student set student_id_nk = '" + TxtID + "', first_name = '" + TxtFirstName + "', last_name = '" + TxtLastName + "', school_id = " + schoolselectlist + ", grade_id = " + gradeselectlist + ", gender = '" + genderselectlist + "', homeroom_id = " + homeroomselectlist + ", last_update_contact_id = samsjacksonville.fn_getContactID('" + current_user + "'), last_update_dt = now() where student_id = " + STUDENTID;
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }
    }
}