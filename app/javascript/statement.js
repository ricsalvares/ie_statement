document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('add_statement_items').addEventListener('click', function(e) {
    e.preventDefault();

    const ref = document.querySelector('#statement_items_form .statement_items')
    let node = ref.cloneNode(true);
    const newIndex = document.querySelectorAll('.statement_items').length;

    node.querySelectorAll('input, select, label').forEach(function(el) {
      const labelFor = el.htmlFor && el.htmlFor.replace(/_\d_/, '_' + newIndex + '_');
      const name = el.name && el.name.replace(/\[\d\]/, '[' + newIndex + ']');
      const id = el.id && el.id.replace(/_\d_/, '_' + newIndex + '_');

      el.name = name;
      el.id = id;
      el.value = '';
      if (labelFor) { 
        el.htmlFor = labelFor
      }
    });

    document.getElementById('statement_items_form').appendChild(node)
  });

});