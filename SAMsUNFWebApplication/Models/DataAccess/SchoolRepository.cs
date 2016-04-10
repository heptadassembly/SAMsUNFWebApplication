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
    public class SchoolRepository
    {
        private MySqlConnection _openConnection;

        public SchoolRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<School>> GetSchools()
        {
            // Read the user by their username in the database. 
            IEnumerable<School> result = await this._openConnection.QueryAsync<School>(@" SELECT * FROM vw_school");
            return result;
        }
        public async Task<IEnumerable<School>> GetSchool(string school_id)
        {
            // Read the user by their username in the database. 
            IEnumerable<School> result = await this._openConnection.QueryAsync<School>(@" SELECT * FROM samsjacksonville.vw_school where school_id = " + school_id + ";");
            return result;
        }

        public async Task<IEnumerable<School>> GetSortedSchools(string school_id)
        {
            // Read the user by their username in the database. 
            IEnumerable<School> result = await this._openConnection.QueryAsync<School>(@" SELECT * FROM vw_school order by case when school_id = " + school_id + " then -2 else school_id end");
            return result;
        }
        public string CreateSchool(string SchoolName)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"INSERT INTO samsjacksonville.school (name,create_contact_id,create_dt,last_update_contact_id,last_update_dt) VALUES ('" + SchoolName + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string EditSchool(string SchoolID, string SchoolName)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"Update samsjacksonville.school set name = '" + SchoolName + "', last_update_contact_id = samsjacksonville.fn_getContactID('" + current_user + "'), last_update_dt = now() where school_id = " + SchoolID;
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