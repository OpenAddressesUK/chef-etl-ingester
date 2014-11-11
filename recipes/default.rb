package 'git'
package 'mariadb-server'
package 'python-mysqldb'

oa_user = 'openaddresses'

user oa_user do
  home '/home/%s' % oa_user
  shell '/bin/bash'
  supports manage_home: true
  action :create
end

deploy_root = '/home/%s/etl' % oa_user

directory deploy_root do
  owner oa_user
  action :create
end

%w{
  common-ETL
  companies-house-ETL
}.each do |etl|
  git '%s/%s' % [ deploy_root, etl ] do
    user oa_user
    repository 'https://github.com/OpenAddressesUK/%s' % etl
    action :sync
  end
end

execute 'create database' do
  command 'mysql -e "create database if not exists commonetldb"'
end

execute 'run sql' do
  cwd '/home/openaddresses/etl/common-ETL'
  command 'mysql commonetldb < oa_alpha_etl.sql'
end

execute 'grab OS Locator data' do
  cwd '/home/openaddresses/etl/common-ETL'
  command 'python OS_Locator_download.py'
end

execute 'grab ONSPD data' do
  cwd '/home/openaddresses/etl/common-ETL'
  command 'python ONSPD_download.py'
end
