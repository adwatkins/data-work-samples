import csv
import psycopg2

conn = psycopg2.connect("dbname=postgres host=localhost dbname=postgres user=postgres password=pass port=5432")
cur = conn.cursor()

try:
    cur.execute('''
DROP TABLE IF EXISTS public.energy_production_by_month;

CREATE TABLE IF NOT EXISTS public.energy_production_by_month
(
    year_month integer NOT NULL PRIMARY KEY,
    total_fossil_fuels_production real,
    nuclear_electric_power_production real,
    total_renewable_energy_production real,
    total_primary_energy_production real,
    primary_energy_imports real,
    primary_energy_exports real,
    primary_energy_net_imports real,
    primary_energy_stock_change real,
    total_fossil_fuels_consumption real,
    nuclear_electric_power_consumption real,
    total_renewable_energy_consumption real,
    total_primary_energy_consumption real,
    CONSTRAINT energy_production_by_month_year_month_key UNIQUE (year_month)
)

TABLESPACE pg_default;

ALTER TABLE public.energy_production_by_month
    OWNER to postgres;
                
COMMENT ON TABLE public.energy_production_by_month
    IS 'All units in Quadrillion Btu';
                ''')
except:
    print("Unable to create table")

with open('Energy Analysis/Primary_Energy_Overview_yyyymm.csv', 'r') as filedata:
    next(filedata)
    cur.copy_from(filedata, 'energy_production_by_month', sep=',')

conn.commit()

print("Successfully created table")