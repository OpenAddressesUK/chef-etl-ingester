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
