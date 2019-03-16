require 'site_hook'
require 'site_hook/logger'
module Certflare
  class Runner
    def initialize(argv = ARGV, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end
    def execute!
      exit_code = begin
        $stderr = @stderr
        $stdin = @stdin
        $stdout = @stdout
        Certflare::PreLogger.new($stdin, $stdout, $stderr)
        Certflare::Config.new
        Certflare::Log.new($stdin, $stdout, $stderr)
        Certflare::CLI.start(@argv)
        0

      rescue StandardError => e
        b = e.backtrace
        STDERR.puts("#{b.shift}: #{e.message} (#{e.class})")
        STDERR.puts(b.map{|s| "\tfrom #{s}"}.join("\n"))
        1
      rescue SystemExit => e
        STDERR.puts e.status
        1
      ensure

        $stderr = STDERR
        $stdin = STDIN
        $stdout = STDOUT
      end
      @kernel.exit(exit_code)
    end
  end
end