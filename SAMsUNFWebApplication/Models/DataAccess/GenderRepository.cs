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
    public class GenderRepository
    {
        private MySqlConnection _openConnection;

        public GenderRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<Gender>> GetGenders()
        {
            // Read the user by their username in the database. 
            IEnumerable<Gender> result = await this._openConnection.QueryAsync<Gender>(@" SELECT * FROM samsjacksonville.gender");
            return result;
        }
        public async Task<IEnumerable<Gender>> GetGender(string gender)
        {
            // Read the user by their username in the database. 
            IEnumerable<Gender> result = await this._openConnection.QueryAsync<Gender>(@" SELECT * FROM samsjacksonville.gender where gender = '" + gender + "';");
            return result;
        }
        public async Task<IEnumerable<Gender>> GetSortedGenders(string gender)
        {
            // Read the user by their username in the database. 
            IEnumerable<Gender> result = await this._openConnection.QueryAsync<Gender>(@" SELECT * FROM samsjacksonville.gender order by case when gender = '" + gender + "' then 'aaa' else gender end;");
            return result;
        }

    }
}