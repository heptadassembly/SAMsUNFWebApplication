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

        public string EditConentCourse(string ContentCourseID, string ContentCourseName)
        {
            try
            {
                var queryString = @"update samsjacksonville.content_course set name = '" + ContentCourseName + "' where content_course_id = " + ContentCourseID + ";";
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string CreateContentCourse(string ContentCourseName)
        {
            try
            {
                var queryString = @"insert into samsjacksonville.content_course (school_year_id, name) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + ContentCourseName + "');";
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