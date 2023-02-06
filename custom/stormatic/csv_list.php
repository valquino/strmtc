<?php

/* Copyright (C) 2007-2017 Laurent Destailleur  <eldy@users.sourceforge.net>
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
 *   	\file       csv_list.php
 *		\ingroup    stormatic
 *		\brief      List page for csv
 */

//if (! defined('NOREQUIREDB'))              define('NOREQUIREDB', '1');				// Do not create database handler $db
//if (! defined('NOREQUIREUSER'))            define('NOREQUIREUSER', '1');				// Do not load object $user
//if (! defined('NOREQUIRESOC'))             define('NOREQUIRESOC', '1');				// Do not load object $mysoc
//if (! defined('NOREQUIRETRAN'))            define('NOREQUIRETRAN', '1');				// Do not load object $langs
//if (! defined('NOSCANGETFORINJECTION'))    define('NOSCANGETFORINJECTION', '1');		// Do not check injection attack on GET parameters
//if (! defined('NOSCANPOSTFORINJECTION'))   define('NOSCANPOSTFORINJECTION', '1');		// Do not check injection attack on POST parameters
//if (! defined('NOCSRFCHECK'))              define('NOCSRFCHECK', '1');				// Do not check CSRF attack (test on referer + on token if option MAIN_SECURITY_CSRF_WITH_TOKEN is on).
//if (! defined('NOTOKENRENEWAL'))           define('NOTOKENRENEWAL', '1');				// Do not roll the Anti CSRF token (used if MAIN_SECURITY_CSRF_WITH_TOKEN is on)
//if (! defined('NOSTYLECHECK'))             define('NOSTYLECHECK', '1');				// Do not check style html tag into posted data
//if (! defined('NOREQUIREMENU'))            define('NOREQUIREMENU', '1');				// If there is no need to load and show top and left menu
//if (! defined('NOREQUIREHTML'))            define('NOREQUIREHTML', '1');				// If we don't need to load the html.form.class.php
//if (! defined('NOREQUIREAJAX'))            define('NOREQUIREAJAX', '1');       	  	// Do not load ajax.lib.php library
//if (! defined("NOLOGIN"))                  define("NOLOGIN", '1');					// If this page is public (can be called outside logged session). This include the NOIPCHECK too.
//if (! defined('NOIPCHECK'))                define('NOIPCHECK', '1');					// Do not check IP defined into conf $dolibarr_main_restrict_ip
//if (! defined("MAIN_LANG_DEFAULT"))        define('MAIN_LANG_DEFAULT', 'auto');					// Force lang to a particular value
//if (! defined("MAIN_AUTHENTICATION_MODE")) define('MAIN_AUTHENTICATION_MODE', 'aloginmodule');	// Force authentication handler
//if (! defined("NOREDIRECTBYMAINTOLOGIN"))  define('NOREDIRECTBYMAINTOLOGIN', 1);		// The main.inc.php does not make a redirect if not logged, instead show simple error message
//if (! defined("FORCECSP"))                 define('FORCECSP', 'none');				// Disable all Content Security Policies
//if (! defined('CSRFCHECK_WITH_TOKEN'))     define('CSRFCHECK_WITH_TOKEN', '1');		// Force use of CSRF protection with tokens even for GET
//if (! defined('NOBROWSERNOTIF'))     		 define('NOBROWSERNOTIF', '1');				// Disable browser notification
//if (! defined('NOSESSION'))                define('NOSESSION', '1');					// On CLI mode, no need to use web sessions

// Load Dolibarr environment
$res = 0;
// Try main.inc.php into web root known defined into CONTEXT_DOCUMENT_ROOT (not always defined)
if (!$res && !empty($_SERVER["CONTEXT_DOCUMENT_ROOT"])) {
	$res = @include $_SERVER["CONTEXT_DOCUMENT_ROOT"]."/main.inc.php";
}
// Try main.inc.php into web root detected using web root calculated from SCRIPT_FILENAME
$tmp = empty($_SERVER['SCRIPT_FILENAME']) ? '' : $_SERVER['SCRIPT_FILENAME']; $tmp2 = realpath(__FILE__); $i = strlen($tmp) - 1; $j = strlen($tmp2) - 1;
while ($i > 0 && $j > 0 && isset($tmp[$i]) && isset($tmp2[$j]) && $tmp[$i] == $tmp2[$j]) {
	$i--; $j--;
}
if (!$res && $i > 0 && file_exists(substr($tmp, 0, ($i + 1))."/main.inc.php")) {
	$res = @include substr($tmp, 0, ($i + 1))."/main.inc.php";
}
if (!$res && $i > 0 && file_exists(dirname(substr($tmp, 0, ($i + 1)))."/main.inc.php")) {
	$res = @include dirname(substr($tmp, 0, ($i + 1)))."/main.inc.php";
}
// Try main.inc.php using relative path
if (!$res && file_exists("../main.inc.php")) {
	$res = @include "../main.inc.php";
}
if (!$res && file_exists("../../main.inc.php")) {
	$res = @include "../../main.inc.php";
}
if (!$res && file_exists("../../../main.inc.php")) {
	$res = @include "../../../main.inc.php";
}
if (!$res) {
	die("Include of main fails");
}

