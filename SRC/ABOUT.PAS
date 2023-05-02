{**************************************************************************}
{    Calmira XP shell for Microsoft® Windows(TM) 3.1                       }
{    version 3.33                                                          }
{    Copyright (C) 2002-2003 Lionel Lowie                                  }
{                                                                          }
{    Based on Calmira II Online! Release 3.3                               }
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

unit About;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Picbtn, Xpbutton;

type
  TAboutBox = class(TForm)
    VersionLabel: TLabel;
    Copy1Label: TLabel;
    Copy2Label: TLabel;
    HomepageLabel: TLabel;
    LicenceLabel: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MemLabel: TLabel;
    ResLabel: TLabel;
    Emaillabel: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Loadlin: TImage;
    AppLogo: TImage;
    Label2: TLabel;
    XPHomepagelabel: TLabel;
    OkBtn: TXPButton;
    LicenseBtn: TXPButton;
    ClassicOkBtn: TButton;
    ClassicLicenseBtn: TButton;
    procedure LicenseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HomepageLabelClick(Sender: TObject);
    procedure AppLogoClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{
var
  AboutBox: TAboutBox;
}

implementation

{$R *.DFM}

uses Strings, SysUtils, Files, MiscUtil, Settings, Fileman,
  Dialogs, Locale, Desk;

procedure TAboutBox.LicenseBtnClick(Sender: TObject);
var
  license : TFilename;
begin
  license := ApplicationPath + 'license.txt';
  if not FileExists(license) then
    MsgDialogRes(SCannotFindLicense, mtError, [mbOK], 0)
  else
    if FileExecute('open', 'notepad.exe', license, '',
      SW_SHOWMAXIMIZED) <= 32 then
        MsgDialogRes(SCannotRunNotepad, mtError, [mbOK], 0);
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  Height := 365;
  If not Buttonstyle then
   begin
    OkBtn.Visible := false;
    ClassicOkBtn.Visible := true;
    ClassicLicenseBtn.Visible := true;
    ClassicOkBtn.Top := 304;
    ClassicLicenseBtn.Top := 304;
  end;

  MemLabel.Caption := FormatByte(GetFreeSpace(0), 2, 2) + ' free';
  ResLabel.Caption := Format('System %d%%  GDI %d%%  User %d%%',
    [GetFreeSystemResources(GFSR_SYSTEMRESOURCES),
     GetFreeSystemResources(GFSR_GDIRESOURCES),
     GetFreeSystemResources(GFSR_USERRESOURCES)]);
  AppLogo.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'XPLOGO');
  Loadlin.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'LOADLIN');
if FirstRun then
  begin
    Caption := LoadStr(SWelcome);
    FirstRun := False;
  end;
end;

procedure TAboutBox.HomepageLabelClick(Sender: TObject);
begin
  modalresult := mrOk;
  { 2.2 added http:// }
  OpenURL('http://www.calmira.de');
end;

procedure TAboutBox.AppLogoClick(Sender: TObject);
begin
  Desktop.Revert;
end;

procedure TAboutBox.OKBtnClick(Sender: TObject);
begin
ModalResult := mrOk
end;

end.

