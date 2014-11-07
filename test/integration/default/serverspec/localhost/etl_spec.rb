require 'spec_helper'

describe package 'git' do
  it { should be_installed }
end

describe package 'python-mysqldb' do
  it { should be_installed }
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