require_once DOL_DOCUMENT_ROOT.'/core/class/html.formcompany.class.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/date.lib.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/files.lib.php';

// load stormatic libraries
require_once __DIR__.'/class/csv.class.php';
require_once DOL_DOCUMENT_ROOT.'/product/class/product.class.php';

// For files imports
$action				= GETPOST('action', 'alpha');
$confirm			= GETPOST('confirm', 'alpha');
$step				= (GETPOST('step') ? GETPOST('step') : 1);

$objimport = new Csv($db);

$form = new Form($db);

// Initialize technical objects
$object = new Csv($db);
$object_product = new Product($db);

$extrafields = new ExtraFields($db);
$diroutputmassaction = $conf->stormatic->dir_output.'/temp/massgeneration/'.$user->id;
$hookmanager->initHooks(array('csvlist')); // Note that conf->hooks_modules contains array

// Fetch optionals attributes and labels
$extrafields->fetch_name_optionals_label($object->table_element);
$extrafields->fetch_name_optionals_label('product');

$search_array_options = $extrafields->getOptionalsFromPost($object->table_element, '', 'search_');

// Default sort order (if not yet defined by previous GETPOST)
if (!$sortfield) {
	reset($object->fields);					// Reset is required to avoid key() to return null.
	$sortfield = "t.".key($object->fields); // Set here default search field. By default 1st field in definition.
}
if (!$sortorder) {
	$sortorder = "ASC";
}

// Initialize array of search criterias
$search_all = GETPOST('search_all', 'alphanohtml');
$search = array();
foreach ($object->fields as $key => $val) {
	if (GETPOST('search_'.$key, 'alpha') !== '') {
		$search[$key] = GETPOST('search_'.$key, 'alpha');
	}
	if (preg_match('/^(date|timestamp|datetime)/', $val['type'])) {
		$search[$key.'_dtstart'] = dol_mktime(0, 0, 0, GETPOST('search_'.$key.'_dtstartmonth', 'int'), GETPOST('search_'.$key.'_dtstartday', 'int'), GETPOST('search_'.$key.'_dtstartyear', 'int'));
		$search[$key.'_dtend'] = dol_mktime(23, 59, 59, GETPOST('search_'.$key.'_dtendmonth', 'int'), GETPOST('search_'.$key.'_dtendday', 'int'), GETPOST('search_'.$key.'_dtendyear', 'int'));
	}
}

// List of fields to search into when doing a "search in all"
$fieldstosearchall = array();
foreach ($object->fields as $key => $val) {
	if (!empty($val['searchall'])) {
		$fieldstosearchall['t.'.$key] = $val['label'];
	}
}

// Definition of array of fields for columns
$arrayfields = array();
foreach ($object->fields as $key => $val) {
	// If $val['visible']==0, then we never show the field
	if (!empty($val['visible'])) {
		$visible = (int) dol_eval($val['visible'], 1);
		$arrayfields['t.'.$key] = array(
			'label'=>$val['label'],
			'checked'=>(($visible < 0) ? 0 : 1),
			'enabled'=>($visible != 3 && dol_eval($val['enabled'], 1)),
			'position'=>$val['position'],
			'help'=> isset($val['help']) ? $val['help'] : ''
		);
	}
}
// Extra fields
include DOL_DOCUMENT_ROOT.'/core/tpl/extrafields_list_array_fields.tpl.php';

$object->fields = dol_sort_array($object->fields, 'position');
$arrayfields = dol_sort_array($arrayfields, 'position');

// There is several ways to check permission.
// Set $enablepermissioncheck to 1 to enable a minimum low level of checks
$enablepermissioncheck = 0;
if ($enablepermissioncheck) {
	$permissiontoread = $user->rights->stormatic->csv->read;
	$permissiontoadd = $user->rights->stormatic->csv->write;
	$permissiontodelete = $user->rights->stormatic->csv->delete;
} else {
	$permissiontoread = 1;
	$permissiontoadd = 1;
	$permissiontodelete = 1;
}

