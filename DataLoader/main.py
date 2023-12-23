import mysql.connector

import pandas as pd
from unidecode import unidecode
from datetime import datetime


def read_file(filename):
    with open(filename, 'r', encoding='utf-8') as file:
        content = file.read()
    return content


if __name__ == '__main__':


    db_config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'ogan123',
        'database': 'finki_rasporedi'
    }


    connection = mysql.connector.connect(**db_config)

    if connection.is_connected():
        print(f"Connected to MySQL Server (version {connection.get_server_info()})")

    cursor = connection.cursor()



    file_path = r'C:\Users\User\Desktop\FinkiRasporedi\DataLoader\output_file.csv'


    df = pd.read_csv(file_path)


    print(df)

    p_l = df['professor'].unique().tolist()

    print(len(p_l))

    #unicode can be done better

    professors_list = [
        {
            'username': unidecode(name.lower().replace(' ', '.')),
            'name': name
        }
        for name in p_l
    ]


    insert_query = "INSERT INTO professors (Id, Name) VALUES (%s, %s)"

    for professor in professors_list:
        cursor.execute(insert_query, (professor['username'], professor['name']))

    r_l = df['rooms'].unique().tolist()
    print(r_l)

    rooms_list = [
        {
            'name': str(name)
        }
        for name in r_l
    ]

    insert_query = "INSERT INTO rooms (Name) VALUES (%s)"

    print(rooms_list)

    for room in rooms_list:
        cursor.execute(insert_query, (room['name'],))

    d = {}
    for index, row in df.iterrows():
        a = int(row["groups"][:1])
        if a >=3:
            a=3
        d[row["subject"]] = a

    print(d)



    subject_list = [
        {
            'id': unidecode(subject.lower().replace(' ', '.')),
            'name': subject,
            'level': d[subject]
        }
        for subject in d
    ]

    insert_query2 = "INSERT INTO subjects (Id, Name, Level) VALUES (%s, %s, %s)"

    for subject in subject_list:
        cursor.execute(insert_query2, (subject['id'], subject['name'],
                                       subject['level']))

    # 0 is summer, 1 is winter
    semesters = [("W23", "2023", 1), ("S24","2024", 0)]

    semesters = [
        {
            'code': c,
            'year': y,
            'sem_type': s
        }
        for c,y,s in semesters
    ]


    insert_query2 = "INSERT INTO semesters (Code, Year, SemesterType) VALUES (%s, %s, %s)"

    for s in semesters:
        cursor.execute(insert_query2, (s['code'], s['year'],
                                       s['sem_type']))

    print(subject_list)

    course_list = [
        {
            'id': "W23"+subject["id"],
            'sem_code': "W23",
            'sub_id': subject["id"]
        }
        for subject in subject_list
    ]

    insert_query2 = "INSERT INTO courses (Id, SemesterCode, SubjectId) VALUES (%s, %s, %s)"

    for c in course_list:
        cursor.execute(insert_query2, (c['id'], c['sem_code'],
                                       c['sub_id']))


    d={"Понеделник":0,"Вторник":1,"Среда":2,"Четврток":3,"Петок":4 }
    li = []
    for index, row in df.iterrows():
        prof_id = unidecode(row["professor"].lower().replace(' ', '.'))
        time_from = datetime.strptime(row["time_from"][:-3], "%H:%M")
        time_to = datetime.strptime(row["time_to"][:-3], "%H:%M")
        day = d[row["day"]]
        room_name = row["rooms"]
        course_id = "W23"+unidecode(row["subject"].lower().replace(' ', '.'))
        li.append((index,prof_id,time_from,time_to,day,room_name,course_id))

    insert_query2 = "INSERT INTO lecture ( Day, TimeFrom, TimeTo,ProfessorId,CourseId, RoomName, Type) VALUES ( %s, %s,%s,%s,%s,%s, %s)"

    for c in li:
        cursor.execute(insert_query2, (c[4], c[2], c[3], c[1], c[6], c[5], 0))

    query_select = "SELECT CourseId, ProfessorId FROM lecture GROUP BY CourseId, ProfessorId"
    cursor.execute(query_select)

    distinct_pairs = cursor.fetchall()

    for pair in distinct_pairs:
        query_insert = "INSERT INTO courseprofessors (CourseId, ProfessorId) VALUES (%s, %s)"
        cursor.execute(query_insert, pair)
        print("CourseId:", pair[0], "ProfessorId:", pair[1])


    
    connection.commit()
    cursor.close()
    connection.close()
