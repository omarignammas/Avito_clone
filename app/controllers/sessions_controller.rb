class SessionsController < ApplicationController
  def new
    # Affiche la vue du formulaire de connexion
  end

  def create
    # Récupère les paramètres du formulaire
    email = params[:email]
    password = params[:password]
    phone_number = params[:phone_number]

    # Recherche l'utilisateur par email
    user = User.find_by(email: email)

    # Si l'utilisateur existe et le mot de passe correspond
    if user && user.authenticate(password) && user.phone_number == phone_number
      # Connecte l'utilisateur (session)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Vous êtes maintenant connecté!"
    else
      # Message d'erreur si les informations ne sont pas valides
      flash.now[:error] = "Email, mot de passe ou numéro de téléphone invalide."
      render :new
    end
  end

  def destroy
    # Déconnexion
    session[:user_id] = nil
    redirect_to root_path, notice: "Vous avez été déconnecté."
  end

  # Pour l'authentification Google OAuth2
  def omniauth
    # Récupère les informations de l'utilisateur depuis le provider
    auth = request.env['omniauth.auth']
    
    # Recherche ou crée un utilisateur avec les informations OAuth
    user = User.from_omniauth(auth)
    
    if user.persisted?
      # Connecte l'utilisateur
      session[:user_id] = user.id
      redirect_to root_path, notice: "Vous êtes connecté avec #{auth.provider.capitalize}!"
    else
      # Gère les erreurs de création d'utilisateur
      redirect_to login_path, alert: "Impossible de vous connecter avec Google."
    end
  end
end