From: John Kacur <jkacur@gmail.com>
Subject: Re: Real-time kernel compile-fix for 32-bit when disabling
	CONFIG_PREEMPT_RT
Date: Tue, 31 Mar 2009 12:39:26 +0200
Message-ID: <520f0cf10903310339r41263cdat961ab40dc2565d9f@mail.gmail.com>
References: <bhm9a-75O-9@gated-at.bofh.it>
	 <f9ba8adc-60a4-43ba-b609-22e80ed984e1@p6g2000pre.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: geoffchien@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:18417 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbZCaKj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Mar 2009 06:39:29 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3016098qwh.37
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Mar 2009 03:39:26 -0700 (PDT)
In-Reply-To: <f9ba8adc-60a4-43ba-b609-22e80ed984e1@p6g2000pre.googlegroups.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/3/31  <geoffchien@gmail.com>:
> On 2008=A6~9=A4=EB29=A4=E9, =A4W=A4=C81=AE=C920=A4=C0, "John Kacur" <=
jka...@gmail.com> wrote:
>> If you start with the real-time kernel linux-2.6.26.5-rt9 and
>> configure it to disable CONFIG_PREEMPT_RT, for example
>> CONFIG_PREEMPT_DESKTOP=3Dy
>> # CONFIG_PREEMPT_RT is not set
>>
>> you will get the following compile error on 32-bit i386. (actually,
>> this will happen on any platform that doesn't use
>> CONFIG_RWSEM_GENERIC_SPINLOCK)
>>
>> In file included from include/linux/notifier.h:14,
>>                  from include/linux/memory_hotplug.h:6,
>>                  from include/linux/mmzone.h:560,
>>                  from include/linux/gfp.h:4,
>>                  from include/linux/slab.h:12,
>>                  from include/linux/percpu.h:5,
>>                  from include/linux/rcupdate.h:39,
>>                  from include/linux/tracepoint.h:18,
>>                  from include/linux/module.h:19,
>>                  from include/linux/crypto.h:21,
>>                  from arch/x86/kernel/asm-offsets_32.c:7,
>>                  from arch/x86/kernel/asm-offsets.c:2:
>> include/linux/rwsem.h:149: error: redefinition of 'rwsem_is_locked'
>> include/asm/rwsem.h:261: error: previous definition of
>> 'rwsem_is_locked' was here
>> include/linux/rwsem.h: In function 'rwsem_is_locked':
>> include/linux/rwsem.h:151: error: implicit declaration of function
>> 'compat_rwsem_is_locked'
>> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
>> make: *** [prepare0] Error 2
>>
>> The fix is simple, and should be folded back into the rt-mutex-core.=
patch
>> Fix is attached.
>>
>>  rwsem_is_locked-fix.patch
>> 1K=C0=CB=B5=F8=A4U=B8=FC
>
> Hi,
> My OS Kernel is Fedora 9 which is 2.6.25, and I've downloaded
> linux-2.6.26.8.tar.bz2 and patch-2.6.26.8-rt16.bz2. Also I've already
> patched them and downloaded the rwsem_is_locked-fix.patch and patched
> the rwsem_is_locked-fix.patch with rwsem.h. But there are still some
> problems,
> it shows:
> mm/slub.c: In function 'slab_unlock';
> mm/slub.c:1245: error: implicit declaration of function
> '_bit_spin_unlock'
> make[1]: ***[mm/slub.0] Error 1
> make: *** [mm] Error 2
>
> Would you please tell me why I'm encountering these?
> Sincerely
> Geoffrey
>

Hmnn, did you apply the proposed rwsem_is_locked-fix.patch ontop of
the rt-patch? Please don't use that patch since patch-2.6.26.8-rt16
should already have a fix for this problem. Please try this again,
using only linux-2.6.26.8 and patch-2.6.26.8-rt16.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
