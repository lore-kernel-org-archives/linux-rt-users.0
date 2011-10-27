From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Latency problem
Date: Thu, 27 Oct 2011 12:03:49 -0400
Message-ID: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58123 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1J0QEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 12:04:12 -0400
Received: by ggnb1 with SMTP id b1so2787036ggn.19
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2011 09:04:12 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Since some weeks, I'm facing a problem with the computer I'm using.
His results to the cyclictest are very bad, and the max latency is
about 38ms. Yes. "ms".

I didn't know yet if it was only a software problem or if it was
linked to hardware, so I installed a debian distribution, with RT
kernel (3.0.0-1-rt-amd64) on an external SDD, and tried it on more
than one computer. The results with other computers were very good
(about 40us maximum), but when I tried on this computer, or on others
computers with the same hardware: the problem was here. There is a
first maximum at about 19ms, and after that about 38ms.

> # /dev/cpu_dma_latency set to 0us
> policy: other/other: loadavg: 0.51 0.18 0.09 1/499 25409
>
> T: 0 (22080) P: 0 I:1000 C:  34849 Min:      3 Act:    3 Avg:   69 Ma=
x:   37864

Yesterday, I posted a patch that allowed me to test the hardware
latency of my computer, and here are the results (still very bad...) :

> root@USBnux:/home/xaf/RT/rt-tests# ./hwlatdetect --threshold=3D1 --re=
port=3D/home/xaf/hwlat_report
>
> hwlatdetect:  test duration 120 seconds
>   parameters:
>        Latency threshold: 1us
>
>        Sample window:     1000000us
>        Sample width:      500000us
>     Non-sampling period:  500000us
>        Output File:       /home/xaf/hwlat_report
>Starting test
>test finished
>Max Latency: 38136us
>Samples recorded: 45
>Samples exceeding threshold: 45
>sample data written to /home/xaf/hwlat_report

and the content of the hwlat_report file :

> 1319575592.0802426354	19061
> 1319575593.0806426299	2
> 1319575608.0898425572	19065
> 1319575610.0906425467	19063
> 1319575616.0930425175	2
> 1319575620.0950424982	19048
> 1319575622.0958424885	2
> 1319575627.0010424686	2
> 1319575629.0026424590	19063
> 1319575630.0030424546	19048
> 1319575633.0046424390	19063
> 1319575634.0050424344	19037
> 1319575637.0062424197	38125
> 1319575641.0078423997	19082
> 1319575642.0082423947	19062
> 1319575649.0110423608	19066
> 1319575650.0114423561	19050
> 1319575651.0118423511	19048
> 1319575655.0138423311	2
> 1319575659.0154423121	19069
> 1319575661.0162423015	19072
> 1319575662.0166422975	19049
> 1319575664.0174422870	19068
> 1319575665.0178422825	19063
> 1319575666.0182422774	19059
> 1319575668.0190422679	19055
> 1319575670.0198422577	19051
> 1319575671.0202422531	19060
> 1319575674.0222422384	2
> 1319575676.0230422288	38106
> 1319575680.0246422092	38136
> 1319575682.0254421988	19045
> 1319575683.0258421943	19045
> 1319575685.0266421842	19058
> 1319575689.0282421645	2
> 1319575695.0318421354	2
> 1319575696.0322421303	19050
> 1319575697.0326421258	19085
> 1319575699.0342421159	19049
> 1319575701.0366421057	19039
> 1319575702.0386420994	19049
> 1319575704.0390420911	19065
> 1319575706.0398420818	19053
> 1319575707.0402420761	19036
> 1319575710.0446420605	2

I really have no idea from where the problem could be. And I need your
lights to help me.
Here is the lspci of the incriminated computer :

> 00:00.0 Host bridge: Intel Corporation 5000X Chipset Memory Controlle=
r Hub (rev 31)
> 00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express=
 x4 Port 2 (rev 31)
> 00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express=
 x4 Port 3 (rev 31)
> 00:04.0 PCI bridge: Intel Corporation 5000X Chipset PCI Express x16 P=
ort 4-7 (rev 31)
> 00:08.0 System peripheral: Intel Corporation 5000 Series Chipset DMA =
Engine (rev 31)
> 00:10.0 Host bridge: Intel Corporation 5000 Series Chipset FSB Regist=
ers (rev 31)
> 00:10.1 Host bridge: Intel Corporation 5000 Series Chipset FSB Regist=
ers (rev 31)
> 00:10.2 Host bridge: Intel Corporation 5000 Series Chipset FSB Regist=
ers (rev 31)
> 00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved R=
egisters (rev 31)
> 00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved R=
egisters (rev 31)
> 00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Regist=
ers (rev 31)
> 00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD Regist=
ers (rev 31)
> 00:1b.0 Audio device: Intel Corporation 631xESB/632xESB High Definiti=
on Audio Controller (rev 09)
> 00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipse=
t UHCI USB Controller #1 (rev 09)
> 00:1d.1 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipse=
t UHCI USB Controller #2 (rev 09)
> 00:1d.2 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipse=
t UHCI USB Controller #3 (rev 09)
> 00:1d.3 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipse=
t UHCI USB Controller #4 (rev 09)
> 00:1d.7 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipse=
t EHCI USB2 Controller (rev 09)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9)
> 00:1f.0 ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LP=
C Interface Controller (rev 09)
> 00:1f.1 IDE interface: Intel Corporation 631xESB/632xESB IDE Controll=
er (rev 09)
> 00:1f.2 SATA controller: Intel Corporation 631xESB/632xESB SATA AHCI =
Controller (rev 09)
> 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus C=
ontroller (rev 09)
> 01:00.0 VGA compatible controller: nVidia Corporation GT215 [GeForce =
GT 240] (rev a2)
> 01:00.1 Audio device: nVidia Corporation High Definition Audio Contro=
ller (rev a1)
> 02:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Ups=
tream Port (rev 01)
> 02:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to =
PCI-X Bridge (rev 01)
> 03:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Dow=
nstream Port E1 (rev 01)
> 03:02.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express Dow=
nstream Port E3 (rev 01)
> 05:00.0 Ethernet controller: Intel Corporation 80003ES2LAN Gigabit Et=
hernet Controller (Copper) (rev 01)
> 05:00.1 Ethernet controller: Intel Corporation 80003ES2LAN Gigabit Et=
hernet Controller (Copper) (rev 01)


Thank you for your help.
Rapha=EBl
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
