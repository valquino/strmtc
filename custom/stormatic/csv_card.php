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

//if (! defined('NOREQUIREDB'))              define('NOREQUIREDB', '1');				// Do not create database handler $db
//if (! defined('NOREQUIREUSER'))            define('NOREQUIREUSER', '1');				// Do not load object $user
//if (! defined('NOREQUIRESOC'))             define('NOREQUIRESOC', '1');				// Do not load object $mysoc
//if (! defined('NOREQUIRETRAN'))            define('NOREQUIRETRAN', '1');				// Do not load object $langs
//if (! defined('NOSCANGETFORINJECTION'))    define('NOSCANGETFORINJECTION', '1');		// Do not check injection attack on GET parameters
//if (! defined('NOSCANPOSTFORINJECTION'))   define('NOSCANPOSTFORINJECTION', '1');		// Do not check injection attack on POST parameters
//if (! defined('NOCSRFCHECK'))              define('NOCSRFCHECK', '1');				// Do not check CSRF attack (test on referer + on token).
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
//if (! defined('NOSESSION'))     		     define('NOSESSION', '1');				    // Disable session

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
require_once DOL_DOCUMENT_ROOT.'/core/class/html.formfile.class.php';
require_once DOL_DOCUMENT_ROOT.'/core/class/html.formother.class.php';
require_once DOL_DOCUMENT_ROOT.'/core/modules/import/modules_import.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/files.lib.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/images.lib.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/import.lib.php';
require_once DOL_DOCUMENT_ROOT . '/product/class/product.class.php';
dol_include_once('/stormatic/class/csv.class.php');
dol_include_once('/stormatic/lib/stormatic_csv.lib.php');

// Load translation files required by the page
$langs->loadLangs(array("stormatic@stormatic", "other"));

// Get parameters
$id = GETPOST('id', 'int');
$ref = GETPOST('ref', 'alpha');
$action = GETPOST('action', 'aZ09');
$confirm = GETPOST('confirm', 'alpha');
$cancel = GETPOST('cancel', 'aZ09');
$contextpage = GETPOST('contextpage', 'aZ') ? GETPOST('contextpage', 'aZ') : 'csvcard'; // To manage different context of search
$backtopage = GETPOST('backtopage', 'alpha');
$backtopageforcancel = GETPOST('backtopageforcancel', 'alpha');
$lineid   = GETPOST('lineid', 'int');

// load stormatic libraries
require_once __DIR__.'/class/csv.class.php';

// For files imports
$datatoimport		= GETPOST('datatoimport');
$format				= 'csv';
$filetoimport		= GETPOST('filetoimport');
$action				= GETPOST('action', 'alpha');
$confirm			= GETPOST('confirm', 'alpha');
$step				= (GETPOST('step') ? GETPOST('step') : 1);
$import_name = GETPOST('import_name');
$hexa				= GETPOST('hexa');
$importmodelid = GETPOST('importmodelid');
$excludefirstline = (GETPOST('excludefirstline') ? GETPOST('excludefirstline') : 2);
$endatlinenb		= (GETPOST('endatlinenb') ? GETPOST('endatlinenb') : '');
$updatekeys			= (GETPOST('updatekeys', 'array') ? GETPOST('updatekeys', 'array') : array());
$separator			= (GETPOST('separator', 'nohtml') ? GETPOST('separator', 'nohtml') : (!empty($conf->global->IMPORT_CSV_SEPARATOR_TO_USE) ? $conf->global->IMPORT_CSV_SEPARATOR_TO_USE : ','));
$enclosure			= (GETPOST('enclosure', 'nohtml') ? GETPOST('enclosure', 'nohtml') : '"');
$separator_used     = str_replace('\t', "\t", $separator);

$object = new Csv($db);

$objmodelimport = new ModeleImports();

$form = new Form($db);
$htmlother = new FormOther($db);
$formfile = new FormFile($db);

