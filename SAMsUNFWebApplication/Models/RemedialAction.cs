using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class RemedialAction
    { 
      public  int remedial_action_id {get; set; }
      public  string name { get; set; }
    }
    public class RemedialActionCollection
    {
        public RemedialAction remedialaction { get; set; }
        public IEnumerable<RemedialAction> allRemedialActions { get; set; }
        public IEnumerable<RemedialAction> singleRemedialAction { get; set; }
        public SelectList remedialactionselectlist { get; set; }
    }
}