<?php
use yii\helpers\Html;
/* @var $this yii\web\View */

$this->title = 'Товары';
?>

<h1 align="center">Товары</h1>

<br>
<p>	
	<a href="index.php?r=admin/create-goods"> <button class="bttn-unite bttn-md bttn-danger">Создать</button></a>        
    </p>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>#</th>
<th>Название</th>
<th>Цена</th>
<th>Действие</th>
</tr>
</thead>
<tbody>
<?php $i=1;
foreach ($goods as $key): 
?>
	    <tr>
            <th><?=$i?></th>
            <th><p><?= Html::encode ("{$key->goods_name}") ?></p> </th>
            <th><p><?= Html::encode ("{$key->goods_price}") ?></p> </th>
            <th>
            <a href="/yii2/web/index.php?r=admin%2Fupdate-goods&amp;id=<?=$key->goods_id?>" title="Update" aria-label="Update" data-pjax="0"><span class="glyphicon glyphicon-pencil"></span></a>
            <a href="/yii2/web/index.php?r=admin%2Fdelete-goods&amp;id=<?=$key->goods_id?>" title="Delete" aria-label="Delete" data-confirm="Are you sure you want to delete this item?" data-method="post" data-pjax="0"><span class="glyphicon glyphicon-trash"></span></a>
            </th>
        </tr>
<?php $i++;
 endforeach;
 ?>
</tbody>
</table>