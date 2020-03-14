Diclaimer:
The structure in the finished database is a bit differnt than in the Step 4 diagram to allow the employees
to have more than one delivery.

It is intentinal that the attribute city exists twice in sender and (pickup/post)location because it is possible
that the customer  sends the package from another city than where his address is.

.)How many packages were sent from Wien?
SELECT
COUNT(name)
FROM
sender
WHERE City = 'Wien'

Result = 3

.)How many customers life in Wien in the street  Hauptstraße?

SELECT
COUNT(name)
FROM
sender
WHERE (City= 'Wien' AND Address LIKE 'Hauptstraße%')

Result = 2


.)Which customer has never brought a package to a location jet?

SELECT name
FROM sender
WHERE sender.city not IN(
SELECT City
FROM location
)

Result: Hannes Niedermeier


.)Who was deposting the package in another city than where they life?


select DISTINCT
sender.Name,sender.City as Sendercity,location.City as Targetcity
from sender
INNER JOIN package ON sender.SenderID = package.fk_SenderID
	INNER JOIN location ON package.PackageID = location.fk_PackageID
	INNER JOIN locemp ON location.LocationID = locemp.fk_LocationID
WHERE location.City!=sender.city


Result:Name Sendercity  Targetcity
Mona Musterfrau Wien Graz


Joins that connect more than 4 tables:

.)What was the average duration between depositdate and deliverydate
SELECT location.Depositetdate,deliveryn.Deliverydate,deliveryn.DeliveryID, 
datediff(deliveryn.Deliverydate,location.Depositetdate),avg(datediff(deliveryn.Deliverydate,location.Depositetdate))
FROM sender
LEFT JOIN package ON sender.SenderID = package.fk_SenderID
	LEFT JOIN location ON package.PackageID = location.fk_PackageID
	LEFT JOIN locemp ON location.LocationID = locemp.fk_LocationID
    LEFT JOIN deliveryn on locemp.LocempID = deliveryn.fk_locempID
    LEFT JOIN recipient on deliveryn.DeliveryID= recipient.fk_DeliverynID
    WHERE location.Depositetdate >0

Result:4.6 days



.)What are the sendername,recipientname, depositdate and deliverydate of each delivery.


SELECT sender.Name,recipient.Name,package.Targetaddress as Target,recipient.Address as Recipient,deliveryn.DeliveryID
FROM sender
LEFT JOIN package ON sender.SenderID = package.fk_SenderID
	LEFT JOIN location ON package.PackageID = location.fk_PackageID
	LEFT JOIN locemp ON location.LocationID = locemp.fk_LocationID
    LEFT JOIN deliveryn on locemp.LocempID = deliveryn.fk_locempID
    LEFT JOIN recipient on deliveryn.DeliveryID= recipient.fk_DeliverynID
    WHERE deliveryn.DeliveryID is not null


.)Which delivery sent to the wrong target?

SELECT sender.Name,recipient.Name,package.Targetaddress as Target,recipient.Address as Recipient,deliveryn.DeliveryID
FROM sender
LEFT JOIN package ON sender.SenderID = package.fk_SenderID
	LEFT JOIN location ON package.PackageID = location.fk_PackageID
	LEFT JOIN locemp ON location.LocationID = locemp.fk_LocationID
    LEFT JOIN deliveryn on locemp.LocempID = deliveryn.fk_locempID
    LEFT JOIN recipient on deliveryn.DeliveryID= recipient.fk_DeliverynID
    WHERE package.Targetaddress!=recipient.Address

 Result: Delivery 5
