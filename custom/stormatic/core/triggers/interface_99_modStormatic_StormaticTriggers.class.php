<?php
/* Copyright (C) 2022 SuperAdmin
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
 * \file    core/triggers/interface_99_modStormatic_StormaticTriggers.class.php
 * \ingroup stormatic
 * \brief   Example trigger.
 *
 * Put detailed description here.
 *
 * \remarks You can create other triggers by copying this one.
 * - File name should be either:
 *      - interface_99_modStormatic_MyTrigger.class.php
 *      - interface_99_all_MyTrigger.class.php
 * - The file must stay in core/triggers
 * - The class name must be InterfaceMytrigger
 */

require_once DOL_DOCUMENT_ROOT.'/core/triggers/dolibarrtriggers.class.php';
require_once DOL_DOCUMENT_ROOT.'/core/lib/files.lib.php';
require_once DOL_DOCUMENT_ROOT.'/custom/stormatic/class/csv.class.php';


/**
 *  Class of triggers for Stormatic module
 */
class InterfaceStormaticTriggers extends DolibarrTriggers
{
	/**
	 * Constructor
	 *
	 * @param DoliDB $db Database handler
	 */
	public function __construct($db)
	{
		$this->db = $db;

		$this->name = preg_replace('/^Interface/i', '', get_class($this));
		$this->family = "demo";
		$this->description = "Stormatic triggers.";
		// 'development', 'experimental', 'dolibarr' or version
		$this->version = 'development';
		$this->picto = 'stormatic@stormatic';
	}

	/**
	 * Trigger name
	 *
	 * @return string Name of trigger file
	 */
	public function getName()
	{
		return $this->name;
	}

	/**
	 * Trigger description
	 *
	 * @return string Description of trigger file
	 */
	public function getDesc()
	{
		return $this->description;
	}


	/**
	 * Function called when a Dolibarrr business event is done.
	 * All functions "runTrigger" are triggered if file
	 * is inside directory core/triggers
	 *
	 * @param string 		$action 	Event action code
	 * @param CommonObject 	$object 	Object
	 * @param User 			$user 		Object user
	 * @param Translate 	$langs 		Object langs
	 * @param Conf 			$conf 		Object conf
	 * @return int              		<0 if KO, 0 if no triggered ran, >0 if OK
	 */
	public function runTrigger($action, $object, User $user, Translate $langs, Conf $conf)
	{
		if (empty($conf->stormatic) || empty($conf->stormatic->enabled)) {
			return 0; // If module is not enabled, we do nothing
		}

		// Put here code you want to execute when a Dolibarr business events occurs.
		// Data and type of action are stored into $object and $action

		// You can isolate code for each action in a separate method: this method should be named like the trigger in camelCase.
		// For example : COMPANY_CREATE => public function companyCreate($action, $object, User $user, Translate $langs, Conf $conf)

		// Or you can execute some code here
		switch ($action) {
			
			case 'COMPANY_CREATE':
				$this->companyCreate($action, $object);
				break;
			case 'PRODUCT_DELETE':
				$this->productDelete($action, $object);
				break;
			case 'LINEPROPAL_UPDATE':
				$this->linepropalUpdate($action, $object);
				break;
			case 'LINEORDER_UPDATE':
				$this->lineorderUpdate($action, $object);
				break;
			case 'LINEBILL_UPDATE':
				$this->linebillUpdate($action, $object);
				break;
			default:
				dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
				break;
		}
	}

	/**
	 * TRIGGERS ON COMPANIES ACTIONS
	 */

	// Set default values on company creation
	public function companyCreate($action, $object) {
		global $db;
		$obj = new Csv($db);
		$obj->customSetCompanyLevelPrice($object);
		return dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
	}


	/**
	 * TRIGGERS ON PRODUCTS ACTIONS
	 */

	// Remove all abaque informations on product deletion
	public function productDelete($action, $object) {
		global $db;
		$obj = new Csv($db);
		$obj->customAbaqueLogs("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
		$obj->customDeleteAbaques($object);
		return dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
	}

	/**
	 * TRIGGERS ON PROPALS ACTIONS
	 */

	// Update a propal line
	public function linepropalUpdate($action, $object) {
		global $updateline_status; // Need it to prevent an infinity loop when an update is triggered
		global $db;
		$obj = new Csv($db);
		
		if($updateline_status === NULL) {
			$updateline_status = true; // Update is in progress. Next time the trigger will not call the customLinePropalUpdate method
			$obj->customAbaqueLineUpdate($action, $object);
			return dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
		} else {
			// Update is complete
			$propal = new Propal($db);
			$propal->fetch($object->fk_propal);
			unset($updateline_status);

			return $obj->customAbaqueLogs("Mise à jour de la proposition commerciale $propal->ref effectuée avec succès.");
		}
	}

	/**
	 * TRIGGERS ON ORDERS ACTIONS
	 */

	// Update an order line
	public function lineorderUpdate($action, $object) {
		global $updateline_status; // Need it to prevent an infinity loop when an update is triggered
		global $db;
		$obj = new Csv($db);
		
		if($updateline_status === NULL) {
			$updateline_status = true; // Update is in progress. Next time the trigger will not call the customLineOrderlUpdate method
			$obj->customAbaqueLineUpdate($action, $object);
			return dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
		} else {
			// Update is complete
			$order = new Commande($db);
			$order->fetch($object->fk_commande);
			unset($updateline_status);

			return $obj->customAbaqueLogs("Mise à jour de la commande $order->ref effectuée avec succès.");
		}
	}

	/**
	 * TRIGGERS ON INVOICES ACTIONS
	 */

	// Update an invoice line
	public function linebillUpdate($action, $object) {
		global $updateline_status; // Need it to prevent an infinity loop when an update is triggered
		global $db;
		$obj = new Csv($db);
		
		if($updateline_status === NULL) {
			$updateline_status = true; // Update is in progress. Next time the trigger will not call the customLineBillUpdate method
			$obj->customAbaqueLineUpdate($action, $object);
			return dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
		} else {
			// Update is complete
			$bill = new Facture($db);
			$bill->fetch($object->fk_facture);
			unset($updateline_status);

			return $obj->customAbaqueLogs("Mise à jour de la facture $bill->ref effectuée avec succès.");
		}
	}


	// public function productCreate($action, $object, User $user, Translate $langs, Conf $conf) {
	// 	global $db;
	// 	require_once DOL_DOCUMENT_ROOT.'/custom/stormatic/class/csv.class.php';
	// 	$obj = new Csv($db);
	// 	$obj->customInsertAbaques($values);
	// 	return dol_syslog("Trigger '".$this->name."' for action '$action' launched by ".__FILE__.". id=".$object->id);
	// }
}
