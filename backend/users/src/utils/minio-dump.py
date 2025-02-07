from minio import Minio
import os
from tqdm import tqdm

IMAGES_PATH = "./avatars" # Change the path according to where you put the "avatars" folder
BUCKET_NAME = "avatars"


# Create client with access key and secret key with specific region.
client = Minio(
    "localhost:9001",
    access_key="brvsacDmKl7rZpc5b4wg",
    secret_key="Hg7TUYl7TkYLozhGiHwMLdE17NOfN6DjsbPVcVLp",
    secure=False  # Otherwise bug
)


def dump_images(images_folder):
    for index, filename in enumerate(tqdm(os.listdir(images_folder), desc="Uploading files")):
        image_path = os.path.join(images_folder, filename)
        client.fput_object(
            BUCKET_NAME, f"avatar_{index}", image_path)


if __name__ == "__main__":
    dump_images(IMAGES_PATH)