// Security check (enable the most restrictive one)
if ($user->socid > 0) accessforbidden();
//if ($user->socid > 0) accessforbidden();
//$socid = 0; if ($user->socid > 0) $socid = $user->socid;
//$isdraft = (($object->status == $object::STATUS_DRAFT) ? 1 : 0);
//restrictedArea($user, $object->element, $object->id, $object->table_element, '', 'fk_soc', 'rowid', $isdraft);
if (empty($conf->stormatic->enabled)) accessforbidden('Moule not enabled');
if (!$permissiontoread) accessforbidden();



/*
 * Actions
 */

if (GETPOST('cancel', 'alpha')) {
	$action = 'list';
	$massaction = '';
}
if (!GETPOST('confirmmassaction', 'alpha') && $massaction != 'presend' && $massaction != 'confirm_presend') {
	$massaction = '';
}

$parameters = array();
$reshook = $hookmanager->executeHooks('doActions', $parameters, $object, $action); // Note that $action and $object may have been modified by some hooks
if ($reshook < 0) {
	setEventMessages($hookmanager->error, $hookmanager->errors, 'errors');
}

if (empty($reshook)) {
	// Selection of new fields
	include DOL_DOCUMENT_ROOT.'/core/actions_changeselectedfields.inc.php';

	// Purge search criteria
	if (GETPOST('button_removefilter_x', 'alpha') || GETPOST('button_removefilter.x', 'alpha') || GETPOST('button_removefilter', 'alpha')) { // All tests are required to be compatible with all browsers
		foreach ($object->fields as $key => $val) {
			$search[$key] = '';
			if (preg_match('/^(date|timestamp|datetime)/', $val['type'])) {
				$search[$key.'_dtstart'] = '';
				$search[$key.'_dtend'] = '';
			}
		}
		$toselect = array();
		$search_array_options = array();
	}
	if (GETPOST('button_removefilter_x', 'alpha') || GETPOST('button_removefilter.x', 'alpha') || GETPOST('button_removefilter', 'alpha')
		|| GETPOST('button_search_x', 'alpha') || GETPOST('button_search.x', 'alpha') || GETPOST('button_search', 'alpha')) {
		$massaction = ''; // Protection to avoid mass action if we force a new search during a mass action confirmation
	}

	// Mass actions
	$objectclass = 'Csv';
	$objectlabel = 'Csv';
	$uploaddir = $conf->stormatic->dir_output;
	include DOL_DOCUMENT_ROOT.'/core/actions_massactions.inc.php';
}



/*
 * View
 */

$form = new Form($db);

$now = dol_now();

//$help_url="EN:Module_Csv|FR:Module_Csv_FR|ES:Módulo_Csv";
$help_url = '';
$title = $langs->trans('ListOf', $langs->transnoentitiesnoconv("Csvs"));
$morejs = array();
$morecss = array();


// Build and execute select
// --------------------------------------------------------------------
$sql = 'SELECT ';
$sql .= $object->getFieldList('t');
$sql .= ",".$object_product->getFieldList('p');
$sql .= ", CAST(t.price AS DECIMAL(7,2)) AS pr";
// Add fields from extrafields
if (!empty($extrafields->attributes[$object->table_element]['label'])) {
	foreach ($extrafields->attributes[$object->table_element]['label'] as $key => $val) {
		$sql .= ($extrafields->attributes[$object->table_element]['type'][$key] != 'separate' ? ", ef.".$key." as options_".$key : '');
	}
}
// Add fields from hooks
$parameters = array();
$reshook = $hookmanager->executeHooks('printFieldListSelect', $parameters, $object); // Note that $action and $object may have been modified by hook
$sql .= preg_replace('/^,/', '', $hookmanager->resPrint);
$sql = preg_replace('/,\s*$/', '', $sql);
$sql .= " FROM ".MAIN_DB_PREFIX.$object->table_element." as t";
if (isset($extrafields->attributes[$object->table_element]['label']) && is_array($extrafields->attributes[$object->table_element]['label']) && count($extrafields->attributes[$object->table_element]['label'])) {
	$sql .= " LEFT JOIN ".MAIN_DB_PREFIX.$object->table_element."_extrafields as ef on (t.rowid = ef.fk_object)";
}

// Add product table to the query
$sql .= " JOIN ".MAIN_DB_PREFIX."product AS p on t.fk_product = p.rowid";

