{**************************************************************************}
{                                                                          }
{    Calmira XP shell for Microsoft® Windows(TM) 3.1                       }
{    Version 3.33                                                          }
{    Copyright (C) Lionel Lowie                                            }
{                                                                          }
{    Based on Calmira Online! Release 3.3                                  }
{    Copyright (C) 1998-2002 Calmira Online!                               }
{    Copyright (C) 1997-1998 Li-Hsin Huang                                 }
{                                                                          }
{    This program is free software; you can redistribute it and/or modify  }
{    it under the terms of the GNU General Public License as published by  }
{    the Free Software Foundation; either version 2 of the License, or     }
{    (at your option) any later version.                                   }
{                                                                          }
{    This program is distributed in the hope that it will be useful,       }
{    but WITHOUT ANY WARRANTY; without even the implied warranty of        }
{    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         }
{    GNU General Public License for more details.                          }
{                                                                          }
{    You should have received a copy of the GNU General Public License     }
{    along with this program; if not, write to the Free Software           }
{    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.             }
{                                                                          }
{**************************************************************************}

unit Logon;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Picbtn, Sysmenu;

type
  TLogonDlg = class(TForm)
    PasswordEdit: TEdit;
    OKBtn: TPicBtn;
    User1Image: TImage;
    User2Image: TImage;
    User3Image: TImage;
    User4Image: TImage;
    User5Image: TImage;
    Gebruikerslijst: TMemo;
    User1Label: TLabel;
    User2Label: TLabel;
    User3Label: TLabel;
    User4Label: TLabel;
    User5Label: TLabel;
    ShutDownLabel: TLabel;
    ManageLabel: TLabel;
    WelcomeLabel: TLabel;
    ChooseUserLabel: TLabel;
    ShutdownLogo: TImage;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure User1ImageClick(Sender: TObject);
    procedure User2ImageClick(Sender: TObject);
    procedure User3ImageClick(Sender: TObject);
    procedure User4ImageClick(Sender: TObject);
    procedure User5ImageClick(Sender: TObject);
    procedure ShutdownLogoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure CheckForLogon;

implementation

{$R *.DFM}

uses Files, FileMan, MiscUtil, Profile, Password, Settings, Locale, IniFiles;

var
  LogonForm: TLogonDlg;
  UserIni: TProfile;
  UserList: TStringList;
  User: string[8];
  BalkBoven: TRect;
  BalkOnder: TRect;
  LijnMidden: TRect;


procedure CheckForLogon;
var
  NewWritePath: TFilename;

procedure EnsureExistence(const filename: TFilename);
begin
  if FileExists(FileWritePath + filename) and not FileExists(NewWritePath + filename) then
    FileCopy(FileWritePath + filename, NewWritePath + filename);
end;

