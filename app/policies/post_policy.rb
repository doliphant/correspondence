class PostPolicy < ApplicationPolicy

  #inheriting from application policy:
  #show?
  #

  def update?
    user.present? && (record.user == user) &&
    (Time.now - record.created_at)/60 < 5
  end

  def edit?
    update?
  end

  def create?
    user.present? && user.in_discussion?(record)
  end

  def new?
    create?
  end

end
