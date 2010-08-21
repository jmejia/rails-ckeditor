require 'fileutils'

class CkeditorInstallGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      create_yml(m)
      copy_javascripts(m)
      
      m.readme "README"
    end
  end

  private
  	cattr_accessor :filepath
  	@@filepath = File.join(RAILS_ROOT, "config/ckeditor.yml")

    def create_yml(m)
      unless File.exists?(@@filepath)
        ck_config = File.join(RAILS_ROOT, 'vendor/plugins/rails-ckeditor/', 'ckeditor.yml.tpl')
        FileUtils.cp ck_config, @@filepath unless File.exist?(@@filepath)

      end
    end
    
    def copy_javascripts(m)
      src_dir = File.join(@source_root, 'ckeditor')
      dst_dir = File.join(RAILS_ROOT, 'public', 'javascripts')
      jquery 	= File.join(@source_root, 'jquery-1.4.2.min.js')
	
      FileUtils.cp_r src_dir, dst_dir, :verbose => true
      FileUtils.cp_r jquery, dst_dir, :verbose => true
    end

end
