import os

AWS_DEFAULT_REGION = os.environ["AWS_REGION"]
JWT_TOKEN_LOCATION = ["cookies"]
JWT_COOKIE_SECURE = True

# We're ok to set this off, as Cognito OAuth state provides protection
JWT_COOKIE_CSRF_PROTECT = False
JWT_ALGORITHM = "RS256"
JWT_IDENTITY_CLAIM = "sub"

SECRET_KEY = os.environ["SECRET_KEY"]
JWT_PRIVATE_KEY = os.environ["JWT_PRIVATE_KEY"]
#  We're using Cognito to generate keys, so this is never used
JWT_SECRET_KEY = os.environ["JWT_SECRET_KEY"]
AWS_COGNITO_DOMAIN = os.environ["AWS_COGNITO_DOMAIN"]
AWS_COGNITO_USER_POOL_ID = os.environ["AWS_COGNITO_USER_POOL_ID"]
AWS_COGNITO_USER_POOL_CLIENT_ID = os.environ["AWS_COGNITO_USER_POOL_CLIENT_ID"]
AWS_COGNITO_USER_POOL_CLIENT_SECRET = os.environ["AWS_COGNITO_USER_POOL_CLIENT_SECRET"]
AWS_COGNITO_REDIRECT_URL = os.environ["SITE_URL"] + "/loggedin"
