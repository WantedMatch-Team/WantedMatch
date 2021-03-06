class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :authorize, only: [:new, :create, :index]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user[:teams]=[]

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def profile

  end

  def remove_team1
    username=params['usname']
    @u=User.find(session[:user_id])
    @arr=@u[:teams]
    @arr.delete(username)
    @u[:teams]= @arr
    @u.save
    redirect_to User.find_by(usname: username)
  end
  def remove_team2
    username=params['usname']
    @u=User.find(session[:user_id])
    @arr=@u[:teams]
    @arr.delete(username)
    @u[:teams]= @arr
    @u.save
    redirect_to @u
  end
  def add_team
    username=params['usname']
    @u=User.find(session[:user_id])
    @arr=@u[:teams]
    if @arr.include?(username)
    else
      @arr.push(username)
    end
    @u[:teams]= @arr
    @u.save
    redirect_to User.find_by(usname: username)
  end

  def search
  end

  def searchtm

    Match.all.each do |element|
      #se il tempo è passato, il match viene cancellato
      if element[:date] < Date.today or (element[:date] == Date.today and element[:time].to_formatted_s(:time) <= Time.now.to_formatted_s(:time))
        element.destroy
      end
      if element[:team1]==nil
        element.destroy
      end
    end

    campo=params['campo']
    $arrt=[]
    $arrm=[]

    Team.all.sort_by{|e| e[:name]}.each do |element|
      if element[:name].include? campo
        $arrt.push(element)
      end
    end
    Match.all.sort_by{|e| e[:time]}.sort_by{|e| e[:date]}.each do |element|
      if element[:location].include? campo
        $arrm.push(element)
      end
    end

    redirect_to search_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end




    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:usname, :password, :password_confirmation, :email)
    end
end

#if params[:password].length<8
#  redirect_to login_url, alert: "Password too short (Minimum 8 chars)"
#end