// There is several ways to check permission.
// Set $enablepermissioncheck to 1 to enable a minimum low level of checks
$enablepermissioncheck = 0;
if ($enablepermissioncheck) {
	$permissiontoread = $user->rights->stormatic->csv->read;
	$permissiontoadd = $user->rights->stormatic->csv->write; // Used by the include of actions_addupdatedelete.inc.php and actions_lineupdown.inc.php
	$permissiontodelete = $user->rights->stormatic->csv->delete || ($permissiontoadd && isset($object->status) && $object->status == $object::STATUS_DRAFT);
	$permissionnote = $user->rights->stormatic->csv->write; // Used by the include of actions_setnotes.inc.php
	$permissiondellink = $user->rights->stormatic->csv->write; // Used by the include of actions_dellink.inc.php
} else {
	$permissiontoread = 1;
	$permissiontoadd = 1; // Used by the include of actions_addupdatedelete.inc.php and actions_lineupdown.inc.php
	$permissiontodelete = 1;
	$permissionnote = 1;
	$permissiondellink = 1;
}

$upload_dir = $conf->stormatic->multidir_output[isset($object->entity) ? $object->entity : 1].'/csv';

if (empty($conf->stormatic->enabled)) accessforbidden();
if (!$permissiontoread) accessforbidden();


/*
 * ACTIONS
 */

if ($action == 'deleteprof') {
	if (GETPOST("id", 'int')) {
		$objimport->fetch(GETPOST("id", 'int'));
		$result = $objimport->delete($user);
	}
}

/*
 * VIEW
 */

$title = $langs->trans("Csv");
$help_url = '';
llxHeader('', $title, $help_url);

/** 
 * STEP 1 : DEBUT OF IMPORT
 */
