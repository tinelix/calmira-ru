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

unit Askdrop;

interface

uses Forms, StdCtrls, Classes, Picbtn, ExtCtrls, Controls, Buttons,
  Xpbutton, settings;

type
  TAskDropBox = class(TForm)
    Label1: TLabel;
    Icon: TImage;
    BitBtn3: TXPButton;
    BitBtn2: TXPButton;
    BitBtn1: TXPButton;
    ClassicBitBtn1: TButton;
    ClassicBitBtn3: TButton;
    ClassicBitBtn2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AskDropBox: TAskDropBox;

implementation

{$R *.DFM}

uses WinProcs, WinTypes, MiscUtil;

procedure TAskDropBox.FormCreate(Sender: TObject);
begin
  Color := kleur1;
  Icon.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
  Height := 130;
  If not ButtonStyle then
   begin
    BitBtn1.Visible := false;
    BitBtn2.Visible := false;
    BitBtn3.Visible := false;
    ClassicBitBtn1.Visible := true;
    ClassicBitBtn2.Visible := true;
    ClassicBitBtn3.Visible := true;
    ClassicBitBtn1.Top := 68;
    ClassicBitBtn2.Top := 68;
    ClassicBitBtn3.Top := 68;
   end;

end;

procedure TAskDropBox.FormShow(Sender: TObject);
begin
  if MsgDialogSounds then MessageBeep(MB_ICONQUESTION);
end;

procedure TAskDropBox.BitBtn3Click(Sender: TObject);
begin
ModalResult := mrCancel;
end;

procedure TAskDropBox.BitBtn2Click(Sender: TObject);
begin
ModalResult := mrYes;
end;

procedure TAskDropBox.BitBtn1Click(Sender: TObject);
begin
ModalResult := mrOk;
end;

end.

