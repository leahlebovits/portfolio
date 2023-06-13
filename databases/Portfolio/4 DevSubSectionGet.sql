

create or alter procedure dbo.DevSubSectionGet(
    @iDevSubSectionId int = 0, 
    @iDevSectionId int = 0,
    @vchDevSubSectionCode varchar(25) = '',
    @bAll bit = 0, 
    @bIncludeBlank bit = 0,
    @vchMessage varchar(500) = ''
)
as 
begin
    declare @iReturn int = 0
    select d.iDevSubSectionId,d.iDevSectionId, s.vchDevSectionCode, d.vchDevSubSectionCode, d.vchDevSubSectionDesc, d.vchDevSubSectionBlurb,d.vchProgrammingCode,d.vchUrl
    from DevSubSection d 
	join DevSection s
	on d.iDevSectionId = s.iDevSectionId
    where isnull(@bAll, 0) = 1
    or d.iDevSubSectionId = isnull(@iDevSubSectionId, 0)
    or d.vchDevSubSectionCode = isnull(@vchDevSubSectionCode,0)
    or d.iDevSectionId = isnull(@iDevSectionId, 0)
    order by d.iDevSubSectionSequence
    return @iReturn
end
go
grant exec on DevSubSectionGet to public
go 
exec DevSubSectionGet @bAll = 1 