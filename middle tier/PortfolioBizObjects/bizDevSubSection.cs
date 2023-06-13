using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using cpuframework;
using System.Data;

namespace PortfolioBizObjects
{
    public class bizDevSubSection: bizObject
    {
        public enum FieldEnum { iDevSectionId, vchDevSubSectionCode, vchDevSubSectionDesc, vchDevSectionCode, vchDevSubSectionBlurb,vchProgrammingCode ,iDevSubSectionSequence,vchUrl}
        public bizDevSubSection():base("DevSubSection",true,false,false)
        {

        }
        public int DevSectionId
        {
            get { return this.GetFieldValueAsInt(FieldEnum.iDevSectionId.ToString()); }
            set { this.SetFieldValueAsInt(FieldEnum.vchDevSubSectionCode.ToString(), value); }
        }
        public string DevSubSectionCode
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSubSectionCode.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSubSectionCode.ToString(), value); }
        }
        public string DevSectionCode
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSectionCode.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSectionCode.ToString(), value); }
        }
        public string DevSubSectionDesc
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSubSectionDesc.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSubSectionDesc.ToString(), value); }
        }
        public string DevSubSectionBlurb
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSubSectionBlurb.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSubSectionBlurb.ToString(), value); }
        }
        public string ProgrammingCode
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchProgrammingCode.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchProgrammingCode.ToString(), value); }
        }
        public int DevSubSectionSequence
        {
            get { return this.GetFieldValueAsInt(FieldEnum.iDevSubSectionSequence.ToString()); }
            set { this.SetFieldValueAsInt(FieldEnum.iDevSubSectionSequence.ToString(), value); }
        }
        public string Url
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchUrl.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchUrl.ToString(), value); }
        }
        public List<bizDevSubSection> GetListBySectionId(int DevSectionIdValue)
        {
            List<bizDevSubSection> lst = new List<bizDevSubSection>();
            bizDevSubSection s = new bizDevSubSection();
            DataTable dt = s.LoadForeignKeyList(DevSectionIdValue, "DevSection");
            foreach (DataRow r in dt.Rows)
            {
                DataTable newtable = dt.Clone();
                newtable.ImportRow(r);
                bizDevSubSection newobj = new bizDevSubSection();
                newobj.TableObject = newtable;
                lst.Add(newobj);
            }
            return lst;
        }
        public List<bizSampleQuery> SampleQueries
        {
            get
            {
                bizSampleQuery q = new bizSampleQuery();
                return q.SampleQueriesforDB(this.PrimaryKeyValue);
            }
        }
    }
}