if($step == 'import' && $datatoimport) {

	// Save file
	if (GETPOST('sendit') && !empty($conf->global->MAIN_UPLOAD_DOC)) {

		dol_mkdir($conf->stormatic->dir_temp);
		$nowyearmonth = dol_print_date(dol_now(), '%Y%m%d%H%M%S');

		$fullpath = $conf->stormatic->dir_temp."/".$nowyearmonth.'-'.$_FILES['userfile']['name'];
		if (dol_move_uploaded_file($_FILES['userfile']['tmp_name'], $fullpath, 1) > 0) {
			dol_syslog("File ".$fullpath." was added for import");
		} else {
			$langs->load("errors");
			setEventMessages($langs->trans("ErrorFailedToSaveFile"), null, 'errors');
		}
	}

	// Delete file
	if ($action == 'confirm_deletefile' && $confirm == 'yes') {
		$langs->load("other");

		$param = '&datatoimport='.urlencode($datatoimport).'&format='.urlencode($format);
		if ($excludefirstline) {
			$param .= '&excludefirstline='.urlencode($excludefirstline);
		}
		if ($endatlinenb) {
			$param .= '&endatlinenb='.urlencode($endatlinenb);
		}

		$file = $conf->stormatic->dir_temp.'/'.GETPOST('urlfile'); // Do not use urldecode here ($_GET and $_REQUEST are already decoded by PHP).
		$ret = dol_delete_file($file);
		if ($ret) {
			setEventMessages($langs->trans("FileWasRemoved", GETPOST('urlfile')), null, 'mesgs');
		} else {
			setEventMessages($langs->trans("ErrorFailToDeleteFile", GETPOST('urlfile')), null, 'errors');
		}
		Header('Location: '.$_SERVER["PHP_SELF"].'?step='.$step.$param);
		exit;
	}

	$param = '&datatoimport='.urlencode($datatoimport).'&format='.urlencode($format);
	if ($excludefirstline) {
		$param .= '&excludefirstline='.urlencode($excludefirstline);
	}
	if ($endatlinenb) {
		$param .= '&endatlinenb='.urlencode($endatlinenb);
	}
	if ($separator) {
		$param .= '&separator='.urlencode($separator);
	}
	if ($enclosure) {
		$param .= '&enclosure='.urlencode($enclosure);
	}

	$list = $objmodelimport->liste_modeles($db);

	/*
	* Confirm delete file
	*/
	if ($action == 'delete') {
		print $form->formconfirm($_SERVER["PHP_SELF"].'?urlfile='.urlencode(GETPOST('urlfile')).'&step=import'.$param, $langs->trans('DeleteFile'), $langs->trans('ConfirmDeleteFile'), 'confirm_deletefile', '', 0, 1);
	}

	print '<div class="underbanner clearboth"></div>';

	if ($format == 'xlsx' && !class_exists('XMLWriter')) {
		$langs->load("install");
		print info_admin($langs->trans("ErrorPHPDoesNotSupport", 'php-xml'), 0, 0, 1, 'error');
	}

	print '<br>';

	print '<form name="" action="'.$_SERVER["PHP_SELF"].'" enctype="multipart/form-data" METHOD="POST">';
		print '<input type="hidden" name="token" value="'.newToken().'">';
		print '<input type="hidden" name="max_file_size" value="'.$conf->maxfilesize.'">';

		print '<input type="hidden" value="'.$step.'" name="step">';
		print '<input type="hidden" value="'.dol_escape_htmltag($format).'" name="format">';
		print '<input type="hidden" value="'.$excludefirstline.'" name="excludefirstline">';
		print '<input type="hidden" value="'.$endatlinenb.'" name="endatlinenb">';
		print '<input type="hidden" value="'.dol_escape_htmltag($separator).'" name="separator">';
		print '<input type="hidden" value="'.dol_escape_htmltag($enclosure).'" name="enclosure">';
		print '<input type="hidden" value="'.dol_escape_htmltag($datatoimport).'" name="datatoimport">';

		print '<span class="opacitymedium">';
		$s = $langs->trans("ChooseFileToImport", '{s1}');
		$s = str_replace('{s1}', img_picto('', 'next'), $s);
		print $s;
		print '</span><br><br>';

		$filetoimport = '';

		// Input file name box
		print '<div class="marginbottomonly">';
		print '<input type="file" name="userfile" size="20" maxlength="80"> &nbsp; &nbsp; ';
		$out = (empty($conf->global->MAIN_UPLOAD_DOC) ? ' disabled' : '');
		print '<input type="submit" class="button small" value="'.$langs->trans("AddFile").'"'.$out.' name="sendit">';
		$out = '';
		if (!empty($conf->global->MAIN_UPLOAD_DOC)) {
			$max = $conf->global->MAIN_UPLOAD_DOC; // In Kb
			$maxphp = @ini_get('upload_max_filesize'); // In unknown
			if (preg_match('/k$/i', $maxphp)) {
				$maxphp = $maxphp * 1;
			}
			if (preg_match('/m$/i', $maxphp)) {
				$maxphp = $maxphp * 1024;
			}
			if (preg_match('/g$/i', $maxphp)) {
				$maxphp = $maxphp * 1024 * 1024;
			}
			if (preg_match('/t$/i', $maxphp)) {
				$maxphp = $maxphp * 1024 * 1024 * 1024;
			}
			$maxphp2 = @ini_get('post_max_size'); // In unknown
			if (preg_match('/k$/i', $maxphp2)) {
				$maxphp2 = $maxphp2 * 1;
			}
			if (preg_match('/m$/i', $maxphp2)) {
				$maxphp2 = $maxphp2 * 1024;
			}
			if (preg_match('/g$/i', $maxphp2)) {
				$maxphp2 = $maxphp2 * 1024 * 1024;
			}
			if (preg_match('/t$/i', $maxphp2)) {
				$maxphp2 = $maxphp2 * 1024 * 1024 * 1024;
			}
			// Now $max and $maxphp and $maxphp2 are in Kb
			$maxmin = $max;
			$maxphptoshow = $maxphptoshowparam = '';
			if ($maxphp > 0) {
				$maxmin = min($max, $maxphp);
				$maxphptoshow = $maxphp;
				$maxphptoshowparam = 'upload_max_filesize';
			}
			if ($maxphp2 > 0) {
				$maxmin = min($max, $maxphp2);
				if ($maxphp2 < $maxphp) {
					$maxphptoshow = $maxphp2;
					$maxphptoshowparam = 'post_max_size';
				}
			}

			$langs->load('other');
			$out .= ' ';
			$out .= info_admin($langs->trans("ThisLimitIsDefinedInSetup", $max, $maxphptoshow), 1);
		} else {
			$out .= ' ('.$langs->trans("UploadDisabled").')';
		}
		print $out;
		print '</div>';

		// Search available imports
		$filearray = dol_dir_list($conf->stormatic->dir_temp, 'files', 0, '', '', 'name', SORT_DESC);
		if (count($filearray) > 0) {
			print '<div class="div-table-responsive-no-min">'; // You can use div-table-responsive-no-min if you dont need reserved height for your table
			print '<table class="noborder centpercent" width="100%" cellpadding="4">';

			$dir = $conf->stormatic->dir_temp;

			// Search available files to import
			$i = 0;
			foreach ($filearray as $key => $val) {
				$file = $val['name'];

				// readdir return value in ISO and we want UTF8 in memory
				if (!utf8_check($file)) {
					$file = utf8_encode($file);
				}

				if (preg_match('/^\./', $file)) {
					continue;
				}

				$modulepart = 'stormatic';
				$urlsource = $_SERVER["PHP_SELF"].'?step='.$step.$param.'&filetoimport='.urlencode($filetoimport);
				$relativepath = $file;

				print '<tr class="oddeven">';
				print '<td>';
				print img_mime($file, '', 'pictofixedwidth');
				print '<a data-ajax="false" href="'.DOL_URL_ROOT.'/document.php?modulepart='.$modulepart.'&file='.urlencode($relativepath).'&step=import'.$param.'" target="_blank" rel="noopener noreferrer">';
				print $file;
				print '</a>';
				print '</td>';
				// Affiche taille fichier
				print '<td style="text-align:right">'.dol_print_size(dol_filesize($dir.'/'.$file)).'</td>';
				// Affiche date fichier
				print '<td style="text-align:right">'.dol_print_date(dol_filemtime($dir.'/'.$file), 'dayhour').'</td>';
				// Del button
				print '<td style="text-align:right"><a href="'.$_SERVER['PHP_SELF'].'?action=delete&token='.newToken().$param.'&urlfile='.urlencode($relativepath);
				print '">'.img_delete().'</a></td>';
				// Action button
				print '<td style="text-align:right">';
				print '<a href="'.$_SERVER['PHP_SELF'].'?step=execute_import'.$param.'&filetoimport='.urlencode($relativepath).'">'.img_picto($langs->trans("NewImport"), 'next', 'class="fa-15x"').'</a>';
				print '</td>';
				print '</tr>';
			}
			print '</table>';
			print '</div>';
		}
	print '</form>';
}

