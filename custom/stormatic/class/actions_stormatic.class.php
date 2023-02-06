<?php

use DebugBar\JavascriptRenderer;

class ActionsStormatic 
{ 
    public $request_url             = "/custom/stormatic/query.php";
    public $authorized_contexts   = array('propalcard', 'ordercard', 'invoicecard');

	/**
	 * Overloading the doActions function : replacing the parent's function with the one below
	 *
	 * @param   array()         $parameters     Hook metadatas (context, etc...)
	 * @param   CommonObject    &$object        The object to process (an invoice if you are in invoice module, a propale in propale's module, etc...)
	 * @param   string          &$action        Current action (if set). Generally create or edit or null
	 * @param   HookManager     $hookmanager    Hook manager propagated to allow calling another hook
	 * @return  int                             < 0 on error, 0 on success, 1 to replace standard code
	 */
	public function doActions($parameters, &$object, &$action, $hookmanager)
	{
        
        $error                          = 0; // Error counter
        $current_context                = $parameters['currentcontext'];
        

		if (array_intersect($this->authorized_contexts, $parameters))
		{
            if($action === 'editline') {
                // Get context from the current page
                // print '<pre>'.var_export($parameters['currentcontext'], true).'</pre>';

                // Get object details
                // print '<pre>'.var_export($object, true).'</pre>';

                // jQuery
                print '<!-- Includes JS for JQuery -->'."\n";
                if (defined('JS_JQUERY') && constant('JS_JQUERY')) print '<script src="'.JS_JQUERY.'jquery.min.js"></script>'."\n";
                else print '<script src="'.DOL_URL_ROOT.'/includes/jquery/js/jquery.min.js"></script>'."\n";

                $product_ref = $object->lines[0]->ref;
                $line_id = GETPOST('lineid', 'int');
                $options = $object->lines[0]->array_options;
                $elem_id = array_keys($options);

                $id                 = GETPOST("id", "int") ? GETPOST("id", "int") : GETPOST("facid", "int");
                $context            = $parameters['currentcontext'];

                print "<script>
                    $(document).ready(function(){

                        <!-- Ajax request to hide Extrafields for non abaque products (update line mode only) -->
                        $.ajax({
                            url: '$this->request_url',
                            method: 'GET',
                            data: { 
                                action:     'hide_extrafields',
                                context:    '$context',
                                id:         '$id',
                            }
                        }).done(function( lines ) {
                            console.log(lines);
                            $.each(
                                JSON.parse(lines),
                                function(index, object_line) {
                                    $('#extrarow-propaldet_abaquesize_'+object_line).hide();
                                }
                            );
                        });


                        $('select#".$elem_id[0]."').change(function() {
                            var abaquesize = $(this).val(); // Id of the current selected value from the select list

                            <!-- Ajax request to update the price H.T on size selection -->
                            $.ajax({
                                url: '$this->request_url',
                                method: 'GET',
                                data: { 
                                    action:             'get_abaque_prices',
                                    product_ref:        '$product_ref',
                                    line_id:            $line_id,
                                    id_extrafields:     abaquesize,
                                    context:            '$current_context'
                                }
                            }).done(function( data ) {
                                data = $.parseJSON(data);
                                console.log( 'Données reçues: Ligne => $line_id; valeur => '  + data);
                                $('input#price_ht').val(data.product_price);
                                $('select#tva_tx').val(data.tva_tx);
                            });
                        });

                    });
                </script>";
            }
		} 

		if (!$error)
		{
			return 0; // or return 1 to replace standard code
		}
		else
		{
			$this->error = $error;
            return -1;
		}
	}

    /**
     * Hide extrafield size for non abaque products (read mode only)
     */
    public function beforeBodyClose( $parameters, &$object, &$action, $hookmanager ) {
        if (array_intersect($this->authorized_contexts, $parameters))
		{
            $id                 = GETPOST("id", "int") ? GETPOST("id", "int") : GETPOST("facid", "int");
            $context            = $parameters['currentcontext'];

            $js_script = "<script>
                $(document).ready(function(){
                    <!-- Ajax request -->
                    $.ajax({
                        url: '$this->request_url',
                        method: 'GET',
                        data: { 
                            action:     'hide_extrafields',
                            context:    '$context',
                            id:         $id,
                        }
                    }).done(function( data ) {
                        console.log('text'+data);
                        $.each(
                            JSON.parse(data),
                            function(index, object_line) {
                                $('#extrafield_lines_area_'+object_line).hide();
                            }
                        );
                    });
                });
            </script>";

            $hookmanager->resPrint = $js_script;
            return 1;
        }
    }
}