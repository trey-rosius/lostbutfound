class LocationsController < ApplicationController
    before_action :set_location, only: [:show,:edit,:update,:destroy]
    def index
        @locations = Location.paginate(page: params[:page],per_page:10)
        
    end
    def new
        @location = Location.new
        
    end

    def create
       
        @location = Location.new(location_params)

       if @location.save
          flash[:success] = "A new Location was successfully created"
          redirect_to location_path(@location)
       else
        render 'new'
       end
    
   
    end
    def edit
        
    
    end
    def update
     
      if @location.update(location_params)
        flash[:success] = "Location was Updated Successfully"
        redirect_to location_path(@location)
      else
        render 'edit'
      end
    end
    def show
        
        @location_users = @location.users.paginate(page: params[:page], per_page: 5)
    end
    def destroy
       
        @location.destroy
        flash[:danger] = "Location was Successfully Deleted"
        redirect_to locations_path
    end
    private
    def location_params
        params.require(:location).permit(:name)
    end
    def set_location
        @location= Location.find(params[:id])
    end
  
end
