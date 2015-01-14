class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This is optional. Decided to catch CanCan access errors here (else the app would just throw a fatal error)
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to(root_path)
  end

  # Returns a scoped/authorised collection, inferred by controller name.
  # This is kind of 'InheritedResources-lite'!
  def collection
    resource_class = controller_name.classify.constantize rescue nil
    return unless resource_class
    @collection ||= if current_user.can? :read, resource_class
      resource_class.accessible_by(current_ability)
    else
      raise CanCan::AccessDenied
    end
  end
  helper_method :collection

end
