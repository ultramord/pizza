<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;
use yii\web\NotFoundHttpException;
use app\models\User;
use app\models\Goods;
use yii\base\Model;

class SiteController extends Controller
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * @inheritdoc
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
        $goods = Goods::find()->all();
        return $this->render('index',['goods' => $goods]);
    }

    /**
     * Login action.
     *
     * @return Response|string
     */
    //авторизация
    public function actionLogin()
    {
        $session = Yii::$app->session;
        $session->open();
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new User();
        if ($model->load(Yii::$app->request->post())) {

            $user = User::find()->where(['username' => $model->username,'password' => $model->password])->one();
            if($user)

            {                    
                Yii::$app->user->login($user);
                switch ($user->status) {
                    case '1':
                        $_SESSION['status']='admin';
                        break;
                    case '2':
                        $_SESSION['status']='operator';
                        break;
                    case '3':
                        $_SESSION['status']='carrier';
                        break;
                    case '4':
                        $_SESSION['status']='cook';
                        break;    
                }
                return $this->goBack();
            }
            else
            {
                $model->addError($attribute='password', 'Incorrect username or password.');
            }
        }
        return $this->render('login', [
            'model' => $model,
        ]);
    }

    /**
     * Logout action.
     *
     * @return Response
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    public function actionShoppingCart()
    {
        if(count($_SESSION['id'])){
            $allGoods = array();
            foreach($_SESSION['id'] as $id){
                $goods = Goods::find()->where(['goods_id' => $id])->one();
                $allGoods[] = $goods;
            }
            return $this->render('shoppingCart',['goods' => $allGoods]);
        }
        else{
            return $this->goBack();
        }
    }

    public function actionDeleteGoods($id){
        $key = array_search($id, $_SESSION['id']);
        unset($_SESSION['id'][$key]);
        return $this->redirect(['shopping-cart']);
    }

    public function actionCountGoods($id){
        #code...
    }

    public function actionChooseGoods(){
            $id = Yii::$app->request->post('goods_id');
            $_SESSION['id'][]=$id; 
            $_SESSION['id'] = array_unique($_SESSION['id']);
            return $this->goBack();
    }

    public function actionBookingCreate(){
        $model = new Booking();
        if (Yii::$app->request->isPost&&$model->load(Yii::$app->request->post()))
            {
                
                return $this->redirect(['index']);
            }
        return $this->render('create', ['model' => $model]);
    }
}
