delete SampleQuery
delete DevSubSection
delete DevSection
insert DevSection(vchDevSectionCode,vchDevSectionDesc,vchDevSectionMiniBlurb,vchDevSectionBlurb, vchDevTechUsed, iDevSectionSequence)
select 'db','DB Schemas','Each database is handwritten using constraints,foreign keys, functions, and stored procedures to produce a safe and secure system....','Each database is handwritten using constraints,foreign keys, functions, and stored procedures to produce a safe and secure system.', ' JQuery, AJAX and Partial Views', 1
union 
select 'framework','Framework/Business Objects','A reusable code framework is the hallmark of a strong software system. A custom framework makes development and long-term production of software easier...','A reusable code framework is the hallmark of a strong software system. A custom framework makes development and long-term production of software easier, smoother, and less error-prone with centralized, reusable code tailored specifically for the business needs. This section describes my object-oriented multi-platform framework, which can be used for Windows, web, and mobile-based apps. Business objects, customized for each application, inherit the generic BizObject. Each strongly-typed object contains properties accessed by enumeration to avoid errors. Special events and properties, such as PlaceOrder and OrderDetailList, are defined for each business object. ', '',2
union 
select 'windows','Windows Projects','Windows applications, written in C# uses CPU Framework and object-oriented programming to optimize development and durability...','Windows applications, written in C# uses CPU Framework and object-oriented programming to optimize development and durability. Applications emphasize clean, focused design and usability. ', '',3
union
select 'web','Web Projects','Data-driven web applications use powerful technologies like MVC for clean user interfaces, intuitive navigation, and organized, configurable code...','Data-driven web applications use powerful technologies like MVC for clean user interfaces, intuitive navigation, and organized, configurable code. Data access is strong and secure with CPUFramework, which loads, saves, and validates data. Hosted in Azure, Microsoft’s cloud service, web applications are easy to manage and deploy. Website code incorporates HTML, Bootstrap, JavaScript, jQuery, and ASP.Net. ', '',4

insert DevSubSection(iDevSectionId, vchDevSubSectionCode, vchDevSubSectionDesc,  vchDevSubSectionBlurb, iDevSubSectionSequence)
select d.iDevSectionId, 'USGov', 'US Gov', 'Database to store US Gov information',0 from DevSection d where d.vchDevSectionCode = 'db'
union
select d.iDevSectionId, 'Portfolio', 'Portfolio', 'Database that drives this site', 1 from DevSection d where d.vchDevSectionCode = 'db'
union
select d.iDevSectionId, 'RecipeWebsiteDb', 'Recipe', 'This recipe database was created based on a detailed user spec which was translated into a relational schema. Secure logins allow administrative staff to create recipes that include ingredients and instructions. External users can suggest recipes that can be published by staff. External users can view and like/dislike specific recipes. Recipes are categorized by their cuisine and course to allow for flexible display and organization.  ', 2 from DevSection d where d.vchDevSectionCode = 'db'
--- framework
union
select d.iDevSectionId,'cpuframework','CPUFramework','CPUFramework integrates with strongly-scripted databases to streamline production of any kind of software. It contains object-oriented code that is common to all applications, such as login functionality, error handling, and data binding. Using consistent naming conventions and validating inputs add further value to this framework.',0
from DevSection d where d.vchDevSectionCode = 'framework'
union
select d.iDevSectionId, 'bizObject', 'bizObject', 'BizObject is the generic business object defined in CPUFramework. It maintains the dialogue between database tables and user inputs, necessary to bind, save, load, and present data. A system using CPUFramework has library of business objects that inherit from the generic BizObject.',1 
from DevSection d where d.vchDevSectionCode = 'framework'
union
select d.iDevSectionId, 'sqlutility', 'SQLUtility', 'SQLUtility is a module, or static class, that stores general utilities that can be used for any program. It sets up connection strings, returns a data table from a stored procedure or SQL statement, parses error messages, and hosts much other shared code.',2
from DevSection d where d.vchDevSectionCode = 'framework'
union
select d.iDevSectionId, 'cpuexception', 'CPUException', 'Inherits from Exception and provides special handling for validation errors in the stored procedures',3
from DevSection d where d.vchDevSectionCode = 'framework'
union
select d.iDevSectionId, 'bizrecipe','bizRecipe', 'A unique library of code inherited from the bizObject pertaining to the data that creates the recipe website.', 4
from DevSection d where d.vchDevSectionCode = 'framework'
--windows
union
select d.iDevSectionId, 'tictactoe', 'Tic Tac Toe', 'Classical Tic Tac Toe Game. Play against another player or against the computer, it''s your choice!', 0
from DevSection d
where d.vchDevSectionCode = 'windows'
union 
select d.iDevSectionId, 'recipe', 'Recipe', 'The recipe windows front end gives users the ability to view, edit, and maintain recipe information. This was implemented using the CPU Framework architecture and recipe business objects.', 1
from DevSection d
where d.vchDevSectionCode = 'windows'
union
select d.iDevSectionId, 'bingogame', 'Bingo Game', 'Classic Bingo Game with options for one or two person games', 2
from DevSection d
where d.vchDevSectionCode = 'windows'
-- web
insert DevSubSection(iDevSectionId, vchDevSubSectionCode, vchDevSubSectionDesc,  vchDevSubSectionBlurb, iDevSubSectionSequence, vchUrl)
select d.iDevSectionId, 'usgovweb', 'USGov', 'The US Gov website is a platform for managing data related to the US Federal government. It uses the basic principles of object-oriented web-based programming to create, read, update, and delete data. Lists of parties, presidents, and executive orders are available to view and modify at will.
', 0,'https://lzusgov.azurewebsites.net/'
from DevSection d
where d.vchDevSectionCode = 'web'
union
select d.iDevSectionId, 'recipeweb', 'Recipe', 'Recipe website website name allows users to view, edit, and maintain recipe information, play a recipe game, and get the recipe REST API. It was designed by applying Bootstrap classes and HTML styles and uses JavaScript, JQuery, partial views, and AJAX. The website ensures secure logins. To login as an external user, use username ..., password .... This was implemented using the CPU Framework architecture and recipe business objects.', 1, 'https://ravingreviews.azurewebsites.net/'
from DevSection d
where d.vchDevSectionCode = 'web'

