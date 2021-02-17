require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:current_user) do
    User.create!(
      name: 'current_user',
      email: 'currentuser@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

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
      user: current_user,
      topic: topic
    )
  end

  it 'has a body' do
    comment = Comment.new(
      body: '',
      user: current_user,
      post: post
    )

    expect(comment).to_not be_valid

    comment.body = 'hello'
    expect(comment).to be_valid
  end

  it 'has an opportunity to get id of user, who created' do
    comment = Comment.new(
      body: 'hello',
      user: current_user,
      post: post
    )

    expect(comment.user_id).to eq(current_user.id)
  end

  it 'has an opportunity to get post id of this post' do
    comment = Comment.new(
      body: 'hello',
      user: current_user,
      post: post
    )

    expect(comment.post_id).to eq(post.id)
  end

  it 'has an opportunity to get topic id of the post' do
    comment = Comment.new(
      body: 'hello',
      user: current_user,
      post: post
    )

    expect(comment.post.topic_id).to eq(topic.id)
  end
end
