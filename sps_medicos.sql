use db_medicos;

-- Procedimiento para insertar pacientes en MySQL
DELIMITER //

CREATE PROCEDURE sp_ins_paciente(
    IN nom VARCHAR(100),
    IN ap_m VARCHAR(100),
    IN ap_p VARCHAR(100),
    IN nacimiento DATE,
    IN enfermedades VARCHAR(200),
    IN alergias VARCHAR(200),
    IN ant_fam VARCHAR(200),
    IN id_med INT
)
BEGIN
    INSERT INTO Pacientes(
        nombre, 
        apellido_paterno, 
        apellido_materno, 
        fecha_nacimiento, 
        enfermedades, 
        alergias, 
        antecedentes_fam,
        id_medico,
        fecha_registro
    ) 
    VALUES (
        nom, 
        ap_m, 
        ap_p, 
        nacimiento, 
        enfermedades, 
        alergias, 
        ant_fam,
        id_med,
        CURDATE()
    );
END //

DELIMITER ;

-- Ejecuciones del procedimiento
CALL sp_ins_paciente('Juan', 'Perez', 'Lopez', '1980-05-15', 'Diabetes', 'Penicilina', 'Padre: Hipertensión', 1);
CALL sp_ins_paciente('Maria', 'Gomez', 'Sanchez', '1990-08-25', 'Asma', 'Ninguna', 'Madre: Asma', 2);
CALL sp_ins_paciente('Carlos', 'Hernandez', 'Diaz', '1975-12-10', 'Hipertensión', 'Polen', 'Tío: Diabetes', 3);
CALL sp_ins_paciente('Ana', 'Martinez', 'Ramirez', '1985-03-30', 'Colesterol alto', 'Frutos secos', 'Hermana: Hipertensión');

-- Procedimiento para insertar medicos
DELIMITER //
CREATE PROCEDURE sp_ins_medico(
IN nom varchar(100),
IN ap_m varchar(100),
IN ap_p varchar(100),
IN rfc varchar(30),
IN tel varchar(15),
IN correo varchar(100),
IN cedula varchar(100),
IN rol varchar(40),
IN contra varchar(150)
)
BEGIN
	INSERT INTO Medicos(nombre, ap_p, ap_m, rfc, tel, correo, cedula, rol, contrasena) VALUES
	(nom, ap_p, ap_m, rfc, tel, correo, cedula, rol, contra);
END //
DELIMITER ;

-- Ejecución del procedimiento sp_ins_medico
CALL sp_ins_medico('Hilda', 'Gomez', 'Torres', 'HILG880422LDF', '4434567890', 'hilda.gomez@example.com', '6677889900', 'Medico', 'passwdprueba');
CALL sp_ins_medico('Ignacio', 'Diaz', 'Vega', 'IGND920915CDF', '4445678901', 'ignacio.diaz@example.com', '7788990011', 'Medico', 'passwdprueba');
CALL sp_ins_medico('Juana', 'Santos', 'Ortega', 'JUAS830628LDF', '4456789012', 'juana.santos@example.com', '8899001122', 'Administrador', 'passwdprueba');

-- Procedimiento para insertar citas
DELIMITER $$
CREATE PROCEDURE sp_ins_citas(
    IN id_medico INT,
    IN id_paciente INT,
    IN fecha DATETIME
)
BEGIN
    INSERT INTO Citas(id_medico, id_paciente, fecha_cita)
    VALUES (id_medico, id_paciente, fecha);
END $$
DELIMITER ;

-- Ejecución del procedimiento sp_ins_citas
CALL sp_ins_citas(5, 3, '2024-06-15 10:30:00');
CALL sp_ins_citas(7, 2, '2024-07-20 14:00:00');
CALL sp_ins_citas(2, 8, '2024-08-05 09:00:00');
CALL sp_ins_citas(9, 1, '2024-06-25 16:00:00');
CALL sp_ins_citas(4, 6, '2024-07-10 11:15:00');
CALL sp_ins_citas(10, 7, '2024-08-15 08:45:00');
CALL sp_ins_citas(3, 4, '2024-06-30 13:30:00');
CALL sp_ins_citas(8, 5, '2024-07-25 15:00:00');
CALL sp_ins_citas(6, 10, '2024-08-20 12:00:00');
CALL sp_ins_citas(1, 9, '2024-07-05 10:00:00');

SELECT * FROM Citas;

-- Procedimiento para insertar diagnóstico
DELIMITER $$
CREATE PROCEDURE sp_ins_diagn(
    IN sintomas VARCHAR(200),
    IN tratamiento VARCHAR(300),
    IN soli_estud VARCHAR(200),
    IN id_paciente INT
)
BEGIN
    INSERT INTO Diagnosticos(sintomas, tratamiento, solicitud_estudios, id_paciente)
    VALUES (sintomas, tratamiento, soli_estud, id_paciente);
END $$
DELIMITER ;

-- Ejecución del procedimiento sp_ins_diagn
CALL sp_ins_diagn('Dolor de cabeza y fiebre', 'Paracetamol 500mg cada 8 horas por 5 dias', 'Ninguno', 4);
CALL sp_ins_diagn('Tos persistente y dolor en el pecho', 'Jarabe para la tos, reposo, y abundantes liquidos', 'Ninguno', 1);
CALL sp_ins_diagn('Dolor abdominal y nauseas', 'Omeprazol 20mg una vez al dia por 7 dias', 'Ultrasonido abdominal', 5);
CALL sp_ins_diagn('Fatiga y debilidad muscular', 'Suplementos de hierro, dieta rica en proteinas', 'Examen de sangre completo', 2);
CALL sp_ins_diagn('Dolor de garganta y fiebre', 'Ibuprofeno 400mg cada 6 horas por 3 dias', 'Ninguno', 3);

-- Procedimiento para actualizar los registro de los medicos
DELIMITER //
CREATE PROCEDURE sp_update_medico(
	IN id int,
    IN nom VARCHAR(100),
    IN apellido_paterno VARCHAR(100),
    IN apellido_materno VARCHAR(100),
    IN rfc VARCHAR(30),
    IN telefono VARCHAR(15),
    IN correo VARCHAR(100),
    IN cedula VARCHAR(100),
    IN rol VARCHAR(40),
    IN contra VARCHAR(150)
)
BEGIN
    UPDATE Medicos 
    SET 
        nombre = nom, 
        ap_p=apellido_paterno ,
        ap_m=apellido_materno, 
        rfc=rfc,
        tel = telefono, 
        correo = correo, 
        cedula = cedula, 
        rol = rol, 
        contrasena = contra
    WHERE id_medico=id;
END //

DELIMITER ;

-- BORRADO LOGICO DE PACIENTES
DELIMITER //
CREATE PROCEDURE sp_logicdel_pac(
IN idPac int
)
BEGIN
	UPDATE pacientes SET estatus=0 where id_paciente=idPac;
END //
DELIMITER ;

-- BORRADO LOGICO DE MEDICOS
DELIMITER //
CREATE PROCEDURE sp_logicdel_med(
IN idMed int
)
BEGIN
	UPDATE medicos SET estatus=0 where id_medico=idMed;
END //
DELIMITER ;