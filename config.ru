# This file is used by Rack-based servers to start the application.
require 'sass/plugin/rack'

use Sass::Plugin::Rack
Sass::Plugin.options[:style] = :compact

require ::File.expand_path('../config/environment',  __FILE__)
run SmoProject::Application
