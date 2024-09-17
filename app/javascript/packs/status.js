/*global $*/
$(document).ready(function() {
  // SAとSBが変更されたときの処理
  $('select[id^="character_SA"], input[id^="character_SB"]').change(function() {
    // SAとSBの合計を計算
    for (var i = 1; i <= 10; i++) {
      var SA = parseInt($('select#character_SA' + i).val());
      var SB = parseInt($('input#character_SB' + i).val());

      // SAまたはSBがNaN（未入力）の場合は0として扱う
      SA = isNaN(SA) ? 0 : SA;
      SB = isNaN(SB) ? 0 : SB;

      // 列ごとの合計を計算
      var total = SA + SB;

      // 合計を表示するフィールドに反映
      $('input#character_total_' + i).val(total);
    }

    // character_total_2 と character_total_6 の計算結果を表示
    var total2 = parseInt($('input#character_total_2').val());
    var total6 = parseInt($('input#character_total_6').val());

    total2 = isNaN(total2) ? 0 : total2;
    total6 = isNaN(total6) ? 0 : total6;

    // total2とtotal6を足し算してから2で割る
    var result1 = (total2 + total6) / 2;

    // 増加分の値を取得して加算
    var increaseTotal2 = parseInt($('input#character_SB2').val());
    var increaseTotal6 = parseInt($('input#character_SB6').val());

    increaseTotal2 = isNaN(increaseTotal2) ? 0 : increaseTotal2;
    increaseTotal6 = isNaN(increaseTotal6) ? 0 : increaseTotal6;

    var finalResult1 = ((total2 + increaseTotal2) + (total6 + increaseTotal6)) / 2;
    $('#calc_result_1').text(finalResult1);

    // character_total_3 の値を表示
    var total3 = parseInt($('input#character_total_3').val());
    total3 = isNaN(total3) ? 0 : total3;

    // 増加分の値を取得して加算
    var increaseTotal3 = parseInt($('input#character_SB3').val());
    increaseTotal3 = isNaN(increaseTotal3) ? 0 : increaseTotal3;

    // character_SB10の値を取得
    var increaseTotal10 = parseInt($('input#character_SB10').val());
    increaseTotal10 = isNaN(increaseTotal10) ? 0 : increaseTotal10;

    // calc_result_2 の計算
    var finalResult2 = total3 + increaseTotal3;
    $('#calc_result_2').text(finalResult2);

    // calc_result_2 と character_SB10 の合計を character_total_10 に表示
    var total10 = finalResult2 + increaseTotal10;
    $('input#character_total_10').val(total10);

    // calc_result_1 と character_SB9 の合計を character_total_9 に表示
    var SB9 = parseInt($('input#character_SB9').val());
    SB9 = isNaN(SB9) ? 0 : SB9;

    var finalResult9 = finalResult1 + SB9;
    $('input#character_total_9').val(finalResult9);
  });
});
