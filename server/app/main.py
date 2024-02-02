<<<<<<< HEAD:server/app/main.py
from app.app import create_app


=======
from app import create_app
from config import FLASK_PORT
>>>>>>> d5277d3623ffb2ea6b39bfb1588836d2462041ce:server/main.py
app = create_app()

if __name__ == '__main__':
    #app.run(host='0.0.0.0',port=8888)
    from werkzeug.serving import run_simple
    run_simple('0.0.0.0', FLASK_PORT, app)

    #app.run(host=,port=8888)
