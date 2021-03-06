require 'rubygems'
require 'spork'

Spork.prefork do
  unless defined? SPREE_ROOT
    ENV["RAILS_ENV"] = "test"
    case
    when ENV["SPREE_ENV_FILE"]
      require ENV["SPREE_ENV_FILE"]
    when File.dirname(__FILE__) =~ %r{vendor/SPREE/vendor/extensions}
      require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../../")}/config/environment"
    else
      require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
    end
  end
  require "#{SPREE_ROOT}/spec/spec_helper"
  
  if File.directory?(File.dirname(__FILE__) + "/scenarios")
    Scenario.load_paths.unshift File.dirname(__FILE__) + "/scenarios"
  end
  if File.directory?(File.dirname(__FILE__) + "/matchers")
    Dir[File.dirname(__FILE__) + "/matchers/*.rb"].each {|file| require file }
  end

  require File.expand_path(File.dirname(__FILE__) + "/factories")
end

Spork.each_run do
end

Spec::Runner.configure do |config|
end
