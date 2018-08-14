$(document).on('turbolinks:load',function(){
  var i = 1;
  $('.plan_topics').on('click', ".add_images", function(e){
    e.preventDefault();
    i ++;
    $('.plan_topics').append(
      `<li class="plan_topic image_sub">
        <label for="plan_captured_images_attributes_${i}_captured_images">サブ(本文中)写真 ${i}</label>
        <input type="file" name="plan[captured_images_attributes][${i}][content]" id="plan_captured_images_attributes_${i}_content">
        <input value="${i}" type="hidden" name="plan[captured_images_attributes][${i}][order]" id="plan_captured_images_attributes_${i}_order">
        <input value="sub" type="hidden" name="plan[captured_images_attributes][${i}][status]" id="plan_captured_images_attributes_${i}_status">
        <div class="preview"></div>
        <button class="add_images">追加</button>
        <button class="remove_images">削除</button>
      </li>`);
  });

  $('.plan_topics').on('click', ".remove_images", function(e){
    e.preventDefault();
    $(this).parent().remove();
  });
    //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('.plan_form').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0],
      reader = new FileReader(),
      // $preview = $(".preview");
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
