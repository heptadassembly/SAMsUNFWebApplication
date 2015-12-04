using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SAMsUNFWebApplication.Models
{
    public class Contact
    {
        public int contact_id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string position { get; set; }
        public string classroom { get; set; }
        public string room_number { get; set; }
        public string room_extenstion { get; set; }
        public int school_id { get; set; }
        public string email_address { get; set; }
        public string cell_phone { get; set; }
        public int school_year_id { get; set; }
        public int create_contact_id { get; set; }
        public DateTime create_dt { get; set; }
        public int last_update_contact_id { get; set; }
        public string last_update_contact_name { get; set; }
        public DateTime last_update_dt { get; set; }
        public bool is_deleted { get; set; }
        public string contact_name
        {
            get
            {
                if (last_name != null)
                {
                    return last_name + ", " + first_name;
                }

                return null;
            }
        }
    }
    public class CSVContacts
    {
        public string last_name { get; set; }
        public string first_name { get; set; }
        public string position { get; set;  }
        public string classroom { get; set; }
        public string school { get; set; }
        public string room_number { get; set; }
        public string room_extension { get; set; }
        public string email { get; set; }
        public string cell { get; set; }
    }
}