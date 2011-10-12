class PagesController < ApplicationController
  def index
  end
  
  def competition
    @competition = Competition.find(params[:competition])
  end
end
