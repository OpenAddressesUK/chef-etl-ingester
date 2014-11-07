package 'git'
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
