from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
@app.route('/index')
def index():
	return render_template('index.html')

@app.route('/menu/page1')
def menu_page1():
	return render_template('menu/page1.html')

@app.route('/menu/page2')
def menu_page2():
	return render_template('menu/page2.html')

@app.route('/menu/page3')
def menu_page3():
	return render_template('menu/page3.html')

@app.route('/menu/page4')
def menu_page4():
	return render_template('menu/page4.html')

@app.route('/menu/page5')
def menu_page5():
	return render_template('menu/page5.html')

@app.route('/menu/page6')
def menu_page6():
	return render_template('menu/page6.html')

@app.route('/menu/page7')
def menu_page7():
	return render_template('menu/page7.html')

@app.route('/menu/page8')
def menu_page8():
	return render_template('menu/page8.html')

@app.route('/menu/page9')
def menu_page9():
	return render_template('menu/page9.html')

if '__main__' == __name__:
	app.run(debug=True, host='0.0.0.0')
