from flask import Flask, render_template
from scrape_mars import Scrape
from flask_pymongo import PyMongo

# create instance of Flask app
app = Flask(__name__)
#app.config["MONGO_URI"] = "mongodb://localhost:27017/mars_app"
#mongo = PyMongo(app)
#mongo = PyMongo(app, uri="mongodb://localhost:27017/mars_app")
conn = 'mongodb://localhost:27017'
client = pymongo.MongoClient(conn)
db = client.marsDB
marsData = db.marsData.find()

@app.route("/")
def root():
    marz_barz = mongo.db.marsData.find_one()
    # render mars_barz as html somehow???
    # Return the template with the teams list passed in
    return render_template('index.html', hemi_dicts=marz_barz)

@app.route("/scrape")
def scrape_mars_func():
    marz_barz = mongo.db.marsData
    scraped_dict = scrape_mars.Scrape()
    marz_barz.update(update{}, scraped_dict, upsert=True)
    return redirect("/", code=302)
#     listings.update({}, listings_data, upsert=True)

if __name__ == '__main__':
    app.run(debug=True)