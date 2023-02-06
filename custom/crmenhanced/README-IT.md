# CRMENHANCED PER <a href="https://www.dolibarr.org">DOLIBARR ERP CRM</a>

## Funzionalità
Fornisce semplici ma complete funzionalità di CRM (Customer Relationship Management).
<ul>
<li>Gestisce tutte le attività erogate nei confronti delle terze parti</li>
<li>Creazione e gestione delle campagne</li>
<li> </li>
</ul>


<!--
![Screenshot crmenhanced](img/screenshot_crmenhanced.png?raw=true "crmenhanced"){imgmd}
-->

Altri moduli sono disponibili su <a href="https://www.dolistore.com" target="_new">Dolistore.com</a>.


### Traduzioni

Esiste la tradzione nelle seguenti lingue: Inglese, Francese, Spagnolo, Italiano.

La traduzione in altre lingue può essere fatta manualmente modificando i file nelle cartelle [langs](langs). 


<!--
This module contains also a sample configuration for Transifex, under the hidden directory [.tx](.tx), so it is possible to manage translation using this service. 

For more informations, see the [translator's documentation](https://wiki.dolibarr.org/index.php/Translator_documentation).

There is a [Transifex project](https://transifex.com/projects/p/dolibarr-module-template) for this module.
-->


<!--

Install
-------

### From the ZIP file and GUI interface

- If you get the module in a zip file (like when downloading it from the market place [Dolistore](https://www.dolistore.com)), go into
menu ```Home - Setup - Modules - Deploy external module``` and upload the zip file.


Note: If this screen tell you there is no custom directory, check your setup is correct: 

- In your Dolibarr installation directory, edit the ```htdocs/conf/conf.php``` file and check that following lines are not commented:

    ```php
    //$dolibarr_main_url_root_alt ...
    //$dolibarr_main_document_root_alt ...
    ```

- Uncomment them if necessary (delete the leading ```//```) and assign a sensible value according to your Dolibarr installation

    For example :

    - UNIX:
        ```php
        $dolibarr_main_url_root_alt = '/custom';
        $dolibarr_main_document_root_alt = '/var/www/Dolibarr/htdocs/custom';
        ```

    - Windows:
        ```php
        $dolibarr_main_url_root_alt = '/custom';
        $dolibarr_main_document_root_alt = 'C:/My Web Sites/Dolibarr/htdocs/custom';
        ```
        
### From a GIT repository

- Clone the repository in ```$dolibarr_main_document_root_alt/crmenhanced```

```sh
cd ....../custom
git clone git@github.com:gitlogin/crmenhanced.git crmenhanced
```

### <a name="final_steps"></a>Final steps

From your browser:

  - Log into Dolibarr as a super-administrator
  - Go to "Setup" -> "Modules"
  - You should now be able to find and enable the module



-->


Licenses
--------

### Codice Sorgente

![GPLv3 logo](img/gplv3.png)

GPLv3 or (at your option) any later version.

See [COPYING](COPYING) for more information.

#### Documentazione

Tutti i testi e i file readme.

![GFDL logo](img/gfdl.png)