class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は英字と数字の両方を含んでください'}, if: -> {password.present? && password.length <= 129 } 

    validates :nickname, presence: {message: "を入力してください"}
    validates :last_name, presence: {message: "を入力してください"}
    validates :first_name, presence: {message: "を入力してください"}
    validates :last_name_kana, presence: {message: "を入力してください"}
    validates :first_name_kana, presence: {message: "を入力してください"}
    validates :birthday, presence: {message: "を入力してください"}
    
    validates :last_name, format: {with: /\A[あ-んア-ヶ一-龥々ー]+\z/, message: 'は全角かな/カナ・漢字で入力してください'}, if: -> {last_name.present?}
    validates :first_name, format: {with: /\A[あ-んア-ヶ一-龥々ー]+\z/, message: 'は全角かな/カナ・漢字で入力してください'}, if: -> {first_name.present?}
    validates :last_name_kana, format: {with: /\A[ア-ヶー]+\z/, message: 'は全角カタカナで入力してください'}, if: -> {last_name_kana.present?}
    validates :first_name_kana, format: {with: /\A[ア-ヶー]+\z/, message: 'は全角カタカナで入力してください'} , if: -> {first_name_kana.present?}

    has_many :items, dependent: :destroy
    has_many :purchases, dependent: :destroy
end
