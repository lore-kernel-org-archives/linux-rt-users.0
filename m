From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS: linux-rt-3.14
 boots by reverting patches + nvidia uses __rt_mutex_init [which in 3.14 has
 been changed to EXPORT_SYMBOL_GPL]
Date: Thu, 24 Apr 2014 01:09:35 +0400
Message-ID: <53582C0F.8040901@pavlinux.ru>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: jordan <triplesquarednine@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp01.mtu.ru ([62.5.255.10]:45169 "EHLO imp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757969AbaDWVJj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2014 17:09:39 -0400
In-Reply-To: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

13.04.2014 19:50, jordan =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hey list.
>
> 1. So after finally having some time off of work [after a busy couple
> of months] i have come back to trying to sort out linux-rt on my AMD
> PHenom II 965 system - which had failed to boot post 3.12.5-rt7
>
> first, i need to make a correction -rt8 DID boot fine and was stable
> [after one/initial lockup, it never locked again, and obviously boote=
d
> fine.]. but i figured this out, only after doing a git-bisect on -rt7
> to -rt8 ... and never got around to testing -rt8 to -rt9... However, =
I
> decided to give 3.14-rt a run - and again - ended up with the machine
> failing to boot... Next, i decided to revert all three of the patches
> that you pointed out Sebastion;
>
> | timers-do-not-raise-softirq-unconditionally.patch
> | timer-Raise-softirq-if-there-s-irq_work.patch
> | timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch
>
> well, what i actually ended up doing was reverting the first and
> modifying the 1st patch to revert the other two patches (by changing
> ../kernel/timer.c section of the original patch). [ i reverted after
> applying the linux-rt patch, not split queue];
> http://pastebin.com/zwsZg9ZM

Please show patch between 3.14-rt1 and 3.14-rt1-you-version



--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
