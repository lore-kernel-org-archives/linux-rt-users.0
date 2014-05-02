From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Fri, 02 May 2014 15:39:55 +0400
Message-ID: <5363840B.6020402@pavlinux.ru>
References: <1399029159.5233.124.camel@marge.simpson.net>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:44455 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbaEBLj6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:39:58 -0400
In-Reply-To: <1399029159.5233.124.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

02.05.2014 15:12, Mike Galbraith =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> The following patches are fixes that fell out of testing rt1.  Patche=
s
> 1-4 are intended to be folded into existing patches, 5-6 are
> replacements.
>
> fold:
> 1/6 - preempt-lazy-support.patch
> 2/6 - x86-preempt-lazy.patch
> 3/6 - hotplug-light-get-online-cpus.patch
> 4/6 - stomp-machine-raw-lock.patch
>
> replace:
> 5/6 - (prep)
> 6/6 - stomp-machine-deal-clever-with-stopper-lock.patch
>
> drop: (buggy - calls migrate_disable() _after_ maybe blocking)
> migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch


Cool, but you can the same, but for 3.14.2 ?


--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
