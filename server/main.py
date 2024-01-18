from app import create_app
from config import FLASK_PORT
app = create_app()

if __name__ == '__main__':
    #app.run(host='0.0.0.0',port=8888)
    from werkzeug.serving import run_simple
    run_simple('0.0.0.0', FLASK_PORT, app)

    #app.run(host=,port=8888)
