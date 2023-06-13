using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace cpuframework
{
    public static class WindowsUtility
    {

        public static void SetupGrid(DataGridView GridObj, string ColumnNameToShow)
        {
            GridObj.AllowUserToAddRows = false;
            GridObj.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            GridObj.ReadOnly = true;
            GridObj.RowHeadersWidth = 23;
            GridObj.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            foreach (DataGridViewColumn col in GridObj.Columns)
            {
                if (col.Name.StartsWith("i") & col.Name.ToLower().EndsWith("id"))
                {
                    col.Visible = false;
                }
                else
                {
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "vch");
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "i");
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "b");
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "dc");
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "dt");
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "d");
                    col.HeaderText = ParseColumnHeader(col.HeaderText, "ch");

                    string newvalue = "";
                    foreach (char c in col.HeaderText.ToCharArray())
                    {
                        if (newvalue != "" & c.ToString() == c.ToString().ToUpper())
                        {
                            newvalue = newvalue + " ";
                        }
                            newvalue = newvalue + c;
                    }
                    col.HeaderText = newvalue;
                    col.HeaderCell.Style.WrapMode = DataGridViewTriState.False;
                }
                 if (col.DataPropertyName != ColumnNameToShow && ColumnNameToShow != "")
                {
                    col.Visible = false;
                }
            }
        }
        private static string  ParseColumnHeader(string HeaderText, string Prefix)
        {
            string value = HeaderText;

            if (value.StartsWith(Prefix))
            {
               value = value.Substring(Prefix.Length, value.Length - Prefix.Length);
            }

            return value;
        }
        public static int GetIdFromGrid (string TableName, DataGridView GridObj, DataGridViewCellEventArgs e )
        {
            int id = 0;
            string colname = "i" + TableName  + "id";
            id = (int)GridObj.Rows[e.RowIndex].Cells[colname].Value;
            return id;
        }
        //get id from grid (parameters)
        //return the select primary key
    }
}
