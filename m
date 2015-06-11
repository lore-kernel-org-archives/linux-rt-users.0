From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 11 Jun 2015 14:08:28 +0200
Message-ID: <20150611120828.GD16115@linutronix.de>
References: <20150519213923.GA26363@linutronix.de>
 <55606B3C.2030604@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55606B3C.2030604@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Pavel Vasilyev | 2015-05-23 14:57:48 [+0300]:

>20.05.2015 00:39, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>>Dear RT folks!
>>
>>I'm pleased to announce the v4.0.4-rt1 patch set.
>
>Guys, 4.0.4-rt1 freezing after
>
># sysctl -w vm.drop_caches=3D3 && memhog `free -k | grep Mem | awk
>'{print $4"k"}'` 2>&1 >/dev/null;

it might be related to the part where it runs into the BUG_ON() in the
swap code. Try my patch from "[RFC][PATCH] mm: ifdef out VM_BUG_ON chec=
k
on PREEMPT_RT_FULL" thread, disable swap or wait for new -RT to verify.

Sebastian
