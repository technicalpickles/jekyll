require 'rake'
require 'rake/tasklib'
require 'jekyll'
	
module Jekyll
  # Rake tasks for generating a Jekyll site.
  class Task < ::Rake::TaskLib
    attr_accessor :source, :destination, :use_lsi, :use_pygments, :use_rdiscount, :permalink_type, :server, :server_port
    def initialize
      @task_name, @desc = task_name, desc

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
      args << "--lsi" if self.use_lsi
      args << "--pygments" if self.use_lsi
      args << "--rdiscount" if self.use_rdiscount
      if permalink_type
        args << "--permalink" << permalink_type
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
