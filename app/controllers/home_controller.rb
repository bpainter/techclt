class HomeController < ApplicationController
  
  def index
    @users = User.paginate :per_page => 4, :page => params[:page],  # :conditions => ['id = ?', "#{}"], 
             :order => 'id DESC'
  end

end
