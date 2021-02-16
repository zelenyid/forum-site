# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    admin_abilities if user.admin?
    moderator_abilities if user.moderator?
    authenticated_abilities(user.id) if user.user_role?

    anyone_abilities
  end

  private

  def anyone_abilities
    can :read, Topic
    can :read, Post
  end

  def admin_abilities
    can :manage, :all
  end

  def moderator_abilities
    can :manage, Post
    can :manage, Comment
  end

  def authenticated_abilities(user_id)
    can :create, Post
    can %i[update destroy], Post, user_id: user_id
    can :create, Comment
    can %i[update destroy], Comment, user_id: user_id
  end
end
