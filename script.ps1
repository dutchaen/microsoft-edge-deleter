# list of directories where microsoft edge programs could be located 
$paths = @("C:\Program Files (x86)\Microsoft\Edge\Application", "C:\Program Files (x86)\Microsoft\EdgeCore");

# for every single one
foreach ( $path in $paths ) {

    # we check this directory exists, if it doesnt we skip. if it does then we continue
    if ([System.IO.Directory]::Exists($path)) {

        # we get the directories of this path
        foreach( $dir in (Get-Item $path).GetDirectories() ) {
            # we check if the directory contains a version number, ex: 92.0.902.67
            # if it does have a version number, we add an additional string to the end of directory path to direct it to the edge setup.exe
          if ( $dir.FullName -match '(\d{1,4})\.(\d{1,4})\.(\d{1,4})\.(\d{1,4})' ) {
               $setup_path = $dir.FullName + '\Installer\setup.exe';

               # we tell the microsoft edge setup program to uninstall itself from the system
               Start-Process -FilePath $setup_path -ArgumentList @('--uninstall', '--force-uninstall', '--system-level') -NoNewWindow -Wait;

               # then we actually remove all of the files of microsoft edge
               Remove-Item -LiteralPath $path -Force -Recurse;
               break
          };
        }
    }
}

# more edge file removing
Remove-Item -LiteralPath 'C:\Program Files (x86)\Microsoft\Edge' -Force -Recurse;
Remove-Item -LiteralPath 'C:\Program Files (x86)\Microsoft\EdgeUpdate' -Force -Recurse;

# then we are done :D
'Deleted Microsoft Edge from this computer.'
