class LanguagesController < ApplicationController
  def index
    @language = Language.new
    @languages = Language.all
  end

  def create
    @language = Language.create(language_params)
    redirect_to languages_path
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy
    redirect_to languages_path
  end

  private
    def language_params
      params.require(:language).permit(:name)
    end
end
