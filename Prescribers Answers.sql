SELECT * 
FROM cbsa;

SELECT *
FROM drug;

SELECT *
FROM fips_county;

SELECT *
FROM overdose_deaths;

SELECT *
FROM population;

SELECT *
FROM prescriber;

SELECT *
FROM prescription;

SELECT *
FROM zip_fips;


--1. 
 
 --a. Which prescriber had the highest total number of claims (totaled over 	all drugs)? Report the npi and the total number of claims.

/*NOTES  
-Tables used: prescribes, prescription 
-Numbering 1,2,3 is a reference of what is in SELECT for group by and order by
-CONCAT is used to join to strings together 

*/ 

SELECT 
	p.npi,
	MAX(ps.total_claim_count) AS max_total_claim_count
FROM prescriber AS p
INNER JOIN prescription AS ps
	ON p.npi = ps.npi
GROUP BY p.npi
ORDER BY 2 DESC
LIMIT 1;

--b. Repeat the above, but this time report the nppes_provider_first_name, 	nppes_provider_last_org_name,  specialty_description, and the total number 	of claims.

SELECT 
	p.npi,
	MAX(ps.total_claim_count) AS max_total_claim_count,
	CONCAT(p.nppes_provider_first_name,' ',p.nppes_provider_last_org_name) AS name,
	p.specialty_description	
FROM prescriber AS p
INNER JOIN prescription AS ps
	ON p.npi = ps.npi
GROUP BY p.npi,3,4
ORDER BY 2 DESC
LIMIT 1;





--2. 
    
	--a. Which specialty had the most total number of claims (totaled over all drugs)?
/* NOTES
Tables: prescriber & prescription
*/

SELECT 
	p.npi,
	SUM(ps.total_claim_count) AS sum_total_claim_count,
	p.specialty_description
FROM prescriber AS p
INNER JOIN prescription AS ps
	ON p.npi = ps.npi
GROUP BY 1,3
ORDER BY sum_total_claim_count DESC
LIMIT 1;

    --b. Which specialty had the most total number of claims for opioids?

SELECT 
	p.npi,
	SUM(ps.total_claim_count) AS sum_total_claim_count,
	p.specialty_description
FROM prescriber AS p
INNER JOIN prescription AS ps
	ON p.npi = ps.npi
GROUP BY 1,3
ORDER BY sum_total_claim_count DESC
LIMIT 1;
    --c. **Challenge Question:** Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?

    --d. **Difficult Bonus:** *Do not attempt until you have solved all other problems!* For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?

