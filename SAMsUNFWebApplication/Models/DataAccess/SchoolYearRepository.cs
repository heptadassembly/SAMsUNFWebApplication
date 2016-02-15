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
    public class SchoolYearRepository
    {
        private MySqlConnection _openConnection;

        public SchoolYearRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<SchoolYear>> GetSchoolYear()
        {
            //Get the current school year
            IEnumerable<SchoolYear> result = await this._openConnection.QueryAsync<SchoolYear>(@" SELECT school_year_id, is_current FROM samsjacksonville.school_year where is_current = 1");
            return result;
        }

        public async Task<IEnumerable<SchoolYear>> GetSchoolYears()
        {
            //Get all School Years 
            IEnumerable<SchoolYear> result = await this._openConnection.QueryAsync<SchoolYear>(@" SELECT school_year_id, is_current FROM samsjacksonville.school_year order by case when is_current = 1 then -2 else school_year_id end");
            return result;
        }
        public bool SetSchoolYear(string allSchoolYears)
        {
            //Update selected school year to current 
            var queryString = @"Call samsjacksonville.update_school_year(" + allSchoolYears + ")";
            _openConnection.Execute(queryString);
            return true;
        }
    }
}