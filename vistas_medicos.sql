-- Vista sencilla de pacientes
CREATE VIEW vista_pacientes AS
SELECT * FROM Pacientes;

-- Vista sencilla de medicos
CREATE VIEW vista_medicos AS
SELECT * FROM Medicos;

-- Vista detalles pacientes
CREATE VIEW vw_PacienteDetalles AS
SELECT 
    CONCAT(p.nombre, ' ', p.apellido_paterno, ' ', p.apellido_materno) AS `Paciente`,
    p.fecha_nacimiento AS `Fecha de Nacimiento`,
    p.direccion AS `Direccion`,
    p.telefono AS `Telefono`,
    p.correo AS `Correo`,
    p.enfermedades AS `Enfermedades`,
    p.alergias AS `Alergias`,
    p.antecedentes_fam AS `Antecedentes Familiares`,
    h.fecha_registro AS `Fecha de Registro`,
    h.edad_paciente AS `Edad`,
    h.peso AS `Peso`,
    h.altura AS `Altura`,
    h.temperatura AS `Temperatura`,
    h.lpm AS `LPM`
FROM Pacientes p
LEFT JOIN Historial_medico h ON p.id_paciente = h.id_paciente;

SELECT * FROM vw_PacienteDetalles;


-- ------------------>
CREATE VIEW vw_CitasDetalles AS
SELECT 
    c.id_citas AS `ID Cita`,
    c.fecha_cita AS `Fecha`,
    CONCAT(p.nombre, ' ', p.apellido_paterno, ' ', p.apellido_materno) AS `Paciente`,
    CONCAT(m.nombre, ' ', m.ap_p, ' ', m.ap_m) AS `Medico`
FROM Citas c
LEFT JOIN Pacientes p ON c.id_paciente = p.id_paciente
LEFT JOIN Medicos m ON c.id_medico = m.id_medico;

SELECT * FROM vw_CitasDetalles;


-- ------------------->
CREATE VIEW vw_Recetas AS
SELECT 
    r.id_receta AS `ID Receta`,
    r.medicamentos AS `Medicamentos`,
    CONCAT(p.nombre, ' ', p.apellido_paterno, ' ', p.apellido_materno) AS `Paciente`,
    CONCAT(m.nombre, ' ', m.ap_p, ' ', m.ap_m) AS `Medico`
FROM Recetas r
LEFT JOIN Pacientes p ON r.id_paciente = p.id_paciente
LEFT JOIN Medicos m ON r.id_medico = m.id_medico;

-- Vista de citas
CREATE VIEW vista_citas AS
SELECT * FROM citas;