begin
  UserIni := TProfile.Create(BasePath + 'calusers.ini');
  MultipleProfiles := UserIni.ReadBool('Settings', 'MultipleProfiles', False);
  if MultipleProfiles then
  begin
    With TInifile.Create(BasePath + 'calmira.ini') do
    begin { 3.0 }
      PicBtnGlyphs := ReadBool('Preferences', 'PicBtnGlyphs', False);
      PicBtnGlyphsChanged;
      Free;
    end;
    UserList := TStringList.Create;
    UserIni.ReadSection('Users', UserList);
    with TLogonDlg.Create(Application) do
    try
      ShowModal;
      if ModalResult = mrOK then
      begin
        NewWritePath := BasePath + 'profiles\' + User;
        if not HDirectoryExists(NewWritePath) then ForceDirectories(NewWritePath);
        AppendStr(NewWritePath, '\');
        EnsureExistence('calmira.ini');
        EnsureExistence('start.ini');
        FileWritePath := NewWritePath;
        UserIni.WriteString('Settings', 'LastUser', User);
      end
      { 3.01 }
      else if UserIni.ReadBool('Settings', 'NoAnonUser', False) then
        if IsShell then ExitWindows(0, 0)
        else Halt;
    finally
      Free;
    end;
    UserList.Free;
  end;
  UserIni.Free;
end;

procedure TLogonDlg.FormCreate(Sender: TObject);
 var User1: String;
     User2: String;
     User3: String;
     User4: String;
     User5: String;

 begin
  {Scherm instellen afhankelijk van resolutie}
  Width := Screen.Width;
  Height := Screen.Height;
  ShutdownLabel.Left := 45;
  ShutDownLabel.Top := (Screen.Height - Screen.Height div 16) - 12 ;
  ManageLabel.Left :=Screen.Width -200;
  ManageLabel.Top :=(Screen.Height - Screen.Height div 16) -25;
  WelcomeLabel.Top := Screen.Height div 2 - 36;
  WelcomeLabel.Left := Screen.Width div 11;
  ChooseUserLabel.Top := Screen.Height div 2 - 6;
  ChooseUserLabel.Left := Screen.Width div 11 + 25;
  Shutdownlogo.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'SHUTDOWN2');
  ShutDownLogo.Top := (Screen.Height - Screen.Height div 16) - 16 ;
  ShutdownLogo.Left := 6;

  {Afbeeldingen en namen van de gebruikers links uitlijnen}
  User1Image.Left := Screen.Width div 2 + Screen.Width div 25;
  User2Image.Left := Screen.Width div 2 + Screen.Width div 25;
  User3Image.Left := Screen.Width div 2 + Screen.Width div 25;
  User4Image.Left := Screen.Width div 2 + Screen.Width div 25;
  User5Image.Left := Screen.Width div 2 + Screen.Width div 25;
  User1Label.Left := User1Image.Left + 62;
  User2Label.Left := User1Image.Left + 62;
  User3Label.Left := User1Image.Left + 62;
  User4Label.Left := User1Image.Left + 62;
  User5Label.Left := User1Image.Left + 62;

  {Afbeeldingen plaatsen afhankelijk van aantal gebruikers}

  UserIni.ReadSection('Users', Gebruikerslijst.Lines);

  If Gebruikerslijst.Lines.Count = 1 then
   begin
    User1Image.Visible := True;
    User1Label.Visible := True;
    User1Image.Top := Screen.Height div 2 - 26;
    User1Label.Top := Screen.Height div 2 - 26;
   end;

  If Gebruikerslijst.Lines.Count = 2 then
   begin
    User1Image.Visible := True;
    User2Image.Visible := True;
    User1Label.Visible := True;
    User2Label.Visible := True;
    User1Image.Top := Screen.Height div 2 -61;
    User2Image.Top := Screen.Height div 2 + 9;
    User1Label.Top := Screen.Height div 2 -61;
    User2Label.Top := Screen.Height div 2 + 9;
   end;

  If Gebruikerslijst.Lines.Count = 3 then
   begin
    User1Image.Visible := True;
    User2Image.Visible := True;
    User3Image.Visible := True;
    User1Label.Visible := True;
    User2Label.Visible := True;
    User3Label.Visible := True;
    User1Image.Top := Screen.Height div 2 - 96;
    User2Image.Top := Screen.Height div 2 - 26;
    User3Image.Top := Screen.Height div 2 + 44;
    User1Label.Top := Screen.Height div 2 - 96;
    User2Label.Top := Screen.Height div 2 - 26;
    User3Label.Top := Screen.Height div 2 + 44;
   end;

  If Gebruikerslijst.Lines.Count = 4 then
   begin
    User1Image.Visible := True;
    User2Image.Visible := True;
    User3Image.Visible := True;
    User4Image.Visible := True;
    User1Label.Visible := True;
    User2Label.Visible := True;
    User3Label.Visible := True;
    User4Label.Visible := True;
    User1Image.Top := Screen.Height div 2 -131;
    User2Image.Top := Screen.Height div 2 -61;
    User3Image.Top := Screen.Height div 2 + 9;
    User4Image.Top := Screen.Height div 2 + 79;
    User1Label.Top := Screen.Height div 2 -131;
    User2Label.Top := Screen.Height div 2 -61;
    User3Label.Top := Screen.Height div 2 + 9;
    User4Label.Top := Screen.Height div 2 + 79;
   end;

  If Gebruikerslijst.Lines.Count = 5 then
   begin
    User1Image.Visible := True;
    User2Image.Visible := True;
    User3Image.Visible := True;
    User4Image.Visible := True;
    User5Image.Visible := True;
    User1Label.Visible := True;
    User2Label.Visible := True;
    User3Label.Visible := True;
    User4Label.Visible := True;
    User5Label.Visible := True;
    User1Image.Top := Screen.Height div 2 - 166;
    User2Image.Top := Screen.Height div 2 - 96;
    User3Image.Top := Screen.Height div 2 - 26;
    User4Image.Top := Screen.Height div 2 + 44;
    User5Image.Top := Screen.Height div 2 + 114;
    User1Label.Top := Screen.Height div 2 - 166;
    User2Label.Top := Screen.Height div 2 - 96;
    User3Label.Top := Screen.Height div 2 - 26;
    User4Label.Top := Screen.Height div 2 + 44;
    User5Label.Top := Screen.Height div 2 + 114;
   end;

  {namen inlezen en weergeven in Userlabel}
  User1Label.Caption := Gebruikerslijst.Lines[0];
  User2Label.Caption := Gebruikerslijst.Lines[1];
  User3Label.Caption := Gebruikerslijst.Lines[2];
  User4Label.Caption := Gebruikerslijst.Lines[3];
  User5Label.Caption := Gebruikerslijst.Lines[4];

  {Afbeeldingen laden}
  With Userini do
   begin
    User1 := ReadString('Bitmaps',Gebruikerslijst.Lines[0],'');
    User2 := ReadString('Bitmaps',Gebruikerslijst.Lines[1],'');
    User3 := ReadString('Bitmaps',Gebruikerslijst.Lines[2],'');
    User4 := ReadString('Bitmaps',Gebruikerslijst.Lines[3],'');
    User5 := ReadString('Bitmaps',Gebruikerslijst.Lines[4],'');
   end;
    If FileExists(User1) then User1Image.Picture.LoadFromFile(User1)
       else User1Image.Picture.LoadFromFile(Basepath+ 'kruis.bmp');
    If FileExists(User2) then User2Image.Picture.LoadFromFile(User2)
       else User2Image.Picture.LoadFromFile(Basepath+ 'kruis.bmp');
    If FileExists(User3) then User3Image.Picture.LoadFromFile(User3)
       else User3Image.Picture.LoadFromFile(Basepath+ 'kruis.bmp');
    If FileExists(User4) then User4Image.Picture.LoadFromFile(User4)
       else User4Image.Picture.LoadFromFile(Basepath+ 'kruis.bmp');
    If FileExists(User5) then User5Image.Picture.LoadFromFile(User5)
       else User5Image.Picture.LoadFromFile(Basepath+ 'kruis.bmp');
 end;

