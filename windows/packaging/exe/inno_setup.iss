[Setup]
AppId=B9F6E402-0CAE-4045-BDE6-14BD6C39C4EA
AppVersion=1.11.0+22
AppName=Wave Music
AppPublisher=anandnet
AppPublisherURL=https://github.com/anandnet/Harmony-Music
AppSupportURL=https://github.com/anandnet/Harmony-Music
AppUpdatesURL=https://github.com/anandnet/Harmony-Music
DefaultDirName={autopf}\harmonymusic
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=harmonymusicv1.11.0
Compression=lzma
SolidCompression=yes
SetupIconFile=..\..\windows\runner\resources\app_icon.ico
WizardStyle=modern
PrivilegesRequired=lowest
LicenseFile=..\..\LICENSE
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\build\windows\x64\runner\Release\harmonymusic.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\Wave Music"; Filename: "{app}\WaveMusic.exe"
Name: "{autodesktop}\Wave Music"; Filename: "{app}\WaveMusic.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\WaveMusic.exe"; Description: "{cm:LaunchProgram,{#StringChange('Wave Music', '&', '&&')}}"; Flags: nowait postinstall skipifsilent
