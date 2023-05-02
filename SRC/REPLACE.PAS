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

unit Replace;

interface

uses
  Classes, SysUtils, Controls, Forms, StdCtrls, Buttons, ExtCtrls, Picbtn,
  Xpbutton,settings;

type
  TReplaceBox = class(TForm)
    Label3: TLabel;
    Target1: TLabel;
    Target2: TLabel;
    Label4: TLabel;
    Source1: TLabel;
    Source2: TLabel;
    Image1: TImage;
    Label1: TLabel;
    YesBtn: TXPButton;
    NoBtn: TXPButton;
    Cancelbtn: TXPButton;
    AllBtn: TXPButton;
    ClassicYesBtn: TButton;
    ClassicNoBtn: TButton;
    ClassicCancelBtn: TButton;
    ClassicAllBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure YesBtnClick(Sender: TObject);
    procedure NoBtnClick(Sender: TObject);
    procedure CancelbtnClick(Sender: TObject);
    procedure AllBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Query(const Filename, Destname: TFilename): Integer;
  end;

var
  ReplaceBox: TReplaceBox;

implementation

{$R *.DFM}

uses Strings, MiscUtil, WinProcs, WinTypes, Desk;

procedure AssignDetails(const fname: TFilename; NameLabel, InfoLabel: TLabel);
var
  rec: TSearchRec;
begin
  FindFirst(fname, faAnyfile, rec);
  NameLabel.Caption := fname;
  InfoLabel.Caption := Format('%s  %s', [FormatByte(rec.Size, 2, 2),
    FormatDateTime('dddd d mmmm yyyy,  hh:mm am/pm',
    TimestampToDate(rec.Time))]);
  FindClose(rec); { 3.11 }
end;

function TReplaceBox.Query(const Filename, Destname: TFilename): Integer;
begin
  AssignDetails(Destname, Target1, Target2);
  AssignDetails(Filename, Source1, Source2);
  Desktop.SetCursor(crDefault);
  try
    Result := ShowModal;
  finally
    Desktop.ReleaseCursor;
  end;
end;

procedure TReplaceBox.FormCreate(Sender: TObject);
begin
  Color := kleur1;
  Height := 202;
  if not ButtonStyle then
   begin
    YesBtn.Visible := false;
    NoBtn.Visible := false;
    CancelBtn.Visible := false;
    AllBtn.Visible := false;
    ClassicYesBtn.Visible := true;
    ClassicNoBtn.Visible := true;
    ClassicCancelBtn.Visible := true;
    ClassicAllBtn.Visible := true;
    ClassicYesBtn.Top := 144;
    ClassicNoBtn.Top := 144;
    ClassicCancelBtn.Top := 144;
    ClassicAllBtn.Top := 144;
   end;
  Image1.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
end;

procedure TReplaceBox.FormShow(Sender: TObject);
begin
  if MsgDialogSounds then MessageBeep(MB_ICONQUESTION);
end;

procedure TReplaceBox.YesBtnClick(Sender: TObject);
begin
ModalResult := mrYes;
end;

procedure TReplaceBox.NoBtnClick(Sender: TObject);
begin
ModalResult := MrNo;
end;

procedure TReplaceBox.CancelbtnClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;

procedure TReplaceBox.AllBtnClick(Sender: TObject);
begin
ModalResult := 8;
end;

end.

