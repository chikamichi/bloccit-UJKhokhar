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
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user || user.admin?)
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
end

