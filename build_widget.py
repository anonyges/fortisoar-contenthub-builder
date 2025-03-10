# %%
import os
import json
import argparse
import subprocess
from uuid import uuid4

parser = argparse.ArgumentParser(prog="ProgramName", description="What the program does", epilog="Text at the bottom of help")
parser.add_argument("-i", "--input_folder_path")
args = parser.parse_args()

input_folder_path = args.input_folder_path
# if input_folder_path.startswith(".")
# elif input_folder_path.startswith("/"):
with open(os.path.join(input_folder_path, "widget", "info.json"), "rb") as f:
    info_json = f.read()
    info = json.loads(info_json)
    filename = info.get("name") + "-" + info.get("version")
    compress_folder_path = os.path.join(os.getcwd(), f"c_{str(uuid4())}")

    subprocess.run(["rm", f"{filename}.tgz"])
    subprocess.run(["rm", "-rf", compress_folder_path])
    subprocess.run(["mkdir", compress_folder_path])
    subprocess.run(
        [
            "cp",
            "-r",
            os.path.join(input_folder_path, "widget"),
            os.path.join(compress_folder_path, filename),
        ]
    )
    subprocess.run(["find", compress_folder_path, "-name", ".DS_Store", "-delete"])
    subprocess.run(
        [
            f'COPYFILE_DISABLE=1 tar -czvf {filename}.tgz -C "{compress_folder_path}" {filename}',
        ],
        shell=True,
    )
    subprocess.run(["rm", "-rf", compress_folder_path])

    # # OR the below command, which cannot be imported from FortiSOAR due to uncompress expression
    # subprocess.run(
    #     [
    #         f"COPYFILE_DISABLE=1; tar -czvf {filename}.tgz -C \"{input_folder_path}\" widget",
    #     ],
    #     shell=True
    # )