// Add table from hooks
$parameters = array();
$reshook = $hookmanager->executeHooks('printFieldListFrom', $parameters, $object); // Note that $action and $object may have been modified by hook
$sql .= $hookmanager->resPrint;
if ($object->ismultientitymanaged == 1) {
	$sql .= " WHERE t.entity IN (".getEntity($object->element).")";
} else {
	$sql .= " WHERE 1 = 1";
}
foreach ($search as $key => $val) {
	if (array_key_exists($key, $object->fields)) {
		if ($key == 'status' && $search[$key] == -1) {
			continue;
		}
		$mode_search = (($object->isInt($object->fields[$key]) || $object->isFloat($object->fields[$key])) ? 1 : 0);
		if ((strpos($object->fields[$key]['type'], 'integer:') === 0) || (strpos($object->fields[$key]['type'], 'sellist:') === 0) || !empty($object->fields[$key]['arrayofkeyval'])) {
			if ($search[$key] == '-1' || ($search[$key] === '0' && (empty($object->fields[$key]['arrayofkeyval']) || !array_key_exists('0', $object->fields[$key]['arrayofkeyval'])))) {
				$search[$key] = '';
			}
			$mode_search = 2;
		}
		if ($search[$key] != '') {
			$sql .= natural_search($key, $search[$key], (($key == 'status') ? 2 : $mode_search));
		}
	} else {
		if (preg_match('/(_dtstart|_dtend)$/', $key) && $search[$key] != '') {
			$columnName = preg_replace('/(_dtstart|_dtend)$/', '', $key);
			if (preg_match('/^(date|timestamp|datetime)/', $object->fields[$columnName]['type'])) {
				if (preg_match('/_dtstart$/', $key)) {
					$sql .= " AND t.".$columnName." >= '".$db->idate($search[$key])."'";
				}
				if (preg_match('/_dtend$/', $key)) {
					$sql .= " AND t." . $columnName . " <= '" . $db->idate($search[$key]) . "'";
				}
			}
		}
	}
}
if ($search_all) {
	$sql .= natural_search(array_keys($fieldstosearchall), $search_all);
}
//$sql.= dolSqlDateFilter("t.field", $search_xxxday, $search_xxxmonth, $search_xxxyear);
// Add where from extra fields
include DOL_DOCUMENT_ROOT.'/core/tpl/extrafields_list_search_sql.tpl.php';
// Add where from hooks
$parameters = array();
$reshook = $hookmanager->executeHooks('printFieldListWhere', $parameters, $object); // Note that $action and $object may have been modified by hook
$sql .= $hookmanager->resPrint;

/* If a group by is required
$sql .= " GROUP BY ";
foreach($object->fields as $key => $val) {
	$sql .= "t.".$key.", ";
}
// Add fields from extrafields
if (!empty($extrafields->attributes[$object->table_element]['label'])) {
	foreach ($extrafields->attributes[$object->table_element]['label'] as $key => $val) {
		$sql .= ($extrafields->attributes[$object->table_element]['type'][$key] != 'separate' ? "ef.".$key.', ' : '');
	}
}
// Add where from hooks
$parameters = array();
$reshook = $hookmanager->executeHooks('printFieldListGroupBy', $parameters, $object);    // Note that $action and $object may have been modified by hook
$sql .= $hookmanager->resPrint;
$sql = preg_replace('/,\s*$/', '', $sql);
*/

// Add HAVING from hooks
/*
$parameters = array();
$reshook = $hookmanager->executeHooks('printFieldListHaving', $parameters, $object); // Note that $action and $object may have been modified by hook
$sql .= empty($hookmanager->resPrint) ? "" : " HAVING 1=1 ".$hookmanager->resPrint;
*/

// Count total nb of records
$nbtotalofrecords = '';
if (empty($conf->global->MAIN_DISABLE_FULL_SCANLIST)) {
	/* This old and fast method to get and count full list returns all record so use a high amount of memory.
	$resql = $db->query($sql);
	$nbtotalofrecords = $db->num_rows($resql);
	*/
	/* The slow method does not consume memory on mysql (not tested on pgsql) */
	/*$resql = $db->query($sql, 0, 'auto', 1);
	while ($db->fetch_object($resql)) {
		$nbtotalofrecords++;
	}*/
	/* The fast and low memory method to get and count full list converts the sql into a sql count */
	$sqlforcount = preg_replace('/^SELECT[a-z0-9\._\s\(\),]+FROM/i', 'SELECT COUNT(*) as nbtotalofrecords FROM', $sql);
	$resql = $db->query($sqlforcount);
	$objforcount = $db->fetch_object($resql);
	$nbtotalofrecords = $objforcount->nbtotalofrecords;
	if (($page * $limit) > $nbtotalofrecords) {	// if total of record found is smaller than page * limit, goto and load page 0
		$page = 0;
		$offset = 0;
	}
	$db->free($resql);
}

