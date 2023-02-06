#------------------MANDATORY PROJECT-3 >>>> (ON NORTHWIND DATABASE) <<<<------------#



-- Q.1. Calculate average Unit Price for each CustomerId.

# HERE I HAVE TAKEN TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# AFTER THAT TOOK AVERAGE AND USED THE WINDOW FUNCTION AND PARTED IT BY CUSTOMERID
# AS PER QUESTION ASKED I USED DISTINCT FUNCTION TO FOR EACH CUSTOMERID
 
select distinct CustomerID,
avg(unitprice) over(partition by customerid)
as Average_Unit_price from orders
join order_details on orders.OrderID= order_details.OrderID;


-- Q.2. Calculate average Unit Price for each group of CustomerId AND EmployeeId.

# HERE I ALSO TOOK TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# AND HERE SAME I USED AVG AND USED THE WINDOW FUNCTION AND PARTED IT BY CUSTOMERID & EMPLOYEEID AS WELL
# AS PER QUESTION ASKED I USED DISTINCT FUNCTION TO FOR EACH CUSTOMERID AND EMPLOYEEID PAIR

select distinct CustomerID,EmployeeID,
avg(unitprice) over(partition by customerid,employeeid)
as Average_Unit_price from orders
join order_details on orders.OrderID= order_details.OrderID;


-- Q.3. Rank Unit Price in descending order for each CustomerId.

-- 1ST APPROACH:-

# HERE I ALSO TOOK TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# HERE I USED THE RANK FUNCTION AND ORDERED IT BY UNITPRICE IN DESCENDING AS PER QUESTION ASKED
# ALSO I HAVE GROUPED IT BY OUTER CUSTOMERID

select CustomerID,
unitprice,rank() over(order by unitprice desc) as ranking
from orders
join order_details on orders.OrderID= order_details.OrderID
group by customerid;

-- 2ND APPROACH:-

# HERE I ALSO TOOK TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# HERE I USED THE RANK FUNCTION AND ORDERED IT BY UNITPRICE 
# ALSO I HAVE GROUPED IT BY OUTER CUSTOMERID
# ALONG WITH THIS TIME I HAVE USED OUTER ORDER BY FOR THE UNITPRICE

select CustomerID,
unitprice,rank() over(order by unitprice) as ranking
from orders
join order_details on orders.OrderID= order_details.OrderID
group by customerid
order by unitprice desc;


-- Q.4. How can you pull the previous order date’s Quantity for each ProductId.

# HERE I ALSO TOOK TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# ALSO USED THE LAG WINDOWS FUNCTION AND PARTED IT BY PRODUCTID ALONG WITH ORDER IT BY ORDERDATE
# BASICALLY IT GIVES ME PAST QUANTITY.

select productid,OrderDate,quantity,
lag(quantity) over(partition by productid order by orderdate)
as previous_date_quantity
from orders
join order_details on orders.OrderID= order_details.OrderID;



-- Q.5. How can you pull the following order date’s Quantity for each ProductId.

# HERE I ALSO TOOK TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# ALSO USED THE LEAD WINDOWS FUNCTION AND PARTED IT BY PRODUCTID ALONG WITH ORDER IT BY ORDERDATE
# BASICALLY IT GIVES ME THE PREDICTED QUANTITY.

select productid,OrderDate,quantity,
lead(quantity) over(partition by productid order by orderdate)
as Following_date_quantity
from orders
join order_details on orders.OrderID= order_details.OrderID;


-- Q.6. Pull out the very first Quantity ever ordered for each ProductId.

# HERE I USED A WINDOW FUNCTION OF NTH VALUE TO FIND THE FIRST MOST ORDERED 
# ALONG WITH THAT I HAVE PARTED IT BY PRODUCID AND FOR THE EACH CUSTOMERID I USED DISTINCT FUNCTION

select distinct productid,
nth_value(quantity,1) over(partition by productid) as '1st Quantity ordered'
from order_details;



-- Q.7. Calculate a cumulative moving average UnitPrice for each CustomerId.

# HERE I ALSO TOOK TABLE ORDER AND ORDERDETAILS AND JOIN THEM ON COMMON COLUMN ORDERID
# ALSO TOOK THE AVG OF UNITPRICE AND PARTED IT BY CUSTOMERID AS WELL AS ORDER IT BY CUSTOMERID
# AFTER THAT I HAVE USED A FRAME FUNCTION TO FIND THE CUMULATIVE MOVING AVG

select CustomerID,unitprice,
avg(unitprice) over(partition by customerid order by customerid
rows between unbounded preceding and current row)
as 'Cumulative moving avg' from orders
join order_details on orders.OrderID= order_details.OrderID;



-- >>> Theoretical questions <<< --


-- Q.8.Can you define a trigger that is invoked automatically before a new row is inserted into a table?
/*/ 
Yes,trigger invoked(activacted)automatically 
by writing certain queries, like at the time of creating
Databases we can set the perimeter for to execute that query
to perform certain operations also if user want to do some 
insert,update and delete and wants to keep the automated log of it 
then one can use this automated trigger.
/*/

-- Q.9. What are the different types of triggers?
/*/
THERE ARE TWO TYPES OF TRIGGERS--
    1.BEFORE TRIGGER
	2.AFTER TRIGGER
/*/


-- Q.10. How is Metadata expressed and structured?
/*/
Basically metadata has all the details of a databse like 
how many tables it consist,table type and all types of stats
in a very well read and structured way and it also tells
about the relationship os the tables and columns and many more.
/*/


-- Q.11.Explain RDS and AWS key management services.
/*/
AWS key management servies mean that it can provide the better 
encryption which help to protect our data being leaked or hacked.

RDS management servies it that it uses the AWS key management services for
better security
 /*/


-- Q.12. What is the difference between amazon EC2 and RDS?
/*/
RDS is cloud based databse system where we can perform
all the operatrions like SQL and it is supported by most of the engines.
where as the EC2 is a product of AWS by which we can make our RDS 
scalable means we can increase or decrease the size of our RDS./*/
