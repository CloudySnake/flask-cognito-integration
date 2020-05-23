from flask import Flask, render_template, request, redirect, url_for, make_response
from flask_awscognito import AWSCognitoAuthentication
from flask_cors import CORS
from jwt.algorithms import RSAAlgorithm
from flask_jwt_extended import (
    JWTManager,
    set_access_cookies,
    verify_jwt_in_request_optional,
    get_jwt_identity,
)

from src.keys import get_cognito_public_keys

app = Flask(__name__, static_url_path="", static_folder="src/static")
app.config.from_object("src.config")
app.config["JWT_PUBLIC_KEY"] = RSAAlgorithm.from_jwk(get_cognito_public_keys())

CORS(app)
aws_auth = AWSCognitoAuthentication(app)
jwt = JWTManager(app)


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    return redirect(aws_auth.get_sign_in_url())


@app.route("/loggedin", methods=["GET"])
def logged_in():
    access_token = aws_auth.get_access_token(request.args)
    resp = make_response(redirect(url_for("protected")))
    set_access_cookies(resp, access_token, max_age=30 * 60)
    return resp


@app.route("/secret")
def protected():
    verify_jwt_in_request_optional()
    if get_jwt_identity():
        return render_template("secret.html")
    else:
        return redirect(aws_auth.get_sign_in_url())
