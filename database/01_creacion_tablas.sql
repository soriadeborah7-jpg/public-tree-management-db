CREATE DATABASE TP_BBDD1_2025_G06;
GO
USE TP_BBDD1_2025_G06;

CREATE TABLE Empleado (
	ID_Empleado int IDENTITY NOT NULL PRIMARY KEY,
	CUIL decimal(11,0) NOT NULL,
	NombreCompleto varchar(100) NOT NULL,
	FechaIngreso date NOT NULL,
	FechaEgreso date NULL
);

CREATE TABLE Cuadrilla (
	ID_Cuadrilla int IDENTITY NOT NULL PRIMARY KEY,
	NombreCuadrilla varchar(50) NOT NULL
);

CREATE TABLE Especie (
	ID_Especie int IDENTITY NOT NULL PRIMARY KEY,
	Nombre_comun varchar(50) NOT NULL,
	Nombre_cientifico varchar(50) NOT NULL
);

CREATE TABLE Ubicacion (
	ID_Ubicacion int IDENTITY NOT NULL PRIMARY KEY,
	Nombre varchar(100) NOT NULL,
	Latitud decimal(9,6) NOT NULL,
	Longitud decimal(9,6) NOT NULL
);

CREATE TABLE Tipo_de_tarea (
	ID_Tipo_de_tarea int IDENTITY NOT NULL PRIMARY KEY,
	Descripcion varchar(100) NOT NULL
);

CREATE TABLE Motivo_de_reclamo (
	ID_Motivo int IDENTITY NOT NULL PRIMARY KEY,
	Descripcion varchar(100) NOT NULL
);

CREATE TABLE Indicador_de_salud (
	ID_Indicador int IDENTITY NOT NULL PRIMARY KEY,
	Estado varchar(50) NOT NULL
);

CREATE TABLE Numero_telefonico (
	Numero_telefonico decimal(20,0) NOT NULL,
	ID_Empleado int NOT NULL,
	Inactivo bit DEFAULT 0 NOT NULL,
	PRIMARY KEY (Numero_telefonico, ID_Empleado),
	FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado)
);

CREATE TABLE Asignacion (
	ID_Asignacion int IDENTITY NOT NULL PRIMARY KEY,
	ID_Empleado int NOT NULL,
	ID_Cuadrilla int NOT NULL,
	Fecha_de_inicio date NOT NULL,
	FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado),
	FOREIGN KEY (ID_Cuadrilla) REFERENCES Cuadrilla(ID_Cuadrilla)
);

CREATE TABLE Tarea (
	ID_Tarea int IDENTITY NOT NULL PRIMARY KEY,
	ID_Tipo_de_tarea int NOT NULL,
	ID_Cuadrilla int NOT NULL,
	Fecha_planificada date NOT NULL,
	Fecha_efectiva date NULL,
	Comentario_final varchar(100) NULL,
	FOREIGN KEY (ID_Tipo_de_tarea) REFERENCES Tipo_de_tarea(ID_Tipo_de_tarea),
	FOREIGN KEY (ID_Cuadrilla) REFERENCES Cuadrilla(ID_Cuadrilla)
);

CREATE TABLE Arbol (
	ID_Arbol varchar(50) NOT NULL PRIMARY KEY,
	ID_Especie int NOT NULL,
	ID_Ubicacion int NOT NULL,
	Fecha_plantado date NULL,
	FOREIGN KEY (ID_Especie) REFERENCES Especie(ID_Especie),
	FOREIGN KEY (ID_Ubicacion) REFERENCES Ubicacion(ID_Ubicacion)
);

CREATE TABLE Arboles_por_tarea (
	ID_Tarea int NOT NULL,
	ID_Arbol varchar(50) NOT NULL,
	PRIMARY KEY (ID_Tarea, ID_Arbol),
	FOREIGN KEY (ID_Tarea) REFERENCES Tarea(ID_Tarea),
	FOREIGN KEY (ID_Arbol) REFERENCES Arbol(ID_Arbol)
);

CREATE TABLE Medicion_de_salud (
	ID_Salud int IDENTITY NOT NULL PRIMARY KEY,
	ID_Arbol varchar(50) NOT NULL,
	ID_Indicador int NOT NULL,
	Fecha_medicion date NOT NULL,
	FOREIGN KEY (ID_Arbol) REFERENCES Arbol(ID_Arbol),
	FOREIGN KEY (ID_Indicador) REFERENCES Indicador_de_salud(ID_Indicador)
);

CREATE TABLE Medicion_de_altura (
	ID_Medicion int IDENTITY NOT NULL PRIMARY KEY,
	ID_Arbol varchar(50) NOT NULL,
	Altura decimal(6,3) NOT NULL,
	Fecha_medicion date NOT NULL,
	FOREIGN KEY (ID_Arbol) REFERENCES Arbol(ID_Arbol)
);

CREATE TABLE Reclamo (
	ID_Reclamo int IDENTITY NOT NULL PRIMARY KEY,
	Mail varchar(100) NOT NULL,
	Texto_mail varchar(1000) NULL,
	ID_Motivo int NOT NULL,
	ID_Arbol varchar(50) NOT NULL,
	Fecha_reclamo date NOT NULL,
	FOREIGN KEY (ID_Arbol) REFERENCES Arbol(ID_Arbol),
	FOREIGN KEY (ID_Motivo) REFERENCES Motivo_de_reclamo(ID_Motivo)
);

CREATE TABLE Asignacion_tarea_reclamo (
	ID_Tarea int NOT NULL,
	ID_Reclamo int NOT NULL,
	Fecha_asignacion date NOT NULL,
	PRIMARY KEY (ID_Tarea, ID_Reclamo),
	FOREIGN KEY (ID_Tarea) REFERENCES Tarea(ID_Tarea),
	FOREIGN KEY (ID_Reclamo) REFERENCES Reclamo(ID_Reclamo)
);
GO