import consumer from "./consumer"

// $(function() { ... }); で囲むことでレンダリング後に実行される
// レンダリング前に実行されると $('#messages').data('group_id') が取得できない
// turbolinks を使っている場合は $(document).on('turbolinks:load', function() { ... }); で囲うorturbolinksの設定を無効にする。
$(function(){
    console.log($('#messages').data('group_id'))
    const chatChannel = consumer.subscriptions.create({ channel: 'GroupChannel', group: $('#messages').data('group_id') }, {
      connected() {
      },

      disconnected() {
      },

      received: function(data) {
        // return $('#messages').append(data['message']);
        if (data['id']) { // 取得したデータがIDだったらという条件分岐で判断
          const id = '#' + data['id'];
          $(id).remove();
        } else {
           $('#messages').append(data['message']);
        }
      },
      
      // received: function(data) {
      //   // return $('#messages').append(data['message']);
      //   if (data['id']) { // 取得したデータがIDだったらという条件分岐で判断
      //     const id = '#' + data['id'];
      //     $(id).remove();
      //   } else {
      //       const show_user = $('#show_user').data('show_user');
      //     if (data['message_user'] == show_user) {
      //       $('#messages').append(data['message']);
      //       $('.message_box').animate({scrollTop: $('.message_box')[0].scrollHeight});
      //     } else {
      //       $('#messages').append(data['message']);
      //       $('.message_box').animate({scrollTop: $('.message_box')[0].scrollHeight});
      //     }
      //   }
      // },


      speak: function(message, group_id) {
        return this.perform('speak', {message: message});
      },

      destroy: function(id) {
        return this.perform('destroy', {id: id}); // perform関数で'destroy'というアクションを呼び出し、idをパラメータとして渡す
      }

    });

    $(document).on('keypress', '[data-behavior~=group_speaker]', function(event) {
      if (event.key === 'Enter') {
        chatChannel.speak(event.target.value);
        event.target.value = '';
        return event.preventDefault();
      }
    });

    $(document).on('click', '.delete-btn', function(event) {
      const id = $(this).data('id'); // ボタンのdata属性からidを取得
      chatChannel.destroy(id); // destroy関数にidを渡して呼び出す
    });
});
