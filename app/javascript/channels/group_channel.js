import consumer from "./consumer"

// $(function() { ... }); で囲むことでレンダリング後に実行される
// レンダリング前に実行されると $('#messages').data('group_id') が取得できない
// turbolinks を使っている場合は $(document).on('turbolinks:load', function() { ... }); で囲うorturbolinksの設定を無効にする。
$(function(){
    console.log($('#messages').data('group_id'))
    const chatChannel = consumer.subscriptions.create({ channel: 'GroupChannel', group: $('#messages').data('group_id') }, {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received: function(data) {
        return $('#messages').append(data['message']);
      },

      speak: function(message, group_id) {
        return this.perform('speak', {message: message});
      }

    });

    $(document).on('keypress', '[data-behavior~=group_speaker]', function(event) {
      if (event.key === 'Enter') {
        chatChannel.speak(event.target.value);
        event.target.value = '';
        return event.preventDefault();
      }
    });
});
