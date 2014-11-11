require 'spec_helper'

describe package 'git' do
  it { should be_installed }
end

describe package 'python-mysqldb' do
  it { should be_installed }
end

describe package 'mariadb-server' do
  it { should be_installed }
end

describe service 'mysql' do
  it { should be_running }
end

describe user 'openaddresses' do
  it {should exist }
end

describe file '/home/openaddresses/etl/common-ETL' do
  it { should be_directory }
end

describe file '/home/openaddresses/etl/common-ETL/setup.py' do
  its(:content) { should match /name='common_etl',/ }
end

describe file '/home/openaddresses/etl/companies-house-ETL' do
  it { should be_directory }
end

describe file '/home/openaddresses/etl/companies-house-ETL/README.md' do
  its(:content) { should match /companies-house-ETL/ }
end

describe command 'mysql -e "show databases"' do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Database/ }
end

describe command 'mysql -e "show databases"' do
  its(:stdout) { should match /commonetldb/ }
end

describe command 'mysql commonetldb -e "show tables"' do
  its(:stdout) { should match /ONSPD_Changes/ }
  its(:stdout) { should match /Posttowns/ }
end
