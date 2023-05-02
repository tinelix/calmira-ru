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
unit Xpprop;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Xpbutton, ExtCtrls, TabPanel, settings;

type
  TXpPropDlg = class(TForm)
    TabPanel: TTabPanel;
    Notebook: TNotebook;
    OkBtn: TXPButton;
    CancelBtn: TXPButton;
    HelpBtn: TXPButton;
    ClassicOkBtn: TButton;
    ClassicCancelBtn: TButton;
    ClassicHelpBtn: TButton;
    XPStyleColors: TRadioButton;
    ClassicStyleColors: TRadioButton;
    Bevel2: TBevel;
    XPStyleButtons: TRadioButton;
    ClassicStyleButtons: TRadioButton;
    Bevel3: TBevel;
    Label4: TLabel;
    Label1: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  XpPropDlg: TXpPropDlg;

implementation

{$R *.DFM}

procedure TXpPropDlg.FormPaint(Sender: TObject);
 begin
  Color := kleur1;
  Tabpanel.Color := kleur2;
  Label1.Font.Color := kleur3;
  Label4.Font.Color := kleur3;
  Height := 402;
  If not Buttonstyle then
   begin
    OkBtn.Visible := false;
    CancelBtn.Visible := false;
    HelpBtn.Visible := false;
    ClassicOkBtn.Visible := true;
    ClassicCancelBtn.Visible := true;
    ClassicHelpBtn.Visible := true;
    ClassicOkBtn.Top := 344;
    ClassicCancelBtn.Top := 344;
    ClassicHelpBtn.Top := 344;
   end;
 if XPStyleKleur then
  XPStyleColors.Checked := true
 else
  ClassicStyleColors.Checked := true;
  Notebook.PageIndex := 0;

 if ButtonStyle then
  XPStyleButtons.Checked := true
 else
  ClassicStyleButtons.Checked := true;

end;

procedure TXpPropDlg.OkBtnClick(Sender: TObject);
 begin
  if XPStyleColors.Checked then
   XPStyleKleur := true;
  if ClassicStyleColors.Checked then
  XPStyleKleur := false;

  if XPStyleButtons.Checked then
   ButtonStyle := true;
  if ClassicStyleButtons.Checked then
   ButtonStyle := false;

 SaveXpProp;
 LoadXpProp;
 modalresult := mrOk;
end;





procedure TXpPropDlg.CancelBtnClick(Sender: TObject);
begin
Modalresult := mrCancel;
end;

end.
