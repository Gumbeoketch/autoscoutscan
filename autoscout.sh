cd /opt 
git clone https://github.com/nccgroup/ScoutSuite.git
cd ScoutSuite
pip install virtualenv
virtualenv -p python3 venv || python3 -m virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
python scout.py aws



exit
      