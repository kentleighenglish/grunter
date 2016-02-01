<?php
	//PHP Document
	
	//Gruntfile/Project directory
	$directory = $argv[1];
	//temporary code
	if(empty($directory)) {
		$directory = "/home/kenglish/workspace/RecruitmentRevolutionCom/RecruitmentRevolution/views/themed/frontend14/";
	}

	//If gruntfile given does not exist, exit with error code 1
	if(empty($directory)) {
		shell_exec('php_exit=1');
	}else{		
		shell_exec('php_exit=1; export php_exit;');
	}

	//Get raw file contents from Gruntfile.js
	$gruntFile_raw = file_get_contents($directory . 'Gruntfile.js');

	//Find Grunt JSON object with settings
	preg_match('/\(\{.*?(\n.*)*\}\)/', $gruntFile_raw, $file_json);
	//Find all variables declared
	preg_match_all('/var\s(\S.*\S)\s=\s(\'.*\'|\".*\")/', $gruntFile_raw, $file_vars, PREG_SET_ORDER);

	$gruntFile0=preg_replace('/\(\{/', '{', $file_json[0]);
	$gruntFile1=preg_replace('/\}\)/', '}', $gruntFile0);
	$gruntFile=preg_replace('/\/\/.*\n/', '', $gruntFile1);
	
	foreach($file_vars as $var) {
		$varName = $var[1];
		$varValue = $var[2];

		// $varName = $varValue;


        $gruntFile=str_replace($varName, $varValue, $gruntFile);
	}

	//remove single quotes
	$gruntFile=str_replace('\'', '', $gruntFile);
	$gruntFile=str_replace('"', '', $gruntFile);
	$gruntFile=preg_replace('/\s\+\s/', '', $gruntFile);

	//Creating regular expression to select all text in json and add double quotes


	json_decode($gruntFile);
	// var_dump($gruntFile);


?>