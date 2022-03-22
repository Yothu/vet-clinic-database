/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, TRUE, 22);

INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

INSERT INTO vets(name, age, date_of_graduation) VALUES('William Tatcher', 45, '2000-04-23');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations(vets_id, species_id) VALUES(3, 1);
INSERT INTO specializations(vets_id, species_id) VALUES(5, 1);
INSERT INTO specializations(vets_id, species_id) VALUES(5, 2);
INSERT INTO specializations(vets_id, species_id) VALUES(6, 2);

/* SPECIES
  1 | Pokemon
  2 | Digimon
*/

/* ANIMALS
 10 | Blossom
  9 | Boarmon
  8 | Angemon
  7 | Squirtle
  6 | Plantmon
  5 | Charmander
  4 | Agumon
  3 | Gabumon
  2 | Pikachu
  1 | Devimon
*/

/* VETS
  6 | Jack Harkness
  5 | Stephanie Mendez
  4 | Maisy Smith
  3 | William Tatcher
*/

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(4, 3, '2020-05-24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(4, 5, '2020-07-22');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(3, 6, '2021-02-02');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(2, 4, '2020-01-05');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(2, 4, '2020-03-08');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(2, 4, '2020-05-14');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(1, 5, '2021-05-04');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(5, 6, '2021-02-24');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(6, 4, '2019-12-21');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(6, 3, '2020-08-10');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(6, 4, '2021-04-07');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(7, 5, '2019-09-29');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(8, 6, '2020-10-03');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(8, 6, '2020-11-04');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(9, 4, '2019-01-24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(9, 4, '2019-05-15');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(9, 4, '2020-02-27');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(9, 4, '2020-08-03');

INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(10, 5, '2020-05-24');
INSERT INTO visits(animals_id, vets_id, visit_date) VALUES(10, 3, '2021-01-11');