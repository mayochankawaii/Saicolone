// var toggleBtn = document.querySelector('.sidebar-toggle');
// var sidebar = document.querySelector('.sidebar');

// toggleBtn.addEventListener('click', function() {
//   toggleBtn.classList.toggle('is-closed');
//   sidebar.classList.toggle('is-closed');
// })

document.addEventListener('DOMContentLoaded', function() {
  var toggleBtn = document.querySelector('.sidebar-toggle');
  var sidebar = document.querySelector('.sidebar');

  toggleBtn.addEventListener('click', function() {
    toggleBtn.classList.toggle('is-closed');
    sidebar.classList.toggle('is-closed');
  });
});

/*global $*/
// $(".sidebar-toggle").click(function () {
//     $(this).toggleClass('active');
//     $(".sidebar").fadeOut();
// });