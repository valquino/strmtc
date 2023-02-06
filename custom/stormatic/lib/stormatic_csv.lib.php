<?php
/* Copyright (C) ---Put here your own copyright and developer email---
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * \file    lib/stormatic_csv.lib.php
 * \ingroup stormatic
 * \brief   Library files with common functions for Csv
 */

/**
 * Prepare array of tabs for Csv
 *
 * @param	Csv	$object		Csv
 * @return 	array					Array of tabs
 */
function csvPrepareHead($object)
{
	global $db, $langs, $conf;

	$langs->load("stormatic@stormatic");

	$h = 0;
	$head = array();

	$head[$h][0] = dol_buildpath("/stormatic/csv_card.php", 1).'?id='.$object->id;
	$head[$h][1] = $langs->trans("Card");
	$head[$h][2] = 'card';
	$h++;

	if (isset($object->fields['note_public']) || isset($object->fields['note_private'])) {
		$nbNote = 0;
		if (!empty($object->note_private)) {
			$nbNote++;
		}
		if (!empty($object->note_public)) {
			$nbNote++;
		}
		$head[$h][0] = dol_buildpath('/stormatic/csv_note.php', 1).'?id='.$object->id;
		$head[$h][1] = $langs->trans('Notes');
		if ($nbNote > 0) {
			$head[$h][1] .= (empty($conf->global->MAIN_OPTIMIZEFORTEXTBROWSER) ? '<span class="badge marginleftonlyshort">'.$nbNote.'</span>' : '');
		}
		$head[$h][2] = 'note';
		$h++;
	}

	require_once DOL_DOCUMENT_ROOT.'/core/lib/files.lib.php';
	require_once DOL_DOCUMENT_ROOT.'/core/class/link.class.php';
	$upload_dir = $conf->stormatic->dir_output."/csv/".dol_sanitizeFileName($object->ref);
	$nbFiles = count(dol_dir_list($upload_dir, 'files', 0, '', '(\.meta|_preview.*\.png)$'));
	$nbLinks = Link::count($db, $object->element, $object->id);
	$head[$h][0] = dol_buildpath("/stormatic/csv_document.php", 1).'?id='.$object->id;
	$head[$h][1] = $langs->trans('Documents');
	if (($nbFiles + $nbLinks) > 0) {
		$head[$h][1] .= '<span class="badge marginleftonlyshort">'.($nbFiles + $nbLinks).'</span>';
	}
	$head[$h][2] = 'document';
	$h++;

	$head[$h][0] = dol_buildpath("/stormatic/csv_agenda.php", 1).'?id='.$object->id;
	$head[$h][1] = $langs->trans("Events");
	$head[$h][2] = 'agenda';
	$h++;

	// Show more tabs from modules
	// Entries must be declared in modules descriptor with line
	//$this->tabs = array(
	//	'entity:+tabname:Title:@stormatic:/stormatic/mypage.php?id=__ID__'
	//); // to add new tab
	//$this->tabs = array(
	//	'entity:-tabname:Title:@stormatic:/stormatic/mypage.php?id=__ID__'
	//); // to remove a tab
	complete_head_from_modules($conf, $langs, $object, $head, $h, 'csv@stormatic');

	complete_head_from_modules($conf, $langs, $object, $head, $h, 'csv@stormatic', 'remove');

	return $head;
}

// /**
//  * Prepare array with list of tabs
//  *
//  * @param   Product	$object		Object related to tabs
//  * @return  array				Array of tabs to show
//  */
// function abaque_prepare_head($object)
// {
// 	global $db, $langs, $conf, $user;
// 	$langs->load("stormatic");

// 	$label = $langs->trans('Product');

// 	$h = 0;
// 	$head = array();

// 	$head[$h][0] = DOL_URL_ROOT."/product/card.php?id=".$object->id;
// 	$head[$h][1] = $label;
// 	$head[$h][2] = 'card';
// 	$h++;

// 	if (!empty($object->status)) {
// 		$head[$h][0] = DOL_URL_ROOT."/product/price.php?id=".$object->id;
// 		$head[$h][1] = $langs->trans("SellingPrices");
// 		$head[$h][2] = 'price';
// 		$h++;
// 	}

