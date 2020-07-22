require_relative "planet"
require "BCrypt"

def read_users()
    run_sql("select * from users;")
end

def read_user_by_email(email)
    run_sql("select * from users where email='#{email}';")[0]
end

def read_user_by_id(user_id)
    run_sql("select * from users where user_id=#{user_id};")[0]
end

def create_user(email, first_name, password)
    password_digested = BCrypt::Password.create(password)
    run_sql("insert into users (email, first_name, password_digested) values ('#{email}', '#{first_name}', '#{password_digested}');")
end