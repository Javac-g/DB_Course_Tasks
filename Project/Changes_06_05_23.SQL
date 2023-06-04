CREATE OR REPLACE FUNCTION comp_gpu(
    pcie_slot character varying,
    power_supply character varying,
    form_factor character varying,
    operating_system character varying
) RETURNS void AS $$
DECLARE
    tr gpu_list%ROWTYPE;
BEGIN
    -- Create the compatible_gpu_list table
    EXECUTE 'CREATE TABLE compatible_gpu_list (
        id bigint,
        manufacturer character varying,
        price_id bigint
    )';
    
    -- Select and insert compatible GPUs into the compatible_gpu_list table
    FOR tr IN SELECT id, manufacturer, price_id FROM gpu_list WHERE
        pcie_slots = comp_gpu.pcie_slot AND
        power_supply = comp_gpu.power_supply AND
        form_factor = comp_gpu.form_factor AND
        operating_system = comp_gpu.operating_system
    LOOP
        EXECUTE 'INSERT INTO compatible_gpu_list VALUES ($1, $2, $3)'
            USING tr.id, tr.manufacturer, tr.price_id;
    END LOOP;
    
    RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT comp_gpu('PCIe x16', 'Sufficient Power', 'ATX', 'Windows 10');



SELECT comp_gpu('PCIe x16', 'Sufficient Power', 'ATX', 'Windows 10');


SELECT comp_gpu('PCIe x16', 'Sufficient Power', 'ATX', 'Windows 10');


SELECT comp_gpu('PCIe x16', 'Sufficient Power', 'ATX', 'Windows 10');
SELECT * FROM gpu_list;
ALTER TABLE gpu_list ADD COLUMN model character varying;

ALTER TABLE motherboard_list RENAME COLUMN connector_interface TO pcie_slots;

SELECT ram_max FROM motherboard_list;
ALTER TABLE motherboard_list ALTER COLUMN ram_max TYPE integer USING (ram_max::integer);

UPDATE motherboard_list SET ram_max = REPLACE(ram_max, 'GB', '') WHERE ram_max LIKE '%GB';
ALTER TABLE motherboard_list ALTER COLUMN multi_gpu_support SET DATA TYPE boolean USING (multi_gpu_support::boolean);
UPDATE gpu_list SET multi_gpu_support = TRUE WHERE id < 190 -- add your conditions here --;
ALTER TABLE gpu_list ADD COLUMN multi_gpu_support boolean;
