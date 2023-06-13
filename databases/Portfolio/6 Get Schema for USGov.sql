update DevSubSection
set vchProgrammingCode = 
'
create table dbo.party(
	iPartyId int not null identity primary key,
	vchPartyName varchar (50) not null
		constraint ck_party_name_cannot_be_blank check(vchPartyName > '''')
		constraint u_party_name_must_be_unique unique
)

go
		create table dbo.president(
		iPresidentId int not null identity (1000,1) primary key,
		iPartyId int not null constraint f_party_president foreign key references party (iPartyId),
		iNum int not null constraint ck_president_num_must_be_unique unique,
		vchFirstName varchar(100) not null constraint ck_president_first_name_cannot_be_blank check (vchFirstName <> ''''),
		vchLastName varchar(100) not null constraint ck_president_lastname_cannot_be_blank check(vchLastName <> ''''),
		iYearBorn int not null,
		iYearDied int,
		iTermStart int not null,
		iTermEnd int null,
		constraint ck_president_year_died_must_be_after_year_born check (iYearDied > iYearBorn),
		constraint ck_president_termend_cannot_be_before_term_start check (iTermEnd >= iTermStart),
		iAgeDied as iYearDied - iYearBorn persisted,
        iAgeStartTerm as iTermStart - iYearBorn persisted,
	    iAgeEndTerm as iTermEnd - iYearBorn persisted
	)
go

select * from president 
	create table dbo.medal(
		iMedalId int not null identity primary key,
		vchMedalName varchar(250) not null
			constraint ck_medal_cannot_be_blank check(vchMedalName <> '''')
			constraint u_medal_must_be_unique unique 
		)
go

	create table dbo.PresidentMedal(
		iPresidentMedalId int not null identity primary key,
		iPresidentId int not null constraint f_president_PresidentMedal foreign key references president (iPresidentId),
		iMedalId int not null constraint f_president_medal foreign key references medal(iMedalId),
		constraint u_PresidentMedal_must_be_unique unique(iPresidentId, iMedalId)
	)


go
create table dbo.ExecutiveOrder(
	iExecutiveOrderId int not null identity primary key,
	iPresidentId int not null 
		constraint f_executiveorder_presidentId foreign key references president(iPresidentId),
	iExecutiveOrderNumber int not null
		constraint u_executiveorder_executiveordernumber_must_be_unique unique
		constraint ck_executiveorder_executiveordernumber_cannot_be_negative check(iExecutiveOrderNumber > 0),
	vchVolumeNumberandName varchar (10) not null default ''3 C.F.R.'', 
		constraint ck_executiveorder_volumenumberandname_cannot_be_blank check(vchVolumeNumberandName > ''''),
	iPageNumber int not null
		constraint ck_executiveorder_pagenumber_cannot_be_negative check(iPageNumber > 0),
	iYearIssued int not null, 
		constraint ck_executiveorder_yearissued_must_be_greater_than_1776 check(iYearIssued >= 1776),
	vchOrderName varchar (300) not null, 
		constraint ck_executiveorder_ordername_cannot_be_blank check(vchOrderName > ''''),
	bOrderStatus bit not null,
	dtDateCreated datetime not null default getdate()
)
'
where vchDevSubSectionCode = 'USGov'