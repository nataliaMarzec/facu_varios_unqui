CREATE TABLE Equipos
 (id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  nombre VARCHAR (20) NOT NULL,
  creado DATE, 
  socios INT UNSIGNED,
  PRIMARY KEY (id),
  UNIQUE KEY(nombre) ) 
ENGINE=InnoDB;

INSERT INTO Equipos (nombre, creado, socios) 
Values('Independiente', STR_TO_DATE('1-01-1905', '%d-%m-%Y'), 110000);

INSERT INTO Equipos (nombre, creado, socios) 
Values('Boca', STR_TO_DATE('3-04-1905', '%d-%m-%Y'), 140000),
('River', STR_TO_DATE('25-05-1901', '%d-%m-%Y'), 123500),
('Racing', STR_TO_DATE('25-03-1903', '%d-%m-%Y'), 70000),
('San Lorenzo', STR_TO_DATE('1-04-1908', '%d-%m-%Y'), 70000);

CREATE TABLE dt
 (id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  nombre VARCHAR (20) NOT NULL,
  apellido VARCHAR (20) NOT NULL, 
  PRIMARY KEY (id),
  UNIQUE KEY (nombre, apellido)) 
ENGINE=InnoDB;


 ALTER TABLE Equipos
  ADD COLUMN dt INT UNSIGNED, 
  ADD FOREIGN KEY (dt) REFERENCES dt(id),
  ADD UNIQUE KEY (dt);

INSERT INTO dt (nombre, apellido) values 
('Daniel','Hollan'), 
('Marcelo', 'Gallardo'),
('Guillermo','Barros Schelotto'), 
('Diego', 'Cocca'), 
('Diego', 'Aguirre');

UPDATE Equipos SET
dt = (Select id from dt where nombre like 'Daniel' and apellido like 'Hollan') 
where nombre like 'Independiente';


UPDATE Equipos SET
dt = (Select id from dt where nombre like 'Marcelo' and apellido like 'Gallardo') 
where nombre like 'River';


UPDATE Equipos SET
dt = (Select id from dt where nombre like 'Guillermo' and apellido like 'Barros Schelotto') 
where nombre like 'Boca';


UPDATE Equipos SET
dt = (Select id from dt where nombre like 'Diego' and apellido like 'Aguirre') 
where nombre like 'San Lorenzo';

CREATE TABLE Banderas
 (id INT UNSIGNED NOT NULL, 
  color_primario VARCHAR (20) NOT NULL,
  color_secundario VARCHAR (20), 
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Equipos(id)) 
ENGINE=InnoDB;

Insert into Banderas (id, color_primario, color_secundario) values 
((Select id from Equipos where nombre like 'Independiente'), 'Rojo', 'Blanco'),
((Select id from Equipos where nombre like 'River'), 'Blanco', 'Rojo'),
((Select id from Equipos where nombre like 'Boca'), 'Azul', 'Amarillo'),
((Select id from Equipos where nombre like 'San Lorenzo'), 'Rojo', 'Azul'),
((Select id from Equipos where nombre like 'Racing'), 'Celeste', 'Blanco');

CREATE TABLE Jugadores
 (id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  nombre VARCHAR (20) NOT NULL,
  apellido VARCHAR (20) NOT NULL, 
  equipo INT UNSIGNED,
  PRIMARY KEY (id),
  UNIQUE KEY (nombre, apellido),
  FOREIGN KEY (equipo) REFERENCES Equipos(id)
  ) ENGINE=InnoDB;

INSERT INTO Jugadores (equipo, nombre, apellido) VALUES 
((Select id from Equipos where nombre like 'Independiente'), 'Nicolas', 'Tagliafico'),
((Select id from Equipos where nombre like 'Independiente'), 'Diego', 'Rodriguez'),
((Select id from Equipos where nombre like 'Independiente'), 'Ezequiel', 'Barco'),
((Select id from Equipos where nombre like 'Boca'), 'Fernando', 'Gago');

CREATE TABLE Copas
 (id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  nombre VARCHAR (40) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY (nombre)  ) 
ENGINE=InnoDB;

INSERT INTO Copas (nombre) VALUES 
('Libertadores'), ('Sudamericana');

CREATE TABLE Campeonatos
 (id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  campeon INT UNSIGNED NOT NULL, 
  copa INT UNSIGNED NOT NULL,
  anio INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (copa) REFERENCES Copas(id),
  FOREIGN KEY (campeon) REFERENCES Equipos(id),
  UNIQUE KEY (copa, anio)
  ) 
ENGINE=InnoDB;

INSERT INTO Campeonatos (anio, campeon, copa) VALUES
(1964, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(1965, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(1972, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(1973, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(1974, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(1975, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(1984, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Libertadores')),
(2010, (Select id from Equipos where nombre like 'Independiente'), (Select id from Copas where nombre like 'Sudamericana')),
(1977,(Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Libertadores')),
(1978,(Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Libertadores')),
(2000,(Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Libertadores')),
(2001,(Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Libertadores')),
(2003,(Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Libertadores')),
(2007,(Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Libertadores')),
(2004, (Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Sudamericana')),
(2005, (Select id from Equipos where nombre like 'Boca'), (Select id from Copas where nombre like 'Sudamericana')),
(1986, (Select id from Equipos where nombre like 'River'), (Select id from Copas where nombre like 'Libertadores')),
(1996, (Select id from Equipos where nombre like 'River'), (Select id from Copas where nombre like 'Libertadores')),
(2015, (Select id from Equipos where nombre like 'River'), (Select id from Copas where nombre like 'Libertadores')),
(2014, (Select id from Equipos where nombre like 'River'), (Select id from Copas where nombre like 'Sudamericana')),
(2014, (Select id from Equipos where nombre like 'San Lorenzo'), (Select id from Copas where nombre like 'Libertadores')),
(2002, (Select id from Equipos where nombre like 'San Lorenzo'), (Select id from Copas where nombre like 'Sudamericana')),
(1967, (Select id from Equipos where nombre like 'Racing'), (Select id from Copas where nombre like 'Libertadores'));
