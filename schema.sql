/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(30),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(30);

CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(40),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(30),
  PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT REFERENCES owners(id);

CREATE TABLE vets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations(
  vets_id INT REFERENCES vets(id) ON UPDATE CASCADE,
  species_id INT REFERENCES species(id) ON UPDATE CASCADE,
  PRIMARY KEY(vets_id, species_id)
);

CREATE TABLE visits(
  id SERIAL,
  vets_id INT REFERENCES vets(id) ON UPDATE CASCADE,
  animals_id INT REFERENCES animals(id) ON UPDATE CASCADE,
  visit_date DATE,
  PRIMARY KEY(id, vets_id, animals_id)
);
