require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:ability_guest) { Ability.new(guest) }
  let(:ability_user) { Ability.new(user) }
  let(:ability_moderator) { Ability.new(moderator) }
  let(:ability_admin) { Ability.new(admin) }

  let(:guest) { nil }
  let(:user) { FactoryBot.create(:user, user_role: true) }
  let(:moderator) { FactoryBot.create(:user, moderator: true) }
  let(:admin) { FactoryBot.create(:user, admin: true) }

  let(:topic) do
    Topic.create!(
      title: 'A valid title',
      description: 'qwertyuioq'
    )
  end

  let(:post) do
    Post.new(
      title: 'qwert',
      body: 'Has a valid test body',
      user: user,
      topic: topic
    )
  end

  let(:comment) do
    Comment.new(
      body: 'hello',
      user: user,
      post: post
    )
  end

  context 'for topic' do
    context 'for guest' do
      subject { ability_guest }

      it { expect(ability_guest).to be_able_to(:read, topic) }
      it { expect(ability_guest).not_to be_able_to(:update, topic) }
      it { expect(ability_guest).not_to be_able_to(:destroy, topic) }
      it { expect(ability_guest).not_to be_able_to(:create, Topic) }
    end

    context 'for user' do
      subject { ability_user }

      it { expect(ability_user).to be_able_to(:read, topic) }
      it { expect(ability_user).not_to be_able_to(:update, topic) }
      it { expect(ability_user).not_to be_able_to(:destroy, topic) }
      it { expect(ability_user).not_to be_able_to(:create, Topic) }
    end

    context 'for moderator' do
      subject { ability_moderator }

      it { expect(ability_moderator).to be_able_to(:read, topic) }
      it { expect(ability_moderator).not_to be_able_to(:update, topic) }
      it { expect(ability_moderator).not_to be_able_to(:destroy, topic) }
      it { expect(ability_moderator).not_to be_able_to(:create, Topic) }
    end

    context 'for admin' do
      subject { ability_admin }

      it { expect(ability_admin).to be_able_to(:read, topic) }
      it { expect(ability_admin).to be_able_to(:update, topic) }
      it { expect(ability_admin).to be_able_to(:destroy, topic) }
      it { expect(ability_admin).to be_able_to(:create, Topic) }
    end
  end

  context 'for post' do
    context 'for guest' do
      subject { ability_guest }

      it { expect(ability_guest).to be_able_to(:read, post) }
      it { expect(ability_guest).not_to be_able_to(:update, post) }
      it { expect(ability_guest).not_to be_able_to(:destroy, post) }
      it { expect(ability_guest).not_to be_able_to(:create, Post) }
    end

    context 'for user' do
      subject { ability_user }

      it { expect(ability_user).to be_able_to(:read, post) }
      it { expect(ability_user).to be_able_to(:update, post) }
      it { expect(ability_user).to be_able_to(:destroy, post) }
      it { expect(ability_user).to be_able_to(:create, Post) }
    end

    context 'for moderator' do
      subject { ability_moderator }

      it { expect(ability_moderator).to be_able_to(:read, post) }
      it { expect(ability_moderator).to be_able_to(:update, post) }
      it { expect(ability_moderator).to be_able_to(:destroy, post) }
      it { expect(ability_moderator).to be_able_to(:create, Post) }
    end

    context 'for admin' do
      subject { ability_admin }

      it { expect(ability_admin).to be_able_to(:read, post) }
      it { expect(ability_admin).to be_able_to(:update, post) }
      it { expect(ability_admin).to be_able_to(:destroy, post) }
      it { expect(ability_admin).to be_able_to(:create, Post) }
    end
  end

  context 'for comments' do
    context 'for guest' do
      subject { ability_guest }

      it { expect(ability_guest).not_to be_able_to(:update, comment) }
      it { expect(ability_guest).not_to be_able_to(:destroy, comment) }
      it { expect(ability_guest).not_to be_able_to(:create, Comment) }
    end

    context 'for user' do
      subject { ability_user }

      it { expect(ability_user).to be_able_to(:update, comment) }
      it { expect(ability_user).to be_able_to(:destroy, comment) }
      it { expect(ability_user).to be_able_to(:create, Comment) }
    end

    context 'for moderator' do
      subject { ability_moderator }

      it { expect(ability_moderator).to be_able_to(:update, comment) }
      it { expect(ability_moderator).to be_able_to(:destroy, comment) }
      it { expect(ability_moderator).to be_able_to(:create, Comment) }
    end

    context 'for admin' do
      subject { ability_admin }

      it { expect(ability_admin).to be_able_to(:update, comment) }
      it { expect(ability_admin).to be_able_to(:destroy, comment) }
      it { expect(ability_admin).to be_able_to(:create, Comment) }
    end
  end
end
