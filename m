From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of
 my machines
Date: Fri, 7 Feb 2014 16:22:50 +0100
Message-ID: <20140207152250.GC2382@linutronix.de>
References: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46355 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbaBGPWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 10:22:51 -0500
Content-Disposition: inline
In-Reply-To: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* jordan | 2014-02-05 20:54:59 [-0500]:

>Hey list,
Hi jordan,

>I've been meaning to post, but alas, I am working three jobs right now
>(just took on more work) and haven't had a whole lot of free time to
>investigate my boot problems on linux-rt (-rt9, -rt10, -rt11, -rt13).
>
>On 3.12.8-rt11 - i was able to get the kernel to boot via reverting tw=
o
>patches, from the split queue;
>
>'timer-Raise-softirq-if-there-s-irq_work.patch'
>'timers-do-not-raise-softirq-unconditionally.patch'

It was reported to the list that
timers-do-not-raise-softirq-unconditionally.patch sometimes stalled the
machine. The timer-Raise-softirq-if-there-s-irq_work.patch should have
fixes one common case and -rt13 should have coverted them all.

>(i haven't tried reverting on -rt13, as i haven't had the time to do t=
hat).

It should work on -rt13 without reverting them.

>however, while this was enough to boot - my system was unstable. thus =
i
>downgraded my kernel back to trusty 3.12.5-rt7 - which works flawlessl=
y for
>me. Next, I saw the -rt13 release, thinking maybe the boot issue was
>finally solved [according to the change log], but no - it fails just a=
s
>before... I tried to add debug to grub's commandline but in the end, i=
t
>wasn't really helpful. [the last thing shown is something about PnP an=
d
>then ACPI];
>
>[    0.255329] pnp: PnP ACPI: found 10 devices
>[    0.255330] ACPI: bus type PNP unregistered
>
>(which i would normally see anyway.)

this looks like a missing event (like timer interrupt or RCU wakeup and
"timers-do-not-raise-softi=E2=80=A6" might be a source of this but then=
 it
should be fixed).

>I might have some time over the weekend (hopefully), to take a closer =
look
>- but i  thought i would at least notify the list ~ as i saw another u=
ser
>have the same booting problems and he has the same CPU as i do; AMD
>Phenom 965 X4 [not exactly exotic H/W and every RT release has worked
>great on my setup, until 3.12.x-rt8. Now, nothing works properly.
>[note: vanilla 3.12.x kernels boot just fine].
>
>anyway, if anyone has some suggestions - that i could follow up on ove=
r the
>weekend that would be fantastic.

At [0] is my quilt queue containing tags for releases between the
working and non-working release. As mentioned before,
timers-do-not-raise-softirq-unconditionally.patch will cause stalls
which is finally fixed by
timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch.

Looking at my queue between -rt8 and now there is nothing big except fo=
r
the "raise softirq unconditional" patch.
If you decide to bisect the queue to find the offending post -rt8 patch
that causes trouble, please note that take these patches
| timers-do-not-raise-softirq-unconditionally.patch
| timer-Raise-softirq-if-there-s-irq_work.patch
| timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch
should be applied together since the later two are fixes for the former=
=2E

[0] git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/rt-devel.git

>cheers
>
>Jordan

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
