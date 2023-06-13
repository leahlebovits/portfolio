use Portfolio
go
drop table if exists SampleQuery
go
drop table if exists DevSubSection
go
drop table if exists DevSection
go

create table dbo.DevSection(
	iDevSectionId int not null identity primary key,
	vchDevSectionCode varchar (20) not null
		constraint ck_DevSectionCode_cannot_be_blank check(vchDevSectionCode <> '')
		constraint u_DevSectionCode_code_must_be_unique unique,
	vchDevSectionDesc varchar (50) not null
		constraint ck_DevSectionDesc_cannot_be_blank check(vchDevSectionDesc <> '')
		constraint u_DevSectionDesc_code_must_be_unique unique,
	vchDevSectionMiniBlurb varchar (300) not null default '',
	vchDevSectionBlurb varchar (1000) not null,
	vchDevTechUsed varchar (500) not null default '',
	iDevSectionSequence int not null
		constraint u_DevSection_Sequence_must_be_unique unique
	)
	go
	create table dbo.DevSubSection(
	iDevSubSectionId int not null identity primary key,
	iDevSectionId int not null 
		constraint f_DevSection_DevSubSection references DevSection(iDevSectionId),
	vchDevSubSectionCode varchar (20) not null
		constraint ck_DevSubSectionCode_cannot_be_blank check(vchDevSubSectionCode <> ''),
	vchDevSubSectionDesc varchar (50) not null
		constraint ck_DevSubSectionDesc_cannot_be_blank check(vchDevSubSectionDesc <> ''),
	vchDevSubSectionBlurb varchar (1000) not null,
	iDevSubSectionSequence int not null,
	vchProgrammingCode varchar(max) not null default '',
	vchUrl varchar (100) not null default '',
			constraint u_DevSubSectionDese_must_be_unique_for_each_section unique(iDevSectionId, vchDevSubSectionDesc),
		constraint u_DevSubSection_Sequence_must_be_unique unique(iDevSectionId, iDevSubSectionSequence),
		constraint u_DevSubSectionCode_code_must_be_unique_for_each_section unique (iDevSectionId, vchDevSubSectionCode)
	)
	go
	create table dbo.SampleQuery(
	iSampleQueryId int not null identity primary key,
	iDevSubSectionId int null constraint f_DevSubSection_SampleQuery references DevSubSection(iDevSubSectionId),
	vchQueryCaption varchar (100) not null,
	--constraint c_SampleQuery_Caption_cannot_be_blank check(vchQueryCaption <> '')
	vchQuery varchar (1000) not null ,
	--constraint c_SampleQuery_Query_cannot_be_blank check(vchQuery <> '')
	iSequence int not null default 0,
	constraint u_SampleQuery_Database_Caption_must_be_unique unique (iDevSubSectionId, vchQueryCaption)
	)
/*
devsection
	pk
	section code
	section desc
	section blurb

subsection
	pk
	subsection code
	subsection desc
	subsection blurb


*/