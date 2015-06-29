# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{ubuntu@52.1.250.117}
role :web, %w{ubuntu@52.1.250.117}
role :db,  %w{ubuntu@52.1.250.117}

set :application, 'moyuzhang_app_staging'
set :repo_url, 'git@bitbucket.org:jamesying/moyuzhang_app.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '~/sites/staging.moyuzhang.com'

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
set :stage, :staging
server '52.1.250.117', user: 'ubuntu', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
server '52.1.250.117',
  user: 'ubuntu',
  roles: %w{web app},
  ssh_options: {
    keys: %w(/Users/james/Mydoc/id/james-key-useast.pem)
    # password: 'please use keys'
  }
# setting per server overrides global ssh_options
