CREATE TABLE Medicos_Log (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT,
    operacion VARCHAR(10),
    nombre VARCHAR(100),
    ap_p VARCHAR(100),
    ap_m VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER tr_medico_insert
AFTER INSERT ON Medicos
FOR EACH ROW
BEGIN
    INSERT INTO Medicos_Log (id_medico, operacion, nombre, ap_p, ap_m)
    VALUES (NEW.id_medico, 'INSERT', NEW.nombre, NEW.ap_p, NEW.ap_m);
END;

CREATE TRIGGER tr_medico_update
AFTER UPDATE ON Medicos
FOR EACH ROW
BEGIN
    INSERT INTO Medicos_Log (id_medico, operacion, nombre, ap_p, ap_m, rfc, tel, correo, cedula, rol, contrasena)
    VALUES (NEW.id_medico, 'UPDATE', NEW.nombre, NEW.ap_p, NEW.ap_m);
END;

CREATE TRIGGER tr_medico_delete
AFTER DELETE ON Medicos
FOR EACH ROW
BEGIN
    INSERT INTO Medicos_Log (id_medico, operacion, nombre, ap_p, ap_m)
    VALUES (OLD.id_medico, 'DELETE', OLD.nombre, OLD.ap_p, OLD.ap_m);
END;
