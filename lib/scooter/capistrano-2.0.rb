configuration = if Capistrano::Configuration.respond_to?(:instance)
                  Capistrano::Configuration.instance(:must_exist)
                else
                  Capistrano.configuration(:must_exist)
                end

configuration.load do
  namespace :scooter do
    task :init do
      dir = fetch(:stage_dir, 'config/deploy')

      stages.each do |stage|
        begin
          # now why does this have to be private?
          path = configuration.send(:find_file_in_load_path, "#{dir}/#{stage}")
        rescue LoadError
          next
        end

        require 'open3'

        key = "scooter.stage-#{stage}"
        dependencies, _ = Open3.capture2('git', 'config', '--local', '--null',
                                         '--get-all', key)

        Open3.capture2('git', 'config', '--local', '--unset-all', key)

        dependencies.split("\0").push(File.absolute_path(path))
                    .uniq.each do |file|

          Open3.capture2('git', 'config', '--local', '--add', key, file)
        end
      end
    end

    task :configure do
      roles.each do |role, servers|
        servers.each do |server|
          puts "#{role}\t#{server.host}"
        end
      end
    end
  end
end
