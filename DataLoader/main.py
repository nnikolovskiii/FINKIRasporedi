import mysql.connector

from data import *


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

    professors_list = [
        {
            'username': username,
            'email': email,
            'name': name,
            'title': title
        }
        for username, email, name, title in professors
    ]

    insert_query = "INSERT INTO professors (Id, Email, Name, ProfessorTitle) VALUES (%s, %s, %s, %s)"

    # for professor in professors_list:
    #     cursor.execute(insert_query, (professor['username'], professor['email'],
    #                                   professor['name'],professor_enums.index(professor['title'])))

    subject_list = [
        {
            'id': subject[0],
            'name': subject[1],
            'semester': int(subject[2]),
            'weekly_auditorium_classes': int(subject[3]),
            'weekly_lab_classes': int(subject[4]),
            'weekly_lectures_classes': int(subject[5])
        }
        for subject in subjects
    ]

    insert_query2 = "INSERT INTO subjects (Id, Name, Semester, WeeklyAuditoriumClasses, WeeklyLabClasses, WeeklyLecturesClasses) VALUES (%s, %s, %s, %s,%s,%s)"

    # for subject in subject_list:
    #     cursor.execute(insert_query2, (subject['id'], subject['name'],
    #                                    subject['semester'], subject['weekly_auditorium_classes'],
    #                                    subject['weekly_lab_classes'], subject['weekly_lectures_classes']))

    study_program_list = [
        {
            'code': program[0],
            'name': program[1]
        }
        for program in study_programs
    ]

    insert_query3 = "INSERT INTO studyprograms (Code, Name) VALUES (%s, %s)"

    # for program in study_program_list:
    #     cursor.execute(insert_query3, (program['code'], program['name']))


    list = [
        {
            'id': sps[0],
            'subjectId': sps[1],
            'studyProgramCode': sps[2],
            'mandatory': bool(sps[3]),
            'semester': int(sps[4]),
            'order': float(sps[5])
        }
        for sps in study_program_subject
    ]

    insert_query4 = ("INSERT INTO studyprogramsubjects (`Id`, `SubjectId`, `StudyProgramCode`, `Mandatory`, `Semester`, `Order`) VALUES (%s, %s, %s, %s, %s, %s)")

    # for sps in list:
    #     cursor.execute(insert_query4, (sps['id'], sps['subjectId'],
    #                                    sps['studyProgramCode'], sps['mandatory'],
    #                                    sps['semester'], sps['order']))



    list1 = [
        {
            'id': sp[0],
            's': sp[1],
            'prof': sp[2],
            'order': float(sp[3])
        }
        for sp in subject_prof
    ]

    insert_query5 = ("INSERT INTO studyprogramsubjectprofessors (`Id`, `StudyProgramSubjectId`, `ProfessorId`, `Order`) VALUES (%s, %s, %s, %s)")

    for sps in list1:
        cursor.execute(insert_query5, (sps['id'], sps['s'],
                                       sps['prof'], sps['order']))




    connection.commit()
    cursor.close()
    connection.close()
