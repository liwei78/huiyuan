CKEDITOR.editorConfig = function( config )
{

  config.toolbar_Basic =
  [
      [ 'Bold', 'Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat']
  ];

  config.toolbar_Full =
  [
      { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
      { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
      '/',
      { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
      { name: 'colors',      items : [ 'TextColor','BGColor' ] },
  ];
};