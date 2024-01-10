from app import create_app

#from lib.SMILE import SMILE

app = create_app()

if __name__ == '__main__':
    #app.run(host='0.0.0.0',port=8888)
    from werkzeug.serving import run_simple
    run_simple('0.0.0.0', 8888, app)

    #app.run(host=,port=8888)
