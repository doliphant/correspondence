class PostPolicy < ApplicationPolicy

  def update?
    user.present? && (record.user == user) &&
    (Time.now - record.created_at)/60 < 15
  end

  def edit?
    update?
  end

  def create?
    user.present? && user.in_correspondence?(record)
  end

  def new?
    create?
  end

end
