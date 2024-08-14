from flask import Flask, render_template, request, redirect, flash, url_for, session, jsonify
from flask_mysqldb import MySQL
import bcrypt

app= Flask(__name__)

app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']='password'
app.config['MYSQL_DB']='db_medicos'

mysql = MySQL(app)

app.secret_key='mysecretkey'

@app.route('/')
def Index():
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    rfc=request.form['rfc']
    contra=request.form['contra']
    
    cursor=mysql.connection.cursor()
    cursor.execute('SELECT contrasena, rol, id_medico FROM medicos WHERE rfc = %s;', (rfc,))
    usuario = cursor.fetchone()
    
    if usuario:
        hashed_contra = usuario[0].encode('utf-8')
        
        if bcrypt.checkpw(contra.encode('utf-8'), hashed_contra):
            if usuario[1]=='Administrador':
                session['id_medico'] = usuario[2] #con el session ya tenemos el id para que el med solo vea sus pacientes y para el trigger
                return redirect(url_for('mostrar_administracion')) #Si el medico tiene rol de admin se va a una pagina para admins
            else:
                session['id_medico'] = usuario[2]
                return redirect(url_for('mostrar_dashboard')) #y si no pus a la normal
        else:
            flash('Contraseña incorrecta')
            return redirect(url_for('Index'))
    else:
        flash('RFC incorrecto')
        return redirect(url_for('Index'))

@app.route('/mostrar_registro')
def mostrar_registro():
    return render_template('nuevo_medico.html')

@app.route('/registrar', methods=['POST'])
def registrar():
    if request.method=='POST':
        medicoId=session.get('id_medico')
        
        nombre=request.form['nombre_med']
        ap=request.form['ap_p']
        am=request.form['ap_m']
        rfc=request.form['rfc']
        tel=request.form['tel']
        correo=request.form['correo']
        cedula=request.form['cedula']
        rol=request.form['rol']
        contra=request.form['password']
        #conf=request.form['confirmar']
                
        hashed_contra = bcrypt.hashpw(contra.encode('utf-8'), bcrypt.gensalt())
            
        cursor=mysql.connection.cursor()
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoId,))
        mysql.connection.commit()
            
        cursor.execute('CALL sp_ins_medico (%s, %s, %s, %s, %s, %s, %s, %s, %s)', (nombre, ap, am, rfc, tel, correo, cedula, rol, hashed_contra))
        mysql.connection.commit()
        print('doc agregado con exito')
    return redirect(url_for('mostrar_administracion'))

@app.route('/mostrar_dashboard')
def mostrar_dashboard():
    medicoID=session.get('id_medico')
    print(f'Medico en dash normal {medicoID}')
    return render_template('dashboard.html')

@app.route('/mostrar_dash_admins')
def mostrar_dash_admins():
    return render_template('dash_admins.html')

@app.route('/mostrar_adm_meds')
def mostrar_adm_meds():
    cursor=mysql.connection.cursor()
    cursor.execute('SELECT * FROM vista_medicos')
    consulta=cursor.fetchall()
    return render_template('adm_medicos.html', datos=consulta)

@app.route('/borrarMed_logico', methods=['POST'])
def borrarMed():
    if request.method=='POST':
        medicoId=session.get('id_medico')
        datos=request.get_json()
        print(datos)
        id=datos.get('ID_borrar')
        #Enviar a db
        cursor=mysql.connection.cursor()
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoId,))
        mysql.connection.commit()
        
        cursor.execute('CALL sp_logicdel_med(%s)', (id,))
        mysql.connection.commit()
    return redirect(url_for('mostrar_administracion'))

#@app.route('/ver_edit_medico/<id>')
#def ver_edit_medico(id):
#    cur=mysql.connection.cursor()
#    cur.execute('SELECT * FROM Medicos WHERE id_medico=%s', [id])
#    consulta=cur.fetchone()
#    return render_template('edit_medico.html', med=consulta)

