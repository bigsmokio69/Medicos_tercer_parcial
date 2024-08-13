from flask import Flask, render_template, request, redirect, flash, url_for, session
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
                return redirect(url_for('mostrar_dash_admins')) #Si el medico tiene rol de admin se va a una pagina para admins
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
        nombre=request.form['nombre_med']
        ap=request.form['ap_p']
        am=request.form['ap_m']
        rfc=request.form['rfc']
        tel=request.form['tel']
        correo=request.form['correo']
        cedula=request.form['cedula']
        rol=request.form['rol']
        contra=request.form['contra']
        conf=request.form['confirmar']
                
        if contra==conf:
            hashed_contra = bcrypt.hashpw(contra.encode('utf-8'), bcrypt.gensalt())
            cursor=mysql.connection.cursor()
            cursor.execute('CALL sp_ins_medico (%s, %s, %s, %s, %s, %s, %s, %s, %s)', (nombre, ap, am, rfc, tel, correo, cedula, rol, hashed_contra))
            mysql.connection.commit()
            flash('Médico agregado correctamente')
            print('doc agregado con exito')
        else:
            flash('Las contraseñas no coinciden')
    return redirect(url_for('mostrar_registro'))

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

@app.route('/borrarMed', methods=['POST'])
def borrarMed():
    if request.method=='POST':
        datos=request.get_json()
        print(datos)
        id=datos.get('ID_borrar')
        #Enviar a db
        cursor=mysql.connection.cursor()
        cursor.execute('DELETE FROM Medicos WHERE id_medico=%s', ([id]))
        mysql.connection.commit()
    return redirect(url_for('mostrar_adm_meds'))

@app.route('/ver_edit_medico/<id>')
def ver_edit_medico(id):
    cur=mysql.connection.cursor()
    cur.execute('SELECT * FROM Medicos WHERE id_medico=%s', [id])
    consulta=cur.fetchone()
    return render_template('edit_medico.html', med=consulta)

@app.route('/edit_medico/<id>', methods=['POST'])
def edit_medico(id):
    if request.method=='POST':
        nombre=request.form['nombre_med']
        ap=request.form['ap_p']
        am=request.form['ap_m']
        rfc=request.form['rfc']
        tel=request.form['tel']
        correo=request.form['correo']
        cedula=request.form['cedula']
        rol=request.form['rol']
        contra=request.form['contra']
        hashed_contra = bcrypt.hashpw(contra.encode('utf-8'), bcrypt.gensalt())
        
        cursor=mysql.connection.cursor()
        cursor.execute('CALL sp_update_medico(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', ([id], nombre, ap, am, rfc, tel, correo, cedula, rol, hashed_contra))
        mysql.connection.commit()#con esto ya deberia hacer insercion en la db
    return redirect(url_for('mostrar_adm_meds'))

@app.route('/mostrar_pacientes')
def mostrar_pacientes():
    medicoId=session.get('id_medico')
    cursor=mysql.connection.cursor()
    cursor.execute('SELECT * FROM Pacientes WHERE id_medico=%s', (medicoId,))
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
        cursor.execute('CALL sp_ins_paciente(%s, %s, %s, %s, %s, %s, %s, %s)', (nombre, ap, am, cumple, cronicas, alergias, antecedentes, medicoID))
        mysql.connection.commit()
        
    return redirect(url_for('mostrar_pacientes'))

@app.route('/editar_paciente')
def editar_paciente():
    
    return redirect(url_for('mostrar_pacientes'))

@app.route('/mostrar_citas')
def mostrar_citas():
    
    return render_template('citas.html')

if __name__=='__main__':#es necesario hacer que main tenga dos guiones bajos
    app.run(port=3000, debug=True)