insert SampleQuery(iDevSubSectionId,vchQueryCaption,vchQuery,iSequence)
select s.iDevSubSectionId, '', '',0
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union
select s.iDevSubSectionId, 'select all presidents', 'select * from president',1
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union
select s.iDevSubSectionId, 'select all parties', 'select * from party', 2
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union
select s.iDevSubSectionId, 'select all Executive Orders','select * from executiveorder',3
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union
select s.iDevSubSectionId, 'select num presidents per party',
'select iNum = count(*), y.vchPartyName
from president p 
join party y 
on p.iPartyId = y.iPartyId
group by y.vchPartyName',4
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union 
select s.iDevSubSectionId, 'select first ten presidents',
'select top 10*
from president p 
order by p.iNum',5
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union
select s.iDevSubSectionId, 'select all presidents ordered by length of first name',
'select *, iLenFirstName = len(p.vchFirstName) 
from president p 
order by LEN(p.vchFirstName)',6
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union 
select s.iDevSubSectionId, 'select all presidents that have a middle name',
'select iMiddleNameStart = CHARINDEX('' '',p.vchFirstName),*
from president p 
where p.vchFirstName like ''% %''',7
from DevSubSection s 
where s.vchDevSubSectionCode = 'USGov'
union 
select s.iDevSubSectionId, '', '',0
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union
select s.iDevSubSectionId, 'select all recipes', 'select * from recipe', 1
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union 
select s.iDevSubSectionId, 'select the most viewed recipe', ' select top 1 * from recipe r order by r.iNumOfViews desc',2s
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union 
select s.iDevSubSectionId, 'select the American style dishes', 
'select r.vchRecipeTitle,c.vchCuisineTypeName
from recipe r
join CuisineType c
on r.iCuisineTypeId = c.iCuisineTypeId
where c.vchCuisineTypeName =''American'' ', 3
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union
select s.iDevSubSectionId, 'select all Recipes published before 2014 or after 2018',
'select vchRecipeTitle, dDatePublished
from recipe 
where 
(
	dDatePublished <''2014-01-01''
	or dDatePublished >=''2018-01-01''
)
order by dDatePublished',4
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union
select s.iDevSubSectionId, 'select all Recipes that contain Chocolate or Chicken in them',
'select * 
from recipe r
where 
(
 r.vchRecipeTitle like''%chocolate%''
	or r.vchRecipeTitle  like''%chicken%''
)', 5
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union
select s.iDevSubSectionId, 'select all Recipes that have a commented rating',
'select * 
from recipe r
join rating ra
on r.iRecipeId = ra.iRecipeId
where ra.vchComment <> '' ''', 6
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union
select s.iDevSubSectionId, 'see a list with views replaced by stars and order recipes by number of views',
'select r.vchRecipeTitle, vchStarredViews =  replicate(''*'', r.iNumofViews)
from recipe r
order by r.iNumofViews desc', 7
from DevSubSection s 
where s.vchDevSubSectionCode = 'RecipeWebsiteDB'
union
select s.iDevSubSectionId, '', '',0
from DevSubSection s 
where s.vchDevSubSectionCode = 'Portfolio'
union
select s.iDevSubSectionId, 'select all Sections', 'select * from DevSection',1
from DevSubSection s 
where s.vchDevSubSectionCode = 'Portfolio'
union
select s.iDevSubSectionId, 'select all subsections', 'select * from DevSubSection',2
from DevSubSection s 
where s.vchDevSubSectionCode = 'Portfolio'
union
select s.iDevSubSectionId, 'order all sections by blurb alphabetically' , 'select * from DevSection d order by d.vchDevSectionBlurb',3
from DevSubSection s 
where s.vchDevSubSectionCode = 'Portfolio'
