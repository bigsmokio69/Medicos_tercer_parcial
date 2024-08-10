from flask import Flask, render_template, request, redirect, flash, url_for
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
    cursor.execute('SELECT contrasena, rol FROM medicos WHERE rfc = %s;', (rfc,))
    usuario = cursor.fetchone()
    
    if usuario:
        hashed_contra = usuario[0].encode('utf-8')
        
        if bcrypt.checkpw(contra.encode('utf-8'), hashed_contra):
            if usuario[1]=='Administrador':
                return redirect(url_for('mostrar_dash_admins')) #Si el medico tiene rol de admin se va a una pagina para admins
            else:
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
    return render_template('dashboard.html')

@app.route('/mostrar_dash_admins')
def mostrar_dash_admins():
    return render_template('dash_admins.html')

@app.route('/adm_meds')
def mostrar_adm_meds():
    return render_template('adm_medicos.html')

if __name__=='__main__':#es necesario hacer que main tenga dos guiones bajos
    app.run(port=3000, debug=True)