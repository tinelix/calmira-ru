{**************************************************************************}
{                                                                          }
{    Calmira II shell for Microsoft� Windows(TM) 3.1                       }
{    Online! Release 3.3                                                  }
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

unit Embed;

interface

const
  SSSelectedItems   = '������� %d ���������  %s';
  SSSelectedOneItem = '������ %d �������  %s';
  SSNumObjects      = '%d �������%s  %s';
  SSNumTasks        = '%d �����%s'; { 3.11 }
  SSNoDescription   = '(��� ��������)';
  SSNoNetConnection = '(��� ������)';
  SSItemsFound      = '%d ��������� �������';
  SSFoundSelected   = '%d �������';
  SSDrive           = '���� (%s:)�%s';
  SSParallelPort    = 'LPT%s�%s';

const
  SelectionLabels: array[Boolean] of string[23] =
    (SSSelectedItems, SSSelectedOneItem); { 2.2 }

  SSUnknownDrive = '�����. (%s:)';
  SSNoDrive      = '��� ����� (%s:)';
  SSFloppyDrive  = '������ (%s:)';
  SSFixedDrive   = '������� (%s:)';
  SSNetworkDrive = '������� (%s:)';
  SSCDROMDrive   = 'CD-ROM (%s:)';
  SSRamDrive     = 'RAMdisk (%s:)';

implementation

end.
