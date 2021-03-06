class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    user_is_owner_of_record?
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def import?
    user_is_owner_of_record?
  end

end
