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

        public bool CreateStudent(string TxtId, string TxtLast, string TxtFirst, string TxtGrade, string TxtSchool, string TxtGender)
        {
            bool success = false;

            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            var queryString = @"INSERT INTO etl.student (studentid, last, first, grade, school, gender) VALUES ('" + TxtId + "','" + TxtLast + "','" + "','" + TxtFirst + "','" + TxtGrade + "','" + TxtSchool + "','" + TxtGender + "');";
            try
            { 
                this._openConnection.Execute(queryString);
                var newString = @"CALL samsjacksonville.import_student();";
                this._openConnection.Execute(newString);
                success = true;
            }
            catch (Exception ex)
            {
                throw (ex);
            }

            return success;
        }

        public async Task<IEnumerable<Student>> GetStudents()
        {
            // Read the user by their username in the database. 
            IEnumerable<Student> result = await this._openConnection.QueryAsync<Student>(@" SELECT * FROM  samsjacksonville.student where student_id > 0  order by last_name");
            return result;
        }

        public async Task<IEnumerable<Student>> GetStudent(int id)
        {
            // Read the user by their username in the database. 
            IEnumerable<Student> result = await this._openConnection.QueryAsync<Student>(@"Select * from samsjacksonville.student where student_id = " + id + ";");
            return result;
        }

        public bool ImportStudents(List<CSVStudent> csvStudent)
        {
            bool success = false;

            var queryString = @"INSERT INTO etl.student values(@StudentID ,@Last,@First,@Grade,@School,@Gender)";

            try
            {
                this._openConnection.Execute(queryString, csvStudent);
                var newString = @"CALL samsjacksonville.import_student();";
                this._openConnection.Execute(newString);
                success = true;
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return success;
        }

        public string AddChild (string TxtID, string TxtFirstName, string TxtLastName, string allSchools, string allGrades, string allGenders, string allHomerooms)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            var queryString = @"INSERT INTO student (school_year_id, student_id_nk, first_name, last_name, school_id, grade_id, gender, homeroom_id) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + TxtID + "','" + TxtFirstName + "','" + TxtLastName + "','" + allSchools + "','" + allGrades + "','" + allGenders + "','" + allHomerooms + "');";
            _openConnection.Execute(queryString);
            return "success";
        }

        public string EditChild (string STUDENTID, string TxtID, string TxtFirstName, string TxtLastName, string schoolselectlist, string gradeselectlist, string genderselectlist, string homeroomselectlist)
        {
            var queryString = @"update student set student_id_nk = '" + TxtID + "', first_name = '" + TxtFirstName + "', last_name = '" + TxtLastName + "', school_id = " + schoolselectlist + ", grade_id = " + gradeselectlist + ", gender = '" + genderselectlist + "', homeroom_id = " + homeroomselectlist + " where student_id = " + STUDENTID + ";";
            _openConnection.Execute(queryString);
            return "success";
        }
    }
}