From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Wed, 20 May 2015 01:48:58 +0300
Message-ID: <555BBDDA.2080904@pavlinux.ru>
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


Patch worked with 4.1.0-rc2, exclude at91rm9200_time.c

--- cut ---

can't find file to patch at input line 700
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/arch/arm/mach-at91/at91rm9200_time.c=20
b/arch/arm/mach-at91/at91rm9200_time.c
|index b00d09555f2b..cc873c12181d 100644
|--- a/arch/arm/mach-at91/at91rm9200_time.c
|+++ b/arch/arm/mach-at91/at91rm9200_time.c
--------------------------
=46ile to patch:
Skip this patch? [y]
Skipping patch.
1 out of 1 hunk ignored

--- cut ---

--=20

                                                          Pavel.