// 	if (!empty($object->status_buy) || (!empty($conf->margin->enabled) && !empty($object->status))) {   // If margin is on and product on sell, we may need the cost price even if product os not on purchase
// 		if ((((!empty($conf->fournisseur->enabled) && empty($conf->global->MAIN_USE_NEW_SUPPLIERMOD)) || !empty($conf->supplier_order->enabled) || !empty($conf->supplier_invoice->enabled)) && $user->rights->fournisseur->lire)
// 		|| (!empty($conf->margin->enabled) && $user->rights->margin->liretous)
// 		) {
// 			$head[$h][0] = DOL_URL_ROOT."/product/fournisseurs.php?id=".$object->id;
// 			$head[$h][1] = $langs->trans("BuyingPrices");
// 			$head[$h][2] = 'suppliers';
// 			$h++;
// 		}
// 	}

// 	// Multilangs
// 	if (!empty($conf->global->MAIN_MULTILANGS)) {
// 		$head[$h][0] = DOL_URL_ROOT."/product/traduction.php?id=".$object->id;
// 		$head[$h][1] = $langs->trans("Translation");
// 		$head[$h][2] = 'translation';
// 		$h++;
// 	}

// 	// Sub products
// 	if (!empty($conf->global->PRODUIT_SOUSPRODUITS)) {
// 		$head[$h][0] = DOL_URL_ROOT."/product/composition/card.php?id=".$object->id;
// 		$head[$h][1] = $langs->trans('AssociatedProducts');

// 		$nbFatherAndChild = $object->hasFatherOrChild();
// 		if ($nbFatherAndChild > 0) {
// 			$head[$h][1] .= '<span class="badge marginleftonlyshort">'.$nbFatherAndChild.'</span>';
// 		}
// 		$head[$h][2] = 'subproduct';
// 		$h++;
// 	}

// 	if (!empty($conf->variants->enabled) && ($object->isProduct() || $object->isService())) {
// 		global $db;

// 		require_once DOL_DOCUMENT_ROOT.'/variants/class/ProductCombination.class.php';

// 		$prodcomb = new ProductCombination($db);

// 		if ($prodcomb->fetchByFkProductChild($object->id) <= 0) {
// 			$head[$h][0] = DOL_URL_ROOT."/variants/combinations.php?id=".$object->id;
// 			$head[$h][1] = $langs->trans('ProductCombinations');
// 			$head[$h][2] = 'combinations';
// 			$nbVariant = $prodcomb->countNbOfCombinationForFkProductParent($object->id);
// 			if ($nbVariant > 0) {
// 				$head[$h][1] .= '<span class="badge marginleftonlyshort">'.$nbVariant.'</span>';
// 			}
// 		}

// 		$h++;
// 	}

// 	if ($object->isProduct() || ($object->isService() && !empty($conf->global->STOCK_SUPPORTS_SERVICES))) {    // If physical product we can stock (or service with option)
// 		if (!empty($conf->stock->enabled) && $user->rights->stock->lire) {
// 			$head[$h][0] = DOL_URL_ROOT."/product/stock/product.php?id=".$object->id;
// 			$head[$h][1] = $langs->trans("Stock");
// 			$head[$h][2] = 'stock';
// 			$h++;
// 		}
// 	}

// 	// Tab to link resources
// 	if (!empty($conf->resource->enabled)) {
// 		if ($object->isProduct() && !empty($conf->global->RESOURCE_ON_PRODUCTS)) {
// 			$head[$h][0] = DOL_URL_ROOT.'/resource/element_resource.php?element=product&ref='.$object->ref;
// 			$head[$h][1] = $langs->trans("Resources");
// 			$head[$h][2] = 'resources';
// 			$h++;
// 		}
// 		if ($object->isService() && !empty($conf->global->RESOURCE_ON_SERVICES)) {
// 			$head[$h][0] = DOL_URL_ROOT.'/resource/element_resource.php?element=service&ref='.$object->ref;
// 			$head[$h][1] = $langs->trans("Resources");
// 			$head[$h][2] = 'resources';
// 			$h++;
// 		}
// 	}

// 	$head[$h][0] = DOL_URL_ROOT."/product/stats/facture.php?showmessage=1&id=".$object->id;
// 	$head[$h][1] = $langs->trans('Referers');
// 	$head[$h][2] = 'referers';
// 	$h++;

