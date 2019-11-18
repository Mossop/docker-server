import os

LOG_FILE = '/var/log/pgadmin4/pgadmin4.log'
SQLITE_PATH = '/var/lib/pgadmin4/pgadmin4.db'
SESSION_DB_PATH = '/var/lib/pgadmin4/sessions'
STORAGE_DIR = '/var/lib/pgadmin4/storage'

if os.path.exists('/var/lib/pgadmin4/config.py'):
    import sys
    sys.path.append('/var/lib')
    from pgadmin4.config import *
