using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SAMsUNFWebApplication.Models
{
    public class Profile
    {

        public int profile_id { get; set; }
        public int contact_id { get; set; }
        public string user_name { get; set; }
        public string password { get; set; }
        public int school_year_id { set; get; }
        public string create_user { get; set; }
        public string create_dt { get; set; }
        public string last_update_user { get; set; }
        public DateTime last_update_dt { get; set; }
        public Boolean is_deleted { get; set; }

    }
}