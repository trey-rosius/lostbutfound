class UsersController < ApplicationController
    before_action :require_active_user, except:[:index,:show]
      before_action :require_user, only:[:new,:create]
      before_action :set_user, only: [:edit,:update,:show]
      before_action :require_same_user, only: [:edit,:update,:destroy]
      before_action :require_admin, only: [:destroy]
      
      def index
        #  @users = current_user.except_current_user(@users)
        
        @users = User.paginate(page: params[:page],per_page: 8)
      
      end
      def new
        @user = User.new
      end
      def create
        @user = User.new(user_params)
        if @user.save
         # session[:user_id] = @user.id
          flash[:success] = "Successfully created An Account For #{@user.full_name}"
          redirect_to users_path(@user)
        else
          render 'new'
        end
    
      end
      def edit
        
    
      end
      def update
       
        if @user.update(user_params)
          flash[:success] = "Your Account was Updated Successfully"
          redirect_to user_path(@user)
        else
          render 'edit'
        end
      end
  
      def show
      
        @user_products = @user.products.paginate(page: params[:page], per_page: 5)
      end
      def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger]= "#{@user.full_name}'s account has been deleted"
        redirect_to users_path
        
      end
  
      def disabled
        @user = User.find(params[:id])
        @user.disable_user
        if !@user.active
          flash[:success] = "#{@user.full_name}'s account has been successfully activated"
          redirect_to users_path
          else
            flash[:success] = "#{@user.full_name}'s account has been successfully disabled"
            redirect_to users_path
        end
       
        
      end
      
      private
      def set_user
        @user = User.find(params[:id])
        
      end
      def user_params
        params.require(:user).permit(:first_name,:last_name,:email,:location,:password)
      end
      def require_same_user
        if current_user != @user and !current_user.admin
          flash[:danger] = "You can only edit your own account"
          redirect_to root_path
        end
      end
      def require_admin
        if !user_signed_in? 
          flash[:danger] ="Only admin users can perform that action"
          redirect_to root_path
        end
      end
      def require_active_user
        if current_user.active
            flash[:danger] = "Only Active Members Can Perform This Action"
            redirect_to root_path
        end
        
    end
  end
  