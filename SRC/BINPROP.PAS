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

unit Binprop;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, TabNotBk, ExtCtrls, Chklist, TabPanel, Picbtn, Xpbutton;

type
  TBinPropDlg = class(TForm)
    TabPanel: TTabPanel;
    Notebook: TNotebook;
    Bevel1: TBevel;
    Label4: TLabel;
    Label2: TLabel;
    CapEdit: TEdit;
    cbIcons: TCheckBox;
    Label3: TLabel;
    Bevel2: TBevel;
    rbUseBin: TRadioButton;
    TrashPanel: TPanel;
    Label1: TLabel;
    rbLeave: TRadioButton;
    rbEmpty: TRadioButton;
    rbCollect: TRadioButton;
    cbDeleteToBin: TCheckBox;
    SizeEdit: TSpinEdit;
    rbDelete: TRadioButton;
    OkBtn: TXPButton;
    CancelBtn: TXPButton;
    HelpBtn: TXPButton;
    ClassicHelpBtn: TButton;
    ClassicCancelBtn: TButton;
    ClassicOkBtn: TButton;
    procedure rbCollectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure rbUseBinClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{
var
  BinPropDlg: TBinPropDlg;
}

implementation

uses WasteBin, MiscUtil, Settings;

{$R *.DFM}

procedure TBinPropDlg.rbCollectClick(Sender: TObject);
begin
  SizeEdit.Enabled := rbCollect.Checked;
end;

procedure TBinPropDlg.FormCreate(Sender: TObject);
begin
  Color := kleur1;
  Tabpanel.Color := kleur2;
  Label3.Font.Color := kleur3;
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
  Notebook.PageIndex := 0;
  CapEdit.Text := BinCaption;
  if BinAction = baDelete then rbDelete.Checked := True
  else
  begin
    rbUseBin.Checked := True;
    case BinAction of
      baLeave   : rbLeave.Checked := True;
      baEmpty   : rbEmpty.Checked := True;
      baCollect : rbCollect.Checked := True;
    end;
  end;
  SizeEdit.Value := BinCapacity;
  cbDeleteToBin.Checked := DeleteToBin;
  cbIcons.Checked := BinIcons;
  EnableControlList([OKBtn, Notebook], CanEditSettings); { 2.2 }
end;

procedure TBinPropDlg.OKBtnClick(Sender: TObject);
const
  Actions : array[0..2] of TBinAction = (baLeave, baEmpty, baCollect);
begin
  BinCaption := CapEdit.Text;
  if rbDelete.Checked then BinAction := baDelete
  else BinAction := Actions[GetRadioIndex([rbLeave, rbEmpty, rbCollect])];
  BinCapacity := SizeEdit.Value;
  DeleteToBin := cbDeleteToBin.Checked;
  BinIcons := cbIcons.Checked;
  SaveBinProp;
  Bin.Configure;
  AnnounceSettingsChanged([scBin]);
  Modalresult := mrOk;
end;

procedure TBinPropDlg.rbUseBinClick(Sender: TObject);
const
  TextColors : array[Boolean] of TColor = (clGray, clBlack);
begin
  TrashPanel.Enabled := rbUseBin.Checked;
  TrashPanel.Font.Color := TextColors[rbUseBin.Checked];
end;

procedure TBinPropDlg.CancelBtnClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;

procedure TBinPropDlg.HelpBtnClick(Sender: TObject);
 begin
  Application.HelpFile := 'CALMIRA.HLP';
  Application.HelpContext(42);
  ModalResult := mrNone;
 end;

end.

