"use strict";
// module Template.Article

exports.simplemdeInit = function(editor_id){
    return function(cached_id){
        var opts = function(editor_id, cached_id, form_id){
            return {
                autosave: {enabled: true, uniqueId: cached_id, delay: 1000},
                renderingConfig:{codeSyntaxHighlighting:true},
                spellChecker: false,
                element: document.getElementById(editor_id),
                toolbar: [
                    'bold',
                    'italic',
                    'heading',
                    '|',
                    'code',
                    'quote',
                    'ordered-list',
                    'clean-block',
                    '|',
                    'link',
                    'image',
                    'table',
                    '|',
                    'preview',
                    'side-by-side',
                    'fullscreen',
                    '|',
                    {
                        name: "trash",
                        action: function(editor){
                            if (confirm('Clean AutoSave and Refresh?')){
                                editor.clearAutosavedValue();
                                editor.value('');
                                location.href = location.href.replace(/#.*$/, '');
                            }
                        },
                        className: "fa fa-trash",
                        title: "Trash"
                    }
                ]
            };
        };
        var init_editor_code = 'var smde = new SimpleMDE((' + opts.toString() + ')('
            + [editor_id, cached_id].map(function(i){return JSON.stringify(i);}).join(', ')
            + '));';

        var binding_function = function(smde){
            var form = document.querySelector('form');
            form.onsubmit = function(e){
                if (confirm('Submit Changes?')){
                    smde.clearAutosavedValue();
                }
                else{
                    e.preventDefault();
                }
            };
        };
        var binding_submit_code = '('+ binding_function.toString() + ')(smde);';

        return '(function(){' + init_editor_code + binding_submit_code + '})();';
    };
};