// STEP 2: EXECUTE IMPORT
if($step == 'execute_import'){
	print '<div class="underbanner clearboth"></div>';

	print load_fiche_titre($langs->trans("InformationOnSourceFile"), '', 'file-export');

	print '<div class="underbanner clearboth"></div>';
	print '<div class="fichecenter">';
		print '<table width="100%" class="border">';

			// Source file format
			print '<tr>';
				print '<td class="titlefieldcreate">'.$langs->trans("SourceFileFormat").'</td>';
				print '<td>';
					$text = $objmodelimport->getDriverDescForKey($format);
					print $form->textwithpicto($objmodelimport->getDriverLabelForKey($format), $text);
				print '</td>';
			print '</tr>';

			// File to import
			print '<tr>';
				print '<td>'.$langs->trans("FileToImport").'</td>';
				print '<td>';
					$modulepart = 'stormatic';
					$relativepath = GETPOST('filetoimport');
					print '<a data-ajax="false" href="'.DOL_URL_ROOT.'/document.php?modulepart='.$modulepart.'&file='.urlencode($relativepath).'&step=simulation'.$param.'" target="_blank" rel="noopener noreferrer"></a>';
					print img_mime($file, '', 'pictofixedwidth');
					print $filetoimport;
				print '</td>';
			print '</tr>';

			// Nb of fields
			print '<tr>';
				print '<td>' .$langs->trans("NbOfSourceLines"). '</td>';
				print '<td>' .$nboflines. '</td>';
			print '</tr>';

		print '</table>';
	print '</div>';

	print '<br>';

	$import_products = readCsvFile($conf->stormatic->dir_temp.'/'.$filetoimport);
	array_shift($import_products); // Be careful : The first line of the file will be excluded from the import

	$importid 		= dol_print_date(dol_now(), '%Y%m%d%H%M%S');

	foreach($import_products as $fields => $rows) {
		if(!empty($rows)) {
			$product_abaque = array();

			// Abaque details from the CSV file
			foreach($rows as $field => $value){
				if($field == '0') { // Ref of the product
					$product_abaque['ref'] = $value;
				} else if($field == '1') { // Label of the product
					$product_abaque['label'] = $value;
				} else if($field == '2') { // Price of the product
					$product_abaque['price'] = $value;
				} else if($field == '3') { // Width of the product
					$product_abaque['width'] = $value;
				} else if($field == '4') { // Heigh of the product
					$product_abaque['height'] = $value;
				} else {
					
				}
			}

			// Create the product
			$objectProduct 					= new Product($db);
			$objectProduct->label 			= $product_abaque['label'];
			$objectProduct->ref 			= $product_abaque['ref'];
			$objectProduct->fk_user_author 	= $user->id;
			$objectProduct->status 			= 1;
			$objectProduct->status_buy 		= 1;

			// Check if the product already exists
			$existing_product = $object->customCheckProduct($product_abaque);

			// Retrieve the existing product ID
			if ($existing_product) {
				// Don't insert abaque details if already exists
				if($existing_product == 'product_abaque_exist') {
					unset($objectProduct, $product_abaque);
					continue;
				} else {
					$objectProduct->id = $product_abaque['fk_product'] = $existing_product->rowid;
				}
			// Or create the new product
			} else {
				$objectProduct->create($user);

				// If the insert is OK, we have a new product ID
				if ($objectProduct->id) {
					$product_abaque['fk_product'] = $objectProduct->id;
				} else {
					dol_print_error($db);
				}
			}

			// Store some infos to update the default price later
			$currents_ref_price[] = array(
				'id'		=> $objectProduct->id,
				'ref'		=> $product_abaque['ref'], 
				'price'		=> $product_abaque['price'],
			);
			
			// To avoid conflict with the next import, the product object created or updated is destroyed before creating/updating a new one
			unset($objectProduct, $existing_product); 
			// We don't need the label anymore to insert the abaque values in the db
			unset($product_abaque['label']); 

			// Prepare details for the final step of the import
			$product_abaque['filetoimport'] = $filetoimport;
			$product_abaque['import_date'] = dol_print_date(dol_now(), '%Y-%m-%d %H:%M:%S');;
			$product_abaque['import_key'] = $importid;
			$product_abaque = array_values($product_abaque);
			$abaque_values[] = "('".implode("', '", $product_abaque)."')";
		}
	}

	// If there is new abaque details to insert from the import file
	if($abaque_values) {
		$abaque_values 	= implode(',', $abaque_values);
		$resql 			= $object->customInsertAbaques($abaque_values);

		// Calculate and set the new default price for each abaque products imported 
		$object->customAbaqueDefaultPrice($currents_ref_price);

		// Show result
		print '<br>';
		print '<div class="ok">';
			print $langs->trans("NbOfLinesImported", $nbok).'</b><br>';
			print $langs->trans("NbInsert", empty($existing_product->nbinsert) ? 0 : $existing_product->nbinsert).'<br>';
			print $langs->trans("NbUpdate", empty($existing_product->nbupdate) ? 0 : $existing_product->nbupdate).'<br><br>';
		print '</div>';
		print '<div class="center">';
			print $langs->trans("FileWasImported", $importid).'<br>';
			print '<span class="opacitymedium">'.$langs->trans("YouCanUseImportIdToFindRecord", $importid).'</span><br>';
		print '</div>';
	} else {
		print "Il n'y a aucune nouvelles données à importer !";
	}

	$db->free($resql);
}

// End of page
llxFooter();
$db->close();

function readCsvFile($csv) {
    $file = fopen($csv, 'r');
    while (!feof($file)) {
        $line[] = fgetcsv($file, 1024);
    }
    fclose($file);
    return $line;
}