/*Queries that provide answers to the questions from all projects.*/
/* Find all animals whose name ends in "mon" */
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT
  name
FROM
  animals
WHERE
  date_of_birth >= '20160101'
  AND date_of_birth < '20200101'
  /* List the name of all animals that are neutered and have less than 3 escape attempts */
SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE
  AND escape_attempts < 3;

/* List date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT
  date_of_birth
FROM
  animals
WHERE
  name = 'Agumon'
  OR name = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT
  *
FROM
  animals
WHERE
  neutered = TRUE;

/* Find all animals not named Gabumon */
SELECT
  *
FROM
  animals
WHERE
  name <> 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT
  *
FROM
  animals
WHERE
  weight_kg >= 10.4
  AND weight_kg <= 17.3;

/*
 Inside a transaction update the animals table by setting the species column to unspecified. 
 Verify that change was made. Then roll back the change and verify that species columns went 
 back to the state before transaction.
 */
BEGIN;

UPDATE
  animals
SET
  species = 'unspecified';

SELECT
  *
FROM
  animals;

ROLLBACK;

SELECT
  *
FROM
  animals;

/* Inside a transaction... */
BEGIN;

/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */
UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon';

/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set */
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species = '';

/* Commit the transaction */
COMMIT;

/* Delete everthing and then rollback */
BEGIN;

DELETE FROM
  animals;

ROLLBACK;

BEGIN;

DELETE FROM
  animals
WHERE
  date_of_birth > '20220101';

SAVEPOINT delete2022;

UPDATE
  animals
SET
  weight_kg = weight_kg * (-1);

ROLLBACK TO delete2022;

UPDATE
  animals
SET
  weight_kg = weight_kg * (-1)
WHERE
  weight_kg < 0;

COMMIT;

/* How many animals are there? */
SELECT
  COUNT(*)
FROM
  animals;

/* How many animals have never tried to escape? */
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

/* What is the average weight of animals? */
SELECT
  AVG(weight_kg)
FROM
  animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT
  CASE
    sub.neutered
    WHEN sub.neutered = TRUE THEN 'Neutered escaped the most'
    ELSE 'Not Neutered escaped the most'
  END
FROM
  (
    SELECT
      neutered,
      SUM(escape_attempts) AS res
    FROM
      animals
    GROUP BY
      neutered
  ) AS sub
ORDER BY
  res DESC
LIMIT
  1;

/* What is the minimum and maximum weight of each type of animal? */
SELECT
  species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM
  animals
GROUP BY
  species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth >= '19900101'
  AND date_of_birth < '20010101'
GROUP BY
  species;

/* What animals belong to Melody Pond? */
SELECT
  a.*
FROM
  animals AS a
  INNER JOIN owners AS o ON a.owner_id = o.id
WHERE
  o.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT
  a.*
FROM
  animals AS a
  INNER JOIN species AS s ON a.species_id = s.id
WHERE
  s.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT
  *
FROM
  owners as o
  LEFT JOIN animals AS a ON o.id = a.owner_id;

/* How many animals are there per species? */
SELECT
  s.name,
  COUNT(*)
FROM
  animals AS a
  INNER JOIN species AS s ON a.species_id = s.id
GROUP BY
  s.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT
  a.*
FROM
  animals AS a
  INNER JOIN owners AS o ON a.owner_id = o.id
  INNER JOIN species AS s ON a.species_id = s.id
WHERE
  s.name = 'Digimon'
  AND o.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT
  a.*
FROM
  animals AS a
  INNER JOIN owners AS o ON a.owner_id = o.id
WHERE
  o.full_name = 'Dean Winchester'
  AND a.escape_attempts = 0;

/* Who owns the most animals? */
SELECT
  o.full_name AS fName,
  COUNT(a.*) AS num
FROM
  owners AS o
  INNER JOIN animals AS a ON o.id = a.owner_id
GROUP BY
  o.id
ORDER BY
  num DESC
LIMIT
  1;

/* Who was the last animal seen by William Tatcher? */
SELECT
  a.name,
  vi.visit_date
FROM
  animals AS a
  INNER JOIN visits AS vi ON a.id = vi.animals_id
  INNER JOIN vets AS ve ON vi.vets_id = ve.id
WHERE
  ve.name = 'William Tatcher'
ORDER BY
  vi.visit_date DESC
LIMIT
  1;

/* How many different animals did Stephanie Mendez see? */
SELECT
  DISTINCT COUNT(a.name)
FROM
  animals AS a
  INNER JOIN visits AS vi ON a.id = vi.animals_id
  INNER JOIN vets AS ve ON vi.vets_id = ve.id
WHERE
  ve.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties. */
SELECT
  ve.name,
  se.name
FROM
  vets AS ve
  LEFT JOIN specializations AS sa ON ve.id = sa.vets_id
  LEFT JOIN species AS se ON sa.species_id = se.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT
  a.name
FROM
  animals AS a
  INNER JOIN visits AS vi ON a.id = vi.animals_id
  INNER JOIN vets AS ve ON vi.vets_id = ve.id
WHERE
  ve.name = 'Stephanie Mendez'
  AND vi.visit_date >= '2020-04-1'
  AND vi.visit_date <= '2020-08-30';

/* What animal has the most visits to vets? */
SELECT
  a.name,
  COUNT(a.name)
FROM
  animals AS a
  INNER JOIN visits AS vi ON a.id = vi.animals_id
GROUP BY
  a.name
ORDER BY
  COUNT DESC
LIMIT
  1;

/* Who was Maisy Smith's first visit? */
SELECT
  a.name,
  vi.visit_date
FROM
  animals AS a
  INNER JOIN visits AS vi ON a.id = vi.animals_id
  INNER JOIN vets AS ve ON vi.vets_id = ve.id
WHERE
  ve.name = 'Maisy Smith'
ORDER BY
  vi.visit_date ASC
LIMIT
  1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT
  a.name,
  a.date_of_birth,
  a.escape_attempts,
  a.neutered,
  a.weight_kg,
  ve.name,
  ve.age,
  ve.date_of_graduation,
  vi.visit_date
FROM
  animals AS a
  INNER JOIN visits AS vi ON a.id = vi.animals_id
  INNER JOIN vets AS ve ON vi.vets_id = ve.id
ORDER BY
  vi.visit_date DESC
LIMIT
  1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT
  COUNT(vi.visit_date)
FROM
  vets AS ve
  INNER JOIN visits AS vi ON vi.vets_id = ve.id
  INNER JOIN animals AS a ON a.id = vi.animals_id
  INNER JOIN specializations AS sa ON ve.id = sa.vets_id
  INNER JOIN species AS se ON sa.species_id = se.id
WHERE
  a.species_id <> sa.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT
  s.name,
  res.COUNT
FROM
  species AS s
  INNER JOIN (
    SELECT
      a.species_id AS id,
      COUNT(*)
    FROM
      visits AS vi
      INNER JOIN vets AS ve ON vi.vets_id = ve.id
      INNER JOIN animalss AS a ON a.id = vi.animals_id
    WHERE
      ve.name = 'Maisy Smith'
    GROUP BY
      a.species_id
  ) AS res ON s.id = res.id
ORDER BY
  res.COUNT DESC
LIMIT
  1;