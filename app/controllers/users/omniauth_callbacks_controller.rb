class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  #Facebook認証ボタンを押した時にこの処理が行われる
  def facebook
    #find_for_facebook_oauthメソッドでFacebookからユーザーのデータを取得
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)
    #persistedでそのユーザーがDBに存在するかを確認
    if @user.persisted?
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

  #Twitter認証ボタンを押した時にこの処理が行われる
  def twitter
    #find_for_twitter_oauthメソッドでTwitterからユーザーのデータを取得
    @user = User.find_for_twitter_oauth(request.env['omniauth.auth'], current_user)
    #persistedでそのユーザーがDBに存在するかを確認
    if @user.persisted? #
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else #
      session['devise.twitter_data'] = request.env['omniauth.auth'].except("extra")
      redirect_to new_user_registration_path
    end
  end

end