@app.route('/edit_medico', methods=['POST'])
def edit_medico():
    if request.method=='POST':
        
        
        medicoId=session.get('id_medico')
        
        nombre=request.form['edit-medic-name']
        ap=request.form['edit-paterno']
        am=request.form['edit-materno']
        rfc=request.form['edit-rfc']
        tel=request.form['edit-phone']
        correo=request.form['edit-email']
        cedula=request.form['edit-cedula']
        rol=request.form['edit-role']
        contra=request.form['edit-password']
        idMedEditar=request.form['medicoEdit']
        hashed_contra = bcrypt.hashpw(contra.encode('utf-8'), bcrypt.gensalt())
        
        
        cursor=mysql.connection.cursor()
        
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoId,))
        mysql.connection.commit()
        
        cursor.execute('CALL sp_update_medico(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', (idMedEditar, nombre, ap, am, rfc, tel, correo, cedula, rol, hashed_contra))
        mysql.connection.commit()#con esto ya deberia hacer insercion en la db

    return redirect(url_for('mostrar_administracion'))

@app.route('/mostrar_pacientes')
def mostrar_pacientes():
    medicoId=session.get('id_medico')
    cursor=mysql.connection.cursor()
    cursor.execute('SELECT * FROM vista_pacientes WHERE id_medico=%s and estatus=1', (medicoId,))
    consulta=cursor.fetchall()
    return render_template('pacientes.html', pacientes=consulta)

@app.route('/agregar_paciente',  methods=['POST'])
def agregar_paciente():
    if request.method=='POST':
        medicoID=session.get('id_medico')
                
        nombre=request.form['patient-name']
        ap=request.form['apellidoP']
        am=request.form['apellidoM']
        cumple=request.form['birth-date']
        cronicas=request.form['chronic-diseases']
        alergias=request.form['allergies']
        antecedentes=request.form['family-history']
        
        cursor=mysql.connection.cursor()
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoID,))
        mysql.connection.commit()
        cursor.execute('CALL sp_ins_paciente(%s, %s, %s, %s, %s, %s, %s, %s)', (nombre, ap, am, cumple, cronicas, alergias, antecedentes, medicoID))
        mysql.connection.commit()
        
    return redirect(url_for('mostrar_pacientes'))

@app.route('/editar_paciente', methods=['POST'])
def editar_paciente():
    if request.method=='POST':
        medicoID=session.get('id_medico')
        
        paciente_id=request.form['edit-idPac']
        nombre=request.form['edit-patient-name']
        ap=request.form['edit-apellidoP']
        am=request.form['edit-apellidoM']
        cumple=request.form['edit-birth-date']
        cronicas=request.form['edit-chronic-diseases']
        alergias=request.form['edit-allergies']
        antecedentes=request.form['edit-family-history']
        
        print(f'Id del paciente en editar> {paciente_id}')
        cursor=mysql.connection.cursor()
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoID,))
        mysql.connection.commit()
        
        cursor.execute('''UPDATE pacientes SET nombre=%s, apellido_paterno=%s, apellido_materno=%s, fecha_nacimiento=%s, 
                       enfermedades=%s, alergias=%s, antecedentes_fam=%s WHERE id_paciente=%s;''', (nombre, ap,am, cumple, cronicas,
                        alergias, antecedentes, paciente_id))
        mysql.connection.commit()
    return redirect(url_for('mostrar_pacientes'))

@app.route('/borrar_paciente_logico', methods=['POST'])
def borrar_paciente_logico():
    if request.method == 'POST':
        medicoID=session.get('id_medico')
        if request.is_json:
            datos = request.get_json()
            print(datos)
            id = datos.get('ID_borrar')

            if id:
                try:
                    cursor = mysql.connection.cursor()
                    cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoID,))
                    mysql.connection.commit()
                    
                    cursor.execute('CALL sp_logicdel_pac(%s);', (id,))
                    mysql.connection.commit()
                    return jsonify({'status': 'success', 'message': 'Paciente eliminado logicamente'}), 200
                except Exception as e:
                    print(f"Error al ejecutar el procedimiento almacenado: {e}")
                    return jsonify({'status': 'error', 'message': 'Error en la eliminación lógica del paciente'}), 500
            else:
                return jsonify({'status': 'error', 'message': 'ID de paciente no proporcionado'}), 400
        else:
            return jsonify({'status': 'error', 'message': 'Unsupported Media Type'}), 415

    return redirect(url_for('mostrar_pacientes'))


