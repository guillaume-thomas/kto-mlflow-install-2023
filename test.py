import os

for root, dirs, files in os.walk("./dataset"):
    for file in files:
        local_path = os.path.join(root, file)
        print(local_path)