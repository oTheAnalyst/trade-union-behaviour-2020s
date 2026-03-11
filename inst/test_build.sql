CREATE
OR REPLACE SEQUENCE strikeOrProtest_id;

CREATE
OR REPLACE SEQUENCE serial;

CREATE
OR REPLACE TABLE stg_imports (
	import_id BIGINT NOT NULL DEFAULT nextval('serial'),
	import_dt TIMESTAMP PRIMARY KEY,
	source_name VARCHAR,
	original_file_path VARCHAR,
	bucket_uri VARCHAR,
	md5_checksum VARCHAR
);

CREATE
OR REPLACE TABLE strikeOrProtest(
	internal_id BIGINT DEFAULT(nextval('strikeOrProtest_id')) PRIMARY KEY,
	id INTEGER,
	strikeOrProtest VARCHAR,
	authorized VARCHAR,
	workerDemands VARCHAR,
	rowExpirationDate TIMESTAMP DEFAULT(NULL),
	rowIndicator VARCHAR
);

CREATE
OR REPLACE TABLE stg_lat(
	import_id BIGINT,
	id INTEGER,
	employer VARCHAR,
	laborOrganization VARCHAR,
	local VARCHAR,
	industry VARCHAR,
	bargainingUnitSize DOUBLE,
	numberOfLocations INTEGER,
	address VARCHAR,
	city VARCHAR,
	state VARCHAR,
	zipCode VARCHAR,
	latitudeLongitude VARCHAR,
	approximateNumberOfParticipants INTEGER,
	startDate DATE,
	endDate DATE,
	durationAmount INTEGER,
	durationUnit VARCHAR,
	strikeOrProtest VARCHAR,
	authorized VARCHAR,
	workerDemands VARCHAR,
	source VARCHAR,
	notes VARCHAR
);

INSERT INTO
	stg_imports (
		import_id,
		import_dt,
		source_name,
		original_file_path,
		bucket_uri,
		md5_checksum
	)
VALUES
	(
		105,
		'2026-01-31 22:51:22.143397',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/4.7.25.xlsx',
		'NA',
		'NA'
	),
	(
		107,
		'2026-01-31 22:51:55.986619',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/5.5.25.xlsx',
		'NA',
		'NA'
	),
	(
		109,
		'2026-01-31 22:52:34.278531',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/6.2.25.xlsx',
		'NA',
		'NA'
	),
	(
		111,
		'2026-01-31 22:53:29.982658',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/7.7.25.xlsx',
		'NA',
		'NA'
	),
	(
		113,
		'2026-01-31 22:54:04.182472',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/8.4.25.xlsx',
		'NA',
		'NA'
	),
	(
		115,
		'2026-01-31 22:54:30.514975',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/9.1.25.xlsx',
		'NA',
		'NA'
	),
	(
		117,
		'2026-01-31 22:55:15.704925',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/10.6.25.xlsx',
		'NA',
		'NA'
	),
	(
		119,
		'2026-01-31 22:55:52.047049',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/11.3.25.xlsx',
		'NA',
		'NA'
	),
	(
		121,
		'2026-01-31 22:56:24.914747',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/12.1.25.xlsx',
		'NA',
		'NA'
	),
	(
		123,
		'2026-01-31 22:58:22.705178',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdata/1.5.26.xlsx',
		'NA',
		'NA'
	);

INSERT INTO
	stg_imports (
		import_id,
		import_dt,
		source_name,
		original_file_path,
		bucket_uri,
		md5_checksum
	)
VALUES
	(
		125,
		'2026-02-05 10:59:47.72509',
		'simplemaps',
		'https://simplemaps.com/data/us-cities',
		'NA',
		'NA'
	),
	(
		127,
		'2026-03-05 09:47:40.911268',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdataNA',
		'NA',
		'NA'
	),
	(
		129,
		'2026-03-05 13:10:15.591302',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdataNA',
		'NA',
		'NA'
	),
	(
		131,
		'2026-03-05 13:10:37.21728',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdataNA',
		'NA',
		'NA'
	),
	(
		133,
		'2026-03-05 13:12:54.695024',
		'email',
		'/home/pretender/R/x86_64-pc-linux-gnu-library/4.4/dsa/extdataNA',
		'NA',
		'NA'
	);

