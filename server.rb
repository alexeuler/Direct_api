require 'daemons'

Daemons.run('app.rb', {
              app_name: 'stats',
              dir_mode: :script,
              dir: 'daemon',
              backtrace: true,
              monitor: true,
              log_output: true
            })
