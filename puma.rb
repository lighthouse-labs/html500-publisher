threads 5,5
workers 1
preload_app!

cwd = File.expand_path(File.dirname(__FILE__))

puts "Booting From Puma Config... with cwd = #{cwd}"

stdout_redirect "#{cwd}/log/puma_stdout.log", "#{cwd}/log/puma_stderr.log", true

