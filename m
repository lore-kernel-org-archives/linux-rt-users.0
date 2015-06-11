From: =?UTF-8?B?U3TDqXBoYW5lIGFuY2Vsb3Q=?= <sancelot@numalliance.com>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 11:06:41 +0200
Message-ID: <55794FA1.20405@numalliance.com>
References: <5576FC70.8050908@numalliance.com>	<CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com>	<5577DCE0.3000805@numalliance.com>	<CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com>	<5577E019.6030106@numalliance.com>	<20150610144047.GB31886@zipoli.ccur.com>	<00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com>	<55792961.8080002@numalliance.com> <20150611101937.07d65235@archlinux> <55794C28.60505@numalliance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
	linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.numalliance.com ([83.206.84.204]:42173 "EHLO
	mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbbFKJGv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 05:06:51 -0400
In-Reply-To: <55794C28.60505@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Using a more recent system, I have following mistakes:
trying to patch a file not present in the kernel.
Sincerely, I do not understand what is the problem !

checking file arch/arm64/kernel/perf_event.c
Hunk #1 succeeded at 461 (offset -6 lines).
checking file arch/sparc/Kconfig
checking file arch/arm64/Kconfig
Hunk #1 succeeded at 61 (offset -7 lines).
checking file include/linux/notifier.h
checking file include/linux/srcu.h
checking file arch/x86/mm/iomap_32.c
Hunk #1 FAILED at 65.
1 out of 1 hunk FAILED
checking file arch/arm/mm/highmem.c
checking file kernel/futex.c
checking file kernel/softirq.c
Hunk #1 FAILED at 461.
1 out of 1 hunk FAILED
checking file arch/arm/include/asm/cmpxchg.h
checking file arch/arm/mm/fault.c
checking file kernel/printk/printk.c
checking file arch/x86/kvm/lapic.c
checking file arch/arm/kvm/arm.c
checking file arch/arm/kvm/psci.c
checking file arch/powerpc/include/asm/kvm_host.h
checking file arch/powerpc/kvm/book3s_hv.c
checking file arch/s390/include/asm/kvm_host.h
checking file arch/s390/kvm/interrupt.c
checking file arch/x86/kvm/lapic.c
Hunk #1 succeeded at 1539 (offset -34 lines).
Hunk #2 succeeded at 1553 (offset -34 lines).
checking file include/linux/kvm_host.h
checking file virt/kvm/async_pf.c
checking file virt/kvm/kvm_main.c
Hunk #2 succeeded at 1741 (offset 1 line).
Hunk #3 succeeded at 1758 (offset 1 line).
Hunk #4 succeeded at 1770 (offset 1 line).
Hunk #5 succeeded at 1879 (offset 1 line).
checking file kernel/locking/rtmutex.c
Hunk #1 FAILED at 1179.
1 out of 1 hunk FAILED
can't find file to patch at input line 1031
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|patches/Revert-rwsem-rt-Do-not-allow-readers-to-nest.patch000066400000=
000000000000000054511252644363100240520ustar00rootroot00000000000000Fro=
m=20
1db4ce56001465fba240916d0c8de7443cafec62 Mon Sep 17 00:00:00 2001
|From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
|Date: Wed, 25 Feb 2015 12:16:43 +0100
|Subject: [PATCH] Revert "rwsem-rt: Do not allow readers to nest"
|
|This behaviour is required by cpufreq and its logic is "okay": It does=
 a
|read_lock followed by a try_read_lock.
|Lockdep warns if one try a read_lock twice in -RT and vanilla so it
|should be good. We still only allow multiple readers as long as it is =
in
|the same process.
|
|Cc: stable-rt@vger.kernel.org
|Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
|---
| include/linux/rwsem_rt.h |    1 +
| kernel/locking/rt.c      |   29 +++++++++++++++++++++++------
| 2 files changed, 24 insertions(+), 6 deletions(-)
|
|--- a/include/linux/rwsem_rt.h
|+++ b/include/linux/rwsem_rt.h
--------------------------







On 11/06/2015 10:51, St=C3=A9phane ancelot wrote:
> On 11/06/2015 10:19, Ralf Mardorf wrote:
>> On Thu, 11 Jun 2015 08:23:29 +0200, St=C3=A9phane ancelot wrote:
>>> can you give me working md5sum of files downloaded ?
>>
>> "These checksums are NOT intended to replace the web of trust. It is
>> merely a way for someone to quickly verify whether contents on one o=
f
>> the many kernel.org mirrors match the contents on the master mirror.
>> While you may use them to quickly verify whether what you have
>> downloaded matches what we have on our central storage system, you
>> should still use the GPG web of trust to verify whether the release
>> tarball actually matches what the kernel developer published." -
>> https://www.kernel.org/category/signatures.html
>>
>> Begin forwarded message:
>>
>> Date: Thu, 11 Jun 2015 01:25:50 +0200 (CEST)
>> From: Thomas Gleixner
>> To: St=C3=A9phane ancelot
>> Cc: Romain Perier, linux-rt-users@vger.kernel.org
>> Subject: Re: rt patch
>>
>> [snip]
>>
>>> here is an example with linux-3.18.13 and patch 3.18.13-rt10:
>>> 3.18.13-rt10
>>>
>>> zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run
>>
>> You are trying to apply a tarball of patches instead of a single
>> combined patch. Use patch-3.18.13-rt10.gz instead.
>> [snip]
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> Ok, I checked,
>
> signatures are right. files well downloaded.
>
> I have always mistake while patching. software release problems?
>
> unxz version 4.999.9beta
> patch version 2.6
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
