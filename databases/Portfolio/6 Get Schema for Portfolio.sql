update DevSubSection
set vchProgrammingCode =
'
create table dbo.DevSection(
	iDevSectionId int not null identity primary key,
	vchDevSectionCode varchar (20) not null
		constraint ck_DevSectionCode_cannot_be_blank check(vchDevSectionCode <> '''')
		constraint u_DevSectionCode_code_must_be_unique unique,
	vchDevSectionDesc varchar (50) not null
		constraint ck_DevSectionDesc_cannot_be_blank check(vchDevSectionDesc <> '''')
		constraint u_DevSectionDesc_code_must_be_unique unique,
	vchDevSectionBlurb varchar (500) not null,
	iDevSectionSequence int not null
		constraint u_DevSection_Sequence_must_be_unique unique
	)
	go
	create table dbo.DevSubSection(
	iDevSubSectionId int not null identity primary key,
	iDevSectionId int not null 
		constraint f_DevSection_DevSubSection references DevSection(iDevSectionId),
	vchDevSubSectionCode varchar (20) not null
		constraint ck_DevSubSectionCode_cannot_be_blank check(vchDevSubSectionCode <> '''')
		constraint u_DevSubSectionCode_code_must_be_unique unique,
	vchDevSubSectionDesc varchar (50) not null
		constraint ck_DevSubSectionDesc_cannot_be_blank check(vchDevSubSectionDesc <> '''')
		constraint u_DevSubSectionDesc_code_must_be_unique unique,
	vchDevSubSectionBlurb varchar (1000) not null,
	iDevSubSectionSequence int not null,
	vchProgrammingCode varchar(max) not null default '''',
		constraint u_DevSubSection_Sequence_must_be_unique unique(iDevSectionId, iDevSubSectionSequence)
	)
	'
	where vchDevSubSectionCode = 'Portfolio'