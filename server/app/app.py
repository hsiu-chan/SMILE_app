from flask import Flask 
from api.SmileDetect import SmileDetect_blueprint
from app.website import website_pages_blueprint,home_blueprint #所有網頁




def create_app():#Application Factories
    app = Flask(__name__, static_url_path='/static/', 
            static_folder='static/')
    
        
    app.register_blueprint(website_pages_blueprint)
    app.register_blueprint(home_blueprint)

    ###API###
    app.register_blueprint(SmileDetect_blueprint) 
    
    
    return app
