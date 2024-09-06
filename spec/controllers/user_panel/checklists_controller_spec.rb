# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPanel::ChecklistsController, type: :controller do
  describe '#index' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        get :index, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when html format' do
        it 'renders index html view' do
          user = create(:user)

          checklist1, checklist2 = create_list(:checklist, 2, user: user)
          create(:checklist, :with_user)

          sign_in user
          get :index

          expect(response).to have_http_status(:ok)
          expect(assigns(:checklists)).to contain_exactly(checklist1, checklist2)
        end
      end

      context 'when json format' do
        it 'renders index json view' do
          user = create(:user)

          checklist1, checklist2 = create_list(:checklist, 2, user: user)
          create(:checklist, :with_user)

          sign_in user
          get :index, as: :json

          expect(response).to have_http_status(:ok)

          expect(response.parsed_body['checklists'].pluck('id'))
            .to contain_exactly(checklist1.id, checklist2.id)
        end
      end
    end
  end

  describe '#show' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        get :show, params: { id: 1 }
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        get :show, params: { id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when html format' do
        it 'renders index html view' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          sign_in user
          get :show, params: { id: checklist.id }

          expect(response).to have_http_status(:ok)
          expect(assigns(:checklist)).to eq(checklist)
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { get :show, params: { id: 1 } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)

          sign_in user
          action = -> { get :show, params: { id: checklist.id } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#create' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        post :create, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when valid params' do
        it 'creates checklist' do
          user = create(:user)

          params = {
            checklist: {
              name: 'Sample Checklist'
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            user.reload
          end

          expect(&action).to change(user.checklists, :count).by(1)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when invalid params' do
        it 'does not create checklist and responds with errors' do
          user = create(:user)

          params = {
            checklist: {
              name: ''
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            user.reload
          end

          expect(&action).to not_change(user.checklists, :count)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body['errors']['name']).to contain_exactly("can't be blank")
        end
      end
    end
  end

  describe '#update' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        put :update, params: { id: 1 }
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        put :update, params: { id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when checklist exists' do
        context 'when valid params' do
          it 'updates checklist' do
            user = create(:user)
            checklist = create(:checklist, user: user, name: 'Old Name')

            params = {
              id: checklist.id,
              checklist: {
                name: 'New Name'
              }
            }

            sign_in user

            action = lambda do
              put :update, params: params, as: :json
              checklist.reload
            end

            expect(&action).to change(checklist, :name).to('New Name')
            expect(response).to have_http_status(:ok)
          end
        end

        context 'when invalid params' do
          it 'does not update checklist and responds with errors' do
            user = create(:user)
            checklist = create(:checklist, user: user, name: 'Old Name')

            params = {
              id: checklist.id,
              checklist: {
                name: ''
              }
            }

            sign_in user

            action = lambda do
              put :update, params: params, as: :json
              checklist.reload
            end

            expect(&action).to not_change(checklist, :name)
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body['errors']['name']).to contain_exactly("can't be blank")
          end
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { put :update, params: { id: 1 } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)

          sign_in user
          action = -> { put :update, params: { id: checklist.id } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#destroy' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        delete :destroy, params: { id: 1 }
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        delete :destroy, params: { id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when checklist exists' do
        it 'deletes checklist' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          sign_in user

          action = lambda do
            delete :destroy, params: { id: checklist.id }, as: :json
            user.reload
          end

          expect(&action).to change(user.checklists, :count).by(-1)
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { delete :destroy, params: { id: 1 } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)

          sign_in user
          action = -> { delete :destroy, params: { id: checklist.id } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
