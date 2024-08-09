from flask import Flask, render_template, request, flash
from flask_mysqldb import MySQL
import bcrypt

app= Flask(__name__)

app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']='password'
app.config['MYSQL_DB']='medicos'

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

@app.route('/registro')
def Registro():
    return render_template('nuevo_medico.html')

if __name__=='__main__':#es necesario hacer que main tenga dos guiones bajos
    app.run(port=3000, debug=True)