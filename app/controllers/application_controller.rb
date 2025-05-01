# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Méthodes helper accessibles dans les vues
  helper_method :current_user, :logged_in?
  
  private
  
  # Obtient l'utilisateur actuellement connecté (si présent)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  # Vérifie si un utilisateur est connecté
  def logged_in?
    !!current_user
  end
  
  # Redirige vers la page de connexion si l'utilisateur n'est pas connecté
  def require_user
    unless logged_in?
      flash[:alert] = "Vous devez être connecté pour accéder à cette page."
      redirect_to login_path
    end
  end
end