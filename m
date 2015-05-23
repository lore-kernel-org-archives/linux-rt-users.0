From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Sat, 23 May 2015 14:57:48 +0300
Message-ID: <55606B3C.2030604@pavlinux.ru>
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

Guys, 4.0.4-rt1 freezing after

# sysctl -w vm.drop_caches=3D3 && memhog `free -k | grep Mem | awk '{pr=
int=20
$4"k"}'` 2>&1 >/dev/null;

- CONFIG_PREEMPT_RT_BASE or CONFIG_PREEMPT_RT_FULL
- Debian 8
- Nvidia blob 346.47 (GeForce GT 740)
- Google Chrome 43.0.2357.65 (64-bit)


--=20

                                                          Pavel.
