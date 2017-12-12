# frozen_string_literal: true
require 'chefspec'
require 'chefspec/berkshelf'

require_relative './unit/recipes/default_spec.rb'
at_exit { ChefSpec::Coverage.report! }

