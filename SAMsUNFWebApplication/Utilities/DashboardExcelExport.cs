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
    public class DashboardExcelGenerator
    {
        public static Byte[] GenerateXLS(DashboardCollection datasource)
        {
            /* Call OpenOfficeXML need nuget package for epplus
               This can now be customize for each type of  excel export, also we can make a abstract calls for data dumps
               My want abastrct it out os multiple worksheets can be created.
            */

            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet 
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Dashboards");

                // Build Excel title
                BuildTitle(ws);
                //By Teachers
                BuildTeachersTable(ws, datasource.Teachers);
               
                //By Homerooms
                BuildHomeroomsTable(ws, datasource.Homerooms);
               
                //By Violations
                BuildViolationsTable(ws, datasource.OffenseTypes);

                return pck.GetAsByteArray();
            }
        }

        private static void BuildTitle(ExcelWorksheet ws)
        {
  
            ws.Cells[1, 5].Value = "Dashboards  To " + DateTime.Now.ToString("MM/dd/yyyy");
            ws.Cells[1, 5].Style.Font.Bold = true;

        }

        /// <summary>
        /// BuildTeachersTable
        /// </summary>
        /// <param name="ws"></param>
        /// <param name="Teachers"></param>
        private static void BuildTeachersTable(ExcelWorksheet ws, IEnumerable<OfficeVisitsByTeacher> Teachers)
        {

            ws.Column(1).Width = 17.86;
            ws.Column(2).Width = 12.43;

            //Set Header titles
            ws.Cells[4, 1].Value = "Teachers";
            ws.Cells[4, 1].Style.Font.Bold = true;
            ws.Cells[5, 1].Value = "Teacher Name";
            ws.Cells[5, 1].Style.Border.BorderAround(ExcelBorderStyle.Thin);
           // ws.Cells[5, 1].AutoFilter = true;
            ws.Cells[5, 2].Value = "Office Visits";
            ws.Cells[5, 2].Style.Border.BorderAround(ExcelBorderStyle.Thin);
           // ws.Cells[5, 2].AutoFilter = true;

            //Get Data for Teachers       
            for (int i = 0; i < Teachers.Count(); i++)
            {
                ws.Cells[i + 6, 1].Value = Teachers.ElementAt(i).sent_by_contact_name;
                ws.Cells[i + 6, 1].Style.Border.BorderAround(ExcelBorderStyle.Thin);
                ws.Cells[i + 6, 2].Value = Teachers.ElementAt(i).total_visits;
                ws.Cells[i + 6, 2].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            }

            //Set Header style
            using (ExcelRange rng = ws.Cells[4, 1, 5 + Teachers.Count(), 2])
            {
                rng.Style.Border.BorderAround(ExcelBorderStyle.Medium);            
            }

        }
       
        /// <summary>
        /// BuildHomeroomsTable
        /// </summary>
        /// <param name="ws"></param>
        /// <param name="Homerooms"></param>
        private static void BuildHomeroomsTable(ExcelWorksheet ws, IEnumerable<OfficeVisitsByHomeroom> Homerooms)
        {


            ws.Column(5).Width = 12.86;
            ws.Column(6).Width = 16;
            ws.Column(7).Width = 6.71;
            ws.Column(8).Width = 11.71;

            ws.Cells[4, 5].Value = "Homerooms";
            ws.Cells[4, 5].Style.Font.Bold = true;
            ws.Cells[5, 5].Value = "School";
            ws.Cells[5, 5].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            ws.Cells[5, 6].Value = "Homeroom";
            ws.Cells[5, 6].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            ws.Cells[5, 7].Value = "Grade";
            ws.Cells[5, 7].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            ws.Cells[5, 8].Value = "Office Visits";
            ws.Cells[5, 8].Style.Border.BorderAround(ExcelBorderStyle.Thin);


            for (int i = 0; i < Homerooms.Count(); i++)
            {
                ws.Cells[i + 6, 5].Value = Homerooms.ElementAt(i).school_name;
                ws.Cells[i + 6, 5].Style.Border.BorderAround(ExcelBorderStyle.Thin);

                ws.Cells[i + 6, 6].Value = Homerooms.ElementAt(i).homeroom_name;
                ws.Cells[i + 6, 6].Style.Border.BorderAround(ExcelBorderStyle.Thin);

                ws.Cells[i + 6, 7].Value = Homerooms.ElementAt(i).grade.ToString();
                ws.Cells[i + 6, 7].Style.Border.BorderAround(ExcelBorderStyle.Thin);

                ws.Cells[i + 6, 8].Value = Homerooms.ElementAt(i).total_visits;
                ws.Cells[i + 6, 8].Style.Border.BorderAround(ExcelBorderStyle.Thin);

            }

            //Set Header style
            using (ExcelRange rng = ws.Cells[4, 5, 5 + Homerooms.Count(), 8])
            {
                rng.Style.Border.BorderAround(ExcelBorderStyle.Medium);
            }
           

        }

        /// <summary>
        /// BuildViolationsTable
        /// </summary>
        /// <param name="ws"></param>
        /// <param name="OffenseTypes"></param>
        private static void BuildViolationsTable(ExcelWorksheet ws, IEnumerable<OfficeVisitsByOffenseType> OffenseTypes)
        {

            ws.Column(11).Width = 50;
            ws.Column(11).Style.WrapText = true;
            ws.Column(12).Width = 12.14;


            ws.Cells[4, 11].Value = "Violations";
            ws.Cells[4, 11].Style.Font.Bold = true;
            ws.Cells[5, 11].Value = "Offense Type";
            ws.Cells[5, 11].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            ws.Cells[5, 12].Value = "Office Visits";
            ws.Cells[5, 12].Style.Border.BorderAround(ExcelBorderStyle.Thin);

            for (int i = 0; i < OffenseTypes.Count(); i++)
            {
                ws.Cells[i + 6, 11].Value = OffenseTypes.ElementAt(i).offense_type;
                ws.Cells[i + 6, 11].Style.Border.BorderAround(ExcelBorderStyle.Thin);
                ws.Cells[i + 6, 12].Value = OffenseTypes.ElementAt(i).total_visits;
                ws.Cells[i + 6, 12].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            }

            //Set Header style
            using (ExcelRange rng = ws.Cells[4, 11, 5 + OffenseTypes.Count(), 12])
            {
                rng.Style.Border.BorderAround(ExcelBorderStyle.Medium);
            }
        }

    }
}