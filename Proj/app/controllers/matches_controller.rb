class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  def show_match
    idmatch=params['idmatch']
    redirect_to Match.find(idmatch)
  end


  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def choose_team
    id=params['id']
    flash[:notice]="Choosen team"
    flash[:notice]=Team.find(id).name

  end

  def select_team
    idmatch=params['idmatch']
    idteam=params['idteam']
    @match=Match.find(idmatch)
    @match[:team2]=idteam
    @match.save
    redirect_to User.find(session[:user_id])
    flash[:notice]="Trovata squadra sfidante!"
    #aggiungere google calendar
  end

  def elimina_match
    idmatch=params['idmatch']
    Match.find(idmatch).destroy
    redirect_to User.find(session[:user_id])
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:location, :time, :tipo, :date, :team1, :team2)
    end
end
