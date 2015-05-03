require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative '../lib/m_and_s'
require_relative 'support/factory_girl'

FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions
