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
//require_once DOL_DOCUMENT_ROOT.'/core/modules/import/modules_import.php';
//require_once DOL_DOCUMENT_ROOT.'/custom/stormatic/core/modules/modStormatic.class.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/files.lib.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/images.lib.php';
//require_once DOL_DOCUMENT_ROOT.'/core/lib/import.lib.php';
dol_include_once('/stormatic/class/csv.class.php');
dol_include_once('/stormatic/lib/stormatic_csv.lib.php');

require_once DOL_DOCUMENT_ROOT.'/product/class/product.class.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/product.lib.php';

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
$type = (GETPOSTISSET('type') ? GETPOST('type', 'int') : Product::TYPE_PRODUCT);
$step = (GETPOST('step') ? GETPOST('step') : 1);

if ($id > 0 || !empty($ref)) {
	$object = new Product($db);
	$object->type = $type; // so test later to fill $usercancxxx is correct
	$object->fetch($id, $ref);
}

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

// Security check (enable the most restrictive one)
//if ($user->socid > 0) accessforbidden();
//if ($user->socid > 0) $socid = $user->socid;
//$isdraft = (isset($object->status) && ($object->status == $object::STATUS_DRAFT) ? 1 : 0);
//restrictedArea($user, $object->element, $object->id, $object->table_element, '', 'fk_soc', 'rowid', $isdraft);
if (empty($conf->stormatic->enabled)) accessforbidden();
if (!$permissiontoread) accessforbidden();


/*
 * ACTIONS
 */


/*
 * VIEW
 */

// $title = $langs->trans("Csv");
// $help_url = '';
// llxHeader('', $title, $help_url);

/** 
 * ABQUE FOR A SPECIFIC PRODUCT
 * .
 */
if (!empty($id) || !empty($ref)) {
	// llxHeader('', $title, $helpurl, '', 0, 0, '', '', '', 'classforhorizontalscrolloftabs');
	llxHeader("", "", $langs->trans("CardProduct".$object->type));

	$head = product_prepare_head($object);
	$titre = $langs->trans("CardProduct".$object->type);
	$picto = 'product';

	print dol_get_fiche_head($head, 'price', $titre, -1, $picto);

	$linkback = '<a href="'.DOL_URL_ROOT.'/product/list.php?step=last_import">'.$langs->trans("BackToList").'</a>';
	$object->next_prev_filter = " fk_product_type = ".$object->type;
	//print '<pre>'.var_export($object, true).'</pre>';

	dol_banner_tab($object, 'product', $linkback, ($user->socid ? 0 : 1), 'product', '', '', '', 0, '', '');

	print '<div class="underbanner clearboth"></div>';
	print '<br />';

	print '<div>Les différentes déclinaisons du produit</div>';
	print '<br />';

	print '<div class="div-table-responsive">'; // You can use div-table-responsive-no-min if you dont need reserved height for your table
		print '<table class="tagtable nobottomiftotal liste'.($moreforfilter ? " listwithfilterbefore" : "").'">'."\n";
			print '<tr class="liste_titre">';
				print '<th class="wrapcolumntitle liste_titre left">'.$langs->trans("Product").'</th>';
				print '<th class="wrapcolumntitle liste_titre right">'.$langs->trans("Height").'</th>';
				print '<th class="wrapcolumntitle liste_titre right">'.$langs->trans("Width").'</th>';
				print '<th class="wrapcolumntitle liste_titre right">'.$langs->trans("Price").'</th>';
			print '</tr>'."\n";

		$sql = "SELECT t.height, t.width, p.label, CAST(t.price AS DECIMAL(7,2)) AS pr";
		$sql .= " FROM ".MAIN_DB_PREFIX."stormatic_csv AS t";
		$sql .= " JOIN ".MAIN_DB_PREFIX.$object->table_element." AS p ON t.fk_product = p.rowid";
		$sql .= " WHERE p.rowid = $id";
		$resql = $db->query($sql);
		if ($resql) {
			$num = $db->num_rows($resql);
			for($i=0; $i < $num; $i++) {
				$obj = $db->fetch_object($resql);
				print '<tr class="oddeven">';
					print '<td class="left">'.$obj->label.'</td>';
					print '<td class="right">'.$obj->height.' cm</td>';
					print '<td class="right">'.$obj->width.' cm</td>';
					print '<td class="right">'.$obj->pr.' HT</td>';
				print '</tr>';
			}
		} else {
			dol_print_error($db);
		}
		print '</table>';
	print '</div>';

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