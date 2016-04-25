using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class OfficeVisitCollection : OfficeVisit
    {
        public OfficeVisit officeVisit { get; set; }
        public IEnumerable<Student> allStudents { get; set; }
        public IEnumerable<Contact> allReporters { get; set; }
        public IEnumerable<Contact> allHandledBys { get; set; }
        public IEnumerable<ContentCourse> allLocations { get; set; }
        public IEnumerable<CodeOfConductViolation> allCodeViolations { get; set; }
        public IEnumerable<RemedialAction> allRemedials { get; set; }
        public IEnumerable<HomeRoom> allHomeRooms { get; set; }

        public SelectList StudentSelectList { get; set; }
        public SelectList ReportersSelectList { get; set; }
        public SelectList HandleBySelectList { get; set; }
        public SelectList LocationSelectList { get; set; }
        public SelectList ViolationSelectList { get; set; }
        public SelectList RemedialSelectList { get; set; }
        public SelectList HomeRoomSelectList { get; set; }

        public String studentSelect { get; set; }
        public String sentbySelect { get; set; }
        public String homeroomSelect { get; set; }
        public String remedialSelect { get; set; }
        public String violationSelect { get; set; }
        public String handledbySelect { get; set; }
        public String locationSelect { get; set; }
        public DateTime officeVisitDate
        {
            get
            {
                if (office_visit_dt == DateTime.MinValue)
                    return DateTime.Now;
                else
                    return office_visit_dt;
            }
            set { office_visit_dt = value.Date; }
        }
        public DateTime officeVisitTime
        {
            get
            {
                if (office_visit_dt == DateTime.MinValue)
                    return DateTime.Now;
                else
                    return office_visit_dt;
            }
            set {  
                 TimeSpan ts = new TimeSpan(value.Hour,value.Minute,value.Second);
                 office_visit_dt = office_visit_dt.Date + ts;
            }
        }
        public DateTime officeArriveDate
        {
            get
            {
                if (arrival_dt == DateTime.MinValue)
                    return DateTime.Now;
                else
                    return arrival_dt;
            }
            set { arrival_dt = value.Date; }
        }
        public DateTime officeArriveTime
        {
            get
            {
                if (arrival_dt == DateTime.MinValue)
                    return DateTime.Now;
                else
                    return arrival_dt;
            }
            set
            {
                TimeSpan ts = new TimeSpan(value.Hour, value.Minute, value.Second);
                arrival_dt = arrival_dt.Date + ts;
            }
        }

    }
}