class CkeditorMigrationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      create_scaffold(m)
      create_migration(m)
    end
  end

  protected
    
    def create_scaffold(m)
      m.directory(File.join('app', 'models'))
      
			m.template "models/#{generator_dir}/assets_controller.rb",
               File.join('app/controllers', "assets_controller.rb")

      m.template "models/#{generator_dir}/asset.rb",
               File.join('app/models', "asset.rb")
      
      m.template "models/#{generator_dir}/picture.rb",
               File.join('app/models', "picture.rb")
      
      m.template "models/#{generator_dir}/attachment_file.rb",
               File.join('app/models', "attachment_file.rb")

			m.route_resources 'assets'
			
			src_dir = File.join(@source_root, 'assets')
			dst_dir = File.join(RAILS_ROOT, 'app', 'views')

			FileUtils.cp_r src_dir, dst_dir, :verbose => true
    end
    
    def create_migration(m)
      m.migration_template "models/#{generator_dir}/migration.rb", 'db/migrate', :migration_file_name => "create_assets.rb"
    end
    
    def generator_dir
      options[:backend] || "paperclip"
    end
end
