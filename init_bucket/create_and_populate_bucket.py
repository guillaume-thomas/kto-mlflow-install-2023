import boto3
import os

endpoint = os.environ.get("MINIO_ENDPOINT")
bucket_name = "cats-dogs-other"
print(endpoint)

s3_client = boto3.client(
    "s3",
    endpoint_url=endpoint,
    aws_access_key_id="minio",
    aws_secret_access_key="minio123"
)


def upload_directory(path, bucketname):
    for root, dirs, files in os.walk(path):
        for file in files:
            local_path = os.path.join(root, file)
            print("uploading " + local_path)
            s3_client.upload_file(os.path.join(root, file), bucketname, local_path)


response = s3_client.create_bucket(
    Bucket=bucket_name
)

print(response)

response = s3_client.put_bucket_versioning(
    Bucket=bucket_name,
    VersioningConfiguration={
        'Status': 'Enabled'
    }
)

print(response)

upload_directory("dataset", bucket_name)


