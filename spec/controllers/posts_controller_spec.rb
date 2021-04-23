require 'rails_helper'

RSpec.describe PostsController, type: :controller do
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

  describe 'GET #show' do
    let(:topic_post) { Post.new(valid_post_params.merge({ user: admin_user, topic: topic })) }

    before(:each) do
      topic_post.save
    end

    it 'admin role returns a success response' do
      login admin_user

      get :show, params: { id: topic_post.id, topic_id: topic_post.topic_id }

      expect(response).to be_successful
    end

    it 'moderator returns a success response' do
      login moderator_user

      get :show, params: { id: topic_post.id, topic_id: topic_post.topic_id }

      expect(response).to be_successful
    end

    it 'user role returns a success response' do
      login user

      get :show, params: { id: topic_post.id, topic_id: topic_post.topic_id }

      expect(response).to be_successful
    end

    it 'guest role returns a success response' do
      get :show, params: { id: topic_post.id, topic_id: topic_post.topic_id }

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'admin role redirect to another page response' do
      login admin_user

      post :create, params: { topic_id: topic.id, post: valid_post_params }

      expect(Post.first.title).to eq(valid_post_params[:title])
      expect(Post.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'moderator role redirect to another page response' do
      login moderator_user

      post :create, params: { topic_id: topic.id, post: valid_post_params }

      expect(Post.first.title).to eq(valid_post_params[:title])
      expect(Post.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'user role redirect to another page response' do
      login user

      post :create, params: { topic_id: topic.id, post: valid_post_params }

      expect(Post.first.title).to eq(valid_post_params[:title])
      expect(Post.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'guest role page not found' do
      post :create, params: { topic_id: topic.id, post: valid_post_params }

      expect(response.code).to eq('404')
    end
  end

  describe 'PUT #update' do
    let(:topic_post) { Post.new(valid_post_params.merge({ user: admin_user, topic: topic })) }

    before(:each) do
      topic_post.save
    end

    it 'admin role redirect to another page response' do
      login admin_user

      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      put :update, params: { id: topic_post.id, topic_id: topic.id, post: valid_post_params }

      expect(Post.first.title).to eq(valid_post_params[:title])
      expect(Post.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'moderator role redirect to another page response' do
      login moderator_user

      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      put :update, params: { id: topic_post.id, topic_id: topic.id, post: valid_post_params }

      expect(Post.first.title).to eq(valid_post_params[:title])
      expect(Post.first.body).to eq(valid_post_params[:body])

      expect(response.code).to eq('302')
    end

    it 'user role page not found' do
      login user

      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      put :update, params: { id: topic_post.id, topic_id: topic.id, post: valid_post_params }

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      put :update, params: { id: topic_post.id, topic_id: topic.id, post: valid_post_params }

      expect(response.code).to eq('404')
    end
  end

  describe 'DELETE #destroy' do
    let(:topic_post) { Post.new(valid_post_params.merge({ user: admin_user, topic: topic })) }

    before(:each) do
      topic_post.save
    end

    it 'admin role redirect to another page response' do
      login admin_user

      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      delete :destroy, params: { id: topic_post.id, topic_id: topic.id }

      expect { Post.find(topic_post.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.code).to eq('302')
    end

    it 'moderator role edirect to another page response' do
      login moderator_user

      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      delete :destroy, params: { id: topic_post.id, topic_id: topic.id }

      expect { Post.find(topic_post.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response.code).to eq('302')
    end

    it 'user role page not found' do
      login user

      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      delete :destroy, params: { id: topic_post.id, topic_id: topic.id }

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      expect(response.code).to eq('404')
    end

    it 'guest role page not found' do
      expect(Post.first.title).to eq(topic_post.title)
      expect(Post.first.body).to eq(topic_post.body)

      delete :destroy, params: { id: topic_post.id, topic_id: topic.id }

      expect(Topic.first.title).to eq(topic.title)
      expect(Topic.first.description).to eq(topic.description)

      expect(response.code).to eq('404')
    end
  end
end
