
use db_medicos;
-- Procedimiento para insertar pacientes en MySQL
DELIMITER //

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
    INSERT INTO Pacientes(
        nombre, 
        apellido_paterno, 
        apellido_materno, 
        fecha_nacimiento, 
        direccion, 
        telefono, 
        correo, 
        enfermedades, 
        alergias, 
        antecedentes_fam
    ) 
    VALUES (
        nom, 
        ap_m, 
        ap_p, 
        nacimiento, 
        direccion, 
        tel, 
        correo, 
        enfermedades, 
        alergias, 
        ant_fam
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



