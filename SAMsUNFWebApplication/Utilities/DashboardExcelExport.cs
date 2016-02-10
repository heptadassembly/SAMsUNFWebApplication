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

                //By Teachers
                BuildTeachersTable(ws, datasource.Teachers);
               
                //By Homerooms
                BuildHomeroomsTable(ws, datasource.Homerooms);
               
                //By Violations
                BuildViolationsTable(ws, datasource.OffenseTypes);

                return pck.GetAsByteArray();
            }
        }

        /// <summary>
        /// BuildHomeroomsTable
        /// </summary>
        /// <param name="ws"></param>
        /// <param name="Homerooms"></param>
        private static void BuildHomeroomsTable(ExcelWorksheet ws, IEnumerable<OfficeVisitsByHomeroom> Homerooms)
        {
            ws.Cells[1, 6].Value = "School";
            ws.Cells[3, 7].Value = "Homeroom";
            ws.Cells[3, 8].Value = "Grade";
            ws.Cells[3, 9].Value = "Office Visits";

            for (int i = 0; i < Homerooms.Count(); i++)
            {
                ws.Cells[i + 4, 6].Value = Homerooms.ElementAt(i).school_name;
                ws.Cells[i + 4, 7].Value = Homerooms.ElementAt(i).homeroom_name;
                ws.Cells[i + 4, 8].Value = Homerooms.ElementAt(i).grade;
                ws.Cells[i + 4, 9].Value = Homerooms.ElementAt(i).total_visits;
            }

            //Set Header style
            using (ExcelRange rng = ws.Cells[1, 6, 4 + Homerooms.Count(), 9])
            {
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                rng.Style.Fill.BackgroundColor.SetColor(Color.LightSalmon);

            }

            using (ExcelRange rng = ws.Cells[3, 6, 3, 9])
            {
                rng.Style.Font.Bold = true;
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                rng.Style.Font.Color.SetColor(Color.White);
            }

            using (ExcelRange rng = ws.Cells[1, 6])
            {
                rng.Style.Font.Bold = true;
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                rng.Style.Font.Color.SetColor(Color.White);

            }

        }
        /// <summary>
        /// BuildTeachersTable
        /// </summary>
        /// <param name="ws"></param>
        /// <param name="Teachers"></param>
        private static void BuildTeachersTable(ExcelWorksheet ws, IEnumerable<OfficeVisitsByTeacher> Teachers)
        {
            //Set Header titles
            ws.Cells[1, 1].Value = "Teachers";
            ws.Cells[3, 1].Value = "Teacher Name";
            ws.Cells[3, 2].Value = "Office Visits";

            //Get Data for Teachers       
            for (int i = 0; i < Teachers.Count(); i++)
            {
                ws.Cells[i + 4, 1].Value = Teachers.ElementAt(i).sent_by_contact_name;
                ws.Cells[i + 4, 2].Value = Teachers.ElementAt(i).total_visits;

            }

            //Set Header style
            using (ExcelRange rng = ws.Cells[1, 1, 4 + Teachers.Count(), 2])
            {
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                rng.Style.Fill.BackgroundColor.SetColor(Color.LightSalmon);

            }

            using (ExcelRange rng = ws.Cells[3, 1, 3, 2])
            {
                rng.Style.Font.Bold = true;
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                rng.Style.Font.Color.SetColor(Color.White);
            }

            using (ExcelRange rng = ws.Cells[1, 1, 1, 2])
            {
                rng.Style.Font.Bold = true;
                rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                rng.Style.Font.Color.SetColor(Color.White);

            }

        }

        /// <summary>
        /// BuildViolationsTable
        /// </summary>
        /// <param name="ws"></param>
        /// <param name="OffenseTypes"></param>
        private static void BuildViolationsTable(ExcelWorksheet ws, IEnumerable<OfficeVisitsByOffenseType> OffenseTypes)
        {
             ws.Cells[1, 11].Value = "Violations";
                ws.Cells[3, 11].Value = "Offense Type";
                ws.Cells[3, 12].Value = "Office Visits";
               
                for (int i = 0; i< OffenseTypes.Count(); i++)
                {
                    ws.Cells[i + 4, 11].Value = OffenseTypes.ElementAt(i).offense_type;
                    ws.Cells[i + 4, 12].Value = OffenseTypes.ElementAt(i).total_visits;
                   }

                //Set Header style
                using (ExcelRange rng = ws.Cells[1, 11, 4 + OffenseTypes.Count(), 12])
                {
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    rng.Style.Fill.BackgroundColor.SetColor(Color.Beige);

                }

                using (ExcelRange rng = ws.Cells[3, 11, 3, 12])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                    rng.Style.Font.Color.SetColor(Color.White);
                }

                using (ExcelRange rng = ws.Cells[1, 11])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                    rng.Style.Font.Color.SetColor(Color.White);

                }
            }
    }
}