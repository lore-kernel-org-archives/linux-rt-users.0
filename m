From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 20 May 2015 13:06:22 +0300
Message-ID: <555C5C9E.2030607@pavlinux.ru>
References: <20150519213923.GA26363@linutronix.de>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519213923.GA26363@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

20.05.2015 00:39, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> Dear RT folks!
>
> I'm pleased to announce the v4.0.4-rt1 patch set.

While work stable. \m/

TYAN S8225
2 x AMD Opteron(tm) Processor 4386
16Gb DDR3 ECC Reg.
Nvidia GeForce GT740 (blob driver)

CONFIG_NO_HZ_COMMON=3Dy
CONFIG_NO_HZ_FULL=3Dy
CONFIG_NO_HZ_FULL_ALL=3Dy
=2E..

# cyclictest -S -c 1 -m -p 99 --latency=3D0 --policy=3Dfifo

# /dev/cpu_dma_latency set to 0us
WARN: Running on unknown kernel version...YMMV
policy: fifo: loadavg: 1.57 1.70 1.55 1/557 19347

T: 0 (18369) P:99 I:1000 C:  26617 Min:      6 Act:   13 Avg:   12 Max:=
    1614
T: 1 (18370) P:99 I:1500 C:  17742 Min:      6 Act:   18 Avg:   19 Max:=
    1700
T: 2 (18371) P:99 I:2000 C:  13304 Min:      8 Act:   19 Avg:   20 Max:=
    1620
T: 3 (18372) P:99 I:2500 C:  10642 Min:      6 Act:   16 Avg:   17 Max:=
      73
T: 4 (18373) P:99 I:3000 C:   8867 Min:      8 Act:   20 Avg:   20 Max:=
    1497
T: 5 (18374) P:99 I:3500 C:   7599 Min:      8 Act:   20 Avg:   20 Max:=
      90
T: 6 (18375) P:99 I:4000 C:   6648 Min:      6 Act:   18 Avg:   19 Max:=
      94
T: 7 (18376) P:99 I:4500 C:   5908 Min:      9 Act:   18 Avg:   19 Max:=
    1172
T: 8 (18377) P:99 I:5000 C:   5317 Min:      6 Act:   17 Avg:   20 Max:=
      66
T: 9 (18378) P:99 I:5500 C:   4832 Min:      7 Act:   24 Avg:   19 Max:=
     100
T:10 (18379) P:99 I:6000 C:   4429 Min:      7 Act:   14 Avg:   19 Max:=
    1216
T:11 (18380) P:99 I:6500 C:   4088 Min:      8 Act:   14 Avg:   20 Max:=
     827
T:12 (18381) P:99 I:7000 C:   3795 Min:      7 Act:   17 Avg:   18 Max:=
      77
T:13 (18382) P:99 I:7500 C:   3542 Min:      6 Act:   18 Avg:   20 Max:=
      71
T:14 (18383) P:99 I:8000 C:   3320 Min:      8 Act:   19 Avg:   20 Max:=
      73
T:15 (18384) P:99 I:8500 C:   3124 Min:      6 Act:   23 Avg:   19 Max:=
      75





--=20

                                                          Pavel.
