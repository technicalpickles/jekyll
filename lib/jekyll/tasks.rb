require 'rake'
require 'rake/tasklib'
require 'jekyll'
	
module Jekyll
  # Rake tasks for generating a Jekyll site and running the server.
  # 
  # The attributes correspond to the command line options the jekyll command accepts.
  #
  # An example Rakefile would look like:
  # 
  #   require 'rake'
  #   require 'jekyll/tasks'
  # 
  #   Jekyll::Tasks.new do |jekyll|
  #     jekyll.rdiscount = true
  #     jekyll.pygments = true
  #   end
  class Tasks < ::Rake::TaskLib
    attr_accessor :source, :destination, :lsi, :pygments, :rdiscount, :permalink, :server, :server_port
    def initialize
      yield self if block_given?

      @source ||= '.'
      @destination ||= File.join('.', '_site')

      define_task
    end

    private 

    def define_task
      desc 'Generate Jekyll site'
      task :jekyll do
        ruby(arguments_for_ruby_execution.join(" "))
      end

      namespace :jekyll do
        desc 'Run Jekyll server'
        task :server do
          ruby(arguments_for_ruby_execution_with_server.join(" "))
        end
      end
    end

    def arguments_for_ruby_execution
      args = [Jekyll::BINARY]
      args << "--lsi" if self.lsi
      args << "--pygments" if self.pygments
      args << "--rdiscount" if self.rdiscount
      if permalink
        args << "--permalink" << permalink
      end

      args << source << destination

      args
    end

    def arguments_for_ruby_execution_with_server
      args = arguments_for_ruby_execution
      args << "--server"
      args << server_port if server_port
      args << "--auto"
    end

  end
end
