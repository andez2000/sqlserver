begin try
	begin tran

	raiserror ('doing some action...', 10, 1) with nowait;

	throw 99001, 'Oh shucks', 1;

end try
begin catch
    declare @errormessage nvarchar(4000);
    declare @errorseverity int;
    declare @errorstate int;

    select 
        @errormessage = error_message(),
        @errorseverity = error_severity(),
        @errorstate = error_state();

	if @@trancount > 0
	begin
		raiserror ('rolling back transaction', 10, 1) with nowait;

		rollback tran;
	end

    raiserror (@errormessage,
               @errorseverity,
               @errorstate
    );
end catch;