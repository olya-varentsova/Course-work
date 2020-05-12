import mysql.connector
from flask import Flask, request, render_template

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    port=3306,
    database="clinic"
)

app = Flask(__name__)
queries = [
    '''
        SELECT
          doctor.Name,
          timetable.Cabinet_number,
          COUNT(*) as Count_of_recoders,
          COUNT(CASE
            WHEN timetable.Tunout_mark="1" THEN 1
            ELSE NULL
        END) as Count_of_visitors
        FROM doctor
        INNER JOIN clinic.timetable
          ON doctor.id_Doc = timetable.id_Doctor
        WHERE YEAR(timetable.Date_of_visit) = {} AND MONTH(timetable.Date_of_visit) = {} AND DAY(timetable.Date_of_visit) = {}
        HAVING Count_of_recoders>0;
    ''',
    '''
        SELECT
          patient.Name,
          timetable.date_of_visit,
          visit.diagnosis
        FROM doctor
        INNER JOIN timetable
          ON doctor.id_Doc = timetable.id_Doctor
        INNER JOIN patient
          ON patient.id_P = timetable.id_Patient
        INNER JOIN visit
          ON visit.id_Timetablee = timetable.id_T
        WHERE doctor.Name="Rotar" AND MONTH(date_of_visit)={} AND YEAR(date_of_visit) = {};
    ''',
    '''
        SELECT * FROM doctor
        ORDER BY Date_of_start_work ASC
        limit 1;
    ''',
    '''
        SELECT
            COUNT(*)/DAY(LAST_DAY(Date_of_visit)) as CNT,
            MONTH(Date_of_visit),
            YEAR(Date_of_visit)
        FROM timetable
        WHERE timetable.Tunout_mark = 1
        GROUP BY MONTH(Date_of_visit), YEAR(Date_of_visit) ASC;
    ''',
    '''
        SELECT
          visit.Doctor_name
        FROM visit LEFT JOIN doctor
        ON doctor.Name = visit.Doctor_name
        WHERE doctor.Name is NULL; 
    ''',
    '''
        SELECT
          doctor.Name
        FROM doctor
        WHERE NOT EXISTS (SELECT visit.Doctor_name
        FROM visit
        WHERE visit.Date_vis = "2000-09-04" AND visit.Doctor_name = doctor.Name );
    ''',
    '''
    SELECT * FROM clinic.reports
    WHERE  `Year` = {} AND `Month`={};
    ''',
    '''SELECT * FROM clinic.reports'''
    ]
titles = [
    '''Отчет на дату 2001-09-04 по форме: Фамилия врача, номер кабинета, количество записавшихся пациентов, количество пациентов, явившихся на прием.
    ''',
    '''  Создайте отчет о пациентах врача по фамилии Rotar за сентябрь 2001 года по форме: Фамилия пациента, дата приема, диагноз.
    ''',
    '''Все сведения о враче, который работает в поликлинике дольше всех.''',
    '''Информация о том, сколько в среднем пациентов в день посещает поликлинику в каждом месяце.''',
    '''Фамилии врачей, которые не сделали ни одной записи в карточках пациентов.''',
    ''' Фамилии врачей, которые не вели приема в дату 2000-09-04.''',
    '''   Выполнить отчет сколько пациентов принял каждый врач, работающий в поликлинике за месяц.''',
    '''Существующие отчеты.''']

cursor = mydb.cursor()


@app.route('/')
def index_page():
    return render_template('index.html')


@app.route('/query/<int:id>', methods=['POST', 'GET'])
def queryy(id):
    if id == 1 or id == 0:
        if request.method == 'POST':
            if id == 1:
                year, month = request.form['month'].split('-')
                cursor.execute(str.format(queries[id], month,year))
            if id == 0:
                year, month, day = request.form['date'].split('-')
                cursor.execute(str.format(queries[id], year, month, day))
            res = []
            for x in cursor:
                res.append(x)
            if len(res) == 0 or (id == 0 and res[0][2] == 0):
                res = None
            return render_template('query.html',
                                   title=titles[id],
                                   result=res,
                                   metadata=cursor.column_names)
        else:
            return render_template('static_otchet.html', ids=id)
    else:
        cursor.execute(queries[id])
        res = []
        for x in cursor:
            res.append(x)
        if len(res) == 0:
            res = None
        return render_template('query.html',
                               title=titles[id],
                               result=res,
                               metadata=cursor.column_names)


@app.route('/static_otchet',methods=['GET','POST'])
def query6_page():
    if request.method == 'POST':
        year, month = request.form['month'].split('-')
        cursor.callproc('Update_report', (int(year), int(month)))
        cursor.execute(str.format(queries[6], year, month))
        res = []
        for x in cursor:
            res.append(x)
        if len(res) == 0:
            res = None
        return render_template('query.html',
                               title=titles[6],
                               result=res,
                               metadata=cursor.column_names)
    else:
        return render_template('static_otchet.html',
                               ids=6)


if __name__ == '__main__':
    app.run()
