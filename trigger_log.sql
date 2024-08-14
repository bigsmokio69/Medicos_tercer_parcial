use db_medicos;

-- TRIGGER DE INSERCIÓN DE MÉDICOS
DELIMITER $$
CREATE TRIGGER tr_medico_insert
AFTER INSERT ON Medicos
FOR EACH ROW
BEGIN
	DECLARE nombre_medico VARCHAR(100);
	DECLARE apellido_p VARCHAR(100);
    DECLARE apellido_m VARCHAR(100);
    
    SELECT nombre INTO nombre_medico 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_p INTO apellido_p
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_m INTO apellido_m 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);

    INSERT INTO Medicos_Log (nombre, ap_p, ap_m, operacion, fecha)
    VALUES (nombre_medico, apellido_p, apellido_m, 'INSERT', NOW());
    
    DELETE FROM temp_session WHERE id>0;
END $$
DELIMITER ;
-- TRIGGER INSERT DEL MEDICO

-- TRIGGER UPDATE DEL MEDICO
DELIMITER $$
CREATE TRIGGER tr_medico_update
AFTER UPDATE ON medicos
FOR EACH ROW
BEGIN
    DECLARE nombre_medico VARCHAR(100);
	DECLARE apellido_p VARCHAR(100);
    DECLARE apellido_m VARCHAR(100);
    
    SELECT nombre INTO nombre_medico 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_p INTO apellido_p
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_m INTO apellido_m 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);

    INSERT INTO Medicos_Log (nombre, ap_p, ap_m, operacion, fecha)
    VALUES (nombre_medico, apellido_p, apellido_m, 'UPDATE', NOW());
    
    DELETE FROM temp_session WHERE id>0;
END$$
DELIMITER ;
-- TRIGGER UPDATE FIN

-- TRIGGER DELETE MEDICO INICIO 
DELIMITER $$
CREATE TRIGGER tr_medico_delete
AFTER DELETE ON Medicos
FOR EACH ROW
BEGIN
    DECLARE nombre_medico VARCHAR(100);
	DECLARE apellido_p VARCHAR(100);
    DECLARE apellido_m VARCHAR(100);
    
    SELECT nombre INTO nombre_medico 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_p INTO apellido_p
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_m INTO apellido_m 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);

    INSERT INTO Medicos_Log (nombre, ap_p, ap_m, operacion, fecha)
    VALUES (nombre_medico, apellido_p, apellido_m, 'DELETE', NOW());
    
    DELETE FROM temp_session WHERE id>0;
END $$
DELIMITER ;
-- TRIGGER DELETE MEDICO FIN

-- TRIGGER INSERT PACIENTE INICIO
DELIMITER $$
CREATE TRIGGER tr_paciente_insert
AFTER INSERT ON pacientes
FOR EACH ROW
BEGIN
    DECLARE nombre_med VARCHAR(100);
	DECLARE apellido_p VARCHAR(100);
    DECLARE apellido_m VARCHAR(100);
    
    SELECT nombre INTO nombre_med 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_p INTO apellido_p
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_m INTO apellido_m 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);

    INSERT INTO Pacientes_Log (nombre_medico, ap_p, ap_m, operacion, fecha)
    VALUES (nombre_med, apellido_p, apellido_m, 'INSERT', NOW());
    
    DELETE FROM temp_session WHERE id>0;
END $$
DELIMITER ;
-- TRIGGER INSERT PACIENTE FIN

-- TRIGGER UPDATE PACIENTE INICIO
DELIMITER $$
CREATE TRIGGER tr_paciente_update
AFTER UPDATE ON pacientes
FOR EACH ROW
BEGIN
    DECLARE nombre_med VARCHAR(100);
	DECLARE apellido_p VARCHAR(100);
    DECLARE apellido_m VARCHAR(100);
    
    SELECT nombre INTO nombre_med 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_p INTO apellido_p
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);
    
	SELECT ap_m INTO apellido_m 
    FROM medicos 
    WHERE id_medico = (SELECT ses_medico_id FROM Temp_Session LIMIT 1);

    INSERT INTO Pacientes_Log (nombre_medico, ap_p, ap_m, operacion, fecha)
    VALUES (nombre_med, apellido_p, apellido_m, 'UPDATE', NOW());
    
    DELETE FROM temp_session WHERE id>0;
END $$
DELIMITER ;
-- TRIGGER UPDATE PACIENTE FIN

-- INICIO DEL TRIGGER DELETE DE PACIENTE
DELIMITER $$
CREATE TRIGGER tr_paciente_delete
AFTER DELETE ON pacientes
FOR EACH ROW
BEGIN
    -- Declarar una variable para almacenar el nombre del médico
    DECLARE medico_nombre VARCHAR(100);
	DECLARE medico_apellidoP VARCHAR(100);
    DECLARE medico_apellidoM VARCHAR(100);
    
    -- Realizar la consulta para obtener el nombre del médico
    SELECT m.nombre INTO medico_nombre 
    FROM medicos m 
    WHERE m.id_medico = OLD.id_medico;
    
	SELECT m.ap_p INTO medico_apellidoP 
    FROM medicos m 
    WHERE m.id_medico = OLD.id_medico;
    
	SELECT m.ap_m INTO medico_apellidoM 
    FROM medicos m 
    WHERE m.id_medico = OLD.id_medico;

    -- Insertar en la tabla de log con el nombre del médico obtenido
    INSERT INTO Pacientes_Log (nombre_medico, ap_p, ap_m, operacion, fecha)
    VALUES (medico_nombre, medico_apellidoP, medico_apellidoM, 'DELETE', NOW());
END$$
DELIMITER ;
-- FIN DEL TRIGGER DELETE DE PACIENTE
