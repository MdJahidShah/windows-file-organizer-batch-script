# Windows File Organizer Batch Script

A simple, lightweight, and beginner-friendly Windows File Organizer Batch Script that automatically organizes files into folders based on their file extensions.

Instead of manually sorting documents, images, videos, archives, and other files, this Windows ".bat" script can organize files in the current directory with a single execution.

## Features

- Organizes files automatically by file extension
- Works with standard Windows Command Prompt
- No third-party software required
- No installation required
- Lightweight Windows batch script
- Processes files in the current directory only
- Automatically creates extension-based folders
- Skips directories
- Skips the organizer script itself
- Skips files without extensions
- Does not overwrite existing destination files
- Displays moved, skipped, and failed file counts
- Beginner-friendly and easy to customize
- Useful for downloads, documents, media, backups, and temporary files

## How It Works

The script examines each file in the current directory and identifies its extension.

**For example:**

* photo.jpg
* document.pdf
* video.mp4
* archive.zip
* notes.txt

**The script creates folders based on those extensions:**
```bash
.jpg
.pdf
.mp4
.zip
.txt
```
**The files are then moved into their corresponding folders:**

```bash
.jpg/
└── photo.jpg

.pdf/
└── document.pdf

.mp4/
└── video.mp4

.zip/
└── archive.zip

.txt/
└── notes.txt
```

This makes it useful as a simple automatic file organizer for Windows.

---

## Complete Code

**Save the following code as:**

```bash
organize-files.bat

@echo off
setlocal EnableExtensions DisableDelayedExpansion

title Windows File Organizer

echo.
echo ==========================================
echo       WINDOWS FILE ORGANIZER
echo ==========================================
echo.
echo Organizing files in:
echo %CD%
echo.

set "MOVED=0"
set "SKIPPED=0"
set "ERRORS=0"

for %%F in (*) do (
    rem Skip directories
    if not exist "%%~fF\" (

        rem Skip this batch file
        if /I not "%%~fF"=="%~f0" (

            rem Process only files that have an extension
            if not "%%~xF"=="" (

                rem Create a folder using the file extension
                if not exist "%%~xF\" (
                    mkdir "%%~xF" 2>nul
                )

                rem Check whether the destination file already exists
                if exist "%%~xF\%%~nxF" (

                    echo [SKIP] "%%~nxF"
                    echo        Destination already exists.
                    set /A SKIPPED+=1

                ) else (

                    rem Move the file
                    move "%%~fF" "%%~xF\" >nul 2>&1

                    if errorlevel 1 (
                        echo [ERROR] Could not move "%%~nxF"
                        set /A ERRORS+=1
                    ) else (
                        echo [MOVED] "%%~nxF" ^> %%~xF\
                        set /A MOVED+=1
                    )
                )
            )
        )
    )
)

echo.
echo ==========================================
echo              ORGANIZATION COMPLETE
echo ==========================================
echo.
echo Files moved   : %MOVED%
echo Files skipped : %SKIPPED%
echo Errors        : %ERRORS%
echo.
echo Files without extensions were left unchanged.
echo Existing destination files were not overwritten.
echo.
pause
endlocal
```
---

## Installation

No installation is required.

### Step 1: Download the Script

You can view the batch file directly in this repository:

[organize-files.bat on GitHub](https://github.com/MdJahidShah/windows-file-organizer-batch-script/blob/main/organize-files.bat)

Download or copy the contents of "organize-files.bat".

### Step 2: Place the Script

Copy "organize-files.bat" into the directory containing the files you want to organize.

**For example:**

```bash
Downloads/
├── photo.jpg
├── report.pdf
├── movie.mp4
├── backup.zip
├── notes.txt
└── organize-files.bat
```

### Step 3: Run the Script

**Double-click** on **organize-files.bat** file.

The script will process files in that directory and create extension-based folders automatically.

---

## Important: Test Before Using

Although this script is designed for a simple file organization task, you should test it on a copy of your files first.

**For example, create a test folder:**

```bash
File Organizer Test/
├── image.jpg
├── document.pdf
├── video.mp4
├── archive.zip
└── organize-files.bat
```

Run the script and verify the result before using it on important data.

Do not use an automated file-moving script on critical folders until you understand exactly how it behaves.

---

## What the Script Does

The script performs several checks before moving a file.

### 1. Looks at the current directory
```bash
for %%F in (*) do (
```

This tells Windows to process items in the current directory.

It does not recursively scan every subfolder.

### 2. Skips folders
```bash
if not exist "%%~fF\" (
```
This prevents the script from treating directories as normal files.

### 3. Skips itself
```bash
if /I not "%%~fF"=="%~f0" (
```

The batch file does not move itself into its own extension folder.

### 4. Checks for an extension
```bash
if not "%%~xF"=="" (
```

Files with extensions are processed.
```bash
Examples:

.jpg
.pdf
.mp4
.zip
.txt
.exe
```

Files without an extension are left unchanged.

### 5. Creates an extension folder
```bash
if not exist "%%~xF\" (
    mkdir "%%~xF"
)
```

If the appropriate extension folder does not exist, the script creates it.
```bash
For example:

.jpg
```

### 6. Checks for duplicate filenames

Before moving a file, the script checks whether the destination already contains a file with the same name.
```bash
if exist "%%~xF\%%~nxF" (
```

If it exists, the file is skipped.

This prevents the script from intentionally replacing an existing destination file.

### 7. Moves the file
```bash
move "%%~fF" "%%~xF\"
```

The file is moved into the folder corresponding to its extension.

---

## Safety Considerations

This script is intentionally simple, but it still performs a filesystem operation: moving files.

Keep the following points in mind.

**It moves files**

The script does not merely display a list of files. It actually moves them.

**It does not delete files**

There is no "del", "erase", "rmdir", or similar deletion command in the script.

**Existing destination files are skipped**

If the destination already contains a file with the same filename, the script skips that file rather than intentionally overwriting it.

**It does not organize subfolders**

The script processes files in the directory where it is executed.

It does not recursively organize:
```bash
Folder/
├── file.jpg
└── Subfolder/
    └── another.jpg
```
The file inside "Subfolder" is not processed.

Files without extensions remain unchanged
```bash
For example:

README
LICENSE
config
```
are not moved because they do not have a detected file extension.

---

## Example Use Cases

This Windows batch file organizer can be useful for several everyday tasks.

### Downloads Folder

Downloads often contain a mixture of:

- PDF documents
- Images
- ZIP archives
- Videos
- Text files
- Installer files

Running the script can separate these files into extension-based folders.

### Project Files

You can organize a directory containing:
```bash
.html
.css
.js
.json
.png
.jpg
```
into separate extension folders.

### Backup Organization

A temporary backup directory containing different file types can be quickly separated by extension.

### Media Organization

A folder containing multiple media formats can be organized into:
```bash
.mp3
.mp4
.mkv
.jpg
.png
```
---

## Before and After

### Before
```bash
My Files/
├── image1.jpg
├── image2.png
├── document.pdf
├── report.docx
├── video.mp4
├── archive.zip
├── notes.txt
└── organize-files.bat
```
### After
```bash
My Files/
├── .jpg/
│   └── image1.jpg
│
├── .png/
│   └── image2.png
│
├── .pdf/
│   └── document.pdf
│
├── .docx/
│   └── report.docx
│
├── .mp4/
│   └── video.mp4
│
├── .zip/
│   └── archive.zip
│
├── .txt/
│   └── notes.txt
│
└── organize-files.bat
```
---

## Why Use a Batch Script?

Windows already includes powerful command-line tools, so a simple file organizer can be created without installing additional software.

This project uses standard Windows batch commands such as:
```bash
FOR
IF
MKDIR
MOVE
SET
ECHO
```
Because it uses Windows Command Prompt functionality, it is suitable for learning basic Windows automation and batch scripting.

---

## Customization

The script can be modified to provide more advanced organization.

**Possible improvements include:**

- Grouping extensions into categories
- Creating "Images", "Documents", "Videos", and "Archives" folders
- Organizing files recursively
- Adding a dry-run mode
- Creating a log file
- Adding date-based folders
- Adding duplicate-file handling
- Sorting files by size
- Sorting files by creation or modification date
- Adding a confirmation prompt before moving files

**For example, a more advanced organizer could transform:**
```bash
.jpg
.png
.gif
```
**into:**
```bash
Images/
├── photo.jpg
├── image.png
└── animation.gif
```
This repository currently focuses on simple extension-based organization to keep the script lightweight and easy to understand.

---

## Limitations

This project intentionally has a limited scope.

**It does not currently:**

- Recursively scan subdirectories
- Categorize files semantically
- Analyze file contents
- Rename files
- Delete duplicate files
- Upload files
- Modify file contents
- Connect to cloud storage
- Require PowerShell or Python

It is designed as a straightforward Windows batch file organizer.

---

## Troubleshooting

The script does not move a file

**Check whether:**

- The file has an extension.
- The file is currently being used by another program.
- You have permission to modify the directory.
- The destination file already exists.
- The directory is protected by Windows permissions or security software.

### A file was skipped

The script may skip a file when a file with the same name already exists inside the destination extension folder.

**For example:**
```bash
.jpg/
└── photo.jpg
```
If another "photo.jpg" is encountered, it will be skipped.

### Some files remain in the original folder

Files without extensions are intentionally left unchanged.

Directories are also left unchanged.

The script only processes files in the current directory.

---

## Security

This repository contains a Windows batch script for local file organization.

The script should be reviewed before execution, especially when using scripts downloaded from the internet.

**For security-sensitive environments:**

1. Review the source code.
2. Test the script in a temporary directory.
3. Keep backups of important files.
4. Avoid running unknown scripts with administrative privileges.
5. Verify the script before deploying it to production or shared systems.

This project does not require administrator privileges for normal use.

---

## Repository

**Source code:**

[Windows File Organizer Batch Script on GitHub](https://github.com/MdJahidShah/windows-file-organizer-batch-script)

**Main script:**

[organize-files.bat](https://github.com/MdJahidShah/windows-file-organizer-batch-script/blob/main/organize-files.bat)

---

## Related Cybersecurity Resources

If you are interested in cybersecurity, ethical security testing, Linux security tools, reconnaissance, vulnerability assessment, and penetration-testing utilities, visit:

[Best Kali Linux Tools Guide](https://labs.jahidshah.com/Best-Kali-Linux-tools/)

The guide covers useful Kali Linux tools and security utilities for learning and authorized security testing.

---

Support the Project

If this project helped you or you found the guide useful, you can support my open-source work:

[Buy Me a Coffee - Jahid Shah](https://buymeacoffee.com/jahidshah)

Your support helps me continue creating free technical guides, open-source projects, WordPress tools, and cybersecurity resources.

---

## License

This project is intended for educational and practical file-organization purposes.

See the repository license file for the applicable license terms.

---

## Disclaimer

Use this script responsibly.

Always understand what a filesystem automation script does before running it on important data. The author is not responsible for data loss, unintended file movement, permission issues, or other consequences resulting from modifications, misuse, or execution of the script.

Always maintain appropriate backups of important files.

---