// Complete request and execute it with limit
$sql .= $db->order($sortfield, $sortorder);
if ($limit) {
	$sql .= $db->plimit($limit + 1, $offset);
}

$resql = $db->query($sql);
if (!$resql) {
	dol_print_error($db);
	exit;
}

$num = $db->num_rows($resql);

// Direct jump if only one record found
if ($num == 1 && !empty($conf->global->MAIN_SEARCH_DIRECT_OPEN_IF_ONLY_ONE) && $search_all && !$page) {
	$obj = $db->fetch_object($resql);
	$id = $obj->rowid;
	header("Location: ".dol_buildpath('/stormatic/csv_card.php', 1).'?id='.$id);
	exit;
}


// Output page
// --------------------------------------------------------------------

llxHeader('', $title, $help_url, '', 0, 0, $morejs, $morecss, '', '');

$arrayofselected = is_array($toselect) ? $toselect : array();

$param = '';
if (!empty($contextpage) && $contextpage != $_SERVER["PHP_SELF"]) {
	$param .= '&contextpage='.urlencode($contextpage);
}
if ($limit > 0 && $limit != $conf->liste_limit) {
	$param .= '&limit='.urlencode($limit);
}
foreach ($search as $key => $val) {
	if (is_array($search[$key]) && count($search[$key])) {
		foreach ($search[$key] as $skey) {
			if ($skey != '') {
				$param .= '&search_'.$key.'[]='.urlencode($skey);
			}
		}
	} elseif ($search[$key] != '') {
		$param .= '&search_'.$key.'='.urlencode($search[$key]);
	}
}
if ($optioncss != '') {
	$param .= '&optioncss='.urlencode($optioncss);
}
// Add $param from extra fields
include DOL_DOCUMENT_ROOT.'/core/tpl/extrafields_list_search_param.tpl.php';
// Add $param from hooks
$parameters = array();
$reshook = $hookmanager->executeHooks('printFieldListSearchParam', $parameters, $object); // Note that $action and $object may have been modified by hook
$param .= $hookmanager->resPrint;

// List of mass actions available
$arrayofmassactions = array(
	//'validate'=>img_picto('', 'check', 'class="pictofixedwidth"').$langs->trans("Validate"),
	//'generate_doc'=>img_picto('', 'pdf', 'class="pictofixedwidth"').$langs->trans("ReGeneratePDF"),
	//'builddoc'=>img_picto('', 'pdf', 'class="pictofixedwidth"').$langs->trans("PDFMerge"),
	//'presend'=>img_picto('', 'email', 'class="pictofixedwidth"').$langs->trans("SendByMail"),
);
if ($permissiontodelete) {
	$arrayofmassactions['predelete'] = img_picto('', 'delete', 'class="pictofixedwidth"').$langs->trans("Delete");
}
if (GETPOST('nomassaction', 'int') || in_array($massaction, array('presend', 'predelete'))) {
	$arrayofmassactions = array();
}
$massactionbutton = $form->selectMassAction('', $arrayofmassactions);

	// print '<form method="POST" id="searchFormList" action="'.$_SERVER["PHP_SELF"].'">'."\n";
	// if ($optioncss != '') {
	// 	print '<input type="hidden" name="optioncss" value="'.$optioncss.'">';
	// }
	// print '<input type="hidden" name="token" value="'.newToken().'">';
	// print '<input type="hidden" name="formfilteraction" id="formfilteraction" value="list">';
	// print '<input type="hidden" name="action" value="list">';
	// print '<input type="hidden" name="sortfield" value="'.$sortfield.'">';
	// print '<input type="hidden" name="sortorder" value="'.$sortorder.'">';
	// print '<input type="hidden" name="page" value="'.$page.'">';
	// print '<input type="hidden" name="contextpage" value="'.$contextpage.'">';

	// $newcardbutton = dolGetButtonTitle($langs->trans('New'), '', 'fa fa-plus-circle', dol_buildpath('/stormatic/csv_card.php', 1).'?action=create&backtopage='.urlencode($_SERVER['PHP_SELF']), '', $permissiontoadd);

	// print_barre_liste($title, $page, $_SERVER["PHP_SELF"], $param, $sortfield, $sortorder, $massactionbutton, $num, $nbtotalofrecords, 'object_'.$object->picto, 0, $newcardbutton, '', $limit, 0, 0, 1);

	// // Add code for pre mass action (confirmation or email presend form)
	// $topicmail = "SendCsvRef";
	// $modelmail = "csv";
	// $objecttmp = new Csv($db);
	// $trackid = 'xxxx'.$object->id;
	// include DOL_DOCUMENT_ROOT.'/core/tpl/massactions_pre.tpl.php';

	// if ($search_all) {
	// 	$setupstring = '';
	// 	foreach ($fieldstosearchall as $key => $val) {
	// 		$fieldstosearchall[$key] = $langs->trans($val);
	// 		$setupstring .= $key."=".$val.";";
	// 	}
	// 	print '<!-- Search done like if PRODUCT_QUICKSEARCH_ON_FIELDS = '.$setupstring.' -->'."\n";
	// 	print '<div class="divsearchfieldfilter">'.$langs->trans("FilterOnInto", $search_all).join(', ', $fieldstosearchall).'</div>'."\n";
	// }

	// $moreforfilter = '';
	// /*$moreforfilter.='<div class="divsearchfield">';
	// $moreforfilter.= $langs->trans('MyFilter') . ': <input type="text" name="search_myfield" value="'.dol_escape_htmltag($search_myfield).'">';
	// $moreforfilter.= '</div>';*/

	// $parameters = array();
	// $reshook = $hookmanager->executeHooks('printFieldPreListTitle', $parameters, $object); // Note that $action and $object may have been modified by hook
	// if (empty($reshook)) {
	// 	$moreforfilter .= $hookmanager->resPrint;
	// } else {
	// 	$moreforfilter = $hookmanager->resPrint;
	// }

	// if (!empty($moreforfilter)) {
	// 	print '<div class="liste_titre liste_titre_bydiv centpercent">';
	// 	print $moreforfilter;
	// 	print '</div>';
	// }

	// $varpage = empty($contextpage) ? $_SERVER["PHP_SELF"] : $contextpage;
	// $selectedfields = $form->multiSelectArrayWithCheckbox('selectedfields', $arrayfields, $varpage); // This also change content of $arrayfields
	// $selectedfields .= (count($arrayofmassacmltions) ? $form->showCheckAddButtons('checkforselect', 1) : '');
	
