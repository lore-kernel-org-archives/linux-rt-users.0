From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: Searching a Bug on Raspberry Pi
Date: Thu, 04 Jul 2013 16:14:07 +0400
Message-ID: <393651372940047@web30e.yandex.ru>
References: <51CF2756.5080509@schorsch-tech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Georg Gast <georg@schorsch-tech.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward6.mail.yandex.net ([77.88.60.125]:39801 "EHLO
	forward6.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3GDMTi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jul 2013 08:19:38 -0400
In-Reply-To: <51CF2756.5080509@schorsch-tech.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, Georg!

29.06.2013, 22:39, "Georg Gast" <georg@schorsch-tech.de>:
> Hi there!
>
> Currently i try to locate a bug in sdhci.c on RaspberryPi. I know it =
is
> not the mainline kernel...
>
> Currently i use Kernel 3.8.13 and RT Patch 3.8.13-rt12 on the kernel
> found at git://github.com/raspberrypi/linux.git on branch rpi-3.8.y.
>
> The bug shows up as booting and after 3 seconds of booting as it want=
s
> to mount the rootfs in a deadlock. as i compiled sdhci_bcm2708 as a
> module i can boot the kernel and system as i pushed the system to a u=
sb
> stick. As far as good.
>
> Now i try to find the bug, if the rootfs is on the sdcard. I narrowd =
the
> deadlock down to the following lines:
>
> void sdhci_spin_lock_irqsave(struct sdhci_host *host,unsigned long *f=
lags)
> {
> =9A=9A=9A=9A=9Areturn;
> #ifdef CONFIG_PREEMPT
> =9A=9A=9A=9A=9Aif(enable_llm)
> =9A=9A=9A=9A=9A{
> =9A=9A=9A=9A=9A=9A=9A=9A=9Awhile(sdhci_locked)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A{
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Apreempt_schedule();
> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aspin_lock_irqsave(&host->lock,*flags);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Adisable_irq(host->irq);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif(host->second_irq)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Adisable_irq(host->second_irq);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Alocal_irq_enable();
> =9A=9A=9A=9A=9A}
> =9A=9A=9A=9A=9Aelse
> #endif
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aspin_lock_irqsave(&host->lock,*flags);
> }
>
> void sdhci_spin_unlock_irqrestore(struct sdhci_host *host,unsigned lo=
ng
> flags)
> {
> =9A=9A=9A=9A=9Areturn;
> #ifdef CONFIG_PREEMPT
> =9A=9A=9A=9A=9Aif(enable_llm)
> =9A=9A=9A=9A=9A{
> =9A=9A=9A=9A=9A=9A=9A=9A=9Alocal_irq_disable();
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif(host->second_irq)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aenable_irq(host->second_irq);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aenable_irq(host->irq);
> =9A=9A=9A=9A=9A}
> #endif
> =9A=9A=9A=9A=9Aspin_unlock_irqrestore(&host->lock,flags);
> }
>
> in drivers/mmc/host/sdhci.c . The both return statements are added by
> me. Now i can boot the RT Preempt kernel but it is for sure not the
> right fix.
>
> My problem is, that i dont know how those both functions should work
> with the rt preempt patch.

Spinlocks transform to mutexes on RT kernel and really functions like
spin_lock_irqsave() do not disable interrupts. Your problem can be conn=
ected
with that.

If you code works on !RT kernel you should convert the type of host->lo=
ck
from spinlock_t to raw_spinlock_t and all of spin_lock_irqsave()
to raw_spin_lock_irqsave() etc.

I think this will help you. Sadly, I don't have enough time to look at =
whole of your
driver.

Kirill
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
