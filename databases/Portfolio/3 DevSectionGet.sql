
use Portfolio
go
create or alter procedure dbo.DevSectionGet(
	@iDevSectionId int = 0,
	@vchDevSectionCode varchar(20) = '',
	@bAll bit = 0,
	@bIncludeBlank bit = 0,
	@vchMessage varchar(500) = ''
)
as
begin
	declare @iReturn int = 0
	select d.iDevSectionId, d.vchDevSectionCode, d.vchDevSectionDesc,d.vchDevSectionMiniBlurb, d.vchDevSectionBlurb,d.vchDevTechUsed
	from DevSection d
	where @vchDevSectionCode = d.vchDevSectionCode
	or @bAll = 1
	order by d.iDevSectionSequence
	return @iReturn
end
go
grant exec on DevSectionGet to public