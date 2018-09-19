IF EXISTS
(SELECT * FROM sys.objects
WHERE OBJECT_ID = OBJECT_ID (N'Stocks')
AND TYPE IN (N'U'))
DROP TABLE Stocks
GO

CREATE TABLE Stocks
(StockSymbol VARCHAR(10) NOT NULL,
StockName VARCHAR(30) NULL,
Exchange VARCHAR(10) NULL,
PriceEarningsRatio INT NULL)

INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('AAPL','Apple Inc','NASDAQ',14)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('AMZN', 'Amazon.com Inc', 'NASDAQ', 489)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('DIS', 'The Walt Disney Company', 'NYSE', 21)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('GE', 'General Electric Company', 'NYSE', 18)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('GOOG', 'Alphabet Inc', 'NASDAQ', 30)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('HSY', 'The Hershey Company', 'NYSE', 26)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('KRFT', 'Kraft Foods Inc', 'NYSE', 12)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('KO', 'The Coca-Cola Company', 'NYSE', 21)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('MCD', 'McDonalds Corporation', 'NYSE', 18)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('MMM', '3M Company', 'NYSE', 20)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('MSFT', 'Microsoft Corporation', 'NASDAQ', 15)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('ORCL', 'Oracle Corporation', 'NASDAQ', 17)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('SBUX', 'Starbucks Corporation', 'NASDAQ', 357)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('WBA', 'Walgreens Boots Alliance Inc', 'NYSE', 24)
INSERT INTO Stocks(StockSymbol,StockName,Exchange,PriceEarningsRatio)VALUES('WMT', 'Wal-Mart Stores Inc', 'NYSE', 15)

select * from Stocks
--For inserting data
alter procedure Proc_Insert
(
  @StockSymbol varchar(20), 
  @StockName varchar(20),
  @Exchange varchar(20),
  @Pre int
)
AS
begin
 IF EXISTS(SELECT 'True' FROM Stocks WHERE StockName=@StockName OR ( PriceEarningsRatio=@Pre and @Pre>500)) 
 BEGIN
		--This means it exists, return it to ASP and tell us
		SELECT 'Same Stock Name! or Price Earning ratio is greater than 500'
 END
 
 ELSE
 BEGIN
		--This means the record isn't in there already, let's go ahead and add it
		 SELECT 'Record Added'
		 INSERT into Stocks(StockSymbol, StockName,Exchange,PriceEarningsRatio) VALUES
		(@StockSymbol, @StockName,@Exchange,@Pre)
 END
 end


 exec Proc_Insert 'AAPL','Amazon.com Inc','NASDAQ',550

 SELECT * FROM Stocks

 --updating the data
ALTER procedure proc_update
(@StockSymbol varchar(20), 
  @StockName varchar(20),
  @Exchange varchar(20),
  @Pre int)
as begin 
	if exists(SELECT 'True' FROM Stocks WHERE StockName=@StockName)
		begin
		SELECT 'Cant update to the existing Stock Name!' 
		end
	else
		begin
		update Stocks set StockSymbol=@StockSymbol,
		Exchange=@Exchange,
		PriceEarningsRatio=@Pre where StockName=@StockName
		end
end

exec proc_update 'KAPL','Apple Inc','NYSE',200

select * from Stocks 

alter procedure proc_delete
( 
  @StockName varchar(50),
  @Exchange varchar(50)
  )
as begin
	declare @countrow as int 
	select @countrow = count(*) from Stocks where Exchange=@Exchange
	if (@countrow <> 1)
	begin
		delete from Stocks where StockName=@StockName
		select 'Stock Deleted'
	end
	else
	begin
		select 'There is only one Exchange left,Cant Delete'
	end
end
exec proc_delete 'Apple Inc','NASDAQ'
exec proc_delete 'Amazon.com Inc','NASDAQ'
exec proc_delete 'Alphabet Inc','NASDAQ'
exec proc_delete 'Oracle Corporation','NASDAQ'
exec proc_delete 'Microsoft Corporation','NASDAQ'
exec proc_delete 'Starbucks Corporation','NASDAQ'
 
 
select * from Stocks