namespace :radiant do
  namespace :extensions do
    namespace :ae_users_authenticator do
      
      desc "Runs the migration of the Ae Users Authenticator extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          AeUsersAuthenticatorExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          AeUsersAuthenticatorExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Ae Users Authenticator to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[AeUsersAuthenticatorExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(AeUsersAuthenticatorExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
