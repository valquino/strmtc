<?php
/* Copyright (C) 2018 Marcello Gribaudo  <marcello.gribaudo@opigi.com>
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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * \file    crmenhanced/admin/setup.php
 * \ingroup crmenhanced
 * \brief   crmenhanced setup page.
 */

// Load Dolibarr environment
$res=0;
// Try main.inc.php into web root known defined into CONTEXT_DOCUMENT_ROOT (not always defined)
if (! $res && ! empty($_SERVER["CONTEXT_DOCUMENT_ROOT"])) $res=@include($_SERVER["CONTEXT_DOCUMENT_ROOT"]."/main.inc.php");
// Try main.inc.php into web root detected using web root caluclated from SCRIPT_FILENAME
$tmp=empty($_SERVER['SCRIPT_FILENAME'])?'':$_SERVER['SCRIPT_FILENAME'];$tmp2=realpath(__FILE__); $i=strlen($tmp)-1; $j=strlen($tmp2)-1;
while($i > 0 && $j > 0 && isset($tmp[$i]) && isset($tmp2[$j]) && $tmp[$i]==$tmp2[$j]) { $i--; $j--; }
if (! $res && $i > 0 && file_exists(substr($tmp, 0, ($i+1))."/main.inc.php")) $res=@include(substr($tmp, 0, ($i+1))."/main.inc.php");
if (! $res && $i > 0 && file_exists(dirname(substr($tmp, 0, ($i+1)))."/main.inc.php")) $res=@include(dirname(substr($tmp, 0, ($i+1)))."/main.inc.php");
// Try main.inc.php using relative path
if (! $res && file_exists("../../main.inc.php")) $res=@include("../../main.inc.php");
if (! $res && file_exists("../../../main.inc.php")) $res=@include("../../../main.inc.php");
if (! $res) die("Include of main fails");

global $langs, $user;

// Libraries
require_once DOL_DOCUMENT_ROOT . "/core/lib/admin.lib.php";
require_once '../lib/crmenhanced.lib.php';
//require_once "../class/myclass.class.php";

// Translations
$langs->loadLangs(array("admin", "crmenhanced@crmenhanced"));

// Access control
if (! $user->admin) 
    accessforbidden();

// Parameters
$action = GETPOST('action', 'alpha');
$backtopage = GETPOST('backtopage', 'alpha');

$arrayofparameters=array('CRMENHANCED_MAIL_MODALITY'=>array('table'=>'crm_activity_mode'), 
                         'CRMENHANCED_SMS_MODALITY'=>array('table'=>'crm_activity_mode'),
                         'CRMENHANCED_DEFAULT_STATUS'=>array('table'=>'crm_activity_status'),
                         'CRMENHANCED_DEFAULT_OBJECT'=>array('table'=>'crm_activity_object'),
                        );


/*
 * Actions
 */

if ($action == 'update') {
    dolibarr_set_const($db, 'CRMENHANCED_MAIL_MODALITY', GETPOST('CRMENHANCED_MAIL_MODALITY', 'array')[0],'chaine',0,'',$conf->entity);
    dolibarr_set_const($db, 'CRMENHANCED_SMS_MODALITY', GETPOST('CRMENHANCED_SMS_MODALITY', 'array')[0],'chaine',0,'',$conf->entity);
    dolibarr_set_const($db, 'CRMENHANCED_DEFAULT_STATUS', GETPOST('CRMENHANCED_DEFAULT_STATUS', 'array')[0],'chaine',0,'',$conf->entity);
    dolibarr_set_const($db, 'CRMENHANCED_DEFAULT_OBJECT', GETPOST('CRMENHANCED_DEFAULT_OBJECT', 'array')[0],'chaine',0,'',$conf->entity);
}
//include DOL_DOCUMENT_ROOT.'/core/actions_setmoduleoptions.inc.php';

/*
 * View
 */

$page_name = "crmenhancedSetup";
llxHeader('', $langs->trans($page_name));

// Subheader
$linkback = '<a href="'.($backtopage?$backtopage:DOL_URL_ROOT.'/admin/modules.php?restore_lastsearch_values=1').'">'.$langs->trans("BackToModuleList").'</a>';

print load_fiche_titre($langs->trans($page_name), $linkback, 'object_crmenhanced@crmenhanced');

// Configuration header
$head = crmenhancedAdminPrepareHead();
dol_fiche_head($head, 'settings', '', -1, "crmenhanced@crmenhanced");

// Setup page goes here
echo $langs->trans("crmenhancedSetupPage");


print '<form name="setupform" method="POST" action="'.$_SERVER["PHP_SELF"].'">';
print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
print '<input type="hidden" name="action" value="update">';

if ($action == 'edit') {

    print '<table class="noborder" width="100%">';
    print '<tr class="liste_titre"><td class="titlefield">'.$langs->trans("Parameter").'</td><td colspan="2">'.$langs->trans("Value").'</td></tr>';

    foreach($arrayofparameters as $key => $val) {
        print '<tr class="oddeven"><td>';
        print $form->textwithpicto($langs->trans($key),$langs->trans($key.'Tooltip')).'</td>';
        print '<td>';
        print selectDictionary($key, $val['table'], $conf->global->$key);
        print '<td></td>';
        print '</tr>';
    }

    print '</table>';

    print '<br><div class="center">';
    print '<input class="button" type="submit" value="'.$langs->trans("Save").'">';
    print '</div>';

} else {
    print '<table class="noborder" width="100%">';
    print '<tr class="liste_titre"><td class="titlefield">'.$langs->trans("Parameter").'</td><td colspan="2">'.$langs->trans("Value").'</td></tr>';

    foreach($arrayofparameters as $key => $val) {
        print '<tr class="oddeven"><td>';
        print $form->textwithpicto($langs->trans($key),$langs->trans($key.'Tooltip')).'</td>';
        print '</td><td>';
        print dictionaryLabel($val['table'], $conf->global->$key);
        print '</td>';
        print '<td></td>';
        print '</tr>';
    }

    print '</table>';

    print '<div class="tabsAction">';
    print '<a class="butAction" href="'.$_SERVER["PHP_SELF"].'?action=edit">'.$langs->trans("Modify").'</a>';
    print '</div>';
}
print '</form>';
print '<br>';


// Page end
dol_fiche_end();

llxFooter();
$db->close();
