import sqlite3
from flask import Flask, render_template, request, redirect, url_for, jsonify

app = Flask(__name__)
DATABASE = 'todo.db'

def get_db():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    with get_db() as conn:
        conn.execute('''
            CREATE TABLE IF NOT EXISTS tasks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                description TEXT,
                completed INTEGER DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()

@app.route('/')
def index():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM tasks ORDER BY created_at DESC')
    tasks = cursor.fetchall()
    conn.close()
    return render_template('index.html', tasks=tasks)

@app.route('/add', methods=['POST'])
def add_task():
    title = request.form.get('title')
    description = request.form.get('description', '')
    if title:
        conn = get_db()
        conn.execute('INSERT INTO tasks (title, description) VALUES (?, ?)', (title, description))
        conn.commit()
        conn.close()
    return redirect(url_for('index'))

@app.route('/toggle/<int:task_id>', methods=['POST'])
def toggle_task(task_id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT completed FROM tasks WHERE id = ?', (task_id,))
    task = cursor.fetchone()
    if task:
        new_status = 1 if task['completed'] == 0 else 0
        conn.execute('UPDATE tasks SET completed = ? WHERE id = ?', (new_status, task_id))
        conn.commit()
    conn.close()
    return redirect(url_for('index'))

@app.route('/edit/<int:task_id>', methods=['POST'])
def edit_task(task_id):
    title = request.form.get('title')
    description = request.form.get('description', '')
    if title:
        conn = get_db()
        conn.execute('UPDATE tasks SET title = ?, description = ? WHERE id = ?', (title, description, task_id))
        conn.commit()
        conn.close()
    return redirect(url_for('index'))

@app.route('/delete/<int:task_id>', methods=['POST'])
def delete_task(task_id):
    conn = get_db()
    conn.execute('DELETE FROM tasks WHERE id = ?', (task_id,))
    conn.commit()
    conn.close()
    return redirect(url_for('index'))

if __name__ == '__main__':
    init_db()
    app.run(debug=True, port=5000)
