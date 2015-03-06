class PostPolicy < ApplicationPolicy

  #inheriting from application policy
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
    user.present? && (record.discussion.creator == user || record.discussion.participant == user)
  end

  def new?
    create?
  end

end
