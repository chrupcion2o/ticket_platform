# frozen_string_literal: true

require 'rails_helper'

describe FeaturesController do
  after(:all) do
    DatabaseCleaner.clean_with(:truncation, except: %w[ar_internal_metadata])
  end

  before(:all) do
    create(:event)
    create(:ticket)
    create(:ticket, :all_together)
  end

  describe 'GET /event_info' do
    context 'with correct event id' do
      let(:params) { { id: 1 } }

      it 'renders json with data' do
        get :event_info, params: params, as: :json

        expect(JSON.parse(response.body).keys).to include('name', 'date', 'info')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with incorrect event id' do
      let(:params) { { id: '-' } }

      it 'renders json with error' do
        get :event_info, params: params, as: :json

        expect(JSON.parse(response.body)).to have_key('error')
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET /event_tickets' do
    context 'with correct event id' do
      let(:params) { { id: 1 } }

      it 'renders json with data' do
        get :event_tickets, params: params, as: :json

        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq(2)
        expect(response_json[0]['ticket_type']).to eq('even')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with incorrect event id' do
      let(:params) { { id: '-' } }

      it 'renders json with error' do
        get :event_tickets, params: params, as: :json

        expect(JSON.parse(response.body)).to have_key('error')
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST /reserve_ticket' do
    context 'with correct data' do
      let(:params) { { ticket: { id: 1, quantity: 2 } } }

      it 'renders json with data' do
        expect { post :reserve_ticket, params: params, as: :json }.to change(Reservation, :count).by(1)

        response_json = JSON.parse(response.body)
        expect(response_json).to have_key('id')
        expect(response_json).to have_key('quantity')
        expect(response_json).to have_key('is_paid')
        expect(response_json).to have_key('ticket_id')

        expect(response).to have_http_status(:success)
      end
    end

    context 'with incorrect event id' do
      let(:params) { { ticket: { id: 1, quantity: 3 } } }

      it 'renders json with error' do
        expect { post :reserve_ticket, params: params, as: :json }.not_to change(Reservation, :count)

        expect(JSON.parse(response.body)).to have_key('error')
        expect(response).to have_http_status(400)
      end
    end
  end
end
