CREATE TABLE patients (
  id INT SERIAL NOT NULL,
  name VARCHAR(30) NOT NULL,
  date_of_birth DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
  id INT SERIAL NOT NULL,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL REFERENCES patients(id),
  status VARCHAR(50),
  PRIMARY KEY(id)
);

CREATE TABLE invoices (
  id INT SERIAL NOT NULL,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  PRIMARY KEY(id),
  medical_history_id INT NOT NULL REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
id INT SERIAL NOT NULL,
type VARCHAR(20) NOT NULL,
name VARCHAR(100) NOT NULL,
);

CREATE TABLE medical_histories_treatments (
medical_history_id INT NOT NULL REFERENCES medical_histories(id),
treatment_id INT NOT NULL REFERENCES treatments(id),
PRIMARY KEY (medical_history_id, treatment_id);
);

CREATE TABLE invoice_items (
id INT SERIAL NOT NULL,
unit_price DECIMAL NOT NULL,
quantity INT NOT NULL,
total_price DECIMAL NOT NULL,
PRIMARY KEY(id),
invoice_id INT NOT NULL REFERENCES invoices(id),
treatment_id INT NOT NULL REFERENCES treatments(id)
); 