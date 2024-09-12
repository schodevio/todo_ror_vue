# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::Checklists::TasksController, type: :controller do
  describe '#index' do
    context 'when user not logged in' do
      it 'responds with unauthorized' do
        get :index, params: { checklist_id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when json format' do
        it 'renders index json view' do
          user = create(:user)
          checklist = create(:checklist, user: user)
          task1, task2 = create_list(:task, 2, checklist: checklist)

          create(:task, :with_checklist)

          sign_in user
          get :index, params: { checklist_id: checklist.id }, as: :json

          expect(response).to have_http_status(:ok)
          expect(response.parsed_body['tasks'].pluck('id')).to contain_exactly(task1.id, task2.id)
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { get :index, params: { checklist_id: 1 }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          checklist = create(:checklist, :with_user)
          create_list(:task, 2, checklist: checklist)

          sign_in user
          action = -> { get :index, params: { checklist_id: checklist.id }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#create' do
    context 'when user not logged in' do
      it 'responds with unauthorized' do
        post :create, params: { checklist_id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when valid params' do
        it 'creates checklist' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          params = {
            checklist_id: checklist.id,
            task: {
              name: 'Sample Task'
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            checklist.reload
          end

          expect(&action).to change(checklist.tasks, :count).by(1)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when invalid params' do
        it 'does not create task and responds with errors' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          params = {
            checklist_id: checklist.id,
            task: {
              name: ''
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            checklist.reload
          end

          expect(&action).to not_change(checklist.tasks, :count)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body['errors']['name']).to contain_exactly("can't be blank")
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { post :create, params: { checklist_id: 1 }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)

          sign_in user
          action = -> { post :create, params: { checklist_id: checklist.id }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#update' do
    context 'when user not logged in' do
      it 'responds with unauthorized' do
        put :update, params: { checklist_id: 1, id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when valid params' do
        it 'updates task' do
          user = create(:user)
          checklist = create(:checklist, user: user)
          task = create(:task, checklist: checklist, name: 'Old Task Name')

          params = {
            checklist_id: checklist.id,
            id: task.id,
            task: {
              name: 'New Task Name'
            }
          }

          sign_in user

          action = lambda do
            put :update, params: params, as: :json
            task.reload
          end

          expect(&action).to change(task, :name).to('New Task Name')
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when invalid params' do
        it 'does not update task and responds with errors' do
          user = create(:user)
          checklist = create(:checklist, user: user)
          task = create(:task, checklist: checklist, name: 'Old Task Name')

          params = {
            checklist_id: checklist.id,
            id: task.id,
            task: {
              name: ''
            }
          }

          sign_in user

          action = lambda do
            put :update, params: params, as: :json
            task.reload
          end

          expect(&action).to not_change(task, :name)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body['errors']['name']).to contain_exactly("can't be blank")
        end
      end

      context 'when task is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          sign_in user
          action = -> { put :update, params: { checklist_id: checklist.id, id: 1 }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { put :update, params: { checklist_id: 1, id: 1 }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist and task belong to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          checklist = create(:checklist, :with_user)
          task = create(:task, checklist: checklist)

          params = {
            checklist_id: checklist.id,
            id: task.id
          }

          sign_in user
          action = -> { put :update, params: params, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#destroy' do
    context 'when user not logged in' do
      it 'responds with unauthorized' do
        delete :destroy, params: { checklist_id: 1, id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when task exists' do
        it 'deletes task' do
          user = create(:user)
          checklist = create(:checklist, user: user)
          task = create(:task, checklist: checklist)

          sign_in user

          action = lambda do
            delete :destroy, params: { checklist_id: checklist.id, id: task.id }, as: :json
            checklist.reload
          end

          expect(&action).to change(checklist.tasks, :count).by(-1)
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when task is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          sign_in user
          action = -> { delete :destroy, params: { checklist_id: checklist.id, id: 1 }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { delete :destroy, params: { checklist_id: 1, id: 1 }, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist and task belong to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)
          task = create(:task, checklist: checklist)

          params = {
            checklist_id: checklist.id,
            id: task.id
          }

          sign_in user
          action = -> { delete :destroy, params: params, as: :json }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