// TABS
print '<div class="tabs nopaddingleft" data-role="controlgroup" data-type="horizontal">';
	print '<div class="inline-block tabsElem tabsElemActive">';
	print '<!-- id tab = step1 --><div class="tab tabactive" style="margin: 0 !important">';
	print '<a id="file" class="tab inline-block" href="'.$_SERVER["PHP_SELF"].'?step=last_import" title="'.$langs->trans('LastImport').'">'.$langs->trans('LastImport').'</a>';
	print '</div></div>';
	print '<div class="inline-block tabsElem tabsElemActive">';
	print '<!-- id tab = step1 --><div class="tab tabactive" style="margin: 0 !important">';
	print '<a id="file" class="tab inline-block" href="'.$_SERVER["PHP_SELF"].'?step=history" title="'.$langs->trans('ImportHistory').'">'.$langs->trans('ImportHistory').'</a>';
	print '</div></div>';
	print '<div class="inline-block tabsElem tabsElemActive">';
	print '<!-- id tab = step1 --><div class="tab tabactive" style="margin: 0 !important">';
	print '<a id="file" class="tab inline-block" href="'.$_SERVER["PHP_SELF"].'?step=logs" title="'.$langs->trans('ImportLogs').'">'.$langs->trans('ImportLogs').'</a>';
	print '</div></div>';
print '</div>';

/**
 * VIEW
 */

