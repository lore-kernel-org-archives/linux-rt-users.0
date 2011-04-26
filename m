From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 3/4] munmap: kbuild menu for munmap interface
Date: Tue, 26 Apr 2011 09:40:58 +0900
Message-ID: <BANLkTi=CHQ39hQZuvUdZ0z2OZxy2jksE_w@mail.gmail.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	<1303728272-11408-4-git-send-email-leemgs1@gmail.com>
	<1303745473.18763.9.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45650 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab1DZAk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2011 20:40:59 -0400
In-Reply-To: <1303745473.18763.9.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 26, 2011 at 12:31 AM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
> On Mon, 2011-04-25 at 19:44 +0900, Geunsik Lim wrote:
>> From: Geunsik Lim <geunsik.lim@samsung.com>
>>
>> Support kbuild menu to select memory unmap operation size
>> at build time.
>
> The subject and this line are not quite the same. The subject looks l=
ike
> it only modifies the kbuild options, not mm/memory.c as well. Please
> fix.
You are right. I will fix it.
>
>>
>> Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
>> Acked-by: Hyunjin Choi <hj89.choi@samsung.com>
>> ---
>> =C2=A0init/Kconfig | =C2=A0 70 +++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0mm/memory.c =C2=A0| =C2=A0 21 +++++++++++-----
>> =C2=A02 files changed, 84 insertions(+), 7 deletions(-)
>>
>
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -57,6 +57,7 @@
>> =C2=A0#include <linux/swapops.h>
>> =C2=A0#include <linux/elf.h>
>> =C2=A0#include <linux/gfp.h>
>> +#include <linux/munmap_unit_size.h>
>>
>> =C2=A0#include <asm/io.h>
>> =C2=A0#include <asm/pgalloc.h>
>> @@ -1079,6 +1080,10 @@ static unsigned long unmap_page_range(struct =
mmu_gather *tlb,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (*zap_work)--;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +#if 0
>> +printk("DEBUG:munmap step2,(%s:%d), unmap range =3D current(%lu) + =
\
>> +zap_work(%lu bytes) \n", current->comm, current->pid, addr, *zap_wo=
rk);
>> +#endif
>
> No #if 0 debug printing in mainline.
Thank you for your advice.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next =3D zap_pud_ra=
nge(tlb, vma, pgd, addr, next,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 zap_work, details);
>> =C2=A0 =C2=A0 =C2=A0 } while (pgd++, addr =3D next, (addr !=3D end &=
& *zap_work > 0));
>> @@ -1088,12 +1093,10 @@ static unsigned long unmap_page_range(struct=
 mmu_gather *tlb,
>> =C2=A0 =C2=A0 =C2=A0 return addr;
>> =C2=A0}
>>
>> -#ifdef CONFIG_PREEMPT
>> -# define ZAP_BLOCK_SIZE =C2=A0 =C2=A0 =C2=A0(8 * PAGE_SIZE)
>> -#else
>> -/* No preempt: go for improved straight-line efficiency */
>> -# define ZAP_BLOCK_SIZE =C2=A0 =C2=A0 =C2=A0(1024 * PAGE_SIZE)
>> -#endif
>> +/* No preempt: go for improved straight-line efficiency
>> + * on PREEMPT(preemption mode) this is not a critical latency-path.
>> + */
>> +# define ZAP_BLOCK_SIZE =C2=A0 =C2=A0 =C2=A0 =C2=A0(munmap_unit_siz=
e * PAGE_SIZE)
>>
>> =C2=A0/**
>> =C2=A0 * unmap_vmas - unmap a range of memory covered by a list of v=
ma's
>> @@ -1133,7 +1136,11 @@ unsigned long unmap_vmas(struct mmu_gather **=
tlbp,
>> =C2=A0 =C2=A0 =C2=A0 spinlock_t *i_mmap_lock =3D details? details->i=
_mmap_lock: NULL;
>> =C2=A0 =C2=A0 =C2=A0 int fullmm =3D (*tlbp)->fullmm;
>> =C2=A0 =C2=A0 =C2=A0 struct mm_struct *mm =3D vma->vm_mm;
>> -
>> +#if 0
>> +printk("DEBUG:munmap step1,(%s:%d), unit=3Dzap_work(%ld)/ZAP_BLOCK(=
%ld), \
>> +vma:[%8lu]=3D%lu-%lu \n", current->comm, current->pid, zap_work, ZA=
P_BLOCK_SIZE, \
>> +vma->vm_end - vma->vm_start, vma->vm_end, vma->vm_start);
>> +#endif
>
> Get rid of this too.
>
> Either have pr_debug(...) or nothing at all.
In fact, I wondered about this debug messages for just debugging. :)
Yes. I will remove this debug messages because it is not necessary
as you commented.
>
> -- Steve
>
>> =C2=A0 =C2=A0 =C2=A0 mmu_notifier_invalidate_range_start(mm, start_a=
ddr, end_addr);
>> =C2=A0 =C2=A0 =C2=A0 for ( ; vma && vma->vm_start < end_addr; vma =3D=
 vma->vm_next) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long end;
>
>
>



--=20
Regards,
Geunsik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 leemgs@gmail.com , leemgs1@gma=
il.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
Please read the FAQ at=C2=A0 http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
