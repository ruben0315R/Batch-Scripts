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

* full_volume - Scans the entire volume drive, processing one volume at a time.
* Desired_path - Scans the file path provided by the user.
* Desired_path & permissibility - Scans the file path specified by the user and asks for confirmation (Y or N) before deleting the file.

# Changes required

* Change the Hash data and CSV file path on your needs.
* In full_volume change the target_directory variables for your specifications.
