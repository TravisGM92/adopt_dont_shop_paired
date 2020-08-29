class AppController < ApplicationController

  def create
     @application = App.new({name: app_params[:name], address: app_params[:address], city: app_params[:city],
       state: app_params[:state], zip: app_params[:zip], phone_number: app_params[:phone_number], description: app_params[:description]})
     ids = app_params[:pets]
     pet = Pet.where(id: (ids.map{ |id| id}))

     if @application.save
       pet.each{ |pet| pet.update(favorite: !pet.favorite)}
       pet.each{ |pet| pet.update(application_pending: true)}
       redirect_to("/favorites")
     else
       flash[:notice] = "Application not submitted: Required information missing"
       redirect_to("/favorites/adopt")
     end
   end

   private
   def app_params
     params.permit!
   end
end
