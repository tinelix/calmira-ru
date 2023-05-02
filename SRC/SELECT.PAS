{**************************************************************************}
{                                                                          }
{    Calmira XP shell for Microsoft® Windows(TM) 3.1                       }
{    Version 3.32                                                          }
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

unit Select;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, StylSped, Picbtn, Settings, Xpbutton;

type
  TSelectFileEvent = procedure(Sender: TObject; const FileSpec: string;
    Select: Boolean) of object;

  TSelectFileDlg = class(TForm)
    Image: TImage;
    Edit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ClassicSelectBtn: TPicBtn;
    ClassicDeselectBtn: TPicBtn;
    ClassicCloseBtn: TPicBtn;
    SelectBtn: TXPButton;
    DeselectBtn: TXPButton;
    CloseBtn: TXPButton;
    procedure FormCreate(Sender: TObject);
    procedure ClassicSelectBtnClick(Sender: TObject);
    procedure ClassicCloseBtnClick(Sender: TObject);
  private
    { Private declarations }
    FSelectFiles: TSelectFileEvent;
  public
    { Public declarations }
    property OnSelectFiles: TSelectFileEvent read FSelectFiles write FSelectFiles;
  end;

var
  SelectFileDlg: TSelectFileDlg;

implementation

{$R *.DFM}

uses Strings, Resource;

procedure TSelectFileDlg.FormCreate(Sender: TObject);
begin
  height := 178;
  color := kleur1;
  Image.Picture.Icon.Assign(Icons.Get('MultiFile'));
  if not Buttonstyle then
   begin
    SelectBtn.Visible := false;
    DeselectBtn.Visible := false;
    CloseBtn.Visible := false;
    ClassicSelectBtn.Visible := true;
    ClassicDeselectBtn.Visible := true;
    ClassicCloseBtn.Visible := true;
    ClassicSelectBtn.Top := 116;
    ClassicDeselectBtn.Top := 116;
    ClassicCloseBtn.Top := 116;
   end;

end;

procedure TSelectFileDlg.ClassicSelectBtnClick(Sender: TObject);
var
  s: string;
begin
  if Assigned(FSelectFiles) then
  begin
    s := Edit.Text;
    repeat
      FSelectFiles(Self, GetWord(s, ';'), Sender = SelectBtn);
    until s = '';
  end;
end;

procedure TSelectFileDlg.ClassicCloseBtnClick(Sender: TObject);
begin
  Close;
  ModalResult := MrCancel;
end;

end.

