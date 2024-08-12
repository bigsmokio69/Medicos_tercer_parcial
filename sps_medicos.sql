
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
        id_medico
    ) 
    VALUES (
        nom, 
        ap_m, 
        ap_p, 
        nacimiento, 
        enfermedades, 
        alergias, 
        ant_fam,
        id_med
    );
END //

DELIMITER ;

-- Ejecuciones del procedimiento
CALL sp_ins_paciente('Juan', 'Perez', 'Lopez', '1980-05-15', 'Calle Falsa 123', '4420401659', 'juan.perez@example.com', 'Diabetes', 'Penicilina', 'Padre: Hipertensión');
CALL sp_ins_paciente('Maria', 'Gomez', 'Sanchez', '1990-08-25', 'Avenida Siempreviva 742', '4427942066', 'maria.gomez@example.com', 'Asma', 'Ninguna', 'Madre: Asma');
CALL sp_ins_paciente('Carlos', 'Hernandez', 'Diaz', '1975-12-10', 'Boulevard Reforma 100', '4279219917', 'carlos.hernandez@example.com', 'Hipertensión', 'Polen', 'Tío: Diabetes');
CALL sp_ins_paciente('Ana', 'Martinez', 'Ramirez', '1985-03-30', 'Calle de la Amargura 50', '4424321524', 'ana.martinez@example.com', 'Colesterol alto', 'Frutos secos', 'Hermana: Hipertensión');
CALL sp_ins_paciente('Luis', 'Garcia', 'Torres', '1995-07-20', 'Camino Real 200', '4270740236', 'luis.garcia@example.com', 'Ninguna', 'Mariscos', 'Abuelo: Cáncer');
CALL sp_ins_paciente('Elena', 'Fernandez', 'Vega', '1982-02-14', 'Callejón del Beso 7', '4417591432', 'elena.fernandez@example.com', 'Hipotiroidismo', 'Lácteos', 'Padre: Hipotiroidismo');
CALL sp_ins_paciente('Jorge', 'Lopez', 'Morales', '1978-11-05', 'Paseo de la Reforma 1234', '4428452049', 'jorge.lopez@example.com', 'Migraña', 'Nueces', 'Madre: Migraña');
CALL sp_ins_paciente('Lucia', 'Ruiz', 'Ortega', '1988-04-22', 'Plaza de la Constitución 1', '4270529427', 'lucia.ruiz@example.com', 'Gastritis', 'Gluten', 'Hermano: Gastritis');
CALL sp_ins_paciente('Miguel', 'Sanchez', 'Rios', '1992-09-15', 'Avenida de los Insurgentes 500', '427052324', 'miguel.sanchez@example.com', 'Hiperglucemia', 'Mariscos', 'Padre: Diabetes');
CALL sp_ins_paciente('Laura', 'Diaz', 'Mendoza', '1983-06-28', 'Calle de los Artesanos 25', '4270529324', 'laura.diaz@example.com', 'Hipertensión', 'Polvo', 'Madre: Hipertensión');

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

-- CALL sp_ins_medico ('Alejandro', 'Mendoza', 'Lopez', 'ALEM780505HDF', '4451236789', 'alejandro.mendoza@example.com', '1234567890', 'Administrador');
-- CALL sp_ins_medico ('Beatriz', 'Ramos', 'Martinez', 'BEAR900825LDF', '4469871234', 'beatriz.ramos@example.com', '0987654321', 'Medico');
-- CALL sp_ins_medico ('Carlos', 'Garcia', 'Hernandez', 'CARG751210CDF', '4476543210', 'carlos.garcia@example.com', '1122334455', 'Medico');
-- CALL sp_ins_medico ('Diana', 'Fernandez', 'Gonzalez', 'DIAF850330CDF', '4483214567', 'diana.fernandez@example.com', '2233445566', 'Medico');
-- CALL sp_ins_medico ('Eduardo', 'Martinez', 'Ruiz', 'EDUM950720LDF', '4491230987', 'eduardo.martinez@example.com', '3344556677', 'Medico');
-- CALL sp_ins_medico ('Fernanda', 'Lopez', 'Mora', 'FERL820214HDF', '4412345678', 'fernanda.lopez@example.com', '4455667788', 'Medico');
-- CALL sp_ins_medico ('Gerardo', 'Perez', 'Sanchez', 'GERP781105CDF', '4423456789', 'gerardo.perez@example.com', '5566778899', 'Administrador');
-- CALL sp_ins_medico ('Hilda', 'Gomez', 'Torres', 'HILG880422LDF', '4434567890', 'hilda.gomez@example.com', '6677889900', 'Medico');
-- CALL sp_ins_medico ('Ignacio', 'Diaz', 'Vega', 'IGND920915CDF', '4445678901', 'ignacio.diaz@example.com', '7788990011', 'Medico');
-- CALL sp_ins_medico ('Juana', 'Santos', 'Ortega', 'JUAS830628LDF', '4456789012', 'juana.santos@example.com', '8899001122', 'Administrador');






-- Procedimiento para insertar pacientes
DELIMITER $$
CREATE PROCEDURE sp_ins_paciente(
    IN nom VARCHAR(100),
    IN ap_m VARCHAR(100),
    IN ap_p VARCHAR(100),
    IN nacimiento DATE,
    IN direccion VARCHAR(200),
    IN tel VARCHAR(15),
    IN correo VARCHAR(100),
    IN enfermedades VARCHAR(200),
    IN alergias VARCHAR(200),
    IN ant_fam VARCHAR(200)
)
BEGIN
    INSERT INTO Pacientes(nombre, apellido_paterno, apellido_materno, fecha_nacimiento, direccion, telefono, correo, enfermedades, alergias, antecedentes_fam)
    VALUES (nom, ap_m, ap_p, nacimiento, direccion, tel, correo, enfermedades, alergias, ant_fam);
