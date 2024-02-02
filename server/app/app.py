from flask import Flask 
from api.SmileDetect import SmileDetect_blueprint
<<<<<<< HEAD:server/app/app.py
from app.website import website_pages_blueprint,home_blueprint #所有網頁
=======
from api.SmileDetect_mt import SmileDetect_blueprint_mt
from website import website_pages_blueprint,home_blueprint #所有網頁
>>>>>>> d5277d3623ffb2ea6b39bfb1588836d2462041ce:server/app.py

from config import UPLOAD_FOLDER



def create_app():#Application Factories
    app = Flask(__name__, static_url_path='/static/', 
            static_folder='static/')
    
    app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


        
    app.register_blueprint(website_pages_blueprint)
    app.register_blueprint(home_blueprint)

    ###API###
<<<<<<< HEAD:server/app/app.py
    app.register_blueprint(SmileDetect_blueprint) 
    
=======
    app.register_blueprint(SmileDetect_blueprint)
    app.register_blueprint(SmileDetect_blueprint_mt)
>>>>>>> d5277d3623ffb2ea6b39bfb1588836d2462041ce:server/app.py
    
    return app
