using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using cpuframework;
namespace PortfolioBizObjects
{
    public class bizSampleQuery : bizObject
    {
        public enum FieldEnum
        {
            vchQueryCaption,vchQuery
        }
        public bizSampleQuery() : base("SampleQuery", true, false, false)
        {
        }
        public List<bizSampleQuery> SampleQueriesforDB(int DevSubSectionIdValue)
        {
            List<bizSampleQuery> lst = new List<bizSampleQuery>();
            DataTable dt = this.LoadForeignKeyList( DevSubSectionIdValue, "DevSubSection");

            foreach (DataRow r in dt.Rows)
            {
                DataTable newtable = dt.Clone();
                newtable.ImportRow(r);
                bizSampleQuery newobj = new bizSampleQuery();
                newobj.TableObject = newtable;
                lst.Add(newobj);
            }
            return lst;
        }
        public string QueryCaption
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.vchQueryCaption.ToString());
            }
        }
        public string Query
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.vchQuery.ToString());
            }
        }
    }
}