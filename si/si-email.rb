#!/usr/bin/env ruby

require 'pony'

Pony.options = {
	via: :smtp,
	via_options: {
		:address              => 'smtp.gmail.com',
		:port                 => '587',
		:enable_starttls_auto => true,
		:user_name            => ENV['GOOGLE_USERNAME'],
		:password             => ENV['GOOGLE_PASSWORD'],
		:authentication       => :plain
	}
}

def si_mail(to:,from:,  **options)
  Pony.mail(
    to: to,
    from: from,
    **options
  )
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
      o.banner = "usage: #{$0} [options]"
      o.array '-t', '--to', 'to email address', delimiter: ','
      o.array '-c', '--cc', 'cc email address', delimiter: ','
      o.array '-d', '--bcc', 'bcc email address', delimiter: ','
      o.string '-f', '--from', 'from email address', default: ENV['SI_EMAIL']
      o.string '-r', '--reply-to', 'reply-to email address', default: ENV['SI_EMAIL']
      o.string '-s', '--subject', 'subject of the email'
      o.string '-b', '--body', 'text body'
      o.string '-a', '--attachment', 'attach a file from stdin with this name', default: 'attachment'
      o.on '--help' do
        puts o
      end
    end

    ARGV.replace opts.arguments

    if opts[:to].nil? || opts[:to].empty?
      err("There must a receiver for this email.")
    end

    args = opts.to_hash

    attachment = args.delete(:attachment)
    if file = ARGF.read
      args[:attachments] = {attachment => file}
    end

    si_mail(**args)
  rescue RuntimeError => e
    $stderr.puts e.to_s
    exit 1
  end

  exit 0
end
