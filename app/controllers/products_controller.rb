class ProductsController < ApplicationController
    before_action :require_active_user, except:[:search,:show]
    before_action :set_products, only: [:edit,:update,:show,:destroy]
    before_action :require_user, except: [:index,:show,:search]
    before_action :require_same_user, only: [:edit,:update,:destroy]

    def index
        @products = Product.paginate(page: params[:page],per_page:5)
    end
    def new
        @product = Product.new
        
    end
    def edit
       
    end
    def create
        
        @product = Product.new(product_params)
        @product.user = current_user
       if @product.save
          flash[:success] = "Product was successfully created"
          redirect_to product_path(@product)
       else
        render 'new'
       end
    end
    def update
        @product = Product.find(params[:id])
        
        if @product.update(product_params)
            flash[:success] = "This Product was updated"
            redirect_to product_path(@product)
        else
        render 'edit'
    end
    end
    def show
        

    end
    def search 
        if params[:search_param].blank?
            flash.now[:danger] = "You have entered an empty search String"
        else
      @products = Product.search(params[:search_param])      
    
    flash.now[:danger] = "No Items Match This Search Criteria" if @products.blank?
        end
   
            render partial: 'home/result'
            
    end
    def destroy
       
        @product.destroy
        flash[:danger] = "Product was Successfully Deleted"
        redirect_to products_path
    end
    def retrieved_item
        @product = Product.find(params[:id])
        @product.mark_as_retrieved
        if @product.retrieved?
        flash[:success] = "Item has been marked as retrieved"
        redirect_to product_path
        else
            flash[:danger] = "Item has'nt been marked as retrieved"
            redirect_to product_path
        end
          
    end
    private
   
    def set_products
        @product = Product.find(params[:id])
    end
    def product_params
        params.require(:product).permit(:name,:owner_name,:location,:details)
    end
    def require_same_user
        if current_user !=  @product.user and !current_user.admin
            flash[:danger] = "You can only edit or delete your own article"
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
