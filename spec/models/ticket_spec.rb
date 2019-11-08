# frozen_string_literal: true

require 'rails_helper'

describe Ticket do
  let(:event) { build(:event) }
  let(:ticket_type) { 'even' }
  subject { build(:ticket, event: event, ticket_type: ticket_type) }

  describe '.valid?' do
    context 'when valid data' do
      it 'returns true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when invalid ticket type' do
      let(:ticket_type) { 'not a valid ticket type' }
      it 'returns false' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.messages).to eq(ticket_type: ["is not included in the list"])
      end
    end

    context 'when invalid quantity' do
      it 'returns false' do
        invalid_ticket = build(:ticket, quantity: -1, event: event)
        expect(invalid_ticket.valid?).to eq(false)
        expect(invalid_ticket.errors.messages).to eq(quantity: ["must be greater than or equal to 0"])
      end
    end
  end

  describe '.allow_reservation?' do
    context 'even ticket type' do
      it 'returns true when correct quantity' do
        expect(subject.allow_reservation?(10)).to eq(true)
      end

      it 'returns false when quantity is odd' do
        expect(subject.allow_reservation?(9)).to eq(false)
      end

      it 'returns false when quantity is greater than ticket count' do
        expect(subject.allow_reservation?(10_000_000)).to eq(false)
      end
    end

    context 'all_together ticket type' do
      let(:ticket_type) { 'all_together' }

      it 'returns true when correct quantity' do
        expect(subject.allow_reservation?(subject.quantity)).to eq(true)
      end

      it 'returns false when requested quantity is greater or lower than ticket quantity' do
        expect(subject.allow_reservation?(10)).to eq(false)
        expect(subject.allow_reservation?(2000)).to eq(false)
      end
    end

    context 'avoid_one ticket type' do
      let(:ticket_type) { 'avoid_one' }

      it 'returns true when correct quantity' do
        expect(subject.allow_reservation?(subject.quantity)).to eq(true)
        expect(subject.allow_reservation?(subject.quantity - 2)).to eq(true)
      end

      it 'returns false when requested quantity is greater or lower than ticket quantity' do
        expect(subject.allow_reservation?(subject.quantity - 1)).to eq(false)
        expect(subject.allow_reservation?(10_000_000)).to eq(false)
      end
    end
  end
end