INSERT INTO
	stg_lat (
		import_id,
		id,
		employer,
		laborOrganization,
		"local",
		industry,
		bargainingUnitSize,
		numberOfLocations,
		address,
		city,
		state,
		zipCode,
		latitudeLongitude,
		approximateNumberOfParticipants,
		startDate,
		endDate,
		durationAmount,
		durationUnit,
		strikeOrProtest,
		authorized,
		workerDemands,
		"source",
		notes
	)
VALUES
	(
		105,
		546,
		'Zanesville City School District',
		'Ohio Education Association - NEA',
		NULL,
		'Educational Services',
		NULL,
		1,
		'956 Moxahala Ave, Zanesville, Ohio, 43701',
		'Zanesville',
		'Ohio',
		'43701',
		'39.923602,-82.00491199999999',
		NULL,
		'2021-09-14',
		'2021-09-14',
		1,
		'days',
		'Protest',
		NULL,
		'Healthcare;Staffing',
		'https://www.zanesvilletimesrecorder.com/story/news/local/2021/09/15/zanesville-teachers-union-rally-board-education-meeting-contract-deadlock/8339257002/;https://whiznews.com/2021/09/14/the-zanesville-education-association-holds-a-unity-rally/',
		NULL
	),
	(
		107,
		546,
		'Zanesville City School District',
		'Ohio Education Association - NEA',
		NULL,
		'Educational Services',
		NULL,
		1,
		'956 Moxahala Ave, Zanesville, Ohio, 43701',
		'Zanesville',
		'Ohio',
		'43701',
		'39.923602,-82.00491199999999',
		NULL,
		'2021-09-14',
		'2021-09-14',
		1,
		'days',
		'Protest',
		NULL,
		'Healthcare;Staffing',
		'https://www.zanesvilletimesrecorder.com/story/news/local/2021/09/15/zanesville-teachers-union-rally-board-education-meeting-contract-deadlock/8339257002/;https://whiznews.com/2021/09/14/the-zanesville-education-association-holds-a-unity-rally/',
		NULL
	),
	(
		107,
		2334,
		'ZF Chassis Systems',
		'United Auto Workers (UAW)',
		NULL,
		'Manufacturing',
		NULL,
		1,
		'1200 Commerce Dr, Tuscaloosa, Alabama, 35401',
		'Tuscaloosa',
		'Alabama',
		'35401',
		'33.2174306,-87.61755529999999',
		190,
		'2023-09-20',
		'2023-10-19',
		30,
		'days',
		'Strike',
		'Y',
		'Pay;Healthcare;End tiers',
		'https://www.al.com/news/2023/09/190-alabama-uaw-union-members-strike-against-mercedes-supplier.html;https://www.reuters.com/business/autos-transportation/uaw-workers-strike-mercedes-supplier-zfs-plant-alabama-2023-09-20/;https://www.al.com/business/2023/10/alabama-uaw-union-members-end-strike-against-mercedes-supplier.html',
		NULL
	),
	(
		105,
		2334,
		'ZF Chassis Systems',
		'United Auto Workers (UAW)',
		NULL,
		'Manufacturing',
		NULL,
		1,
		'1200 Commerce Dr, Tuscaloosa, Alabama, 35401',
		'Tuscaloosa',
		'Alabama',
		'35401',
		'33.2174306,-87.61755529999999',
		190,
		'2023-09-20',
		'2023-10-19',
		30,
		'days',
		'Strike',
		'Y',
		'Pay;Healthcare;End tiers',
		'https://www.al.com/news/2023/09/190-alabama-uaw-union-members-strike-against-mercedes-supplier.html;https://www.reuters.com/business/autos-transportation/uaw-workers-strike-mercedes-supplier-zfs-plant-alabama-2023-09-20/;https://www.al.com/business/2023/10/alabama-uaw-union-members-end-strike-against-mercedes-supplier.html',
		NULL
	),
	(
		105,
		2242,
		'Worst Cooks in America - Bright Road Productions',
		'International Alliance of Theatrical Stage Employees (IATSE)',
		NULL,
		'Information',
		NULL,
		1,
		', Long Island City, New York, 11101',
		'Long Island City',
		'New York',
		'11101',
		'40.7443091,-73.9418603',
		50,
		'2023-08-16',
		'2023-08-21',
		6,
		'days',
		'Strike',
		NULL,
		'Pay;Healthcare;Retirement benefits;Union recognition',
		'https://deadline.com/2023/08/worst-cooks-in-america-strike-iatse-1235524503/;https://www.hollywoodreporter.com/tv/tv-news/worst-cooks-in-america-shuts-down-production-iatse-strike-1235570204/',
		NULL
	),
	(
		107,
		2242,
		'Worst Cooks in America - Bright Road Productions',
		'International Alliance of Theatrical Stage Employees (IATSE)',
		NULL,
		'Information',
		NULL,
		1,
		', Long Island City, New York, 11101',
		'Long Island City',
		'New York',
		'11101',
		'40.7443091,-73.9418603',
		50,
		'2023-08-16',
		'2023-08-21',
		6,
		'days',
		'Strike',
		NULL,
		'Pay;Healthcare;Retirement benefits;Union recognition',
		'https://deadline.com/2023/08/worst-cooks-in-america-strike-iatse-1235524503/;https://www.hollywoodreporter.com/tv/tv-news/worst-cooks-in-america-shuts-down-production-iatse-strike-1235570204/',
		NULL
	),
	(
		105,
		3488,
		'Woodbridge',
		'United Auto Workers (UAW)',
		NULL,
		'Manufacturing',
		NULL,
		1,
		'2399 S Stone Mountain Lithonia Rd, Lithonia, Georgia, 30058',
		'Lithonia',
		'Georgia',
		'30058',
		'33.7375979,-84.11995519999999',
		70,
		'2024-10-30',
		NULL,
		NULL,
		'days',
		'Strike',
		'Y',
		'Pay;Healthcare;Seniority',
		'https://uaw.org/uaw-members-at-woodbridge-corp-walk-out-on-strike/;https://www.ajc.com/news/atlanta-news/uaw-workers-strike-at-woodbridge-plant-in-lithonia/H2HD72V5LBBY3OQFFXND7XCKQA/',
		NULL
	),
	(
		107,
		3488,
		'Woodbridge',
		'United Auto Workers (UAW)',
		NULL,
		'Manufacturing',
		NULL,
		1,
		'2399 S Stone Mountain Lithonia Rd, Lithonia, Georgia, 30058',
		'Lithonia',
		'Georgia',
		'30058',
		'33.7375979,-84.11995519999999',
		70,
		'2024-10-30',
		NULL,
		NULL,
		'days',
		'Strike',
		'Y',
		'Pay;Healthcare;Seniority',
		'https://uaw.org/uaw-members-at-woodbridge-corp-walk-out-on-strike/;https://www.ajc.com/news/atlanta-news/uaw-workers-strike-at-woodbridge-plant-in-lithonia/H2HD72V5LBBY3OQFFXND7XCKQA/',
		NULL
	),
	(
		107,
		3493,
		'Women & Infants Hospital',
		'Service Employees International Union (SEIU)',
		NULL,
		'Health Care and Social Assistance',
		NULL,
		1,
		'101 Dudley St, Providence, Rhode Island, 02905',
		'Providence',
		'Rhode Island',
		'2905',
		'41.8110921,-71.4125943',
		NULL,
		'2024-11-12',
		'2024-11-12',
		1,
		'days',
		'Protest',
		NULL,
		'Health and safety;Staffing;End anti-union retaliation',
		'https://web.archive.org/web/20241112191714/https://www.abc6.com/women-and-infants-union-holds-informational-picket-on-unfair-labor-practices/;https://web.archive.org/web/20241112192033/https://turnto10.com/news/local/union-workers-at-women-infants-hold-unfair-labor-practice-informational-picket-hospital-nurse-contract-negotiations-caregivers-bargaining-november-11-2024',
		NULL
	),
	(
		105,
		3493,
		'Women & Infants Hospital',
		'Service Employees International Union (SEIU)',
		NULL,
		'Health Care and Social Assistance',
		NULL,
		1,
		'101 Dudley St, Providence, Rhode Island, 02905',
		'Providence',
		'Rhode Island',
		'02905',
		'41.8110921,-71.4125943',
		NULL,
		'2024-11-12',
		'2024-11-12',
		1,
		'days',
		'Protest',
		NULL,
		'Health and safety;Staffing;End anti-union retaliation',
		'https://web.archive.org/web/20241112191714/https://www.abc6.com/women-and-infants-union-holds-informational-picket-on-unfair-labor-practices/;https://web.archive.org/web/20241112192033/https://turnto10.com/news/local/union-workers-at-women-infants-hold-unfair-labor-practice-informational-picket-hospital-nurse-contract-negotiations-caregivers-bargaining-november-11-2024',
		NULL
	);

