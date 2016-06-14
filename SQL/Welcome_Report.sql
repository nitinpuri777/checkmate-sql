DECLARE @start_date DATE=GETDATE()+1

SELECT 
  Res.ResID AS ConfirmationNumber,
  Guest.LastName AS LastName,
  Guest.FirstName AS FirstName,
  CONVERT(DATE, Res.ArrivalDate) AS ArrivalDate,
  CONVERT(DATE, Res.DepartureDate) AS DepartureDate,
  Guest.Email AS GuestEmail,
  (Guest.CountryCode + Guest.AreaCode + Guest.Telephone) AS GuestPhone,
  RoomType.RoomType AS RoomCode,
  Rate.RateType AS RateCode,
  '' AS ADR,
  Guest.FranchiseMemberCode AS LoyaltyAccount
FROM
  Reservation AS Res
INNER JOIN
  GuestHistory AS Guest
ON (Res.GuestHistoryID = Guest.GuestHistoryID)
INNER JOIN
  RoomTypeConfig AS RoomType
ON (Res.RoomTypeID = RoomType.RoomTypeID)
INNER JOIN
  RateType AS Rate
ON (Res.RateTypeID = Rate.RateTypeID)
WHERE
  Res.ResStatusID != 5 /* Assuming Status IDs don't change... Could also use join*/
  AND ArrivalDate = @start_date
