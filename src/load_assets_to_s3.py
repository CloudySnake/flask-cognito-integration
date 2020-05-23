import mimetypes

import os
import boto3


BUCKET = "hc-flask-assets"


def write_to_s3(bucket_name: str, from_file: str, to_file: str, mimetype) -> None:
    s3 = boto3.resource("s3")
    s3.Bucket(bucket_name).upload_file(
        from_file, to_file, ExtraArgs={"ACL": "public-read", "ContentType": mimetype}
    )


def get_mimetype(file):
    mimetype, _ = mimetypes.guess_type(file)
    if mimetype is None:
        raise Exception("Failed to guess mimetype")
    return mimetype


def load_assets():
    for root, dirs, files in os.walk("static"):
        if files:
            s3_folder = root.replace("static/", "")
            for file in files:
                mimetype = get_mimetype(file)
                write_to_s3(BUCKET, f"{root}/{file}", f"{s3_folder}/{file}", mimetype)


if __name__ == "__main__":
    load_assets()
