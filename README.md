Small program to send files from folder by mail

all settings in config.json

{
	"logs_path":"/home/test",
	"mail":{
		"from": "mail@domain.com",
		"to": "user@domain.com",
		"subject": "something"
	},
	"smtp":{
		"address": "smtp.yandex.ru",
		"port": 587,
		"domain": "domain.com",
		"user_name": "mail@domain.com",
		"password": "password",
		"authentication": "plain",
		"enable_starttls_auto": true
	},		
	"send_text": true,
	"send_files": true,
	"clean_files": true
}

now it can only send mails by smtp