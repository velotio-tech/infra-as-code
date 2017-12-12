# frozen_string_literal: true
require 'chefspec'
require 'chefspec/berkshelf'
require 'simplecov'
require 'simplecov-json'
require 'simplecov-rcov'

SimpleCov.formatters = [
  SimpleCov::Formatter::RcovFormatter
]
SimpleCov.start

require_relative '../recipes/default.rb'

