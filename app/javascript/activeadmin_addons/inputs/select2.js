var initializer = function() {
  configureSelect2(document);

  $(document).on('has_many_add:after', function(event, container) {
    configureSelect2(container);
  });

  function configureSelect2(container) {
    if (window.ActiveadminAddons.config.defaultSelect == 'select2') {
      $('select:not(.default-select)', container).each(function(i, el) {
        setupSelect2(el);
      });
    }

    $('select.select2', container).each(function(i, el) {
      setupSelect2(el);
    });

    function setupSelect2(select) {
      var selectConfig = {
        placeholder: '',
        width: '80%',
        allowClear: true,
      };

      function isFilter(path) {
        return $(select).closest(path).length > 0;
      }

      if (isFilter('.select_and_search')) {
        selectConfig.width = 'resolve';
        selectConfig.allowClear = false;
      } else if (isFilter('.filter_select')) {
        selectConfig.width = 'resolve';
      }

      $(select).select2(selectConfig);

      // makes sure that the search field is focused when drop-down list opens
      $(select).on("select2:open", () =>
        $(".select2-container--open .select2-search__field")[0].focus()
      )
    }
  }
};

$(initializer);
$(document).on('turbolinks:load turbo:load', initializer);
