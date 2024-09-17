/*global $*/
$(document).ready(function() {
  // 共通の関数として計算処理を定義
  function updateTotals() {
    // SAとSBの合計を計算
    for (var i = 1; i <= 10; i++) {
      var SA = parseInt($('select#character_SA' + i).val());
      var SB = parseInt($('input#character_SB' + i).val());

      SA = isNaN(SA) ? 0 : SA;
      SB = isNaN(SB) ? 0 : SB;

      var total = SA + SB;
      $('input#character_total_' + i).val(total);
    }

    // character_total_2 と character_total_6 の計算
    var total2 = parseInt($('input#character_total_2').val()) || 0;
    var total6 = parseInt($('input#character_total_6').val()) || 0;
    var finalResult1 = (total2 + total6) / 2;

    var increaseTotal2 = parseInt($('input#character_SB2').val()) || 0;
    var increaseTotal6 = parseInt($('input#character_SB6').val()) || 0;

    finalResult1 = ((total2 + increaseTotal2) + (total6 + increaseTotal6)) / 2;
    $('#calc_result_1').text(finalResult1);

    // character_total_3 の計算
    var total3 = parseInt($('input#character_total_3').val()) || 0;
    var increaseTotal3 = parseInt($('input#character_SB3').val()) || 0;
    var finalResult2 = total3 + increaseTotal3;
    $('#calc_result_2').text(finalResult2);

    // calc_result_2 と character_SB10 の合計を character_total_10 に表示
    var increaseTotal10 = parseInt($('input#character_SB10').val()) || 0;
    var total10 = finalResult2 + increaseTotal10;
    $('input#character_total_10').val(total10);

    // calc_result_1 と character_SB9 の合計を character_total_9 に表示
    var SB9 = parseInt($('input#character_SB9').val()) || 0;
    var finalResult9 = finalResult1 + SB9;
    $('input#character_total_9').val(finalResult9);

    // 新しい処理の追加: 表示エリアに値を設定
    var total1 = parseInt($('input#character_total_1').val()) || 0;
    var total7 = parseInt($('input#character_total_7').val()) || 0;
    var total8 = parseInt($('input#character_total_8').val()) || 0;

    // total3 * 5 を初期正気度 (初期値を表示)
    var resultInitialSanity = total3 * 5;
    $('#initial_sanity').text(resultInitialSanity); // 初期正気度は常に total3 * 5

    // その他のフィールドの更新
    var resultIdea = total7 * 5;
    $('#idea').text(resultIdea); // アイデア

    var resultKnowledge = total8 * 5;
    $('#knowledge').text(resultKnowledge); // 知識

    // total1 + total6 を使って条件に基づくDBを表示
    var dbTotal = total1 + total6;
    var dbResult = '';
    if (dbTotal >= 2 && dbTotal <= 12) {
      dbResult = '-1D6';
    } else if (dbTotal >= 13 && dbTotal <= 16) {
      dbResult = '-1D4';
    } else if (dbTotal >= 17 && dbTotal <= 24) {
      dbResult = '+0';
    } else if (dbTotal >= 25 && dbTotal <= 32) {
      dbResult = '+1D4';
    } else if (dbTotal >= 33 && dbTotal <= 40) {
      dbResult = '+1D6';
    }
    $('#db').text(dbResult); // DB
  }

  // 初期ロード時に計算を実行
  updateTotals();

  // SAとSBが変更されたときに再計算
  $('select[id^="character_SA"], input[id^="character_SB"]').change(function() {
    updateTotals();
  });

  // sanity_form に値が手動で変更された場合
  $('#sanity_form').on('input', function() {
    // 正気度フォームの値はユーザーが自由に変更可能
  });
});
