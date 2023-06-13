update DevSubSection
set vchProgrammingCode =
'
create table dbo.CuisineType(
	iCuisineTypeId int not null identity primary key,
	vchCuisineTypeName varchar (40) not null
		constraint ck_cuisinetype_name_cannot_be_blank check(vchCuisineTypeName <> '''')
		constraint u_cuisinetype_name_must_be_unique unique 
)
go 

create table dbo.MealCategory(
	iMealCategoryId int not null identity primary key,
	vchMealCategoryName varchar (40) not null
		constraint ck_mealcategory_name_cannot_be_blank check(vchMealCategoryName <> '''')
		constraint u_mealcategory_name_must_be_unique unique 
)
go

create table dbo.roles(
	iRoleId int not null identity primary key,
	vchRoleName varchar(50) not null
		constraint c_role_name_cannot_be_blank check(vchRoleName > '''')
		constraint u_role_name_must_be_unique unique,
	iRole int not null
		constraint c_role_cannot_be_blank check(iRole >= 0)
		constraint u_role_must_be_unique unique
)
go

create table dbo.users(
	iUserId int not null identity primary key,
	iRoleId int not null 
		constraint f_role_user foreign key references roles(iRoleId),
	vchUserName varchar(50) not null
		constraint c_user_name_must_be_a_minimum_of_five_characters check(len(vchUserName) >= 5 and vchUserName <> '''')
		constraint u_user_name_must_be_unique unique,
	vchFirstName varchar(50) not null,
		constraint c_user_first_name_cannot_be_blank check(vchFirstName > ''''),
	vchLastName varchar(50) not null,
		constraint c_user_last_name_cannot_be_blank check(vchLastName > ''''),
	vchPassword varbinary(128) not null,
	vchEmail varchar(500) not null,
	bActive bit not null	
)
go

create table dbo.RecipeStatus(
	iRecipeStatusId int not null identity primary key,
	vchStatusDescription varchar (30) not null
		constraint ck_recipestatus_statusdescription_cannot_be_blank check(vchStatusDescription <> '''')
)
go

create table dbo.ingredient(
	iIngredientId int not null identity primary key,
	vchIngredientName varchar (50) not null
		constraint ck_ingredient_name_cannot_be_blank check(vchIngredientName <> '''')
		constraint u_ingredient_name_must_be_unique unique 
)
go

create table dbo.measurement(
	iMeasurementId int not null identity primary key,
	vchMeasurementType varchar (30) not null
		constraint ck_measurement_measurementtype_cannot_be_blank check(vchMeasurementType <> '''')
		constraint u_measurement_measurementtype_must_be_unique unique,
	bMeasurementDisplay bit not null
)
go

create table dbo.recipe(
	iRecipeId int not null identity primary key,
	iUserId int not null
		constraint f_users_recipe foreign key references users(iUserId),
	iCuisineTypeId int not null
		constraint f_cuisinetype_recipe foreign key references CuisineType (iCuisineTypeId),
	iMealCategoryId int not null
		constraint f_mealcategory_recipe foreign key references MealCategory (iMealCategoryId),
	iRecipeStatusId int not null
		constraint f_recipestatus_recipe foreign key references RecipeStatus (iRecipeStatusId),
	vchRecipeTitle varchar (60) not null
		constraint ck_recipe_title_cannot_be_blank check(vchRecipeTitle <> ''''),
	chRecipeCode char(6) not null 
		constraint ck_recipe_code_cannot_have_blank_spaces check(chRecipeCode not like ''% %'')
		constraint u_recipe_code_must_be_unique unique,
	dDateCreated date not null
		constraint ck_recipe_datecreated_must_be_after_1970 check (dDateCreated >= ''01-01-1970''),
	dDatePublished date
		constraint ck_recipe_datepublished_must_be_after_1970 check (dDatePublished >= ''01-01-1970''),
	iCaloriesPerRecipe int not null
		constraint ck_recipe_caloriesperrecipe_cannot_be_less_than_0 check (iCaloriesPerRecipe >= 0),
	iOuncesPerServing int not null
		constraint ck_recipe_ouncesperserving_must_be_greater_than_0 check (iOuncesPerServing > 0),
	iPrepTimeInMinutes int not null
		constraint ck_recipe_preptime_must_be_greater_than_0 check(iPrepTimeInMinutes > 0),
	iNumOfViews int not null
		constraint ck_recipe_views_cannot_be_negative check (iNumOfViews >= 0),
	constraint ck_recipe_datecreated_must_be_before_or_equal_to_datedpublished check(dDateCreated <= dDatePublished)
)
go

create table dbo.RecipeIngredient(
	iRecipeIngredientId int not null identity primary key,
	iRecipeId int not null
		constraint f_recipe_recipeingredient foreign key references recipe (iRecipeId),
	iIngredientId int not null
		constraint f_ingredient_recipeingredient foreign key references ingredient (iIngredientId),
	iMeasurementId int not null
		constraint f_measurement_recipeingredient foreign key references measurement (iMeasurementId),
	dcRecipeIngredientAmount dec (5,2) not null 
		constraint ck_recipeingredient_amount_must_be_greater_than_0 check (dcRecipeIngredientAmount > 0)
)
go

create table dbo.RecipeStep(
	iRecipeStepId int not null identity primary key,
	iRecipeId int not null
		constraint f_recipe_recipestep foreign key references recipe (iRecipeId),
	iSequenceNum int not null
		constraint ck_recipestep_sequencenum_must_be_greater_than_0 check (iSequenceNum > 0 ),
	vchRecipeDescription varchar (1000) not null
		constraint ck_recipestep_description_cannot_be_blank check (vchRecipeDescription <> ''''),
	constraint ck_recipestep_sequencenumber_per_recipe_must_be_unique unique (iRecipeId, iSequenceNum)
)
go

create table dbo.Rating(
	iRatingId int not null identity primary key,
	iUserId int not null
		constraint f_users_rating foreign key references Users (iUserId),
	iRecipeId int not null
		constraint f_recipe_rating foreign key references Recipe (iRecipeId),
	iLikes int not null default 0
		constraint ck_rating_likes_must_be_between_0_and_1 check(iLikes between 0 and 1),
	iDislikes int not null default 0
		constraint ck_rating_dislikes_must_be_between_0_and_1 check(iDislikes between 0 and 1),
	vchComment varchar (500) not null,
	constraint ck_rating_like_and_dislike_cannot_be_the_same_number check(not(iLikes = 0 and iDislikes = 0 ) or (not(iLikes = 1 and iDislikes = 1)))
)
'
where vchDevSubSectionCode = 'RecipeWebsiteDB'