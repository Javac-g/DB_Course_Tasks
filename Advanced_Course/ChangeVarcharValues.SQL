UPDATE motherboard_list
SET ram_speed = REPLACE(ram_speed, 'MHz', '')
WHERE ram_speed LIKE '%MHz';
