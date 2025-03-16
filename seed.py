import sqlite3
from faker import Faker

fake = Faker()

conn = sqlite3.connect("tasks.db")
cursor = conn.cursor()

# Заполнение users
for _ in range(5):  # 5 пользователей
    cursor.execute("INSERT INTO users (fullname, email) VALUES (?, ?)", (fake.name(), fake.email()))

# Заполнение status
statuses = [('new',), ('in progress',), ('completed',)]
cursor.executemany("INSERT OR IGNORE INTO status (name) VALUES (?)", statuses)

# Заполнение tasks
cursor.execute("SELECT id FROM users")
user_ids = [row[0] for row in cursor.fetchall()]

cursor.execute("SELECT id FROM status")
status_ids = [row[0] for row in cursor.fetchall()]

for _ in range(10):  # Делаем 10 задач
    cursor.execute(
        "INSERT INTO tasks (title, description, status_id, user_id) VALUES (?, ?, ?, ?)",
        (fake.sentence(), fake.text(), fake.random.choice(status_ids), fake.random.choice(user_ids))
    )

conn.commit()
conn.close()
