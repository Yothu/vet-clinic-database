/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon" */
SELECT * FROM animals WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT name FROM animals WHERE date_of_birth >= '20160101' AND date_of_birth < '20200101'

/* List the name of all animals that are neutered and have less than 3 escape attempts */
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

/* List date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT * FROM animals WHERE neutered = TRUE;

/* Find all animals not named Gabumon */
SELECT * FROM animals WHERE name <> 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*
  Inside a transaction update the animals table by setting the species column to unspecified. 
  Verify that change was made. Then roll back the change and verify that species columns went 
  back to the state before transaction.
*/

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

/* Inside a transaction... */
BEGIN;
/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set */
UPDATE animals SET species = 'pokemon' WHERE species = '';
/* Commit the transaction */
COMMIT;

/* Delete everthing and then rollback */
BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '20220101';
SAVEPOINT delete2022;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO delete2022;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT CASE sub.neutered
WHEN sub.neutered = TRUE THEN 'Neutered escaped the most'
ELSE 'Not Neutered escaped the most'
END
FROM (
  SELECT neutered, SUM(escape_attempts) AS res FROM animals GROUP BY neutered
) AS sub
ORDER BY res DESC
LIMIT 1;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '19900101' AND date_of_birth < '20010101' GROUP BY species;