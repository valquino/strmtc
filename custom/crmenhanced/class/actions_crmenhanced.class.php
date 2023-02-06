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
 * \file    crmenhanced/class/actions_crmenhanced.class.php
 * \ingroup crmenhanced
 * \brief   Example hook overload.
 *
 * Put detailed description here.
 */

/**
 * Class Actionscrmenhanced
 */
class Actionscrmenhanced
{
    /**
     * @var DoliDB Database handler.
     */
    public $db;
    /**
     * @var string Error
     */
    public $error = '';
    /**
     * @var array Errors
     */
    public $errors = array();


    /**
     * @var array Hook results. Propagated to $hookmanager->resArray for later reuse
     */
    public $results = array();

    /**
     * @var string String displayed by executeHook() immediately after return
     */
    public $resprints;


    /**
     * Constructor
     *
     *  @param		DoliDB		$db      Database handler
     */
    public function __construct($db)
    {
        $this->db = $db;
    }

    /**
     * Overloading the SendMail function : replacing the parent's function with the one below
     *
     * @param   array()         $parameters     Hook metadatas (context, etc...)
     * @param   CommonObject    $object         The object to process (an invoice if you are in invoice module, a propale in propale's module, etc...)
     * @param   string          $action         Current action (if set). Generally create or edit or null
     * @param   HookManager     $hookmanager    Hook manager propagated to allow calling another hook
     * @return  int                             < 0 on error, 0 on success, 1 to replace standard code
     */
    public function sendMail($parameters, &$object, &$action, $hookmanager){
        global $conf, $langs;
                
    }
    
    /**
     * Overloading the doActions function : replacing the parent's function with the one below
     *
     * @param   array()         $parameters     Hook metadatas (context, etc...)
     * @param   CommonObject    $object         The object to process (an invoice if you are in invoice module, a propale in propale's module, etc...)
     * @param   string          $action         Current action (if set). Generally create or edit or null
     * @param   HookManager     $hookmanager    Hook manager propagated to allow calling another hook
     * @return  int                             < 0 on error, 0 on success, 1 to replace standard code
     */
    public function doActions($parameters, &$object, &$action, $hookmanager) {
        global $db, $user, $conf, $langs;

        $error = 0; // Error counter
        
        // Sending mail Hook
        if ($parameters['currentcontext'] == 'globalcard' && $action == 'send' && 
            ! $_POST['addfile'] && ! $_POST['removAll'] && ! $_POST ['removedfile'] && ! $_POST['cancel'] && !$_POST['modelselected']) {
        require_once 'activity.class.php';
        
        // Create a new thirdparty activity 
        $activitystatic = new Activity($db);
        $ret = 1; 
        
        $activitystatic->datec = dol_now();
        $activitystatic->priority = 0;
        $activitystatic->activity_type = 'O';
        if ($conf->global->CRMENHANCED_MAIL_MODALITY)
            $activitystatic->fk_mode = $conf->global->CRMENHANCED_MAIL_MODALITY;
        else {
            $this->errors[] = $langs->trans('DefaultoModeIsRequired');
            $ret = -1;
        }
            
        if (isset($object->socid)) {
           $activitystatic->fk_thirdparty  = $object->socid;
        } else {
            $activitystatic->fk_thirdparty  = $object->id;
        }
        $activitystatic->fk_owner = $user->id;
        if ($conf->global->CRMENHANCED_DEFAULT_STATUS)
            $activitystatic->fk_status = $conf->global->CRMENHANCED_DEFAULT_STATUS;
        else {
            $this->errors[] = $langs->trans('DefaultoStatusIsRequired');
            $ret = -1;
        }
        if ($conf->global->CRMENHANCED_DEFAULT_OBJECT)
            $activitystatic->fk_object = $conf->global->CRMENHANCED_DEFAULT_OBJECT; 
        else {
            $this->errors[] = $langs->trans('DefaultoObjectIsRequired');
            $ret = -1;
        }
        $activitystatic->note = $_POST['message'];
        
        if ($ret > 0) {
            $ret = $activitystatic->create();
            if ($ret <= 0)
                $this->errors[] = $activitystatic->error;
        }
        
        if ($ret > 0) {
            return 0;
        } else {
            return -1;
        }        

        }
    }
    
        

}
