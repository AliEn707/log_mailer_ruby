# encoding: UTF-8
require 'json'
require 'mail'

class LogMailer
	SEQ=%w{load_config check_files create_mail send_mail}
	
	attr_accessor :files
	def self.run
		runner=self.new
		SEQ.each{|m| runner.send(m)}
	end
	
	def load_config
		@config=File.open("config.json","rt"){|f| JSON.parse(f.read)}
		@files=get_files
	end
	
	def check_files
		@files.each{|f| File.open(f,"r"){|d| return (@has_data=true) if (d.read.size>0)}}
#		p "files are clean"
		return false
	end
	
	def send_mail
		return if !(@has_data)
		@mail.delivery_method :smtp, { :address              => @config["smtp"]["address"],
								   :port                 => @config["smtp"]["port"],
								   :domain               => @config["smtp"]["domain"],
								   :user_name            => @config["smtp"]["user_name"],
								   :password             => @config["smtp"]["password"],
								   :authentication       => @config["smtp"]["authentication"],
								   :enable_starttls_auto => @config["smtp"]["enable_starttls_auto"]  }
		@mail.deliver!
		clean_files if (@config["clean_files"])
	end
	
	def create_mail
		return if !(@has_data)
		config=@config
		runner=self
		@mail=Mail.new do
				from     config["mail"]["from"]
				to       config["mail"]["to"]
				subject  config["mail"]["subject"]
				body     (config["send_text"] ? runner.create_body : "")
				runner.files.each{|f| add_file f} if (config["send_files"])
			end
	end
	
	
	def get_files
		@config["logs_path"].split.map!{|path| `ls #{path}`}.join(" ").split.map!{|f| "#{@config["logs_path"]}/#{f}"}
	end
	
	def create_body
		files.map{|f| "#{f}:\n#{File.open(f,"rt"){|d| d.read.split("\n").map!{|l| "\t#{l}"}.join("\n")}}"}.join("\n\n")
	end
	
	def clean_files
		files.each{|f| File.open(f,"w"){|s| s.write("")}}
	end
end