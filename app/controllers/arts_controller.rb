class ArtsController < ApplicationController
  before_action :set_art, only: %i[ show edit update destroy ]

  def index
    @arts = Art.all.order('created_at DESC')
    @pagy, @arts = pagy(@arts)
    if params[:query].present?
      @arts = Art.where("name LIKE ?", "%#{params[:query]}%")
    end

    if turbo_frame_request?
      render partial: "arts",
      locals: { arts: @arts }
    else
      render :index
    end

  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  def show
  end

  def new
    @art = Art.new
  end

  def edit
  end

  def create
    @art = Art.new(art_params)

    respond_to do |format|
      if @art.save
        format.html { redirect_to @art, notice: "Art was successfully created." }
        format.json { render :show, status: :created, location: @art }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @art.update(art_params)
        format.html { redirect_to @art, notice: "Art was successfully updated." }
        format.json { render :show, status: :ok, location: @art }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @art.destroy!

    respond_to do |format|
      format.html { redirect_to arts_path, status: :see_other, notice: "Art was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_art
      @art = Art.find(params.expect(:id))
    end

    def art_params
      params.expect(art: [ :name ])
    end
end
