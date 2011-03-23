class ApplicationController < ActionController::Base
  protect_from_forgery
  # Give controllers access to a module in 'helpers'
  include SessionsHelper
end
