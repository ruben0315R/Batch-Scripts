# Batch-Scripts

Hi communtiy :>)

We have made a batch scripts to remove apllications from the system by using SHA-256 hashes and give the logs / events in .csv files.

# Working process

* First to set up necessary variables like _target_directory, _hash_data, and _csv_file_path.
* The script iterates through all files in the target directory (excluding itself) using a nested loop.
* For each file, it calculates the SHA256 hash using PowerShell and checks if the hash value is in the hash data file.
* If the hash is found, it logs the action as "Deleted" and deletes the file using "icacls" and "del".
* The script creates a CSV file and logs events performed.

# Files operation

* full_c_directory - Scans whole c: volume drive.
* Desired_path - Scans the file path given by the user.
* Desired_path & permissibility - Scans the file path given by the user and ask for Y or N before deleting the file.