// Details of the last import
if($step == 'last_import') {
	print '<div class="div-table-responsive">'; // You can use div-table-responsive-no-min if you dont need reserved height for your table
		print '<table class="tagtable nobottomiftotal liste'.($moreforfilter ? " listwithfilterbefore" : "").'">'."\n";

			// Fields title label
			// --------------------------------------------------------------------
			print '<tr class="liste_titre">';
				print '<th class="wrapcolumntitle liste_titre">'.$langs->trans('Product').'</th>';
			foreach ($object->fields as $key => $val) {
				$cssforfield = (empty($val['csslist']) ? (empty($val['css']) ? '' : $val['css']) : $val['csslist']);
				if ($key == 'status') {
					$cssforfield .= ($cssforfield ? ' ' : '').'center';
				} elseif (in_array($val['type'], array('date', 'datetime', 'timestamp'))) {
					$cssforfield .= ($cssforfield ? ' ' : '').'center';
				} elseif (in_array($val['type'], array('timestamp'))) {
					$cssforfield .= ($cssforfield ? ' ' : '').'nowrap';
				} elseif (in_array($val['type'], array('double', 'integer', 'real', 'price')) && $val['label'] != 'TechnicalID' && empty($val['arrayofkeyval'])) {
					$cssforfield .= ($cssforfield ? ' ' : '').'right';
				}
				if (!empty($arrayfields['t.'.$key]['checked'])) {
					print getTitleFieldOfList($arrayfields['t.'.$key]['label'], 0, $_SERVER['PHP_SELF'], 't.'.$key, '', $param, ($cssforfield ? 'class="'.$cssforfield.'"' : ''), $sortfield, $sortorder, ($cssforfield ? $cssforfield.' ' : ''))."\n";
				}
			}
			// Extra fields
			include DOL_DOCUMENT_ROOT.'/core/tpl/extrafields_list_search_title.tpl.php';
			// Hook fields
			$parameters = array('arrayfields'=>$arrayfields, 'param'=>$param, 'sortfield'=>$sortfield, 'sortorder'=>$sortorder);
			$reshook = $hookmanager->executeHooks('printFieldListTitle', $parameters, $object); // Note that $action and $object may have been modified by hook
			print $hookmanager->resPrint;
			// Action column
			print getTitleFieldOfList($selectedfields, 0, $_SERVER["PHP_SELF"], '', '', '', '', $sortfield, $sortorder, 'center maxwidthsearch ')."\n";
			print '</tr>'."\n";


			// Detect if we need a fetch on each output line
			$needToFetchEachLine = 0;
			if (isset($extrafields->attributes[$object->table_element]['computed']) && is_array($extrafields->attributes[$object->table_element]['computed']) && count($extrafields->attributes[$object->table_element]['computed']) > 0) {
				foreach ($extrafields->attributes[$object->table_element]['computed'] as $key => $val) {
					if (preg_match('/\$object/', $val)) {
						$needToFetchEachLine++; // There is at least one compute field that use $object
					}
				}
			}


			// Loop on record
			// --------------------------------------------------------------------
			$i = 0;
			$totalarray = array();
			$totalarray['nbfield'] = 0;
			while ($i < ($limit ? min($num, $limit) : $num)) {
				$obj = $db->fetch_object($resql);

				if (empty($obj)) {
					break; // Should not happen
				}

				// Store properties in $object
				//$object->setVarsFromFetchObj($obj);
				
				// Show here line of result
				print '<tr class="oddeven">';
				foreach ($obj as $key => $val) {
					
					if ($key == 'rowid') {
						print '<td><a href="'.dol_buildpath('/product/card.php', 1).'?id='.$obj->fk_product.'">'.$obj->label.'</a></td>';
					}
					if (!empty($arrayfields['t.'.$key]['checked'])) {
						print '<td class="'.($key == 'import_date' ? 'center' : 'right').'">';
							if ($key == 'status') {
								print $obj->getLibStatut(5);
							} elseif ($key == 'price') {
								print $obj->pr.' '.$langs->trans("HT-Tag");
							}else {
								print $obj->$key;
							}
						print '</td>';
						if (!$i) {
							$totalarray['nbfield']++;
						}
						if (!empty($val['isameasure']) && $val['isameasure'] == 1) {
							if (!$i) {
								$totalarray['pos'][$totalarray['nbfield']] = 't.'.$key;
							}
							if (!isset($totalarray['val'])) {
								$totalarray['val'] = array();
							}
							if (!isset($totalarray['val']['t.'.$key])) {
								$totalarray['val']['t.'.$key] = 0;
							}
							$totalarray['val']['t.'.$key] += $obj->$key;
						}
					}
				}
				// Extra fields
				include DOL_DOCUMENT_ROOT.'/core/tpl/extrafields_list_print_fields.tpl.php';
				// Fields from hook
				$parameters = array('arrayfields'=>$arrayfields, 'object'=>$object, 'obj'=>$obj, 'i'=>$i, 'totalarray'=>&$totalarray);
				$reshook = $hookmanager->executeHooks('printFieldListValue', $parameters, $object); // Note that $action and $object may have been modified by hook
				print $hookmanager->resPrint;
				// Action column
				print '<td class="nowrap center">';
				if ($massactionbutton || $massaction) { // If we are in select mode (massactionbutton defined) or if we have already selected and sent an action ($massaction) defined
					$selected = 0;
					if (in_array($object->id, $arrayofselected)) {
						$selected = 1;
					}
					print '<input id="cb'.$object->id.'" class="flat checkforselect" type="checkbox" name="toselect[]" value="'.$object->id.'"'.($selected ? ' checked="checked"' : '').'>';
				}
				print '</td>';
				if (!$i) {
					$totalarray['nbfield']++;
				}

				print '</tr>'."\n";

				$i++;
			}

			// Show total line
			include DOL_DOCUMENT_ROOT.'/core/tpl/list_print_total.tpl.php';

			// If no record found
			if ($num == 0) {
				$colspan = 1;
				foreach ($arrayfields as $key => $val) {
					if (!empty($val['checked'])) {
						$colspan++;
					}
				}
				print '<tr><td colspan="'.$colspan.'"><span class="opacitymedium">'.$langs->trans("NoCSVFileFound").'</span></td></tr>';
			}


			$db->free($resql);

			$parameters = array('arrayfields'=>$arrayfields, 'sql'=>$sql);
			$reshook = $hookmanager->executeHooks('printFieldListFooter', $parameters, $object); // Note that $action and $object may have been modified by hook
			print $hookmanager->resPrint;

		print '</table>'."\n";
	print '</div>'."\n";
}

