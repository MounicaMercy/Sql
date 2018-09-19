use Mydb1
create table AccountAudit(LastTransactionDate date)

insert into AccountAudit values ('2018-06-25')

create table AccountTransactions(TypeOfTransaction varchar(10),DateofTransaction date,
TransactedAmount money)

create table AccountBalance(openingbalance money,TransactionAmount money,
AsOnBalance money)



insert into AccountAudit values('2018-05-15')
insert into AccountTransactions values('credit','2018-05-15',1500.00)
insert into AccountBalance(openingbalance) values (2000)

alter procedure Proc_Banking
(@TypeOfTransaction varchar(50),
@DateofTransaction date,
@TransactionAmount money,
@LastTransactionId int output)
as
begin
BEGIN TRANSACTION;
	insert into AccountTransactions(TypeOfTransaction,DateofTransaction,TransactedAmount) 
	values(@TypeOfTransaction,@DateofTransaction,@TransactionAmount)
	
	select @LastTransactionId=SCOPE_IDENTITY();
	select  'LastTransaction:'+ convert(varchar(50),@LastTransactionId);
	if(@TypeOfTransaction='credit')
	begin
	declare @debitsumC as int
	declare @creditsumC as int
	select @creditsumC=SUM(TransactedAmount)from AccountTransactions where TypeOfTransaction='credit'
	select @debitsumC=SUM(TransactedAmount)from AccountTransactions where TypeOfTransaction='debit'
	update AccountBalance set openingbalance=2000,TransactionAmount=@TransactionAmount,AsOnBalance=((openingbalance+@creditsumC)-@debitsumC)
	update AccountAudit set LastTransactionDate=@DateofTransaction
	end
	if(@TypeOfTransaction='debit')
	begin
	declare @debitsumD as int
	declare @creditsumD as int
	select @creditsumD=SUM(TransactedAmount)from AccountTransactions where TypeOfTransaction='credit'
    select @debitsumD=SUM(TransactedAmount)from AccountTransactions where TypeOfTransaction='debit'
	update AccountBalance set openingbalance=2000,TransactionAmount=@TransactionAmount,AsOnBalance=((openingbalance+@creditsumD)-@debitsumD)
	update AccountAudit set LastTransactionDate=@DateofTransaction
	end 
	else
	print N'You are Entered Something'
COMMIT TRANSACTION;
end

declare @LastTransaction as int
exec Proc_Banking 'credit','2018-07-20',1000,@LastTransaction
select @LastTransaction as LastTransaction


exec Proc_Banking 'debit','2018-06-30',500
exec Proc_Banking 'debit','2018-07-01',500



select *from AccountBalance
select *from AccountTransactions
select *from AccountAudit

truncate table AccountAudit

delete from  AccountTransactions where TransactedAmount=1000 and DateofTransaction='2018-06-20'