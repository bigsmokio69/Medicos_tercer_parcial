use db_medicos;

CREATE TABLE Medicos(
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ap_p VARCHAR(100),
    ap_m VARCHAR(100),
    rfc VARCHAR(30),
    tel VARCHAR(15),
    correo VARCHAR(100),
    cedula VARCHAR(30),
    rol VARCHAR(40),
    contrasena VARCHAR(150),
    estatus INT DEFAULT 1
);

CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL, 
    fecha_nacimiento DATE,
    enfermedades VARCHAR(200),
    alergias VARCHAR(200),
    antecedentes_fam VARCHAR(200),
    id_medico INT,
    estatus INT DEFAULT 1,
    fecha_registro DATE ,
    foreign key (id_medico) references Medicos(id_medico)
);

CREATE TABLE Citas(
    id_citas INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha_cita DATETIME,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

CREATE TABLE Diagnosticos(
    id_diagnostico INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    sintomas VARCHAR(200),
    tratamiento VARCHAR(300),
    solicitud_estudios VARCHAR(200),
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
);

CREATE TABLE Recetas(
    id_receta INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT,
    id_paciente INT,
    medicamentos VARCHAR(200),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico),
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
);

CREATE TABLE Exploracion(
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    fecha_registro DATETIME,
    edad_paciente INT,
    peso VARCHAR(10),
    altura VARCHAR(10),
    temperatura VARCHAR(10),
    lpm VARCHAR(10),
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
);

CREATE TABLE Medicos_Log (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ap_p VARCHAR(100),
    ap_m VARCHAR(100),
	operacion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Pacientes_Log (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    nombre_medico VARCHAR(100),
    ap_p VARCHAR(100),
    ap_m VARCHAR(100),
    operacion VARCHAR(10),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Temp_Session (
	id int AUTO_INCREMENT PRIMARY KEY,
    ses_medico_id INT
);

-- Por si acaso
-- ALTER table medicos ADD COLUMN estatus int default 1;
-- ALTER table pacientes ADD COLUMN estatus int default 1;
-- ALTER TABLE pacientes ADD COLUMN fecha_registro DATE;