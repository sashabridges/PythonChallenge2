<<<<<<< HEAD
from flask import Flask, jsonify
from matplotlib import style
style.use('fivethirtyeight')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import datetime as dt
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect
engine = create_engine("sqlite:///Resources/hawaii.sqlite")
# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)
Measurement = Base.classes.measurement
Station = Base.classes.station


app = Flask(__name__)

# for home route
routes = ['Home': '/', 'Precipitation': '/api/v1.0/precipitation', 'Stations': '/api/v1.0/stations', 'Temperatures': '/api/v1.0/tobs', 'Date Selector': '/api/v1.0/<start> and /api/v1.0/<start>/<end>']

# for precipitation route
prcp_and_date = engine.execute("SELECT date, prcp FROM measurement WHERE (date LIKE '2017%') OR (date LIKE '2016-08-2%') OR (date LIKE '2016-09%') OR (date LIKE '2016-10%') OR (date LIKE '2016-11%') OR (date LIKE '2016-11%') OR (date LIKE '2016-12%')")
date_prcp_dict = []

for value[0], value[1] in prcp_and_date:
    date_prcp_dict[value[0]] = value[1]

# for stations route
station_data = engine.execute("SELECT id, station, name, latitude, longitude, elevation FROM station")

# for temperature route


# for select date route

@app.route("/")
def home():
    return routes


@app.route("/api/v1.0/precipitation")
def precipitation():
    return jsonify(date_prcp_dict)


@app.route("/api/v1.0/stations")
def station_data():
    return jsonify(station_data)

@app.route("/api/v1.0/tobs")
def temperature():
    return jsonify(prcp_and_date)

@app.route("/api/v1.0/<start>` and `/api/v1.0/<start>/<end>")
def date_select(start_date, end_date):
    """TMIN, TAVG, and TMAX for a list of dates.
    
    Args:
        start_date (string): A date string in the format %Y-%m-%d
        end_date (string): A date string in the format %Y-%m-%d
        
    Returns:
        TMIN, TAVE, and TMAX
    """
    
    return jsonify(session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start_date).filter(Measurement.date <= end_date).all())

if __name__ == "__main__":
    app.run(debug=True)
=======
from flask import Flask, jsonify
from matplotlib import style
style.use('fivethirtyeight')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import datetime as dt
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect
engine = create_engine("sqlite:///Resources/hawaii.sqlite")
# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)
Measurement = Base.classes.measurement
Station = Base.classes.station


app = Flask(__name__)

# for home route
routes = ['Home': '/', 'Precipitation': '/api/v1.0/precipitation', 'Stations': '/api/v1.0/stations', 'Temperatures': '/api/v1.0/tobs', 'Date Selector': '/api/v1.0/<start> and /api/v1.0/<start>/<end>']

# for precipitation route
prcp_and_date = engine.execute("SELECT date, prcp FROM measurement WHERE (date LIKE '2017%') OR (date LIKE '2016-08-2%') OR (date LIKE '2016-09%') OR (date LIKE '2016-10%') OR (date LIKE '2016-11%') OR (date LIKE '2016-11%') OR (date LIKE '2016-12%')")
date_prcp_dict = []

for value[0], value[1] in prcp_and_date:
    date_prcp_dict[value[0]] = value[1]

# for stations route
station_data = engine.execute("SELECT id, station, name, latitude, longitude, elevation FROM station")

# for temperature route


# for select date route

@app.route("/")
def home():
    return routes


@app.route("/api/v1.0/precipitation")
def precipitation():
    return jsonify(date_prcp_dict)


@app.route("/api/v1.0/stations")
def station_data():
    return jsonify(station_data)

@app.route("/api/v1.0/tobs")
def temperature():
    return jsonify(prcp_and_date)

@app.route("/api/v1.0/<start>` and `/api/v1.0/<start>/<end>")
def date_select(start_date, end_date):
    """TMIN, TAVG, and TMAX for a list of dates.
    
    Args:
        start_date (string): A date string in the format %Y-%m-%d
        end_date (string): A date string in the format %Y-%m-%d
        
    Returns:
        TMIN, TAVE, and TMAX
    """
    
    return jsonify(session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start_date).filter(Measurement.date <= end_date).all())

if __name__ == "__main__":
    app.run(debug=True)
>>>>>>> 4423b59a2ac507feb4d24ee5b182585e2847c9d8
