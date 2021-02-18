require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:admin_user) { create(:user, admin: true) }
  let(:moderator_user) { create(:user, moderator: true) }
  let(:user) { create(:user, user_role: true) }
  let(:guest) { nil }

  let(:topic) { create(:topic) }

  let(:valid_post_params) do
    {
      title: 'qwerty',
      body: 'qwertyuq qwerty qwert'
    }
  end

  let(:topic_post) { Post.new(valid_post_params.merge({ user: admin_user, topic: topic })) }

  let(:valid_comment_params) do
    {
      body: 'qwertyuq qwerty qwert'
    }
  end

  describe 'POST #create' do
    before(:each) do
      topic_post.save
    end

    it 'admin role redirect to another page response' do
      login admin_user

      post :create, params: { topic_id: topic.id, post_id: topic_post.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(valid_comment_params[:body])

      expect(response.code).to eq('302')
    end

    it 'moderator role redirect to another page response' do
      login moderator_user

      post :create, params: { topic_id: topic.id, post_id: topic_post.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(valid_comment_params[:body])

      expect(response.code).to eq('302')
    end

    it 'user role redirect to another page response' do
      login user

      post :create, params: { topic_id: topic.id, post_id: topic_post.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(valid_comment_params[:body])

      expect(response.code).to eq('302')
    end

    it 'guest role page not found' do
      post :create, params: { topic_id: topic.id, post_id: topic_post.id, comment: valid_comment_params }

      expect(response.code).to eq('404')
    end
  end

  describe 'PUT #update' do
    let(:comment) do
      Comment.new(valid_comment_params.merge({ user: admin_user, post: topic_post }))
    end

    before(:each) do
      topic_post.save
      comment.save
    end

    it 'admin role redirect to another page response' do
      login admin_user

      expect(Comment.first.body).to eq(comment.body)

      put :update, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'moderator role redirect to another page response' do
      login moderator_user

      expect(Comment.first.body).to eq(comment.body)

      put :update, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'user role page not found' do
      login user

      expect(Comment.first.body).to eq(comment.body)

      put :update, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(comment.body)

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      expect(Comment.first.body).to eq(comment.body)

      put :update, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id, comment: valid_comment_params }

      expect(Comment.first.body).to eq(comment.body)

      expect(response.code).to eq('404')
    end
  end

  describe 'DELETE #destroy' do
    let(:comment) do
      Comment.new(valid_comment_params.merge({ user: admin_user, post: topic_post }))
    end

    before(:each) do
      topic_post.save
      comment.save
    end

    it 'admin role redirect to another page response' do
      login admin_user

      expect(Comment.first.body).to eq(comment.body)

      delete :destroy, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id }

      expect { Comment.find(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.code).to eq('302')
    end

    it 'moderator role edirect to another page response' do
      login moderator_user

      expect(Comment.first.body).to eq(comment.body)

      delete :destroy, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id }

      expect { Comment.find(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.code).to eq('302')
    end

    it 'user role page not found' do
      login user

      expect(Comment.first.body).to eq(comment.body)

      delete :destroy, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id }

      expect(Comment.first.body).to eq(comment.body)

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      expect(Comment.first.body).to eq(comment.body)

      delete :destroy, params: { post_id: topic_post.id, topic_id: topic.id, id: comment.id }

      expect(Comment.first.body).to eq(comment.body)

      expect(response.code).to eq('404')
    end
  end
end
