using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class OfficeVisitCollection:OfficeVisit
    {
        public OfficeVisit officeVisit { get; set; }
        public IEnumerable<Student> allStudents { get; set; }
        public IEnumerable<Contact> allReporters { get; set; }
        public IEnumerable<Contact> allHandledBys { get; set; }
        public IEnumerable<ContentCourse> allLocations { get; set; }
        public IEnumerable<CodeOfConductViolation> allCodeViolations { get; set; }
        public IEnumerable<RemedialAction> allRemedials { get; set; }
        public IEnumerable<HomeRoom> allHomeRooms { get; set; }
    }
}