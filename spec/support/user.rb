def current_user
  @user ||= User.create(first_name: "kenneth", last_name: "chung", email: "test@test.com", password: "password")
end