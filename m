From: =?UTF-8?B?U3TDqXBoYW5lIGFuY2Vsb3Q=?= <sancelot@numalliance.com>
Subject: Re: rt patch
Date: Wed, 10 Jun 2015 08:58:33 +0200
Message-ID: <5577E019.6030106@numalliance.com>
References: <5576FC70.8050908@numalliance.com>	<CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com>	<5577DCE0.3000805@numalliance.com> <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Romain Perier <romain.perier@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.numalliance.com ([83.206.84.204]:37960 "EHLO
	mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbbFJG6n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2015 02:58:43 -0400
In-Reply-To: <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

here is an example with linux-3.18.13 and patch 3.18.13-rt10:
3.18.13-rt10

zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run
patching file arch/arm64/kernel/perf_event.c
Hunk #1 succeeded at 461 (offset -6 lines).
patching file arch/sparc/Kconfig
patching file arch/arm64/Kconfig
Hunk #1 succeeded at 61 (offset -7 lines).
patching file include/linux/notifier.h
patching file include/linux/srcu.h
patching file arch/x86/mm/iomap_32.c
Hunk #1 FAILED at 65.
1 out of 1 hunk FAILED -- saving rejects to file arch/x86/mm/iomap_32.c=
=2Erej
patching file arch/arm/mm/highmem.c
patching file kernel/futex.c
patching file kernel/softirq.c
Hunk #1 FAILED at 461.
1 out of 1 hunk FAILED -- saving rejects to file kernel/softirq.c.rej
patching file arch/arm/include/asm/cmpxchg.h
patching file arch/arm/mm/fault.c
patching file kernel/printk/printk.c
patching file arch/x86/kvm/lapic.c
patching file arch/arm/kvm/arm.c
patching file arch/arm/kvm/psci.c
patching file arch/powerpc/include/asm/kvm_host.h
patching file arch/powerpc/kvm/book3s_hv.c
patching file arch/s390/include/asm/kvm_host.h
patching file arch/s390/kvm/interrupt.c
patching file arch/x86/kvm/lapic.c
Hunk #1 succeeded at 1539 (offset -34 lines).
Hunk #2 succeeded at 1553 (offset -34 lines).
patching file include/linux/kvm_host.h
patching file virt/kvm/async_pf.c
patching file virt/kvm/kvm_main.c
Hunk #2 succeeded at 1741 (offset 1 line).
Hunk #3 succeeded at 1758 (offset 1 line).
Hunk #4 succeeded at 1770 (offset 1 line).
Hunk #5 succeeded at 1879 (offset 1 line).
patching file kernel/locking/rtmutex.c
Hunk #1 FAILED at 1179.
1 out of 1 hunk FAILED -- saving rejects to file=20
kernel/locking/rtmutex.c.rej
patching file include/linux/rwsem_rt.h
Hunk #1 FAILED at 20.
1 out of 1 hunk FAILED -- saving rejects to file=20
include/linux/rwsem_rt.h.rej
patching file kernel/locking/rt.c
Hunk #1 FAILED at 316.
Hunk #2 FAILED at 327.
Hunk #3 FAILED at 356.
Hunk #4 FAILED at 371.
Hunk #5 FAILED at 396.
5 out of 5 hunks FAILED -- saving rejects to file kernel/locking/rt.c.r=
ej
patching file include/linux/hrtimer.h
Reversed (or previously applied) patch detected!  Assume -R? [n]


On 10/06/2015 08:50, Romain Perier wrote:
> Hi,
>
> It would propably be easier for us if you give the error.... What is
> the exact error ?
>
> Regards,
> Romain
>
> 2015-06-10 8:44 GMT+02:00 St=C3=A9phane ancelot <sancelot@numalliance=
=2Ecom>:
>> Hi,
>>
>> Yes, I did ! This is why I asked ....
>> and kernels from here , why v3.0 and v4.0 kernels, patch errors .
>>
>> https://www.kernel.org/pub/linux/kernel/
>>
>>
>> Regards
>> S.Ancelot
>>
>>
>> On 09/06/2015 17:12, Romain Perier wrote:
>>>
>>> Hi,
>>>
>>> did you try the patches located at
>>> https://www.kernel.org/pub/linux/kernel/projects/rt/ ?
>>> Use the corresponding mainline kernel, for example if you want to u=
se
>>> 3.18.13-rt10, download linux 3.18.13 (from torvald's repo for examp=
le)
>>> and apply the rt patch on it .
>>> Latest rt patches are for linux 3.18 and 4.0, so if you use the
>>> correct version it should work just fine.
>>>
>>> Everything is explained on the wiki,
>>> Regards,
>>> Romain
>>>
>>> 2015-06-09 16:47 GMT+02:00 St=C3=A9phane ancelot <sancelot@numallia=
nce.com>:
>>>>
>>>> Hi,
>>>> I have tried the rt patches available on kernel.org.
>>>> Unfortunately none patches correctly with latests kernel !
>>>>
>>>> Where can I download the good ones ?
>>>> Regards,
>>>> Steph
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-rt=
-users"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
