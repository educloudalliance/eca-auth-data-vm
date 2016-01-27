
source ../venv/bin/activate
pip install -r requirements.txt
export DJANGO_SETTINGS_MODULE="{{ pillar['educloud']['django_settings_module'] }}"
python manage.py migrate
python manage.py collectstatic --noinput

