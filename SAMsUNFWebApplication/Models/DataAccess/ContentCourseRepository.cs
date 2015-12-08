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
    public class ContentCourseRepository
    {
        private MySqlConnection _openConnection;


        public ContentCourseRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<IEnumerable<ContentCourse>> GetContentCourses()
        {
            // Read the user by their username in the database. 
            IEnumerable<ContentCourse> result = await this._openConnection.QueryAsync<ContentCourse>(@" SELECT * FROM  vw_content_course where content_course_id > 0 order by name");
            return result;
        }


    }
}