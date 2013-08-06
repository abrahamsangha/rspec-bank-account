require "rspec"

require_relative "account"

describe Account do

  let(:account) { Account.new('9999999999') }


  describe "#initialize" do
    it 'creates an Account object' do
      expect(account).to eq(account)
    end

    it 'requires two parameters' do
      expect { Account.new }.to raise_error(ArgumentError)
    end

  end

  describe "#transactions" do
    it 'is an Array' do
      expect(account.transactions).to be_kind_of(Array)
    end
  end

  describe "#balance" do
    before { account.stub(:transactions).and_return([0, 1, 2]) }

    it "should return transaction total" do
      expect(account.balance).to eq 3
    end
  end

  describe "#account_number" do

    it 'should be 10 digits long' do
      account.stub(:acct_number).and_return('9999999999')
      expect(account.acct_number.length).to eq 10
    end

    it 'should be hidden' do
      expect(account.acct_number).to eq '******9999'
    end

  end

  describe "deposit!" do
    it 'returns NegativeDepositError if negative amount' do
      expect{ account.deposit!(-1) }.to raise_error NegativeDepositError
    end

    it 'should call add_transaction' do
      account.should_receive(:add_transaction).with(5)
      account.deposit!(5)
    end

    it 'should return balance' do
      account.stub(:balance).and_return(3)
      account.should_receive(:balance)
      expect(account.deposit!(5)).to eq 3
    end
  end

  describe "#withdraw!" do
    it 'should withdraw if the amount is positive' do
      account.stub(:transactions).and_return([5, 5, 5])

      expect(account.withdraw!(5)).to eq 10
    end

    it 'should withdraw absolute value if the amount is negative' do
      account.stub(:transactions).and_return([5, 5, 5])
      expect(account.withdraw!(-5)).to eq 10
    end

    it 'should call add_transaction' do
      account.should_receive(:add_transaction).with(5)
      account.deposit!(5)
    end
  end
end
