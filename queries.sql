-- 1. Получить все задачи определённого пользователя 
SELECT * FROM tasks WHERE user_id = 3;

-- 2. Выбрать задачи со статусом "new"
SELECT * FROM tasks WHERE status_id = (SELECT id FROM status WHERE name = 'new');

-- 3. Обновить статус конкретной задачи 
UPDATE tasks SET status_id = (SELECT id FROM status WHERE name = 'in progress') WHERE id = 5;

-- 4. Найти пользователей без задач
SELECT * FROM users WHERE id NOT IN (SELECT DISTINCT user_id FROM tasks);

-- 5. Добавить новую задачу пользователю 
INSERT INTO tasks (title, description, status_id, user_id)
VALUES ('Новая задача', 'Описание новой задачи', (SELECT id FROM status WHERE name = 'new'), 2);

-- 6. Получить все незавершённые задачи
SELECT * FROM tasks WHERE status_id != (SELECT id FROM status WHERE name = 'completed');

-- 7. Удалить задачу по id 
DELETE FROM tasks WHERE id = 7;

-- 8. Найти пользователей по email 
SELECT * FROM users WHERE email LIKE '%@gmail.com';

-- 9. Обновить имя пользователя 
UPDATE users SET fullname = 'Новое Имя' WHERE id = 4;

-- 10. Получить количество задач для каждого статуса
SELECT status.name, COUNT(tasks.id) AS count 
FROM tasks 
JOIN status ON tasks.status_id = status.id 
GROUP BY status.name;

-- 11. Найти задачи, привязанные к пользователям с email на example.com
SELECT tasks.* FROM tasks
JOIN users ON tasks.user_id = users.id
WHERE users.email LIKE '%@example.com';

-- 12. Найти задачи без описания
SELECT * FROM tasks WHERE description IS NULL OR description = '';

-- 13. Выбрать пользователей и их задачи со статусом "in progress"
SELECT users.fullname, tasks.title FROM users
JOIN tasks ON users.id = tasks.user_id
JOIN status ON tasks.status_id = status.id
WHERE status.name = 'in progress';

-- 14. Получить пользователей и количество их задач
SELECT users.fullname, COUNT(tasks.id) AS task_count FROM users
LEFT JOIN tasks ON users.id = tasks.user_id
GROUP BY users.fullname;
