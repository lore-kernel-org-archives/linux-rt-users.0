From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: 3.12.5 CRASH/FREEZE
Date: Mon, 23 Dec 2013 02:19:14 +0400
Message-ID: <52B76562.7040608@pavlinux.ru>
References: <52A9CC77.20904@linaro.org> <52AA1CC0.30307@pavlinux.ru> <20131220141008.GE10249@linutronix.de> <52B45AEB.2060508@pavlinux.ru> <52B45CD7.5030404@linutronix.de>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:56654 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab3LVWTf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Dec 2013 17:19:35 -0500
In-Reply-To: <52B45CD7.5030404@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

20.12.2013 19:05, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> On 12/20/2013 03:57 PM, Pavel Vasilyev wrote:
>>
>> Same bug if attach to ehci hub.
>>
>> ksoftird/0 process of loading the CPU upto 100% Sometimes process
>> irq17/0 - ehci_hcd  or xhci_hcd. After taking the camera out of the
>> socket, the load does not fall, keyboard and console blocked
>=20
> Okay, but this problem is unique to your webcam. Keyboard & mice to
> work as usual?
> Could please provide me the addr2line either for the ehci or xhci? I'=
ve
> been browsing to the code and I didn't see anything obvious.
>=20

Too many bugs, too many computers ...

3.12.5-rt7 work ONLY in UP-mode!!! cmdline: nosmp maxcpus=3D1

In SMP mode, problems arise in different places on different computers.
On Intel Atom - USB, webcam and console. On the Opteron 285 system
does not boot, can't mount devtmpfs, XFS partitions ...

I can not get to catch the error and find a place neither in debug mode=
 or in
normal. Because everything is frozen completely, and get to the console=
 or logs
is not possible.
I described one situation where had run top and see that the process
ksoftirqd/0 use CPU upto 100%

P.S.
    3.12.5-rt7 still work Basic-RT mode.






--=20

                                                         Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
