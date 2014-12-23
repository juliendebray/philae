class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  respond_to :js, only: [:detail]

  def detail
    @experience = Experience.find(params[:experience_id])
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
  end

  # GET /experiences/new
  def new
    @experience = Experience.new
    # 3.times { @experience.experience_pictures.build }
  end

  # GET /experiences/1/edit
  def edit
    @experience.experience_pictures.build
    # 3.times { @experience.experience_pictures.build }
  end

  # POST /experiences
  # POST /experiences.json
  def create
    @experience = Experience.new(experience_params)

    respond_to do |format|
      if @experience.save
        format.html { redirect_to new_experience_path, notice: 'Experience créée avec sucess. Merci pour votre contribution.' }
      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiences/1
  # PATCH/PUT /experiences/1.json
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:name, :address, :description, :category_id, experience_pictures_attributes: [:picture])
    end
end
