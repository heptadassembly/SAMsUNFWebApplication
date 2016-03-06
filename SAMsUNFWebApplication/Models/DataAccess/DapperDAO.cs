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


    }
}