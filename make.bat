@echo off
SETLOCAL ENABLEEXTENSIONS

for %%A in (%*) do @set _%%A_=""

if defined _HELP_ (
    echo.
    echo    Type below to run:
    echo        make run                Run project
    echo        make setup              Setup project
    echo        make migrate            Migrate data
    echo        make clean              Clean project
    echo        make useradd            Create superuser
    echo    Note: You can user mutiple param in once time
)

if defined _CLEAN_ (
    call del /f /s /q %cd%\*.pyc
    if EXIST build rd build /s/q
)

call venv\Scripts\activate

if defined _SETUP_ (
    call python -m pip install --upgrade pip
    call pip install virtualenv
    if NOT EXIST venv call virtualenv venv
    call venv\Scripts\activate
    call pip install -r requirements.txt
    call python manage.py migrate
)

if defined _MIGRATE_ (
    call python manage.py makemigrations app
    call python manage.py makemigrations
    call python manage.py migrate app
    call python manage.py migrate
)

if defined _USERADD_ (
    call python manage.py createsuperuser
)

if defined _RUN_ (
    call python manage.py runserver 127.0.0.1:8082
)

call deactivate