INSERT INTO
	strikeOrProtest with cte as(
		select
			distinct stg_lat.id,
			stg_lat.strikeOrProtest,
			stg_lat.authorized,
			(stg_lat.workerDemands).STRING_SPLIT(';').UNNEST(),
			NULL,
			'current'
		FROM
			stg_lat
			JOIN stg_imports on stg_lat.import_id = stg_imports.import_id
		WHERE
			stg_lat.import_id = 105
	)
select
	('strikeOrProtest_id').nextval(),
	*
from
	cte
group by
	all
;

UPDATE
	strikeOrProtest
set
	rowExpirationDate = current_localtimestamp(),
	rowIndicator = 'expired'
WHERE
	id IN(
		with cte as(
			select
				distinct id,
				strikeOrProtest,
				authorized,
				(workerDemands).STRING_SPLIT(';').UNNEST() as workerDemands
			from
				stg_lat
			where
				import_id = 107
		)
		select
			stg_lat.id
		from
			cte as stg_lat
			join strikeOrProtest on stg_lat.id = strikeOrProtest.id
			AND strikeOrProtest.rowIndicator = 'current'
		WHERE
			(
				stg_lat.strikeOrProtest <> strikeOrProtest.strikeOrProtest
				OR stg_lat.authorized <> strikeOrProtest.authorized
				OR stg_lat.workerDemands <> strikeOrProtest.workerDemands 
  -- rebuild everything and comment out this^ line to get a workable SCD type 2
			)
  order by stg_lat.id, stg_lat.workerDemands desc
	);

select
	*
from
	strikeOrProtest;

INSERT INTO
	strikeOrProtest
select
	('strikeOrProtest_id').nextval() as internal_id,
	stg_lat.id,
	stg_lat.strikeOrProtest,
	stg_lat.authorized,
	(stg_lat.workerDemands).STRING_SPLIT(';').UNNEST() as workerDemandsUN,
	NULL,
	'current'
FROM
	stg_lat as stg_lat
	JOIN stg_imports as stg_imports on stg_lat.import_id = stg_imports.import_id
	LEFT JOIN strikeOrProtest on stg_lat.id = strikeOrProtest.id
	AND strikeOrProtest.rowIndicator = 'current'
WHERE
	(
		stg_lat.import_id = 107
		and strikeOrProtest.id IS NULL
	)
	OR (
		stg_lat.strikeOrProtest <> strikeOrProtest.strikeOrProtest
		OR stg_lat.authorized <> strikeOrProtest.authorized
		OR stg_lat.workerDemands <> strikeOrProtest.workerDemands 
-- rebuild everything comment out ^ this line to get workable type 2 scd
	)
order by stg_lat.id,   desc
;

select
	*
from
	strikeOrProtest;
