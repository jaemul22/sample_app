require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
	end

  test "unsuccesful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template "users/edit"
  	patch user_path(@user), user: {name: "", email: "user@invalid", 
	  		password:"foo", password_confirmation:"bar"}
	  assert_template "users/edit"
  end

  test "successful edit with friendly forwarding" do
  	get edit_user_path(@user)
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	patch user_path(@user), user: {name: "Foo Baar", email: "user@invalid.com", 
	  		password:"", password_confirmation:""}
	  assert_not flash.empty?
	  assert_redirected_to @user
	  
	  @user.reload
	  assert_equal @user.name, "Foo Baar"
	  assert_equal @user.email, "user@invalid.com"
  end
end
