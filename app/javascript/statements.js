document.addEventListener('turbo:load', function() {
  let element = document.getElementById('add_statement_items')
  if (element) { 
    document.getElementById('add_statement_items').addEventListener('click', addNewStatementItem);
  }

});

function addNewStatementItem (e) {
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
    el.value = el.tagName === 'SELECT' ? '0' : '';
    if (labelFor) { 
      el.htmlFor = labelFor
    }
  });

  document.getElementById('statement_items_form').appendChild(node)
}