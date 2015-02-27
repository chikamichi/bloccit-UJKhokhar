class ApplicationPolicy
  attr_reader :user, :record

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # The default scope simply resolves to all records.
    def resolve
      scope.all
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    record_exists?
  end

  def create?
    user_exists?
  end

  def new?
    create?
  end

  def update?
    record_owned_by_user? || user_is?('admin')
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    record.class
  end

  # --------------------------- Utility methods --------------------------------

  # Checks whether the record exists.
  def record_exists?
    scope.where(:id => record.id).exists?
  end

  # Checks whether the record is owned by the user.
  #
  # If the record is not owned by a user, returns false.
  def record_owned_by_user?
    return false if record.user.nil?
    return false unless user_exists?
    record.user == user
  end

  # Checks whether the user is available.
  def user_exists?
    user.present?
  end

  # Checks wether the user has some specific role.
  #
  # The user *must* have a role from the provided whitelist.
  def user_is?(*roles)
    user_exists? && roles.any? { |role| user.send(:"#{role}?") }
  end
end

