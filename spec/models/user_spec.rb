require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全てのフォームに適切な値が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字のフリガナを入力してください")
      end

      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のフリガナを入力してください")
      end

      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it "passwordに改行が含まれていては登録できない" do
        @user.password = 'abc 123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含んでください")
      end

      it "passwordに全角が含まれていては登録できない" do
        @user.password = 'abc１２３'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含んでください")
      end

      it "passwordに記号が含まれていては登録できない" do
        @user.password = 'abc-123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含んでください")
      end

      it "passwordに数字が含まれていなければ登録できない" do
        @user.password = 'abcefg'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含んでください")
      end

      it "passwordに英字が含まれていなければ登録できない" do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含んでください")
      end

      it "passwordが5文字以下では登録できない" do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end

      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      
      it 'last_nameが半角文字を含む場合無効であること' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角かな/カナ・漢字で入力してください')
      end

      it 'first_nameが半角文字を含む場合無効であること' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角かな/カナ・漢字で入力してください')
      end

      it 'last_nameが数字を含む場合無効であること' do
        @user.last_name = '山田123'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角かな/カナ・漢字で入力してください')
      end

      it 'first_nameが数字を含む場合無効であること' do
        @user.first_name = '太郎123'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角かな/カナ・漢字で入力してください')
      end

      it 'last_name_kanaがひらがなを含む場合無効であること' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字のフリガナは全角カタカナで入力してください')
      end

      it 'first_name_kanaがひらがなを含む場合無効であること' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のフリガナは全角カタカナで入力してください')
      end

      it 'last_name_kanaが漢字を含む場合無効であること' do
        @user.last_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字のフリガナは全角カタカナで入力してください')
      end

      it 'first_name_kanaが漢字を含む場合無効であること' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のフリガナは全角カタカナで入力してください')
      end

      it 'last_name_kanaが半角カタカナを含む場合無効であること' do
        @user.last_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字のフリガナは全角カタカナで入力してください')
      end

      it 'first_name_kanaが半角カタカナを含む場合無効であること' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のフリガナは全角カタカナで入力してください')
      end
    end
  end
end
