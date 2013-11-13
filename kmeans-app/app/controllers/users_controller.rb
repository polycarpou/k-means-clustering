class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @clusters = Kmeans.new
    points = []
    @users.each do |user|
      points << [user.q1,user.q2,user.q3,user.q4,user.q5,user.q6,user.q7,user.q8,user.q9,user.q10]
    end
    #points = [[4,2,1,3],[4,3,2,2],[4,4,3,1],[1,2,4,4],[1,3,4,0],[1,1,0,0],[3,2,1,2],[3,4,2,1],[4,4,3,2],[0,0,4,4],[0,1,2,0]]
    @clusters = @clusters.cluster(3,points,10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @users = User.all
    @clusters = Kmeans.new
    points = []
    @users.each do |user|
      points << [user.q1,user.q2,user.q3,user.q4,user.q5,user.q6,user.q7,user.q8,user.q9,user.q10]
    end
    #points = [[4,2,1,3],[4,3,2,2],[4,4,3,1],[1,2,4,4],[1,3,4,0],[1,1,0,0],[3,2,1,2],[3,4,2,1],[4,4,3,2],[0,0,4,4],[0,1,2,0]]
    @clusters = @clusters.cluster(3,points,10)
    center = []
    @clusters.each do |k,v|
      if v.include?([@user.q1,@user.q2,@user.q3,@user.q4,@user.q5,@user.q6,@user.q7,@user.q8,@user.q9,@user.q10])
        center << k
      end
    end
    same_clustered_users = @clusters[center.first].map do |p|
      User.find_by(q1: p[0], q2: p[1], q3: p[2], q4: p[3], q5: p[4], q6: p[5], q7: p[6], q8: p[7], q9: p[8], q10: p[9])
    end
    s = same_clustered_users.compact.reject{|x| x.id.to_s  == params[:id]}
    @recommend = s.map{|x| x.random_field}
  # in_same_cluster = User.find(params[:id])
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
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10, :random_field)
    end
end
