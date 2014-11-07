package 'git'
package 'python-mysqldb'

user 'openaddresses' do
  home '/home/openaddresses'
  shell '/bin/bash'
  supports manage_home: true
  action :create
end