procedure TLogonDlg.OKBtnClick(Sender: TObject);
begin
  if not IsValidLogin(User) then
    MsgDialogRes(SInvalidUserName, mtError, [mbOK], 0)
  else if UserIni = nil then
    ModalResult := mrCancel
  else if (UserList.IndexOf(User) >= 0) and
    (DecryptPassword(UserIni.ReadString('Users', User, '')) = PasswordEdit.Text) then
      ModalResult := mrOK
  else begin
    PasswordEdit.Clear;
    MsgDialogRes(SInvalidPassword, mtError, [mbOK], 0);
  end;
end;

procedure TLogonDlg.FormPaint(Sender: TObject);
 var Midden: Integer;
 begin
  Midden := Screen.Width div 2;
  BalkBoven := Rect(0,0,Screen.Width,Screen.Height div 10);
  BalkOnder := Rect(0,Screen.Height - Screen.Height div 8, Screen.Width, Screen.Height);
  LijnMidden := Rect(Midden, Screen.Height div 10 +25, Midden + 1, Screen.Height - Screen.Height div 8 -25);
  Canvas.Brush.Color := $02AE332D;
  Canvas.FillRect(BalkBoven);
  Canvas.FillRect(BalkOnder);
  Canvas.Brush.Color := $02F0C8A4;
  Canvas.FillRect(LijnMidden);
 end;

procedure TLogonDlg.User1ImageClick(Sender: TObject);
 begin
  User := Gebruikerslijst.Lines[0];
  PassWordEdit.Left := User1Label.Left;
  PasswordEdit.Top := User1Label.Top + 24;
  PasswordEdit.Visible := True;
  OkBtn.Top := User1Label.Top + 24;
  OkBtn.Left := User1Label.Left + 130;
  OkBtn.Visible := True;
  PasswordEdit.SetFocus;
 end;

procedure TLogonDlg.User2ImageClick(Sender: TObject);
 begin
  User := Gebruikerslijst.Lines[1];
  PassWordEdit.Left := User2Label.Left;
  PasswordEdit.Top := User2Label.Top + 24;
  PasswordEdit.Visible := True;
  OkBtn.Top := User2Label.Top + 24;
  OkBtn.Left := User2Label.Left + 130;
  OkBtn.Visible := True;
  PasswordEdit.SetFocus;
 end;

procedure TLogonDlg.User3ImageClick(Sender: TObject);
 begin
  User := Gebruikerslijst.Lines[2];
  PassWordEdit.Left := User3Label.Left;
  PasswordEdit.Top := User3Label.Top + 24;
  PasswordEdit.Visible := True;
  OkBtn.Top := User3Label.Top + 24;
  OkBtn.Left := User3Label.Left + 130;
  OkBtn.Visible := True;
  PasswordEdit.SetFocus;
 end;

procedure TLogonDlg.User4ImageClick(Sender: TObject);
 begin
  User := Gebruikerslijst.Lines[3];
  PassWordEdit.Left := User4Label.Left;
  PasswordEdit.Top := User4Label.Top + 24;
  PasswordEdit.Visible := True;
  OkBtn.Top := User4Label.Top + 24;
  OkBtn.Left := User4Label.Left + 130;
  OkBtn.Visible := True;
  PasswordEdit.SetFocus;
 end;

procedure TLogonDlg.User5ImageClick(Sender: TObject);
 begin
  User := Gebruikerslijst.Lines[4];
  PassWordEdit.Left := User5Label.Left;
  PasswordEdit.Top := User5Label.Top + 24;
  PasswordEdit.Visible := True;
  OkBtn.Top := User5Label.Top + 24;
  OkBtn.Left := User5Label.Left + 130;
  OkBtn.Visible := True;
  PasswordEdit.SetFocus;
 end;


procedure TLogonDlg.ShutdownLogoClick(Sender: TObject);
begin
ExitWindows(0,0)
end;

end.

