require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
    it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      expect(@user).to be_valid
    end
  end
  context '新規登録できないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")    
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid. Input full-width characters.")    
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank","First name is invalid. Input full-width characters.")    
    end
    it 'last_name_kanaが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid. Input full-width characters.")    
    end
    it 'first_name_kanaが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid. Input full-width characters.")    
    end
    it 'birth_dateが空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")    
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが129文字以上では登録できない' do
      @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
    end
    it '英字のみのpasswordでは登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
    end
    it '数字のみのpasswordでは登録できない' do
      @user.password = '111111'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
    end
    it '全角文字を含むpasswordでは登録できない' do
      @user.password = 'ああああああ'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
    end
    it 'last_nameに半角文字が含まれていると登録できない' do
      @user.last_name = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.")    
    end
    it 'first_nameに半角文字が含まれていると登録できない' do
      @user.first_name = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")    
    end
    it 'last_name_kanaにカタカナ以外の文字（ひらがな・漢字・英数字・記号）が含まれていると登録できない' do
      @user.last_name = 'あ亜a1@'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.")    
    end
    it 'first_name_kanaにカタカナ以外の文字（ひらがな・漢字・英数字・記号）が含まれていると登録できない' do
      @user.first_name = 'あ亜a1@'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")    
    end
  end
  end
end