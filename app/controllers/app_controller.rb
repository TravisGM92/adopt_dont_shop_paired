class AppController < ApplicationController

  def create
    app = App.new(name: app_params[:name], address: app_params[:address], city: app_params[:city], state: app_params[:state], zip: app_params[:zip], phone_number: app_params[:phone_number], description: app_params[:description])
    ids = app_params[:pets]
    # pets = Pet.where(id: ids)
    pets = Pet.where(id: (ids.map{ |id| id}))
    if app.save
      pets.each do |pet|
        ApplicationPet.create!(app_id: app.id, pet_id: pet.id)
        # require "pry"; binding.pry
        # pet.application_pending = true
        pet.update(application_pending: true)
      end
      redirect_to("/favorites")
    else
      # require "pry"; binding.pry
      flash[:notice] = "Application not submitted: Required information missing"
        redirect_to("/pets/#{Pet.last.id}/adopt")
    end
  end

  def index
    @app = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def show_apps
    @app = Pet.find(params[:id]).apps
  end

  def toggle_status
    pet = Pet.find(params[:id])
    pet.update(status: "pending")
    if pet.status == "pending"
      flash[:notice] = "Application approved"
      redirect_to("/pets/#{pet.id}")
    else
      flash[:notice] = "Application not approved"
    end
  end

  private
  def app_params
    params.permit!
    end
  end
