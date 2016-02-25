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


        public async Task<IEnumerable<Student>> GetStudents()
        {
            // Read the user by their username in the database. 
            IEnumerable<Student> result = await this._openConnection.QueryAsync<Student>(@" SELECT * FROM  student where student_id > 0  order by last_name");
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

    }
}