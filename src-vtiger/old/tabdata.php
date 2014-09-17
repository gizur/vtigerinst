<?php

//This file contains the commonly used variables 


// This is the standard content
// ----------------------------

//$tab_info_array=array('Dashboard'=>1,'Potentials'=>2,'Home'=>3,'Contacts'=>4,'Accounts'=>6,'Leads'=>7,'Documents'=>8,'Calendar'=>9,'Emails'=>10,'HelpDesk'=>13,'Products'=>14,'Faq'=>15,'Events'=>16,'Vendors'=>18,'PriceBooks'=>19,'Quotes'=>20,'PurchaseOrder'=>21,'SalesOrder'=>22,'Invoice'=>23,'Rss'=>24,'Reports'=>25,'Campaigns'=>26,'Portal'=>27,'Webmails'=>28,'Users'=>29,'Import'=>30,'ConfigEditor'=>31,'MailManager'=>32,'PBXManager'=>33,'Services'=>34,'Integration'=>35,'VtigerBackup'=>36,'Mobile'=>37,'ModTracker'=>38,'WSAPP'=>39,'ServiceContracts'=>40,'ModComments'=>41,'Webforms'=>42,'Assets'=>43,'FieldFormulas'=>44,'Tooltip'=>45,'CronTasks'=>46,'SMSNotifier'=>47,'CustomerPortal'=>48,'RecycleBin'=>49,'ProjectMilestone'=>50,'ProjectTask'=>51,'Project'=>52,);
//$tab_seq_array=array('1'=>0,'2'=>0,'3'=>0,'4'=>0,'6'=>0,'7'=>0,'8'=>0,'9'=>0,'10'=>0,'13'=>0,'14'=>0,'15'=>0,'16'=>2,'18'=>0,'19'=>0,'20'=>0,'21'=>0,'22'=>0,'23'=>0,'24'=>0,'25'=>0,'26'=>0,'27'=>0,'28'=>0,'29'=>0,'30'=>0,'31'=>0,'32'=>0,'33'=>0,'34'=>0,'35'=>0,'36'=>0,'37'=>0,'38'=>0,'39'=>0,'40'=>0,'41'=>0,'42'=>0,'43'=>0,'44'=>0,'45'=>0,'46'=>0,'47'=>0,'48'=>0,'49'=>0,'50'=>0,'51'=>0,'52'=>0,);
//$tab_ownedby_array=array('1'=>1,'2'=>0,'3'=>1,'4'=>0,'6'=>0,'7'=>0,'8'=>0,'9'=>0,'10'=>1,'13'=>0,'14'=>0,'15'=>1,'16'=>0,'18'=>1,'19'=>1,'20'=>0,'21'=>0,'22'=>0,'23'=>0,'24'=>1,'25'=>1,'26'=>0,'27'=>1,'28'=>1,'29'=>1,'30'=>0,'31'=>0,'32'=>0,'33'=>0,'34'=>0,'35'=>0,'36'=>0,'37'=>0,'38'=>0,'39'=>0,'40'=>0,'41'=>0,'42'=>0,'43'=>0,'44'=>0,'45'=>0,'46'=>0,'47'=>0,'48'=>0,'49'=>0,'50'=>0,'51'=>0,'52'=>0,);
//$action_id_array=array('Save'=>0,'SavePriceBook'=>0,'SaveVendor'=>0,'DetailViewAjax'=>1,'EditView'=>1,'PriceBookEditView'=>1,'QuickCreate'=>1,'VendorEditView'=>1,'Delete'=>2,'DeletePriceBook'=>2,'DeleteVendor'=>2,'index'=>3,'Popup'=>3,'DetailView'=>4,'PriceBookDetailView'=>4,'TagCloud'=>4,'VendorDetailView'=>4,'Import'=>5,'Export'=>6,'Merge'=>8,'ConvertLead'=>9,'DuplicatesHandling'=>10);
//$action_name_array=array(0=>'Save',1=>'EditView',2=>'Delete',3=>'index',4=>'DetailView',5=>'Import',6=>'Export',8=>'Merge',9=>'ConvertLead',10=>'DuplicatesHandling');

