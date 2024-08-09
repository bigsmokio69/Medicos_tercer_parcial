from flask import Flask, render_template, request, flash
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
    return 1

@app.route('/mostrar_registro')
def mostrar_registro():
    return render_template('nuevo_medico.html')

@app.route('/registrar', methods=['POST'])
def registrar():
    nombre=request.form['nombre_med']
    ap=request.form['ap_p']
    am=request.form['ap_m']
    rfc=request.form['rfc']
    tel=request.form['tel']
    correo=request.form['correo']
    cedula=request.form['cedula']
    rol=request.form['rol']
    contra=request.form['contra']
    
    cursor=mysql.connection.cursor()
    cursor.execute('CALL sp_ins_medico ')
    return 1

if __name__=='__main__':#es necesario hacer que main tenga dos guiones bajos
    app.run(port=3000, debug=True)