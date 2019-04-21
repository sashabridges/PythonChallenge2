from flask import Flask, render_template, redirect
from scrape_mars import Scrape
from flask_pymongo import PyMongo

app = Flask(__name__)
mongo = PyMongo(app, uri="mongodb://localhost:27017/marsDB")

@app.route("/")
def root():
    hemi_dicts = mongo.db.marsData.find_one()
    return render_template('index.html', hemi_dicts=hemi_dicts)

@app.route("/scrape")
def scrape_mars_func():
    hemi_dicts = Scrape()
    mongo.db.marsData.update({}, hemi_dicts, upsert=True)
    return redirect("/", code=302)


if __name__ == '__main__':
    app.run(debug=True)