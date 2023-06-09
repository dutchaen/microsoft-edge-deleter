# this is a list of directories where microsoft edge programs could be located 
$paths = @("C:\Program Files (x86)\Microsoft\Edge\Application", "C:\Program Files (x86)\Microsoft\EdgeCore");

# and for every single one of them
foreach ( $path in $paths ) {

    # we check if the directory is valid, if it is not valid, we skip this directory. but if it is valid...
    if ([System.IO.Directory]::Exists($path)) {

        # then we get the subdirectories of this directory and for every single subdirectory...
        foreach( $dir in (Get-Item $path).GetDirectories() ) {
            # we check if the subdirectory contains a version number, ex: 92.0.902.67
            # if it does not have a version number, we skip this subdirectory
            # but if it does have a version number, we add an additional string to the end of the full subdirectory path so it points to the microsoft edge setup.exe
            # ex: 'C:\Program Files (x86)\Microsoft\Edge\Application\92.0.902.67' + '\Installer\setup.exe' = 'C:\Program Files (x86)\Microsoft\Edge\Application\92.0.902.67\Installer\setup.exe'
            
          if ( $dir.FullName -match '(\d{1,4})\.(\d{1,4})\.(\d{1,4})\.(\d{1,4})' ) {
               $setup_path = $dir.FullName + '\Installer\setup.exe';

               # then we tell the microsoft edge setup program to uninstall itself from the system
               Start-Process -FilePath $setup_path -ArgumentList @('--uninstall', '--force-uninstall', '--system-level') -NoNewWindow -Wait;

               # then we actually remove all of the files of microsoft edge from this directory
               Remove-Item -LiteralPath $path -Force -Recurse;
               break
          };
        }
    }
}

# more edge file removing
Remove-Item -LiteralPath 'C:\Program Files (x86)\Microsoft\Edge' -Force -Recurse;
Remove-Item -LiteralPath 'C:\Program Files (x86)\Microsoft\EdgeUpdate' -Force -Recurse;

# and then we are done :D
'Deleted Microsoft Edge from this computer.'
