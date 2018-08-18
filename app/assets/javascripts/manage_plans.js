$(document).on('turbolinks:load',function(){

  //contentsの画像
  var i = 1;
  $('.plan_topics').on('click', ".add_images_sub", function(e){
    e.preventDefault();
    i ++;
    $('.plan_topics').append(
      `<li class="plan_topic image_sub">
        <label for="plan_captured_images_attributes_${i}_captured_images">サブ(本文中)写真 ${i}</label>
        <input type="file" name="plan[captured_images_attributes][${i}][content]" id="plan_captured_images_attributes_${i}_content">
        <input value="2" type="hidden" name="plan[captured_images_attributes][${i}][order]" id="plan_captured_images_attributes_${i}_order">
        <input value="sub" type="hidden" name="plan[captured_images_attributes][${i}][status]" id="plan_captured_images_attributes_${i}_status">
        <div class="preview"></div>
        <button class="add_images_sub">追加</button>
        <button class="remove_images_sub">削除</button>
      </li>`);
  });

  $('.plan_topics').on('click', ".remove_images_sub", function(e){
    e.preventDefault();
    $(this).parent().remove();
  });

  //cardの画像
  var num = 1;
  $('.plan_topics').on('click', ".add_images_card", function(e){
    e.preventDefault();
    num ++;
    $('.plan_topics').append(
      `<li class="plan_topic image_card">
        <label for="plan_captured_images_attributes_${num}_captured_images">カード写真 ${num}</label>
        <input type="file" name="plan[captured_images_attributes][${num}][content]" id="plan_captured_images_attributes_${num}_content">
        <input value="3" type="hidden" name="plan[captured_images_attributes][${num}][order]" id="plan_captured_images_attributes_${num}_order">
        <input value="card" type="hidden" name="plan[captured_images_attributes][${num}][status]" id="plan_captured_images_attributes_${num}_status">
        <div class="preview"></div>
        <button class="add_images_card">追加</button>
        <button class="remove_images_card">削除</button>
      </li>`);
  });

  $('.plan_topics').on('click', ".remove_images_card", function(e){
    e.preventDefault();
    $(this).parent().remove();
  });

    //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('.plan_form').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0],
      reader = new FileReader(),
      $preview = $(this).siblings('.preview');
      t = this;
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }
    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
                  src: e.target.result,
                  width: "150px",
                  class: "preview",
                  title: file.name
              }));
      };
    })(file);
    reader.readAsDataURL(file);
  });

});