#De prueba

@app.route('/mostrar_citas')
def mostrar_citas():
    
    return render_template('citas.html')

#rutas de administración
@app.route('/mostrar_administracion')
def mostrar_administracion():
    medicoId=session.get('id_medico')
    cursor=mysql.connection.cursor()
    cursor.execute('SELECT * FROM vista_pacientes WHERE id_medico=%s and estatus=1', (medicoId,))
    consulta=cursor.fetchall()
    
    cursor.execute('SELECT * FROM vista_medicos WHERE estatus=1')
    consulta2=cursor.fetchall()
    
    cursor.execute('SELECT * FROM medicos_log')
    consulta3=cursor.fetchall()
    
    cursor.execute('SELECT * FROM pacientes_log')
    consulta4=cursor.fetchall()
    return render_template('administracion.html', pacientes=consulta, medicos=consulta2, medlogs=consulta3, paclogs=consulta4)

@app.route('/agregar_paciente2',  methods=['POST'])
def agregar_paciente2():
    if request.method=='POST':
        medicoID=session.get('id_medico')
                
        nombre=request.form['patient-name']
        ap=request.form['apellidoP']
        am=request.form['apellidoM']
        cumple=request.form['birth-date']
        cronicas=request.form['chronic-diseases']
        alergias=request.form['allergies']
        antecedentes=request.form['family-history']
        
        cursor=mysql.connection.cursor()
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoID,))
        mysql.connection.commit()
        cursor.execute('CALL sp_ins_paciente(%s, %s, %s, %s, %s, %s, %s, %s)', (nombre, ap, am, cumple, cronicas, alergias, antecedentes, medicoID))
        mysql.connection.commit()
        
    return redirect(url_for('mostrar_administracion'))

@app.route('/editar_paciente2', methods=['POST'])
def editar_paciente2():
    if request.method=='POST':
        medicoID=session.get('id_medico')
        
        paciente_id=request.form['edit-idPac']
        nombre=request.form['edit-patient-name']
        ap=request.form['edit-apellidoP']
        am=request.form['edit-apellidoM']
        cumple=request.form['edit-birth-date']
        cronicas=request.form['edit-chronic-diseases']
        alergias=request.form['edit-allergies']
        antecedentes=request.form['edit-family-history']
        
        print(f'Id del paciente en editar> {paciente_id}')
        cursor=mysql.connection.cursor()
        cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoID,))
        mysql.connection.commit()
        
        cursor.execute('''UPDATE pacientes SET nombre=%s, apellido_paterno=%s, apellido_materno=%s, fecha_nacimiento=%s, 
                       enfermedades=%s, alergias=%s, antecedentes_fam=%s WHERE id_paciente=%s;''', (nombre, ap,am, cumple, cronicas,
                        alergias, antecedentes, paciente_id))
        mysql.connection.commit()
    return redirect(url_for('mostrar_administracion'))

@app.route('/borrar_paciente_logico2', methods=['POST'])
def borrar_paciente_logico2():
    if request.method == 'POST':
        medicoID=session.get('id_medico')
        if request.is_json:
            datos = request.get_json()
            print(datos)
            id = datos.get('ID_borrar')

            if id:
                try:
                    cursor = mysql.connection.cursor()
                    cursor.execute("INSERT INTO Temp_Session (ses_medico_id) VALUES (%s)", (medicoID,))
                    mysql.connection.commit()
                    
                    cursor.execute('CALL sp_logicdel_pac(%s);', (id,))
                    mysql.connection.commit()
                    return jsonify({'status': 'success', 'message': 'Paciente eliminado logicamente'}), 200
                except Exception as e:
                    print(f"Error al ejecutar el procedimiento almacenado: {e}")
                    return jsonify({'status': 'error', 'message': 'Error en la eliminación lógica del paciente'}), 500
            else:
                return jsonify({'status': 'error', 'message': 'ID de paciente no proporcionado'}), 400
        else:
            return jsonify({'status': 'error', 'message': 'Unsupported Media Type'}), 415

    return redirect(url_for('mostrar_pacientes'))

if __name__=='__main__':#es necesario hacer que main tenga dos guiones bajos
    app.run(port=3000, debug=True)