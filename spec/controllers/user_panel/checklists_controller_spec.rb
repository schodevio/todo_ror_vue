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

          file = fixture_file_upload(
            Rails.root.join('spec/fixtures/sample_image.jpg'),
            'image/jpg'
          )

          params = {
            checklist: {
              name: 'Sample Checklist',
              thumbnail: file
            }
          }

          sign_in user

          action = lambda do
            post :create, params: params, as: :json
            user.reload
          end

          expect(&action)
            .to change(user.checklists, :count)
            .by(1)
            .and change(ActiveStorage::Attachment, :count)
            .by(1)

          expect(response).to have_http_status(:ok)
          expect(user.checklists.last.thumbnail).to be_attached
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
            checklist = create(:checklist, user: user, name: 'Old Checklist Name')

            file = fixture_file_upload(
              Rails.root.join('spec/fixtures/sample_image.jpg'),
              'image/jpg'
            )

            params = {
              id: checklist.id,
              checklist: {
                name: 'New Checklist Name',
                thumbnail: file
              }
            }

            sign_in user

            action = lambda do
              put :update, params: params, as: :json
              checklist.reload
            end

            expect(&action)
              .to change(checklist, :name)
              .to('New Checklist Name')
              .and change(checklist.thumbnail, :attached?)
              .to(true)

            expect(response).to have_http_status(:ok)
          end
        end

        context 'when invalid params' do
          it 'does not update checklist and responds with errors' do
            user = create(:user)
            checklist = create(:checklist, user: user, name: 'Old Checklist Name')

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

  describe '#export' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        get :export, params: { id: 1 }
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        get :export, params: { id: 1 }, as: :pdf
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when checklist exists' do
        it 'updates checklist' do
          user = create(:user)
          checklist = create(:checklist, user: user, name: 'Sample Name')

          sign_in user
          get :export, params: { id: checklist.id }, as: :pdf

          expect(response).to have_http_status(:ok)
          expect(response.body).to start_with('%PDF-1.4')
          expect(response.content_type).to eq('application/pdf')
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { get :export, params: { id: 1 } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)

          sign_in user
          action = -> { get :export, params: { id: checklist.id } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#send_email' do
    context 'when user not logged in' do
      it 'redirects to login view' do
        post :send_email, params: { id: 1 }
        expect(response).to redirect_to new_user_session_path
      end

      it 'responds with unauthorized' do
        post :send_email, params: { id: 1 }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user logged in' do
      context 'when valid params' do
        it 'enqueues UserPanel::ChecklistMailer#checklist_export' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          params = {
            id: checklist.id,
            checklist: {
              receiver_email: 'john@example.com'
            }
          }

          sign_in user
          action = -> { post :send_email, params: params, as: :json }

          expect(&action).to have_enqueued_mail(UserPanel::ChecklistMailer, :checklist_export)
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when invalid params' do
        it 'responds with errors' do
          user = create(:user)
          checklist = create(:checklist, user: user)

          params = {
            id: checklist.id,
            checklist: {
              receiver_email: ''
            }
          }

          sign_in user
          action = -> { post :send_email, params: params, as: :json }

          expect(&action).to not_have_enqueued_mail(UserPanel::ChecklistMailer, :checklist_export)
          expect(response).to have_http_status(:unprocessable_entity)

          expect(response.parsed_body['errors']['receiver_email'])
            .to contain_exactly("can't be blank")
        end
      end

      context 'when checklist is missing' do
        it 'raises RecordNotFound error' do
          user = create(:user)

          sign_in user
          action = -> { post :send_email, params: { id: 1 } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when checklist belongs to other user' do
        it 'raises RecordNotFound error' do
          user = create(:user)
          checklist = create(:checklist, :with_user)

          sign_in user
          action = -> { post :send_email, params: { id: checklist.id } }

          expect(&action).to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
