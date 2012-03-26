# encoding : utf-8
class BeautifulController < ApplicationController
  
  layout "beautiful_layout"
  
  def do_sort_and_paginate(model_sym)
    # Paginate
    session[:paginate] ||= {}
    session[:paginate][model_sym] ||= nil
    params[:page] ||= session[:paginate][model_sym]
    session[:paginate][model_sym] = params[:page]
    
    # Sort
    session[:sorting] ||= {}
    session[:sorting][model_sym] ||= { :attribute => "id", :sorting => "DESC" }
    params[:sorting] ||= session[:sorting][model_sym]
    session[:sorting][model_sym] = params[:sorting]
    
    # Search and Filter
    session[:search] ||= {}
    session[:search][model_sym] = nil if not params[:nosearch].blank?
    params[:q] ||= session[:search][model_sym]
    session[:search][model_sym] = params[:q]
        
    # Scope
    session[:scope] ||= {}
    session[:scope][model_sym] ||= nil
    params[:scope] ||= session[:scope][model_sym]
    session[:scope][model_sym] = params[:scope]
  end
  
  def boolean(string)
    return true if string == true || string =~ (/(true|t|yes|y|1)$/i)
    return false if string == false || string.nil? || string =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
  end
end
