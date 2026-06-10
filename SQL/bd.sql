CREATE DATABASE bd;

use bd;

CREATE TABLE residente (
	cedula int PRIMARY KEY, 
    nombre VARCHAR(50), 
    apto VARCHAR(50), 
    torre VARCHAR(20), 
    telefono int,
    correo VARCHAR(50),
    fecha_ingreso DATETIME
);

CREATE TABLE vehiculo (
	placa varchar(10) PRIMARY KEY, 
    marca VARCHAR(50), 
    modelo VARCHAR(50), 
    tipo_vehiculo VARCHAR(20), 
    año_fabricacion DATE,
    ult_mantenimiento DATE,
    fecha_ingreso DATETIME,
    cedulaResidente int,
    FOREIGN KEY (cedulaResidente) REFERENCES residente(cedula)
);

CREATE TABLE fuenteEmisora (
	id_fuente int AUTO_INCREMENT PRIMARY KEY, 
    tipo VARCHAR(50), 
    descripcion VARCHAR(50), 
    combustible VARCHAR(20), 
    estado VARCHAR(20),
    placaVehiculo VARCHAR(20),
    FOREIGN KEY (placaVehiculo) REFERENCES vehiculo(placa)
);

CREATE TABLE zona (
	id_zona int AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(50), 
    tipo VARCHAR(50), 
    cap_ventilacion int,
    umbra_ppm double,
    idFuente int,
    FOREIGN KEY (idFuente) REFERENCES fuenteEmisora(id_fuente)
);

CREATE TABLE sensor(
	id_sensor int AUTO_INCREMENT PRIMARY KEY, 
    f_instalacion DATE, 
    ulti_calibracion DATE, 
    estado VARCHAR(20), 
    umbral_ppm double,
    idZona int,
    FOREIGN KEY (idZona) REFERENCES zona(id_zona)
);

CREATE TABLE medicion (
	id_medicion int AUTO_INCREMENT PRIMARY KEY, 
    concentracion_ppm double, 
    clasificacion_nivel VARCHAR(50), 
    fecha_y_hora DATETIME, 
    idZona int,
    idSensor int,
    idFuente int,
    FOREIGN KEY (idSensor) REFERENCES sensor(id_sensor)
);

CREATE TABLE alerta(
	id_alerta int AUTO_INCREMENT PRIMARY KEY, 
    nivel_severidad VARCHAR(20), 
    responsable_notif VARCHAR(20), 
    estado VARCHAR(20), 
    fecha_cierre DATE,
    fecha_hora_generacion DATETIME,
    idMedicion int,
    FOREIGN KEY (idMedicion) REFERENCES medicion(id_medicion)
);