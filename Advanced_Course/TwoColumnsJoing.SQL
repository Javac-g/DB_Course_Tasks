SELECT m.tdp AS motherboard_tdp, c.tdp AS cpu_tdp
FROM motherboard_list m
JOIN cpu_list c ON m.id = c.id;
