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
    public class ContactRepository
    {

        private MySqlConnection _openConnection;


        public ContactRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<Contact>> GetContacts()
        {
            // Read the user by their username in the database. 
            IEnumerable<Contact> result = await this._openConnection.QueryAsync<Contact>(@" SELECT * FROM  vw_contact where contact_id > 0 order by last_name");
            return result;
        }

        public async Task<IEnumerable<Contact>> GetContact(int id)
        {
            // Read the user by their username in the database. 
            IEnumerable<Contact> result = await this._openConnection.QueryAsync<Contact>(@" SELECT * FROM  vw_contact where contact_id = " + id + ";");
            return result;
        }


        public bool AddPerson(string TxtId, string TxtFirst, string TxtLast, string TxtPosition, string TxtClassRoom, string TxtRoomNumber, string TxtRoomExtension, string schoolselectlist, string TxtEmailAddress, string TxtCellPhone)
        {
            //Update selected school year to current 
            var queryString = @"Insert into samsjacksonville.contact (contact_id, first_name, last_name, position, classroom, room_number, room_extension, school_id, email_address, cell_phone, school_year_id) VALUES (" + TxtId + ",'" + TxtFirst + "','" + TxtLast + "','" + TxtPosition + "','" + TxtClassRoom + "','" + TxtRoomNumber + "','" + TxtRoomExtension + "'," + schoolselectlist + ",'" + TxtEmailAddress + "','" + TxtCellPhone + "', samsjacksonville.fn_getSchoolYear(1));";
            _openConnection.Execute(queryString);
            return true;
        }

        public bool ImportContacts(List<CSVContacts> csvContacts)
        {
            bool success = false;

            var queryString = @"INSERT INTO etl.contact values(@lastname,@firstname,@position,@classroom,@school,@room,@roomextension,@email,@cell)";

            try
            {
                this._openConnection.Execute(queryString, csvContacts);
                var newString = @"CALL samsjacksonville.import_contact();";
                this._openConnection.Execute(newString);
                success = true;
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return success;
        }

        public string EditPerson(string TxtID, string TxtFirstName, string TxtLastName, string TxtPosition, string TxtClassRoom, string TxtRoomNumber, string TxtRoomExtension, string schoolselectlist, string TxtEmailAddress, string TxtCellPhone)
        {
            var queryString = @"update samsjacksonville.contact set first_name = '" + TxtFirstName + "', last_name = '" + TxtLastName + "', position = '" + TxtPosition + "', classroom = '" + TxtClassRoom + "', room_number = '" + TxtRoomNumber + "', room_extension = '" + TxtRoomExtension + "', school_id = " + schoolselectlist + ", email_address = '" + TxtEmailAddress + "', cell_phone = '" + TxtCellPhone + "' where contact_id = " + TxtID + ";";
            _openConnection.Execute(queryString);
            return "success";
        }
    }
}