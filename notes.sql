sudo -u postgres psql
ALTER USER postgres PASSWORD 'yourpassword';
sudo systemctl restart postgresql
sudo systemctl status postgresql
pg_lsclusters
