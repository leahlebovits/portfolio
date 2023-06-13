update DevSubSection
set vchProgrammingCode =
'
    public partial class frmRecipeEdit : Form
    {
        public enum ListTypeEnum{RecipeIngredient, RecipeStep, Rating};

        DataTable tbl;

        bizRecipe recipeobj = new bizRecipe();

        string TableNameValue = "Recipe";

        public int iRecipeId { get; private set; }

        public frmRecipeEdit()
        {
            InitializeComponent();
            btnSave.Click += BtnSave_Click;
            btnDelete.Click += BtnDelete_Click;
            gListIngredientMeasurementDescription.CellDoubleClick += GListIngredientMeasurementDescription_CellDoubleClick;
            gListRating.CellDoubleClick += GListRating_CellDoubleClick;
            gListRecipeStep.CellDoubleClick += GListRecipeStep_CellDoubleClick;
            btnAddIngredient.Click += BtnAddIngredient_Click;
            btnAddRecipeStep.Click += BtnAddRecipeStep_Click;
            btnAddRating.Click += BtnAddRating_Click;
        }

        private void BindControls(ListTypeEnum ListTypeValue)
        {
            this.ListType = ListTypeValue;
            this.Text = ListTypeValue.ToString();
            bizObject obj = new bizObject(ListTypeValue.ToString());
            gListRating.DataSource = obj.LoadForeignKeyList(iRecipeId, TableNameValue);
            gListIngredientMeasurementDescription.DataSource = obj.LoadForeignKeyList(iRecipeId, TableNameValue);
            gListRecipeStep.DataSource = obj.LoadForeignKeyList(iRecipeId, TableNameValue);
            string ColumnNameToShow = "";
            WindowsUtility.SetupGrid(gListRating, ColumnNameToShow);
        }
        public ListTypeEnum ListType { get; set; }
        public void ShowForm(int Id)
        {
            string ColumnNameToShow = "";

            if (Id == 0)
            {
                recipeobj.CreateNew();
            }

            else
            {
                tbl = recipeobj.Load(Id);
            }

            tbl = recipeobj.TableObject;

            this.Text = recipeobj.RecipeTitle.ToString();
    
            bizRating ra = new bizRating();
            DataTable dtrating = ra.LoadForeignKeyList(Id, TableNameValue);
            gListRating.DataSource = dtrating;
            WindowsUtility.SetupGrid(gListRating,ColumnNameToShow);
  

            bizRecipeStep rs = new bizRecipeStep();
            DataTable dtrecipestep = rs.LoadForeignKeyList(Id, TableNameValue);
            gListRecipeStep.DataSource = dtrecipestep;
            WindowsUtility.SetupGrid(gListRecipeStep, ColumnNameToShow);

            bizRecipeIngredient ri = new bizRecipeIngredient();
            DataTable dtrecipeingredient = ri.LoadForeignKeyList(Id, TableNameValue);
            gListIngredientMeasurementDescription.DataSource = dtrecipeingredient;
            WindowsUtility.SetupGrid(gListIngredientMeasurementDescription, ColumnNameToShow);

            bizUser u = new bizUser();
            DataTable dtuser = u.LoadList(true);
            lstUsers.DataSource = dtuser;
            lstUsers.DisplayMember = bizUser.FieldEnum.vchEmail.ToString();
            lstUsers.ValueMember = bizUser.FieldEnum.iUserId.ToString();
            lstUsers.DataBindings.Add("SelectedValue", tbl, bizUser.FieldEnum.iUserId.ToString());

            bizRecipeStatus rstat = new bizRecipeStatus();
            DataTable dtrecipestatus = rstat.LoadList(true);
            lstRecipeStatus.DataSource = dtrecipestatus;
            lstRecipeStatus.DisplayMember = bizRecipeStatus.FieldEnum.vchStatusDescription.ToString();
            lstRecipeStatus.ValueMember = bizRecipeStatus.FieldEnum.iRecipeStatusId.ToString();
            lstRecipeStatus.DataBindings.Add("SelectedValue", tbl, bizRecipeStatus.FieldEnum.iRecipeStatusId.ToString());

            bizMealCategory mc = new bizMealCategory();
            DataTable dtmealcategory = mc.LoadList(true);
            lstMealCategory.DataSource = dtmealcategory;
            lstMealCategory.DisplayMember = bizMealCategory.FieldEnum.vchMealCategoryName.ToString();
            lstMealCategory.ValueMember = bizMealCategory.FieldEnum.iMealCategoryId.ToString();
            lstMealCategory.DataBindings.Add("SelectedValue", tbl, bizMealCategory.FieldEnum.iMealCategoryId.ToString());

            bizCuisineType ct = new bizCuisineType();
            DataTable dtcuisinetype = ct.LoadList(true);
            lstCuisineType.DataSource = dtcuisinetype;
            lstCuisineType.DisplayMember = bizCuisineType.FieldEnum.vchCuisineTypeName.ToString();
            lstCuisineType.ValueMember = bizCuisineType.FieldEnum.iCuisineTypeId.ToString();
            lstCuisineType.DataBindings.Add("SelectedValue", tbl,bizCuisineType.FieldEnum.iCuisineTypeId.ToString());

            txtRecipeTitle.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.vchRecipeTitle.ToString());
            txtRecipeCode.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.chRecipeCode.ToString());
            txtDateCreated.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.dDateCreated.ToString());
            txtDatePublished.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.dDatePublished.ToString());
            txtCaloriesPerRecipe.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.iCaloriesPerRecipe.ToString());
            txtOuncesPerServing.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.iOuncesPerServing.ToString());
            txtPrepTimeinMinutes.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.iPrepTimeInMinutes.ToString());
            txtNumofViews.DataBindings.Add("Text", tbl, bizRecipe.FieldEnum.iNumOfViews.ToString());

            this.Show();
        }

        private void BtnAddRating_Click(object sender, EventArgs e)
        { 
            frmRatingEdit ra = new frmRatingEdit();
            ra.MdiParent = this.MdiParent;
            ra.WindowState = FormWindowState.Maximized;
            ra.ShowForm(0, recipeobj.RecipeId, txtRecipeTitle.Text); 
        }
        private void BtnAddRecipeStep_Click(object sender, EventArgs e)
        {
            frmRecipeStepEdit rs = new frmRecipeStepEdit();
            rs.MdiParent = this.MdiParent;
            rs.WindowState = FormWindowState.Maximized;
            rs.ShowForm(0, recipeobj.RecipeId, txtRecipeTitle.Text);
        }

        private void BtnAddIngredient_Click(object sender, EventArgs e)
        {
            frmRecipeIngredientEdit ri = new frmRecipeIngredientEdit();
            ri.MdiParent = this.MdiParent;
            ri.WindowState = FormWindowState.Maximized;
            ri.ShowForm(0, recipeobj.RecipeId,txtRecipeTitle.Text);
        }
        public void GListRecipeStep_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = WindowsUtility.GetIdFromGrid(ListTypeEnum.RecipeStep.ToString(), gListRecipeStep, e);
            frmRecipeStepEdit rs = new frmRecipeStepEdit();
            rs.MdiParent = this.MdiParent;
            rs.ShowForm(id);
        }
        private void GListRating_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = WindowsUtility.GetIdFromGrid(ListTypeEnum.Rating.ToString(), gListRating, e);
            frmRatingEdit ra = new frmRatingEdit();
            ra.MdiParent = this.MdiParent;
            ra.ShowForm(id);
        }

        private void GListIngredientMeasurementDescription_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = WindowsUtility.GetIdFromGrid(ListTypeEnum.RecipeIngredient.ToString(), gListIngredientMeasurementDescription, e);
            frmRecipeIngredientEdit ri = new frmRecipeIngredientEdit();
            ri.MdiParent = this.MdiParent;
            ri.ShowForm(id);
        }
        private void DoSave()
        {
            BindingContext[tbl].EndCurrentEdit();
            try
            {
                recipeobj.Save();
            }
            catch (CPUException ex)
            {
                MessageBox.Show(ex.Message, "RecipeWebsiteDB", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

        }
        private void DoDelete()
        {
            DialogResult response = MessageBox.Show("Are you sure you want to delete this recipe?", "RecipeWebsiteDB", MessageBoxButtons.YesNo);

            if (response == DialogResult.No)
            {
                return;
            }
            recipeobj.Delete();

            this.Close();
        }

        private void BtnDelete_Click(object sender, EventArgs e)
        {
            DoDelete();
        }

        private void BtnSave_Click(object sender, EventArgs e)
        {
            DoSave(); 
        }
    }
'
where vchDevSubSectionCode = 'recipe'