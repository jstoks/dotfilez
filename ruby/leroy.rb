#!/usr/bin/env ruby

require 'tty-command'

class FileList
  include Enumerable
  extend Forwardable

  def_delegator :list, :each

  def initialize(reference, target, command: TTY::Command.new(printer: :null))
    @reference = reference
    @target = target
    @command = command
  end

  private
  attr_reader :reference, :target, :list, :command

  def list
    @list ||= begin
                git_list(reference, target)
                  .each_line
                  .reject{ |line| line =~ /^D/ }
                  .map { |line| line.split("\t").last.strip }
                  .select { |line| line =~ /\.rb$/ }
              end
  end

  def git_list(reference, target)
    command.run("git diff --name-status #{reference}..#{target}", chdir: git_root).out
  end

  def git_root
    command.run('git rev-parse --show-toplevel').out.strip
  end
end

class Rubocopper
  def auto(list)
    null_command.run!("rubocop -a #{list.join(' ')}")
  end

  def run(list)
    quiet_command.run!("rubocop --color -D -f s #{list.join(' ')}")
  end

  private

  def quiet_command
   TTY::Command.new(printer: :quiet)
  end

  def null_command
   TTY::Command.new(printer: :null)
  end

  attr_reader :command
end

class Flogger
  def initialize(command: TTY::Command.new(printer: :quiet))
    @command = command
  end

  def run(list)
    command.run!("flog #{list.join(' ')}")
  end

  private
  attr_reader :command
end

if __FILE__ == $0
  def err(message,code=1)
    code = 1 if code == 0
    $stderr.puts message
    exit code
  end

  begin
    require 'slop'

    opts = Slop.parse do |o|
      o.banner = "usage: #{$0} [OPTIONS] reference_branch"
      o.string '-t', '--target', 'The target branch to check for changes from.', default: 'HEAD'
      o.bool '-d', '--docs', 'Add useful rubocop help to the output.', default: true
      o.bool '-s', '--spec', 'Check the spec files.', default: false
      o.bool '-a', '--auto', 'Include an initial run with auto on.', default: true
      o.bool '-f', '--flog', 'Run flog instead of rubocop', default: false
      o.on '--help' do
        puts o
      end
    end

    args = opts.arguments

    if args.empty?
      err("Must provide a reference_branch.")
    end

    list = FileList.new(args[0],opts[:target]).to_a

    list = list.reject{ |line| line =~ /_spec\.rb$/ } unless opts[:spec]

    if opts[:flog]
      puts Flogger.new.run(list).out
    else
      rubocopper = Rubocopper.new
      rubocopper.auto(list) if opts[:auto]

      rubocopper.run(list)

      if opts[:docs]
        puts <<~DOCS
        -----------------------------------------------------------
        One or more individual cops can be disabled locally in a section of a file by adding a comment such as
            
            # rubocop:disable Metrics/LineLength, Style/StringLiterals
            # [...]
            # rubocop:enable Metrics/LineLength, Style/StringLiterals

        You can also disable all cops with

            # rubocop:disable all
            # [...]
            # rubocop:enable all

        One or more cops can be disabled on a single line with an end-of-line comment.

            for x in (0..19) # rubocop:disable Style/For
        -----------------------------------------------------------
        DOCS
      end
    end

  rescue RuntimeError => e
    $stderr.puts e.to_s
    exit 1
  end

  exit 0
end
