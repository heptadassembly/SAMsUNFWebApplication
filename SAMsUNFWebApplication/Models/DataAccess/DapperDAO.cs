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

    public class UserRepository
    {
        private MySqlConnection _openConnection;


        public UserRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<ProfileModel> LoginValidation(string userID, string password)
        {
            // Read the user by their username in the database. 
            var results = await this._openConnection.QueryAsync<ProfileModel>(@" SELECT * FROM  profile 
                     WHERE user_name = @UserID AND password = @Password",
                    new { UserID  = userID, Password = password });

            var result = results.FirstOrDefault();
            return result;
        }

        public async Task<bool> LoginUpdate(string userID, string password, string secretAnswer)
        {
            // Read the user by their username in the database. 
            var queryString = @"update samsjacksonville.profile set password = '" + password + "', secretanswer = '" + secretAnswer + "',last_update_dt = now() where user_name = '" + userID + "';";
            int updated =  await this._openConnection.ExecuteAsync(queryString);
            return (updated > 0) ? true:false;
        }

        public ProfileModel LoginGetbyUserId(string userID)
        {
            // Read the user by their username in the database. 
            var results = this._openConnection.Query<ProfileModel>(@" SELECT * FROM  profile 
                     WHERE user_name = @UserID",
                    new { UserID = userID });

            var result = results.FirstOrDefault();
            return result;
        }
    }
}