From: jordan <triplesquarednine@gmail.com>
Subject: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Sun, 13 Apr 2014 11:50:49 -0400
Message-ID: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:47673 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaDMPuu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Apr 2014 11:50:50 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so6519239veb.16
        for <linux-rt-users@vger.kernel.org>; Sun, 13 Apr 2014 08:50:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey list.

1. So after finally having some time off of work [after a busy couple
of months] i have come back to trying to sort out linux-rt on my AMD
PHenom II 965 system - which had failed to boot post 3.12.5-rt7

first, i need to make a correction -rt8 DID boot fine and was stable
[after one/initial lockup, it never locked again, and obviously booted
fine.]. but i figured this out, only after doing a git-bisect on -rt7
to -rt8 ... and never got around to testing -rt8 to -rt9... However, I
decided to give 3.14-rt a run - and again - ended up with the machine
failing to boot... Next, i decided to revert all three of the patches
that you pointed out Sebastion;

| timers-do-not-raise-softirq-unconditionally.patch
| timer-Raise-softirq-if-there-s-irq_work.patch
| timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch

well, what i actually ended up doing was reverting the first and
modifying the 1st patch to revert the other two patches (by changing
../kernel/timer.c section of the original patch). [ i reverted after
applying the linux-rt patch, not split queue];
http://pastebin.com/zwsZg9ZM

[ninez@localhost ~]$ uname -a
Linux localhost 3.14.0-rt1-1-l-pa #1 SMP PREEMPT RT Sun Apr 13
10:44:19 EDT 2014 x86_64 GNU/Linux

I've been running 3.14-rt for a couple of hours now and it appears to
be stable, thus far - without those patches/fixes applied [and
obviously doesn't boot at all with them applied...and as you know - i
am not the only AMD user affected by the boot failures...so i am
thinking those patches really need to be looked at again, as they
cause serious regressions for some of us :\

It also presents a problem because i package linux-rt and how i am
supposed to update it, when if i revert these patches, afaict - other
H/W may not boot. [wasn't it some i7 machines that failed or
something?]... So i am not sure what to do [aside from not updating my
packages until the problem is resolved upstream].

2. Nvidia [and possibly/most likely other out-of-tree drivers] make
use or __rt_mutex_init - which apparently has been changed from
EXPORT_SYMBOL to EXPORT_SYMBOL_GPL in 3.14 [or 3.13?] (and obviously
in 3.12 it was EXPORT_SYMBOL). I had to end up switching nvidia's
license to GPL in order to be able to use the driver/modules. I'm not
sure what is supposed to happen here, but nvidia should be usable
without having to change it's license [since i never had to before,
aside from similar situations where symbols where changed to gpl, only
to be reverted back, as has happened before].

anyway, I am less concerned about the nvidia issue [im just pointing
it out] and am obviously more concerned about being able to sort out
the boot failure issues, as afaict - they are caused by changes in
-rt9, not upstream.

cheerz

Jordan
