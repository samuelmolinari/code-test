ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require_relative 'support/factory_girl'
require_relative '../lib/m_and_s'

FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions
