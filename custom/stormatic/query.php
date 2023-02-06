<?php
/* Copyright (C) 2017 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copyright (C) ---Put here your own copyright and developer email---
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

/**
 *   	\file       csv_card.php
 *		\ingroup    stormatic
 *		\brief      Page to create/edit/view csv
 */
require '../../main.inc.php';
dol_include_once('/stormatic/class/csv.class.php');
dol_include_once('../categories/class/categorie.class.php');

// Get parameters
$id                 = GETPOST('id', 'int');
$action             = GETPOST('action', 'aZ09');
$product_ref        = GETPOST('product_ref', 'alpha');
$line_id            = GETPOST('line_id', 'int');
$product_id         = GETPOST('product_id', 'int');
$abaque_id          = GETPOST('id_extrafields', 'int');
$current_context    = GETPOST('context', 'alpha');

$object             = new Csv($db);
$categorie          = new Categorie($db);

// List of authorized context from the hook
$authorized_context  = array(
    'propalcard' => [
        'table'         => 'propal',
        'tabledet'      => 'propaldet',
    ], 
    'ordercard' => [
        'table'        => 'commande',
        'tabledet'      => 'commandedet',
        
    ], 
    'invoicecard' => [
        'table'         => 'facture',
        'tabledet'      => 'facturedet',
        
    ]
);

// Get the current context
// var_dump($authorized_context[$context]['table'], $context);

if($action == 'get_abaque_prices') {
    if($product_ref && array_key_exists($current_context, $authorized_context)) {
        $return_prices = array(
            'product_price' => $object->customCommerceUpdate($current_context, $authorized_context, NULL, $line_id, $abaque_id),
            'tva_tx'        => $conf->global->MAIN_VAT_DEFAULT_IF_AUTODETECT_FAILS,
        );

        echo json_encode($return_prices);
    }
}

// Hide abaques extrafields on spare parts (pièces détachées)
if($action == 'hide_extrafields') {
    echo $object->customHideExtrafields($id, $current_context);
}