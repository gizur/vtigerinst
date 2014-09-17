<?php

//This file contains the commonly used variables 


// This is the standard content
// ----------------------------

//$parent_tab_info_array=array(1=>'My Home Page',2=>'Marketing',3=>'Sales',4=>'Support',5=>'Analytics',6=>'Inventory',7=>'Tools',8=>'Settings');
//$parent_child_tab_rel_array=array(1=>array(3,9,28,),2=>array(26,6,4,28,7,9,8,),3=>array(7,6,4,2,20,22,23,19,8,9,),4=>array(13,15,6,4,8,28,9,40,50,51,52,),5=>array(25,1,),6=>array(14,18,19,21,22,20,23,34,43,),7=>array(24,27,8,32,33,35,41,47,49,),8=>array(),);


$parent_tab_info_array=array(1=>'My Home Page',2=>'Marketing',3=>'Sales',4=>'Support',5=>'Analytics',6=>'Inventory',7=>'Tools',8=>'Settings');
$parent_child_tab_rel_array=array(1=>array(3,9,28,),2=>array(26,6,4,28,7,9,8,),3=>array(7,6,4,2,20,22,23,19,8,9,),4=>array(13,15,6,4,8,28,9,40,50,51,52,),5=>array(25,1,),6=>array(14,18,19,21,22,20,23,34,43,),7=>array(24,27,8,32,33,35,41,47,49,),8=>array(),);



// Changes performed for Gizur SaaS
// -------------------------------

//This file contains the commonly used variables 
/*
include 'modules/CikabTroubleTicket/dynamodb.config.php';
global $memcache_url;
$_cache = array();
$memcache = new Memcache;
if ($memcache->connect($memcache_url, 11211)) {
    $_tabdata_cache = $memcache->get($gizur_client_id . "_parent_tabdata_details");
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
            'TableName' => $parent_tabdata_table_name,
            'Key' => $dynamodb->attributes(array('HashKeyElement' => $gizur_client_id)),
            'ConsistentRead' => 'true'
        )
    );

    if (isset($response->body->Item)) {
        $items = $response->body->Item;
        
        $_cache['id'] = $gizur_client_id;
        $_cache['parent_tab_info_array'] = (String) $items->parent_tab_info_array->{AmazonDynamoDB::TYPE_STRING};
        $_cache['parent_child_tab_rel_array'] = (String) $items->parent_child_tab_rel_array->{AmazonDynamoDB::TYPE_STRING};
        
        if (isset($memcache)) {
            $memcache->set($gizur_client_id . "_parent_tabdata_details", $_cache);
        }
    } else {
        $_cache = create_parenttab_data_file();
    }
}

if (isset($_cache) && !empty($_cache)) {
    eval("\$parent_tab_info_array=" . $_cache['parent_tab_info_array'] . ";");
    eval("\$parent_child_tab_rel_array=" . $_cache['parent_child_tab_rel_array'] . ";");
}*/

?>
