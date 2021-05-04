$DestinationFolderPath = "E:\Test\";
$TotalFilesToWrite = 1000000;
$MinFileSize = 50000;
$MaxFileSize = 2000000;

$StartTime = $(get-date);

for($i=1;$i -le $TotalFilesToWrite;$i++) 
{ 
	$out = new-object byte[] (new-object Random).Next($MinFileSize, $MaxFileSize); 
    (new-object Random).NextBytes($out); 
    [IO.File]::WriteAllBytes($DestinationFolderPath + [GUID]::NewGuid().ToString('N')+'.pdf', $out); 

    $elapsedTime = $(get-date) - $StartTime
    $totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
    Write-Progress -Id 1 -Activity ('Generating ' + $TotalFilesToWrite + ' dummy files. Time since the inception ' + $totalTime) -Status ('Writing File '+ $i +' ...') -PercentComplete ($i/$TotalFilesToWrite*100);
}

Write-Host 'Elapsed time' $elapsedTime;
Write-Host 'Total number of files in the folder: '( Get-ChildItem $DestinationFolderPath | Measure-Object ).Count;