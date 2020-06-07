class UserService
  def initialize(user = nil)
    @current_user = user
  end

  def index
  end

  def show
  end

  def create(params)
    User.create(params)
  end

  def update
  end

  def delete
  end
end