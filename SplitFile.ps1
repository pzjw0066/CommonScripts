function SplitFile([String]$SrcFilePath,[String]$DstDirPath,[Int64]$EachSize){
    if (-Not (Test-Path $SrcFilePath)){
        Write-Output 'Invaild Path!'
        return -1
    }

    if (-Not (Test-Path $DstDirPath)){
        New-Item $DstDirPath -ItemType Directory
    }

    $SrcFile = [System.IO.File]::OpenRead((Get-Item $SrcFilePath | Select-Object -ExpandProperty FullName))
    $SrcFileLength = [Int64](Get-Item -Path $SrcFilePath | Select-Object -ExpandProperty Length)

    $Rem = [Int64]0
    $FileCount = [Math]::DivRem($SrcFileLength,$EachSize,[ref]$Rem)
    $Buffer = New-Object byte[] 8MB

    function CopyFile([Int64]$a,[bool]$IsLast){
        $b = 0
        $Counts = [Math]::DivRem($a,$Buffer.Length,[ref]$b)
        $DstFile = [System.IO.File]::OpenWrite("$((Get-Item $DstDirPath | Select-Object -ExpandProperty FullName))\$SrcFilePath_$i")
        for ($j=0;$j -lt $Counts;$j++){
            $SrcFile.Read($Buffer,0,$buffer.Length) | Out-Null
            $DstFile.Write($Buffer,0,$buffer.Length)
            if (-Not $ShowInfo){
                Write-Host "Progress:$([Int32]([Double]($i*$EachSize+($j+1)*$Buffer.Length)/$SrcFileLength*100))%`r" -NoNewline
            }else{
                Write-Host "Progress:$([Int32]([Double]($SrcFileLength-$a+($j+1)*$Buffer.Length)/$SrcFileLength*100))%`r" -NoNewline
            }
        }
        if ($SrcFile.Read($Buffer,0,$b)){
            $DstFile.Write($Buffer,0,$b)
        }
        $DstFile.Dispose()
    }

    for ($i=0;$i -lt $FileCount;$i++){
        CopyFile $EachSize $false
    }

    CopyFile $Rem $true

    Write-Host "Progress:100%`r`nComplete!"
}