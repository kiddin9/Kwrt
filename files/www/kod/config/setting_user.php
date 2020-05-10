<?php
//分片上传: 每个切片5M,需要php.ini 中upload_max_filesize大于此值
$GLOBALS['config']['settings']['updloadChunkSize'] = 1024*1024*5;

//上传并发数量; 推荐15个并发;
$GLOBALS['config']['settings']['updloadThreads'] = 15;
