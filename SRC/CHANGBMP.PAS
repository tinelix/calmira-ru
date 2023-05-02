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
unit Changbmp;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Settings, Xpbutton;

type
  TChangeUserBmpDlg = class(TForm)
    Label1: TLabel;
    Curpict: TLabel;
    Picture: TImage;
    Label3: TLabel;
    BmpLocation: TEdit;
    ClassicBrowseBtn: TButton;
    OpenDialog: TOpenDialog;
    ClassicOkBtn: TButton;
    SelUser: TLabel;
    OkBtn: TXPButton;
    ClassicCancelBtn: TButton;
    CancelBtn: TXPButton;
    BrowseBtn: TXPButton;
    Shape1: TShape;
    procedure BrowseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangeUserBmpDlg: TChangeUserBmpDlg;

implementation

{$R *.DFM}

procedure TChangeUserBmpDlg.BrowseBtnClick(Sender: TObject);
begin
with OpenDialog do if Execute then
    BmpLocation.Text := LowerCase(Filename);
end;

procedure TChangeUserBmpDlg.FormCreate(Sender: TObject);
begin
Color := kleur1;
  If not Buttonstyle then
   begin
    OkBtn.Visible := false;
    CancelBtn.Visible := false;
    BrowseBtn.Visible := false;
    ClassicOkBtn.Visible := true;
    ClassicCancelBtn.Visible := true;
    ClassicBrowseBtn.Visible := true;
    ClassicOkBtn.Top := 128;
    ClassicCancelBtn.Top := 128;
    ClassicBrowseBtn.Left := 168;
   end;
end;

procedure TChangeUserBmpDlg.OkBtnClick(Sender: TObject);
begin
ModalResult := mrOk;
end;

procedure TChangeUserBmpDlg.CancelBtnClick(Sender: TObject);
begin
ModalResult := MrCancel;
end;

end.
