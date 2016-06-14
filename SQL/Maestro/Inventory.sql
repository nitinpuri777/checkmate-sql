SELECT
  "",
  CONVERT(varchar(10), rmtyp.sba_date, 111),
  "",
  rmtyp.room_type_code,
  "",
  (rmtyp.number_of_rooms - (rmtyp.number_reserved_night + rmtyp.number_offmarket)) AS "available_rooms"
FROM nw_src..fdrmtyussm rmtyp
INNER JOIN nw_src..gbbuilding gbbuild
  ON rmtyp.building_code = gbbuild.building_code
WHERE rmtyp.sba_date BETWEEN GETDATE() AND GETDATE() + 30
AND rmtyp.room_type_code NOT LIKE "zzz%"
ORDER BY rmtyp.sba_date, rmtyp.room_type_code
