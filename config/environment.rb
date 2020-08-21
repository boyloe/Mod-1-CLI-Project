require 'bundler/setup'
Bundler.require
require 'colorize'
require_all 'lib'
ActiveRecord::Base.logger = nil