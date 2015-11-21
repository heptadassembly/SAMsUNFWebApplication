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
    public class CodeOfConductViolationRepository
    {
        private MySqlConnection _openConnection;


        public CodeOfConductViolationRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<IEnumerable<CodeOfConductViolation>> GetCodeOfConductViolations()
        {
            // Read the user by their username in the database. 
            IEnumerable<CodeOfConductViolation> result = await this._openConnection.QueryAsync<CodeOfConductViolation>(@" SELECT * FROM  code_of_conduct_violation");
            return result;
        }

        public string CreateCodeOfConductViolation(string TxtId, string TxtCode, string TxtName)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            var queryString = @"INSERT INTO code_of_conduct_violation (duval_violation_code, short_code, name) VALUES ('" + TxtId + "','" + TxtCode + "','" + TxtName + "');";
            _openConnection.Execute(queryString);
            return "success";
        }
    }
}