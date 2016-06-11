class Users::RegistrationsController < Devise::RegistrationsController

  #Twitter認証時のemail用にuuidのランダムな文字列を生成する処理
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  protected
    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end
  end

end