// Import history
if($step == 'history') {
	print '<div class="div-table-responsive">'; // You can use div-table-responsive-no-min if you dont need reserved height for your table
		print '<table class="tagtable nobottomiftotal liste'.($moreforfilter ? " listwithfilterbefore" : "").'">'."\n";
			print '<tr class="liste_titre">';
				print '<th class="wrapcolumntitle liste_titre">'.$langs->trans("FileName").'</th>';
				print '<th class="wrapcolumntitle liste_titre center">'.$langs->trans("FileSize").'</th>';
				print '<th class="wrapcolumntitle liste_titre center">'.$langs->trans("ImportDate").'</th>';
				print '<th class="wrapcolumntitle liste_titre center">'.$langs->trans("NumberOfProducts").'</th>';
				print '<th class="wrapcolumntitle liste_titre center">'.$langs->trans("Action").'</th>';
			print '</tr>'."\n";

			$sql = "SELECT DISTINCT filepath, import_date, import_key";
			$sql .= " FROM ".MAIN_DB_PREFIX.$object->table_element;
			$resql = $db->query($sql);
			$num = $db->num_rows($resql);
			
			$i = 0;
			$totalarray = array();
			$totalarray['nbfield'] = 0;

			$modulepart = 'stormatic';
			while ($i < $num) {
				$obj = $db->fetch_object($resql);
				
				print '<tr class="oddeven">';
					if($obj->filepath) {
						// The file and its size
						print '<td><a href="'.dol_buildpath('documents.php',1).'?modulepart='.$modulepart.'&file=temp/'.$obj->filepath.'">'.$obj->filepath.'</a></td>';
						print '<td class="center">'.dol_filesize(DOL_DATA_ROOT.'/'.$modulepart.'/temp/'.$obj->filepath).' octet</td>';
					}

					// Import date
					if($obj->import_date) {
						print '<td class="center">'.$obj->import_date.'</td>';
					}
					
					// Total of products imported from this specific file
					if($obj->import_key) {
						$sql = "SELECT rowid";
						$sql .= " FROM ".MAIN_DB_PREFIX.$object->table_element;
						$sql .= " WHERE import_key = $obj->import_key";
						$resql2 = $db->query($sql);
						$total_product = $db->num_rows($resql2);
						print '<td class="center">'.$total_product.'</td>';
					}
					print '<td class="center">X</td>';
				print '</tr>';
				$i++;
			}
			if($num == 0) {
				$colspan = 1;
				foreach ($arrayfields as $key => $val) {
					if (!empty($val['checked'])) {
						$colspan++;
					}
				}
				print '<tr><td colspan="'.$colspan.'"><span class="opacitymedium">'.$langs->trans("NoCSVFileFound").'</span></td></tr>';
			}

		print '</table>';
	print '</div>';
}

// Logs
if($step == 'logs') {
	print '<pre>'.var_export($user->login, true).'</pre>'; die;
}

// if (in_array('builddoc', $arrayofmassactions) && ($nbtotalofrecords === '' || $nbtotalofrecords)) {
// 	$hidegeneratedfilelistifempty = 1;
// 	if ($massaction == 'builddoc' || $action == 'remove_file' || $show_files) {
// 		$hidegeneratedfilelistifempty = 0;
// 	}

// 	require_once DOL_DOCUMENT_ROOT.'/core/class/html.formfile.class.php';
// 	$formfile = new FormFile($db);

// 	// Show list of available documents
// 	$urlsource = $_SERVER['PHP_SELF'].'?sortfield='.$sortfield.'&sortorder='.$sortorder;
// 	$urlsource .= str_replace('&amp;', '&', $param);

// 	$filedir = $diroutputmassaction;
// 	$genallowed = $permissiontoread;
// 	$delallowed = $permissiontoadd;

// 	print $formfile->showdocuments('massfilesarea_', '', $filedir, $urlsource, 0, $delallowed, '', 1, 1, 0, 48, 1, $param, $title, '', '', '', null, $hidegeneratedfilelistifempty);
// }

// End of page
llxFooter();
$db->close();

