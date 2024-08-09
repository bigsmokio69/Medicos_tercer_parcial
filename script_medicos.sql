use db_medicos;
CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL, 
    fecha_nacimiento DATE,
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    correo VARCHAR(100),
    enfermedades VARCHAR(200),
    alergias VARCHAR(200),
    antecedentes_fam VARCHAR(200)
);

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
    contrasena VARCHAR(150)
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

CREATE TABLE Historial_medico(
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