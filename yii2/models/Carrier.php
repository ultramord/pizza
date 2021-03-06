<?php

namespace app\models;

use Yii;

class Carrier extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['carrier_name', 'carrier_surname','user_id'], 'required'],
            [['carrier_id'], 'integer'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'carrier_name' => 'Имя',
            'carrier_surname' => 'Фамилия',
        ];
    }
    public function getBooking()
    {
        return $this->hasMany(Booking::className(), ['carrier_id' => 'user_id']);
    }  



}
