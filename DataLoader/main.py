import mysql.connector

from data import professors, professor_enums, subjects


def read_file(filename):
    with open(filename, 'r', encoding='utf-8') as file:
        content = file.read()
    return content


if __name__ == '__main__':

    # Replace these values with your actual database credentials
    db_config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'ogan123',
        'database': 'finki_rasporedi'
    }

    # Create a connection to the MySQL database
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

    for subject in subject_list:
        cursor.execute(insert_query2, (subject['id'], subject['name'],
                                       subject['semester'], subject['weekly_auditorium_classes'],
                                       subject['weekly_lab_classes'], subject['weekly_lectures_classes']))

    connection.commit()

    # Close the cursor and connection
    cursor.close()
    connection.close()
