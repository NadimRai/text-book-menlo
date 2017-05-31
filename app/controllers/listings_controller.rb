class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  def seller
    @listings = Listing.where(user: current_user).order('created_at DESC')
  end
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.order('created_at DESC')
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    if @listing.reviews.blank?
      @average_review = 0
    else
      @average_review = @listing.reviews.average(:rating).round(2)
    end
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  # GET /listings/1/edit
  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.category_id = params[:category_id]

    Stripe.api_key = ENV['SECRET_KEY']
    token = params[:stripeToken]

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    @listing.category_id = params[:category_id]

    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image, :category_id)
    end

    def check_user
      if current_user != @listing.user
        redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
      end
    end

end
