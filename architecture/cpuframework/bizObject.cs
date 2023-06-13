using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace cpuframework
{
    public class bizObject
    {
        SqlDataAdapter _adapter;
        DataTable _tbl;
        bool bHasGet; bool bHasUpdate; bool bHasDelete;
        private enum SprocTypeEnum { Get, Update, Delete}
        public bizObject(string TableNameValue, bool HasGet = true, bool HasUpdate = true, bool HasDelete = true)
        {
            TableName = TableNameValue;
            bHasGet = HasGet; bHasUpdate = HasUpdate; bHasDelete = HasDelete;
        }
        public SqlDataAdapter AdapterObject
        {
            get {
                SetupAdapter();  
            return _adapter; }
        }
        public string TableName
        {
            get;
            private set;
        }
        public int PrimaryKeyValue
        {
            get
            {
                int val = this.GetFieldValueAsInt(this.PrimaryKeyFieldName);
 
              
                return val;
            }
            set
            {
                this.SetFieldValueAsInt(this.PrimaryKeyFieldName, value);
            }
        }
        public string PrimaryKeyFieldName
        {
            get { return "i" + this.TableName + "Id"; }
        }
        public DataTable TableObject
        {
            get { return _tbl; }
            protected set
            {
                _tbl = value;
            }
        }
        public DataTable Load(int IdValue)
        {
            SqlCommand cmd = this.GetSqlCommand(SprocTypeEnum.Get);
            cmd.Parameters["@" + this.PrimaryKeyFieldName].Value = IdValue;

            _tbl = SQLUtility.GetDataTable(this.AdapterObject);

            return _tbl;
        }
        public DataTable LoadByFieldName(string FieldName, int IdValue)
        {
            SqlCommand cmd = this.GetSqlCommand(SprocTypeEnum.Get);
            if (cmd.Parameters.Contains("@" + FieldName) == false)
            {
                throw new Exception("Parameter" + FieldName + "does not existfor sproc" + cmd.CommandText);
            }
        
            cmd.Parameters["@" + FieldName].Value = IdValue;

            _tbl = SQLUtility.GetDataTable(this.AdapterObject);

            return _tbl;
        }
        public DataTable LoadByFieldName(string FieldName, string StringValue)
        {
            SqlCommand cmd = this.GetSqlCommand(SprocTypeEnum.Get);
            if (cmd.Parameters.Contains("@" + FieldName) == false)
            {
                throw new Exception("Parameter" + FieldName + "does not existfor sproc" + cmd.CommandText);
            }

            cmd.Parameters["@" + FieldName].Value = StringValue;

            _tbl = SQLUtility.GetDataTable(this.AdapterObject);

            return _tbl;
        }
        public DataTable LoadList(bool IncludeBlank)
        {
            SqlCommand cmd = this.GetSqlCommand(SprocTypeEnum.Get);
            cmd.Parameters["@bAll"].Value = 1;
            cmd.Parameters["@bIncludeBlank"].Value = IncludeBlank; 
            DataTable t = SQLUtility.GetDataTable(this.AdapterObject);
            return t;
        }
        public DataTable LoadForeignKeyList(int IdValue, string TableNameValue)
        {
            SqlCommand cmd = this.GetSqlCommand(SprocTypeEnum.Get);
            cmd.Parameters["@i" + TableNameValue + "Id"].Value = IdValue;
            DataTable dt = SQLUtility.GetDataTable(this.AdapterObject);
            return dt;
        }
        public void CreateNew()
        {
            this.Load(0);
            foreach (DataColumn col in _tbl.Columns)
            {
                if (col.DataType == typeof(bool))
                {
                    col.DefaultValue = false;
                }
                else if (col.DataType == typeof(int) || col.DataType == typeof (Int16))
                {
                    col.AutoIncrement = false;
                    col.DefaultValue = 0;
                }
            }
            _tbl.Rows.Add();
        }
        public void Save()
        {
            SQLUtility.ExecuteAdapter(this.AdapterObject, _tbl);
        }
        public void Delete()
        {
            _tbl.Rows[0].Delete();
            SQLUtility.ExecuteAdapter(this.AdapterObject, _tbl);
        }
        protected int GetFieldValueAsInt(string FieldName)
        {
            int val = 0;

            if (IsFieldValidToRead(FieldName))
            {
                val = (int)this.TableObject.Rows[0][FieldName];
            }

            return val; ;
        }
        protected string GetFieldValueAsString(string FieldName)
        {
            string val = "";

            if (IsFieldValidToRead(FieldName))
            {
                val = (string)this.TableObject.Rows[0][FieldName];
            }

            return val;
        }
        protected bool GetFieldValueAsBool (string FieldName)
        {
            bool val = false;

            if (IsFieldValidToRead(FieldName) == true)
            {
                val = (bool)this.TableObject.Rows[0][FieldName];
            }

            return val;
        }
        protected decimal GetFieldValueAsDecimal(string FieldName)
        {
            decimal val = 0;

            if (IsFieldValidToRead(FieldName) == true)
            {
                val = (decimal)this.TableObject.Rows[0][FieldName];
            }

            return val;
        }
        protected DateTime? GetFieldValueAsDate(string FieldName)
      {
          DateTime? val = null;
      
          if (IsFieldValidToRead(FieldName) == true)
          {
              val = (DateTime?)this.TableObject.Rows[0][FieldName];
          }
      
          return val;
      }
        protected void SetFieldValueAsString(string FieldName, string value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsInt(string FieldName, int value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsBool(string FieldName, bool value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsDecimal(string FieldName, decimal value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsDate(string FieldName,  DateTime? value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        private void EnsureTableAndRowExist(string FieldName)
        {
            
            if (this.TableObject == null)
            {
                this.Load(0);
            }
            this.CheckFieldExists(FieldName);
            if (this.TableObject.Rows.Count == 0)
            {
                this.CreateNew();
            }
        }
        private bool IsFieldValidToRead(string FieldName)
        {
            bool b = false;
            if (this.TableObject != null && this.TableObject.Rows.Count > 0)
            {
                CheckFieldExists(FieldName);
                if (this.TableObject.Rows[0].IsNull(FieldName) == false)
                {
                    b = true;
                }
               
            }
            return b;
        }
        private void CheckFieldExists(string FieldName)
        {
            SqlCommand cmd = this.GetSqlCommand(SprocTypeEnum.Get);
            if (this.TableObject.Columns.Contains(FieldName) == false)
            {
                string msg = this.TableName;

                if (cmd != null) 
                { msg = cmd.CommandText; }

                msg = msg + " does not contain" + FieldName;

                throw new Exception(msg);
            }
        }
        private void SetupAdapter()
        {
            if(_adapter == null)
            {
                _adapter = SQLUtility.GetSQLAdapter(this.TableName, bHasGet, bHasUpdate, bHasDelete);
            }
        }
        private SqlCommand GetSqlCommand(SprocTypeEnum SprocTypeValue, bool FailonNotExists = true)
        {
            SetupAdapter();
            SqlCommand cmd = null;
            switch (SprocTypeValue)
            {
                case SprocTypeEnum.Get:
                    cmd = this.AdapterObject.SelectCommand;
                    break;
                case SprocTypeEnum.Update:
                    cmd = this.AdapterObject.UpdateCommand;
                    break;
                case SprocTypeEnum.Delete:
                    cmd = this.AdapterObject.DeleteCommand;
                    break;
            }
            if(FailonNotExists == true && cmd == null)
            {
                throw new Exception(this.TableName + SprocTypeValue.ToString() + " does not exist.");
            }
            return cmd;
        }
    }
}
 