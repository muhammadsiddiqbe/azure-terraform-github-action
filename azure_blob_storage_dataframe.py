import os, uuid
from io import BytesIO
from datetime import datetime
from urllib.parse import urlparse
from azure.storage.blob import BlobServiceClient
import pandas as pd

def azure_upload_df(container=None, dataframe=None, filename=None):
    """
    Upload DataFrame to Azure Blob Storage for given container

    Keyword arguments:
    container -- the container name (default None)
    dataframe -- the dataframe(df) object (default None)
    filename -- the filename to use for the blob (default None)

    Function uses following enviornment variables

    AZURE_STORAGE_CONNECTION_STRING -- the connection string for the account
    OUTPUT -- the ouput folder name

    eg: upload_file(container="test", dataframe=df, filename="test.csv")
    """
    if all([container, job_id, len(dataframe), filename]):
        file_path = f"{os.getenv('OUTPUT')}"
        upload_file_path = os.path.join(file_path, f"{filename}.csv")
        connect_str = os.getenv("AZURE_STORAGE_CONNECTION_STRING")
        blob_service_client = BlobServiceClient.from_connection_string(connect_str)
        blob_client = blob_service_client.get_blob_client(
            container=container, blob=upload_file_path
        )
        try:
            output = dataframe.to_csv(index=False, encoding="utf-8")
        except Exception as e:
            pass
        try:
            blob_client.upload_blob(output, blob_type="BlockBlob")
        except Exception as e:
            pass

def azure_download_csv_to_df(url=None):
    """
    Download dataframe from Azure Blob Storage for given url

    Keyword arguments:
    url -- the url of the blob (default None)

    Function uses following enviornment variables

    AZURE_STORAGE_CONNECTION_STRING -- the connection string for the account

    eg: download_file("https://<account_name>.blob.core.windows.net/<container_name>/<blob_name>")
    """
    if url:
        connect_str = os.getenv("AZURE_STORAGE_CONNECTION_STRING")
        blob_service_client = BlobServiceClient.from_connection_string(connect_str)
        path = urlparse(url).path
        path = path.split("/")
        container = path[1]
        blob = '/'.join(path[2:])
        blob_client = blob_service_client.get_blob_client(container=container, blob=blob)
        with BytesIO() as input_blob:
            blob_client.download_blob().download_to_stream(input_blob)
            input_blob.seek(0)
            df = pd.read_csv(input_blob)
        return df
    else:
        return None