END $$
DELIMITER ;

-- Ejecución del procedimiento sp_ins_paciente
CALL sp_ins_paciente('Juan', 'Perez', 'Lopez', '1980-05-15', 'Calle Falsa 123', '4420401659', 'juan.perez@example.com', 'Diabetes', 'Penicilina', 'Padre: Hipertension');
CALL sp_ins_paciente('Maria', 'Gomez', 'Sanchez', '1990-08-25', 'Avenida Siempreviva 742', '4427942066', 'maria.gomez@example.com', 'Asma', 'Ninguna', 'Madre: Asma');
CALL sp_ins_paciente('Carlos', 'Hernandez', 'Diaz', '1975-12-10', 'Boulevard Reforma 100', '4279219917', 'carlos.hernandez@example.com', 'Hipertension', 'Polen', 'Tio: Diabetes');
CALL sp_ins_paciente('Ana', 'Martinez', 'Ramirez', '1985-03-30', 'Calle de la Amargura 50', '4424321524', 'ana.martinez@example.com', 'Colesterol alto', 'Frutos secos', 'Hermana: Hipertension');
CALL sp_ins_paciente('Luis', 'Garcia', 'Torres', '1995-07-20', 'Camino Real 200', '4270740236', 'luis.garcia@example.com', 'Ninguna', 'Mariscos', 'Abuelo: Cancer');
CALL sp_ins_paciente('Elena', 'Fernandez', 'Vega', '1982-02-14', 'Callejon del Beso 7', '4417591432', 'elena.fernandez@example.com', 'Hipotiroidismo', 'Lacteos', 'Padre: Hipotiroidismo');
CALL sp_ins_paciente('Jorge', 'Lopez', 'Morales', '1978-11-05', 'Paseo de la Reforma 1234', '4428452049', 'jorge.lopez@example.com', 'Migraña', 'Nueces', 'Madre: Migraña');
CALL sp_ins_paciente('Lucia', 'Ruiz', 'Ortega', '1988-04-22', 'Plaza de la Constitucion 1', '4270529427', 'lucia.ruiz@example.com', 'Gastritis', 'Gluten', 'Hermano: Gastritis');
CALL sp_ins_paciente('Miguel', 'Sanchez', 'Rios', '1992-09-15', 'Avenida de los Insurgentes 500', '427052324', 'miguel.sanchez@example.com', 'Hiperglucemia', 'Mariscos', 'Padre: Diabetes');
CALL sp_ins_paciente('Laura', 'Diaz', 'Mendoza', '1983-06-28', 'Calle de los Artesanos 25', '4270529324', 'laura.diaz@example.com', 'Hipertension', 'Polvo', 'Madre: Hipertension');

SELECT * FROM Pacientes;

-- Procedimiento para insertar medicos
DELIMITER $$
CREATE PROCEDURE sp_ins_medico(
    IN nom VARCHAR(100),
    IN ap_m VARCHAR(100),
    IN ap_p VARCHAR(100),
    IN rfc VARCHAR(30),
    IN tel VARCHAR(15),
    IN correo VARCHAR(100),
    IN cedula VARCHAR(100),
    IN rol VARCHAR(40)
)
BEGIN
    INSERT INTO Medicos(nombre, ap_p, ap_m, rfc, tel, correo, cedula, rol)
    VALUES (nom, ap_p, ap_m, rfc, tel, correo, cedula, rol);
END $$
DELIMITER ;

-- Ejecución del procedimiento sp_ins_medico
CALL sp_ins_medico('Alejandro', 'Mendoza', 'Lopez', 'ALEM780505HDF', '4451236789', 'alejandro.mendoza@example.com', '1234567890', 'Administrador');
CALL sp_ins_medico('Beatriz', 'Ramos', 'Martinez', 'BEAR900825LDF', '4469871234', 'beatriz.ramos@example.com', '0987654321', 'Medico');
CALL sp_ins_medico('Carlos', 'Garcia', 'Hernandez', 'CARG751210CDF', '4476543210', 'carlos.garcia@example.com', '1122334455', 'Medico');
CALL sp_ins_medico('Diana', 'Fernandez', 'Gonzalez', 'DIAF850330CDF', '4483214567', 'diana.fernandez@example.com', '2233445566', 'Medico');
CALL sp_ins_medico('Eduardo', 'Martinez', 'Ruiz', 'EDUM950720LDF', '4491230987', 'eduardo.martinez@example.com', '3344556677', 'Medico');
CALL sp_ins_medico('Fernanda', 'Lopez', 'Mora', 'FERL820214HDF', '4412345678', 'fernanda.lopez@example.com', '4455667788', 'Medico');
CALL sp_ins_medico('Gerardo', 'Perez', 'Sanchez', 'GERP781105CDF', '4423456789', 'gerardo.perez@example.com', '5566778899', 'Administrador');
CALL sp_ins_medico('Hilda', 'Gomez', 'Torres', 'HILG880422LDF', '4434567890', 'hilda.gomez@example.com', '6677889900', 'Medico');
CALL sp_ins_medico('Ignacio', 'Diaz', 'Vega', 'IGND920915CDF', '4445678901', 'ignacio.diaz@example.com', '7788990011', 'Medico');
CALL sp_ins_medico('Juana', 'Santos', 'Ortega', 'JUAS830628LDF', '4456789012', 'juana.santos@example.com', '8899001122', 'Administrador');

SELECT * FROM Medicos;

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