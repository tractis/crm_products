class Admin::ProductsController < Admin::ApplicationController
  before_filter :set_current_tab
  before_filter :auto_complete, :only => :auto_complete

  # GET /admin/products
  # GET /admin/products.xml                                                   HTML
  #----------------------------------------------------------------------------
  def index
    @products = get_products
    
    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @products }
    end
  end

  # GET /admin/products/new
  # GET /admin/products/new.xml                                               AJAX
  #----------------------------------------------------------------------------
  def new
    @product = Product.new()
    
    respond_to do |format|
      format.js   # new.js.rjs
      format.xml  { render :xml => @product }
    end
  end

  # GET /admin/products/1/edit                                                AJAX
  #----------------------------------------------------------------------------
  def edit
    @product = Product.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = Product.find($1)
    end

  rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @product
  end

  # POST /admin/products
  # POST /admin/products.xml                                                  AJAX
  #----------------------------------------------------------------------------
  def create
    @product = Product.new(params[:product])
    
    respond_to do |format|
      if @product.save
        @products = Product.find(:all)
        format.js   # create.js.rjs
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.js   # create.js.rjs
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/products/1
  # PUT /admin/products/1.xml                                                 AJAX
  #----------------------------------------------------------------------------
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.js   # update.js.rjs
        format.xml  { head :ok }
      else
        format.js   # update.js.rjs
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # GET /admin/products/1/confirm                                             AJAX
  #----------------------------------------------------------------------------
  def confirm
    @product = Product.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.xml                                              AJAX
  #----------------------------------------------------------------------------
  def destroy
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.destroy
        format.js   # destroy.js.rjs
        format.xml  { head :ok }
      else
        flash[:warning] = t(:msg_cant_delete_product, @product.name)
        format.js   # destroy.js.rjs
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  #----------------------------------------------------------------------------
  def get_products
    Product.find(:all)
  end
  
end