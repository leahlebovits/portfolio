update DevSubSection
set vchProgrammingCode = '
    public class bizRecipe : bizObject
    {
        public enum FieldEnum
        {
            iRecipeId,
            iUserId,
            iCuisineTypeId,
            iMealCategoryId,
            iRecipeStatusId,
            vchRecipeTitle,
            chRecipeCode,
            iCaloriesPerRecipe,
            iOuncesPerServing,
            iPrepTimeInMinutes,
            iNumOfViews,
            vchIngredientName,
            vchMealCategoryName,
            vchCuisineTypeName,
            vchStatusDescription,
            vchUserName,
            iLikes,
            iDislikes,
            vchEmail
        }
        public bizRecipe() : base("Recipe")
        {

        }
        [Required]
        [Display(Name = "Recipe Title")]
        public string RecipeTitle
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.vchRecipeTitle.ToString());
            }
            set
            {
                this.SetFieldValueAsString(FieldEnum.vchRecipeTitle.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Recipe Code")]
        public string RecipeCode
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.chRecipeCode.ToString());
            }
            set
            {
                this.SetFieldValueAsString(FieldEnum.chRecipeCode.ToString(), value);
            }
        }
        public int RecipeId
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iRecipeId.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iRecipeId.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "User")]
        public int UserId
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iUserId.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iUserId.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Cuisine Type")]
        public int CuisineTypeId
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iCuisineTypeId.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iCuisineTypeId.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Meal Category")]
        public int MealCategoryId
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iMealCategoryId.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iMealCategoryId.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Recipe Status")]
        public int RecipeStatusId
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iRecipeStatusId.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iRecipeStatusId.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Calories Per Recipe")]
        public int CaloriesPerRecipe
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iCaloriesPerRecipe.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iCaloriesPerRecipe.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Ounces Per Serving")]
        public int OuncesPerServing
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iOuncesPerServing.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iOuncesPerServing.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Prep Time In Minutes")]
        public int PrepTimeinMinutes
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iPrepTimeInMinutes.ToString());
            }
            set
            {
                this.SetFieldValueAsInt(FieldEnum.iPrepTimeInMinutes.ToString(), value);
            }
        }
        [Required]
        [Display(Name = "Number Of Views")]
        public int NumofViews
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iNumOfViews.ToString());
            }
        }
        public string IngredientName
        {
            get
            {
                {
                    return this.GetFieldValueAsString(FieldEnum.vchIngredientName.ToString());
                }
            }
        }
        public string MealCategoryName
        {
            get
            {
                {
                    return this.GetFieldValueAsString(FieldEnum.vchMealCategoryName.ToString());
                }
            }
        }
        public string CuisineTypeName
        {
            get
            {
                {
                    return this.GetFieldValueAsString(FieldEnum.vchCuisineTypeName.ToString());
                }
            }
        }
        public string StatusDescription
        {
            get
            {
                {
                    return this.GetFieldValueAsString(FieldEnum.vchStatusDescription.ToString());
                }
            }
        }
        public int Likes
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iLikes.ToString());
            }
        }
        public int Dislikes
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iDislikes.ToString());
            }
        }
      public string UserEmail
      {
          get
          {
              return this.GetFieldValueAsString(FieldEnum.vchEmail.ToString());
          }
      }
        public List<bizRecipe> GetList(bool IncludeBlank = false)
        {
            List<bizRecipe> lst = new List<bizRecipe>();

            DataTable dt = this.LoadList(IncludeBlank);

            foreach (DataRow dr in dt.Rows)
            {
                bizRecipe r = new bizRecipe();
                r.Load((int)dr[this.PrimaryKeyFieldName]);
                lst.Add(r);
            }

            return lst;
        }
        public List<bizRecipe> GetListTopTen(SqlCommand cmd) 
        {    
            List<bizRecipe> lst = new List<bizRecipe>();
            DataTable dt = SQLUtility.GetDataTable(cmd);
            foreach (DataRow dr in dt.Rows)
            {
             bizRecipe r = new bizRecipe();
             r.Load((int)dr[this.PrimaryKeyFieldName]);
             lst.Add(r);
            }

            return lst;
       }
        public List<bizRecipeIngredient> GetRecipeIngredientList(bool IncludeBlank = false)
        {
            List<bizRecipeIngredient> lst = new List<bizRecipeIngredient>();

            DataTable dt = this.LoadList(IncludeBlank);

            foreach (DataRow dr in dt.Rows)
            {
                bizRecipeIngredient ri = new bizRecipeIngredient();
                ri.Load((int)dr[this.PrimaryKeyFieldName]);
                lst.Add(ri);
            }
            return lst;
        }
   
        public List<bizIngredient> IngredientList
        {
            get
            {
                bizIngredient i = new bizIngredient();
                return i.GetList(true);
            }
        }
        public List<bizMeasurement> MeasurementList
        {
            get
            {
                bizMeasurement m = new bizMeasurement();
                return m.GetList(true);
            }
        }
        public List<bizRating> RatingList
        {
            get
            {
                bizRating r = new bizRating();
                return r.GetList(true);
            }
        }
        public List<bizRecipeIngredient> RecipeIngredients
        {
            get
            {
                bizRecipeIngredient ri = new bizRecipeIngredient();
                return ri.GetListByRecipeId(this.PrimaryKeyValue);
            }
        }
        public List<bizRecipeStep> RecipeSteps
        {
            get
            {
                bizRecipeStep rs = new bizRecipeStep();
                return rs.GetListByRecipeId(this.PrimaryKeyValue);
            }
        }
        public List<bizRating> Ratings
        {
            get
            {
                bizRating r = new bizRating();
                return r.GetListByRecipeId(this.PrimaryKeyValue);
            }
        }
        public List<bizCuisineType> CuisineType
        {
            get
            {
                bizCuisineType c = new bizCuisineType();
                return c.GetList(true);
            }
        }
        public List<bizMealCategory> MealCategory
        {
            get
            {
                bizMealCategory m = new bizMealCategory();
                return m.GetList(true);
            }
        }
        public List<bizUser> User
        {
            get
            {
                bizUser u = new bizUser();
                return u.GetList(true);
            }
        }
        public List<bizRecipeStatus> RecipeStatus
        {
            get
            {
                bizRecipeStatus rs = new bizRecipeStatus();
                return rs.GetList(true);
            }
        }
    
    }
'
where vchDevSubSectionCode = 'bizrecipe'