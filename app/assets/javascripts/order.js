// $(function(){

//   function showLoadingModal() {
//     $('#loadingModal').modal({
//       show: true,
//       keyboard: false,
//       backdrop: 'static'
//     });
//   }

//   function hideLoadingModal() {
//     $('#loadingModal').modal('hide');
//   }

//   let lastTouch = 0;
//   document.addEventListener('touchend', event => {
//     const now = window.performance.now();
//     if (now - lastTouch <= 500) {
//       event.preventDefault();
//     }
//     lastTouch = now;
//   }, true);

//   var course_selection_limit = {};

//   course_selection_limit['20180813194041-3d-B7ejTKOzUNSUiCYIvBH'] = 85;

//   var subtotal_data = {};

//   function count(course_id, value) {

//   console.log('course_id :', course_id, 'value :', value);

//     var count_input = $('#hidden_count_' + course_id);
//     var count = 0;
//     if (count_input.val() == '') {
//       count = parseInt(value);
//     } else {
//       count = parseInt(count_input.val()) + value;
//     }
//     if (count < 0) {
//       return ;
//     }

//   if (count > course_selection_limit[course_id]) {
//     alert('コース選択上限です。これ以上お申込みできません。');
//     return ;
//   }

//   //countの値を代入
//   count_input.val(count);
//   $('#count_' + course_id).html(count);

//   //minus_buttonの表示切り替え
//   var decrement_button = $('#count_button_decrement_' + course_id);
//   if (count == 0) {
//     decrement_button.attr('src', decrement_button.data('image-disabled'))
//   } else {
//     decrement_button.attr('src', decrement_button.data('image-enabled'))
//   }

//   // 小計
//   var subtotal = $('#subtotal_' + course_id);
//   var price = parseInt(subtotal.data('price').replace(/,/g, ''));
//   subtotal.html((price * count).toLocaleString() + ' 円');
//   subtotal_data[course_id] = (price * count);

//   // 合計
//   var sum = 0;
//   $.each(subtotal_data, function(course_id, subtotal) {
//   sum += parseInt(subtotal);
//   });
//   $('#sum').html(sum.toLocaleString() + ' 円');
//   $('#sum_sp').html(sum.toLocaleString());
//   }

//   function increment(course_id) {
//     count(course_id, 1)
//   }

//   function decrement(course_id) {
//     count(course_id, -1)
//   }

//   function toggleCollapse(course_id) {
//     var body = $('#accordion_body_' + course_id);
//     body.collapse('toggle');
//     $('#triangle_' + course_id).toggleClass('triangle_rotate');
//   }


//   $('#form').on('submit', function(){

//   console.log('FORM');

//     showLoadingModal();

//     var c = 0;
//     var course_id_list = [];
//     var course_count_list = [];

//     $(".order-counter").each(function(i, elem) {

//   console.log('i ;', i, 'elem ;', elem);

//       var id = $(elem).attr('id').replace('hidden_count_', '');
//       var count = 0;
//       if ($(elem).val() != '') {
//         count = parseInt($(elem).val());
//       }

//       course_id_list.push(id);
//       course_count_list.push(count);

//       c = c + count;
//       });

//     if (c == 0) {
//       hideLoadingModal();
//       alert('コースが選択されていません');
//       return false;
//     }

//     $('#course_id_list').val(course_id_list.join(''));
//     $('#course_count_list').val(course_count_list.join(''));

//     return true;
//   });

// });

