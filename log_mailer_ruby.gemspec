require './lib/version'

Gem::Specification.new do |s|
  s.name         = 'log_mailer_ruby'
  s.version      = LogMailer::VERSION
  s.summary      = %q[Small app to send log files via mail]
  s.description  = %q[Usefull]

  s.authors      = ['Denis Yarikov']
  s.email        = %w[whitesandwitch@yandex.com]
  s.homepage     = 'http://wsstudio.tk'
  s.license      = 'MIT'

  s.files        = Dir['[A-Z]*', 'log_mailer_ruby.gemspec', '{bin,lib}/**/*'] - ['Gemfile.lock']
#s.test_files   = Dir['test/**/*']
  s.executables  = %w[log_mailer_ruby]
  s.require_path = 'lib'

  s.add_dependency 'mail'
 
 # s.add_development_dependency 'rake', '~> 10.3'

  s.required_ruby_version = '>= 1.9.3'
end