$tab_info_array=array('Dashboard'=>1,'Potentials'=>2,'Home'=>3,'Contacts'=>4,'Accounts'=>6,'Leads'=>7,'Documents'=>8,'Calendar'=>9,'Emails'=>10,'HelpDesk'=>13,'Products'=>14,'Faq'=>15,'Events'=>16,'Vendors'=>18,'PriceBooks'=>19,'Quotes'=>20,'PurchaseOrder'=>21,'SalesOrder'=>22,'Invoice'=>23,'Rss'=>24,'Reports'=>25,'Campaigns'=>26,'Portal'=>27,'Webmails'=>28,'Users'=>29,'Import'=>30,'ConfigEditor'=>31,'MailManager'=>32,'PBXManager'=>33,'Services'=>34,'Integration'=>35,'VtigerBackup'=>36,'Mobile'=>37,'ModTracker'=>38,'WSAPP'=>39,'ServiceContracts'=>40,'ModComments'=>41,'Webforms'=>42,'Assets'=>43,'FieldFormulas'=>44,'Tooltip'=>45,'CronTasks'=>46,'SMSNotifier'=>47,'CustomerPortal'=>48,'RecycleBin'=>49,'ProjectMilestone'=>50,'ProjectTask'=>51,'Project'=>52,);
$tab_seq_array=array('1'=>0,'2'=>0,'3'=>0,'4'=>0,'6'=>0,'7'=>0,'8'=>0,'9'=>0,'10'=>0,'13'=>0,'14'=>0,'15'=>0,'16'=>2,'18'=>0,'19'=>0,'20'=>0,'21'=>0,'22'=>0,'23'=>0,'24'=>0,'25'=>0,'26'=>0,'27'=>0,'28'=>0,'29'=>0,'30'=>0,'31'=>0,'32'=>0,'33'=>0,'34'=>0,'35'=>0,'36'=>0,'37'=>0,'38'=>0,'39'=>0,'40'=>0,'41'=>0,'42'=>0,'43'=>0,'44'=>0,'45'=>0,'46'=>0,'47'=>0,'48'=>0,'49'=>0,'50'=>0,'51'=>0,'52'=>0,);
$tab_ownedby_array=array('1'=>1,'2'=>0,'3'=>1,'4'=>0,'6'=>0,'7'=>0,'8'=>0,'9'=>0,'10'=>1,'13'=>0,'14'=>0,'15'=>1,'16'=>0,'18'=>1,'19'=>1,'20'=>0,'21'=>0,'22'=>0,'23'=>0,'24'=>1,'25'=>1,'26'=>0,'27'=>1,'28'=>1,'29'=>1,'30'=>0,'31'=>0,'32'=>0,'33'=>0,'34'=>0,'35'=>0,'36'=>0,'37'=>0,'38'=>0,'39'=>0,'40'=>0,'41'=>0,'42'=>0,'43'=>0,'44'=>0,'45'=>0,'46'=>0,'47'=>0,'48'=>0,'49'=>0,'50'=>0,'51'=>0,'52'=>0,);
$action_id_array=array('Save'=>0,'SavePriceBook'=>0,'SaveVendor'=>0,'DetailViewAjax'=>1,'EditView'=>1,'PriceBookEditView'=>1,'QuickCreate'=>1,'VendorEditView'=>1,'Delete'=>2,'DeletePriceBook'=>2,'DeleteVendor'=>2,'index'=>3,'Popup'=>3,'DetailView'=>4,'PriceBookDetailView'=>4,'TagCloud'=>4,'VendorDetailView'=>4,'Import'=>5,'Export'=>6,'Merge'=>8,'ConvertLead'=>9,'DuplicatesHandling'=>10);
$action_name_array=array(0=>'Save',1=>'EditView',2=>'Delete',3=>'index',4=>'DetailView',5=>'Import',6=>'Export',8=>'Merge',9=>'ConvertLead',10=>'DuplicatesHandling');


// Changes performed for Gizur SaaS
// -------------------------------


//include 'modules/CikabTroubleTicket/dynamodb.config.php';
/*
global $memcache_url;
$_cache = array();
$memcache = new Memcache;
if ($memcache->connect($memcache_url, 11211)) {
    $_tabdata_cache = $memcache->get($gizur_client_id . "_tabdata_details");
    $_cache = $_tabdata_cache;
} else {
    unset($memcache);
    $_tabdata_cache = false;
}

if (!$_tabdata_cache && true) {
    $dynamodb = new AmazonDynamoDB();
    $dynamodb->set_region(constant($dynamodb_table_region));
    // Get an item
    $response = $dynamodb->get_item(
        array(
            'TableName' => $tabdata_table_name,
            'Key' => $dynamodb->attributes(array('HashKeyElement' => $gizur_client_id)),
            'ConsistentRead' => 'true'
        )
    );

    if (isset($response->body->Item)) {
        $_items = $response->body->Item;

        $_cache['id'] = $gizur_client_id;
        $_cache['tab_info_array'] = (string)$_items->tab_info_array->{AmazonDynamoDB::TYPE_STRING};
        $_cache['tab_seq_array'] = (string)$_items->tab_seq_array->{AmazonDynamoDB::TYPE_STRING};
        $_cache['tab_ownedby_array'] = (string)$_items->tab_ownedby_array->{AmazonDynamoDB::TYPE_STRING};
        $_cache['action_id_array'] = (string)$_items->action_id_array->{AmazonDynamoDB::TYPE_STRING};
        $_cache['action_name_array'] = (string)$_items->action_name_array->{AmazonDynamoDB::TYPE_STRING};
        if (isset($memcache)) {
            $memcache->set($gizur_client_id . "_tabdata_details", $_cache);
        }
    } else {
        $_cache = create_tab_data_file();
    }
}

if (isset($_cache) && !empty($_cache)) {
    eval("\$tab_info_array=" . $_cache['tab_info_array'] . ";");
    eval("\$tab_seq_array=" . $_cache['tab_seq_array'] . ";");
    eval("\$tab_ownedby_array=" . $_cache['tab_ownedby_array'] . ";");
    eval("\$action_id_array=" . $_cache['action_id_array'] . ";");
    eval("\$action_name_array=" . $_cache['action_name_array'] . ";");
}

require_once 'auto_privilege.php';

*/

?>
