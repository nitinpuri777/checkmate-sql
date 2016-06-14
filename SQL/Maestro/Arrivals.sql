SELECT
  fdcus.reservation_number,
  cli.last_name,
  cli.first_name,
  CONVERT(varchar(10), fdcus.arrival_date, 111) AS "Arrival_Date",
  CONVERT(varchar(10), fdcus.departure_date, 111) AS "Departure Date",
  cli.email_address,
  (SELECT TOP 1
    fdrm.room_type_code
  FROM nw_src..fdroomresc fdrm
  WHERE fdrm.reservation_number = fdcus.reservation_number
  AND fdrm.rate_category = "room"
  ORDER BY fdrm.sba_date, fdrm.sub_reservation_number, fdrm.suffix_no)
  AS "roomtype",
  (SELECT TOP 1
    fdrm.rate_type
  FROM nw_src..fdroomresc fdrm
  WHERE fdrm.reservation_number = fdcus.reservation_number
  AND fdrm.rate_category = "room"
  ORDER BY fdrm.sba_date, fdrm.sub_reservation_number, fdrm.suffix_no)
  AS "Ratecode"
FROM nw_src..fdcustres fdcus
INNER JOIN nw_src..maclient cli
  ON fdcus.home_client_code = cli.client_code
WHERE fdcus.reservation_status IN (1, 2, 3)
AND fdcus.reservation_type = "i"
AND (CONVERT(varchar, fdcus.arrival_date, 111) >= CONVERT(varchar, GETDATE(), 111)
AND CONVERT(varchar, fdcus.arrival_date, 111) <= CONVERT(varchar, GETDATE() + 1, 111))