// 	$head[$h][0] = DOL_URL_ROOT."/product/stats/card.php?id=".$object->id;
// 	$head[$h][1] = $langs->trans('Statistics');
// 	$head[$h][2] = 'stats';
// 	$h++;

// 	// Show more tabs from modules
// 	// Entries must be declared in modules descriptor with line
// 	// $this->tabs = array('entity:+tabname:Title:@mymodule:/mymodule/mypage.php?id=__ID__');   to add new tab
// 	// $this->tabs = array('entity:-tabname);   												to remove a tab
// 	complete_head_from_modules($conf, $langs, $object, $head, $h, 'product');

// 	// Notes
// 	if (empty($conf->global->MAIN_DISABLE_NOTES_TAB)) {
// 		$nbNote = 0;
// 		if (!empty($object->note_private)) {
// 			$nbNote++;
// 		}
// 		if (!empty($object->note_public)) {
// 			$nbNote++;
// 		}
// 		$head[$h][0] = DOL_URL_ROOT.'/product/note.php?id='.$object->id;
// 		$head[$h][1] = $langs->trans('Notes');
// 		if ($nbNote > 0) {
// 			$head[$h][1] .= '<span class="badge marginleftonlyshort">'.$nbNote.'</span>';
// 		}
// 		$head[$h][2] = 'note';
// 		$h++;
// 	}

// 	// Attachments
// 	require_once DOL_DOCUMENT_ROOT.'/core/lib/files.lib.php';
// 	require_once DOL_DOCUMENT_ROOT.'/core/class/link.class.php';
// 	if (!empty($conf->product->enabled) && ($object->type == Product::TYPE_PRODUCT)) {
// 		$upload_dir = $conf->product->multidir_output[$object->entity].'/'.dol_sanitizeFileName($object->ref);
// 	}
// 	if (!empty($conf->service->enabled) && ($object->type == Product::TYPE_SERVICE)) {
// 		$upload_dir = $conf->service->multidir_output[$object->entity].'/'.dol_sanitizeFileName($object->ref);
// 	}
// 	$nbFiles = count(dol_dir_list($upload_dir, 'files', 0, '', '(\.meta|_preview.*\.png)$'));
// 	if (!empty($conf->global->PRODUCT_USE_OLD_PATH_FOR_PHOTO)) {
// 		if (!empty($conf->product->enabled) && ($object->type == Product::TYPE_PRODUCT)) {
// 			$upload_dir = $conf->product->multidir_output[$object->entity].'/'.get_exdir($object->id, 2, 0, 0, $object, 'product').$object->id.'/photos';
// 		}
// 		if (!empty($conf->service->enabled) && ($object->type == Product::TYPE_SERVICE)) {
// 			$upload_dir = $conf->service->multidir_output[$object->entity].'/'.get_exdir($object->id, 2, 0, 0, $object, 'product').$object->id.'/photos';
// 		}
// 		$nbFiles += count(dol_dir_list($upload_dir, 'files', 0, '', '(\.meta|_preview.*\.png)$'));
// 	}
// 	$nbLinks = Link::count($db, $object->element, $object->id);
// 	$head[$h][0] = DOL_URL_ROOT.'/product/document.php?id='.$object->id;
// 	$head[$h][1] = $langs->trans('Documents');
// 	if (($nbFiles + $nbLinks) > 0) {
// 		$head[$h][1] .= '<span class="badge marginleftonlyshort">'.($nbFiles + $nbLinks).'</span>';
// 	}
// 	$head[$h][2] = 'documents';
// 	$h++;

// 	complete_head_from_modules($conf, $langs, $object, $head, $h, 'product', 'remove');

// 	// Log
// 	$head[$h][0] = DOL_URL_ROOT.'/product/agenda.php?id='.$object->id;
// 	$head[$h][1] = $langs->trans("Events");
// 	if (!empty($conf->agenda->enabled) && (!empty($user->rights->agenda->myactions->read) || !empty($user->rights->agenda->allactions->read))) {
// 		$head[$h][1] .= '/';
// 		$head[$h][1] .= $langs->trans("Agenda");
// 	}
// 	$head[$h][2] = 'agenda';
// 	$h++;

// 	return $head;
// }
