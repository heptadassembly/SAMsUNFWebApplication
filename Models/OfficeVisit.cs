using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SAMsUNFWebApplication.Models
{
    public class OfficeVisit
    {
        public int office_visit_id { get; set; }
        public DateTime office_visit_dt { get; set; }
        public int student_id { get; set; }
        public string student_number { get; set; }
        public int total_visits { get; set; }
        public string student_name { get; set; }
        public int handled_by_contact_id { get; set; }
        public string handled_by_contact_name { get; set; }
        public Boolean nap { get; set; }
        public string comments { get; set; }
        public DateTime arrival_dt { get; set; }
        public int sent_by_contact_id { get; set; }
        public string sent_by_contact_name { get; set; }
        public int content_course_id { get; set; }
        public string content_course_name { get; set; }
        public string grade_value { get; set; }
        public string school_name { get; set; }
        public string homeroom_id { get; set; }
        public string room_number { get; set; }
        public string homeroom_name { get; set; }
        public int last_update_contact_id { get; set; }
        public string last_update_contact_name { get; set; }
        public DateTime last_update_dt { get; set; }
        public string offenses { get; set; }
        public string consequences { get; set; }

    }
}