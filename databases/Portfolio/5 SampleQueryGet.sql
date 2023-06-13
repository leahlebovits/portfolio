create or alter procedure dbo.SampleQueryGet(
@iDevSubSectionId int = 0,
@bAll bit = 0,
@vchMessage varchar (1000) = ''
)
as
begin
	select s.iSampleQueryId,s.iDevSubSectionId,s.vchQueryCaption,s.vchQuery
	from SampleQuery s
	where s.iDevSubSectionId = @iDevSubSectionId
	order by s.iSequence,s.vchQueryCaption
end
go
grant execute on SampleQueryGet to public