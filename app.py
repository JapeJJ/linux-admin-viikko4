import os

import pymysql
from flask import Flask, make_response, render_template

app = Flask(__name__)


def read_counter():
    conn = pymysql.connect(
        unix_socket="/run/mysqld/mysqld.sock",
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        database="laskuri",
    )
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT count FROM visits WHERE id = 1")
            return cur.fetchone()[0]
    finally:
        conn.close()


@app.route("/")
def index():
    count = read_counter()
    response = make_response(render_template("index.html", count=count))
    response.headers["Cache-Control"] = "no-store"
    return response

