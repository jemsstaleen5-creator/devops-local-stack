from flask import Flask
import os
import psycopg2
import time

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_NAME = os.getenv("DB_NAME", "testdb")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASS = os.getenv("DB_PASS", "password")

def connect_with_retry():
    retries = 5
    while retries > 0:
        try:
            conn = psycopg2.connect(
                host=DB_HOST,
                database=DB_NAME,
                user=DB_USER,
                password=DB_PASS
            )
            return conn
        except Exception as e:
            print(f"DB not ready, retrying... {e}")
            retries -= 1
            time.sleep(5)
    raise Exception("Database not reachable")

@app.route("/")
def home():
    return "DevOps Local Stack Running!"

@app.route("/health")
def health():
    return {"status": "healthy"}

@app.route("/db")
def db_test():
    try:
        conn = connect_with_retry()
        conn.close()
        return {"database": "connected"}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
