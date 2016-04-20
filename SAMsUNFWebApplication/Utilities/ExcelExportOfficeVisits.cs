using OfficeOpenXml;
using OfficeOpenXml.Style;
using SAMsUNFWebApplication.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web;

namespace SAMsUNFWebApplication.Utilities
{
    public class OfficeVisitExcelGenerator
    {
        public static Byte[] GenerateXLS(List<OfficeVisit> datasource)
        {
            /* Call OpenOfficeXML need nuget package for epplus
               This can now be customize for each type of  excel export, also we can make a abstract calls for data dumps
               My want abastrct it out os multiple worksheets can be created.
            */
            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet 
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("OfficeVisits");

                // Build Excel title
                BuildTitle(ws);


                //Set Header titles
                ws.Cells[3, 1].Value = "StudentId";
                ws.Cells[3, 2].Value = "Name";
                ws.Cells[3, 3].Value = "Visit";
                ws.Cells[3, 4].Value = "Date";
                ws.Cells[3, 5].Value = "School";
                ws.Cells[3, 6].Value = "Grade";
                ws.Cells[3, 7].Value = "Homeroom";
                ws.Cells[3, 8].Value = "Content";
                ws.Cells[3, 9].Value = "SentBy";
                ws.Cells[3, 10].Value = "Offenses";
                ws.Cells[3, 11].Value = "Arrived";
                ws.Cells[3, 12].Value = "HandledBy";
                ws.Cells[3, 13].Value = "Consequences";
                ws.Cells[3, 14].Value = "Comment";
                ws.Cells[3, 15].Value = "Nap";


                //Set column width
                ws.Column(1).Width = 13.14;
                ws.Column(2).Width = 20.57;
                ws.Column(3).Width = 6.43;
                ws.Column(4).Width = 13.14;
                ws.Column(5).Width = 12.86;
                ws.Column(6).Width = 8.43;
                ws.Column(7).Width = 17.43;
                ws.Column(8).Width = 14.43;
                ws.Column(9).Width = 18;
                ws.Column(10).Width = 37;
                ws.Column(11).Width = 13.29;
                ws.Column(12).Width = 18;
                ws.Column(13).Width = 37;
                ws.Column(14).Width = 37;
                ws.Column(15).Width = 6.43;

                //Get Data
                for (int i = 0; i < datasource.Count(); i++)
                {
                    ws.Cells[i  + 4, 1].Value = datasource.ElementAt(i).student_number;
                    ws.Cells[i + 4, 2].Value = datasource.ElementAt(i).student_name;
                    ws.Cells[i + 4, 3].Value = datasource.ElementAt(i).total_visits;
                    ws.Cells[i + 4, 4].Value = datasource.ElementAt(i).office_visit_dt.ToShortDateString();
                    ws.Cells[i + 4, 5].Value = datasource.ElementAt(i).school_name;
                    ws.Cells[i + 4, 6].Value = datasource.ElementAt(i).grade_value;
                    ws.Cells[i + 4, 7].Value = datasource.ElementAt(i).homeroom_name;
                    ws.Cells[i + 4, 8].Value = datasource.ElementAt(i).content_course_name;
                    ws.Cells[i + 4, 9].Value = datasource.ElementAt(i).sent_by_contact_name;
                    ws.Cells[i + 4, 10].Value = datasource.ElementAt(i).offenses;
                    ws.Cells[i + 4, 11].Value = datasource.ElementAt(i).arrival_dt.ToShortTimeString();
                    ws.Cells[i + 4, 12].Value = datasource.ElementAt(i).handled_by_contact_name;
                    ws.Cells[i + 4, 13].Value = datasource.ElementAt(i).consequences;
                    ws.Cells[i + 4, 14].Value = datasource.ElementAt(i).comments;
                    ws.Cells[i + 4, 15].Value = (datasource.ElementAt(i).nap == true)? "Y":"N";

                }

                //Set Header style
                using (ExcelRange rng = ws.Cells[ 3,1,3,15])
                {
                    rng.AutoFilter = true;
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                    rng.Style.Font.Color.SetColor(Color.White);
                }

               
                return pck.GetAsByteArray();
            }
        }

        private static void BuildTitle(ExcelWorksheet ws)
        {

            ws.Cells[1, 5].Value = "Office Visits To " + DateTime.Now.ToString("MM/dd/yyyy");
            ws.Cells[1, 5].Style.Font.Bold = true;

        }
    }
}