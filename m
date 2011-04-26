From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 3/4] munmap: kbuild menu for munmap interface
Date: Tue, 26 Apr 2011 09:42:32 +0900
Message-ID: <BANLkTi=psQRm9W9uXBgCEyYp-oEA0d0GVA@mail.gmail.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	<1303728272-11408-4-git-send-email-leemgs1@gmail.com>
	<20110425084508.dda5ec8f.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55111 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab1DZAmc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2011 20:42:32 -0400
In-Reply-To: <20110425084508.dda5ec8f.randy.dunlap@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 26, 2011 at 12:45 AM, Randy Dunlap <randy.dunlap@oracle.com=
> wrote:
> On Mon, 25 Apr 2011 19:44:31 +0900 Geunsik Lim wrote:
>
>> From: Geunsik Lim <geunsik.lim@samsung.com>
>>
>> Support kbuild menu to select memory unmap operation size
>> at build time.
>>
>> Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
>> Acked-by: Hyunjin Choi <hj89.choi@samsung.com>
>> ---
>> =C2=A0init/Kconfig | =C2=A0 70 +++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0mm/memory.c =C2=A0| =C2=A0 21 +++++++++++-----
>> =C2=A02 files changed, 84 insertions(+), 7 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 56240e7..0983961 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -557,6 +557,76 @@ config LOG_BUF_SHIFT
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
13 =3D> =C2=A08 KB
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
12 =3D> =C2=A04 KB
>>
>> +config PREEMPT_OK_MUNMAP_RANGE
>> + =C2=A0 =C2=A0 int "Memory unmap unit on preemption mode (8 =3D> 32=
KB)"
>> + =C2=A0 =C2=A0 depends on !PREEMPT_NONE
>> + =C2=A0 =C2=A0 range 8 2048
>> + =C2=A0 =C2=A0 default 8
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 unmap_vmas(=3Dunmap a range of memory covered=
 by a list of vma) is treading
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unmap_vmas (=3D unmap a range ...
>
>> + =C2=A0 =C2=A0 =C2=A0 a delicate and uncomfortable line between hi-=
performance and low-latency.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high performane and low latenc=
y.
>
>> + =C2=A0 =C2=A0 =C2=A0 We've chosen to improve performance at the ex=
pense of latency.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This option improves performance at=
 the expense of latency.
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 So although there may be no need to resched r=
ight now,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0reschedule
>
>> + =C2=A0 =C2=A0 =C2=A0 if we keep on gathering more and more without=
 flushing,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0gathering more and more <what> ?
>
>> + =C2=A0 =C2=A0 =C2=A0 we'll be very unresponsive when a resched is =
needed later on.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reschedule
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 Consider the best suitable result between hig=
h performance and low latency
>> + =C2=A0 =C2=A0 =C2=A0 on preemption mode.
>> + =C2=A0 =C2=A0 =C2=A0 Select optimal munmap size to return memory s=
pace that is allocated by mmap system call.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 For example, For recording mass files, if we =
try to unmap memory that we allocated
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 for
>
>> + =C2=A0 =C2=A0 =C2=A0 with 100MB for recording in embedded devices,=
 we have to wait for more than 3seconds to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A03 seconds
>
> (but try not to put text over 80 columns, please)
>
>> + =C2=A0 =C2=A0 =C2=A0 change mode from play mode to recording mode.=
 This results from the unit of memory
>> + =C2=A0 =C2=A0 =C2=A0 unmapped size when we are recording mass file=
s like camcorder particularly.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This value can be changed after =
boot using the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/proc/sys/vm/munmap_unit_size tu=
nable.
>
> Indent above with tab + 2 spaces.
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 Examples:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02048=
 =3D> 8,388,608bytes : for straight-line efficiency
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01024=
 =3D> 4,194,304bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 512=
 =3D> 2,097,152bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 256=
 =3D> 1,048,576bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 128=
 =3D> =C2=A0 524,288bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A064 =3D> =C2=A0 262,144bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A032 =3D> =C2=A0 131,072bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A016 =3D> =C2=A0 =C2=A065,536bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 8 =3D> =C2=A0 =C2=A032,768bytes : for low-latency (*default)
>
> All of above would be better with added space before "bytes", as, e.g=
=2E:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A08 =3D> =C2=A0 =C2=A032,768 bytes
>
>> +
>> +config PREEMPT_NO_MUNMAP_RANGE
>> + =C2=A0 =C2=A0 int "Memory unmap unit on non-preemption mode (1024 =
=3D> 4MB)"
>> + =C2=A0 =C2=A0 depends on PREEMPT_NONE
>> + =C2=A0 =C2=A0 range 8 2048
>> + =C2=A0 =C2=A0 default 1024
>> + =C2=A0 =C2=A0 help
>> +
>> + =C2=A0 =C2=A0 =C2=A0 unmap_vmas(=3Dunmap a range of memory covered=
 by a list of vma) is treading
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unmap_vmas (=3D unmap
>
>> + =C2=A0 =C2=A0 =C2=A0 a delicate and uncomfortable line between hi-=
performance and low-latency.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high performance and low laten=
cy.
>
>> + =C2=A0 =C2=A0 =C2=A0 We've chosen to improve performance at the ex=
pense of latency.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This option improves performance at=
 the expense of latency.
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 So although there may be no need to resched r=
ight now,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0reschedule
>
>> + =C2=A0 =C2=A0 =C2=A0 if we keep on gathering more and more without=
 flushing,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0more and more what?
>
>> + =C2=A0 =C2=A0 =C2=A0 we'll be very unresponsive when a resched is =
needed later on.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reschedule
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 Consider the best suitable result between hig=
h performance and low latency
>> + =C2=A0 =C2=A0 =C2=A0 on preemption mode.
>
> but this option is for non-preempt mode... so should that text above =
be modified?
>
>> + =C2=A0 =C2=A0 =C2=A0 Select optimal munmap size to return memory s=
pace that is allocated by mmap system call.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This value can be changed after =
boot using the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/proc/sys/vm/munmap_unit_size tu=
nable.
>
> Indent above with tab + 2 spaces.
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 Examples:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02048=
 =3D> 8,388,608bytes : for straight-line efficiency
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01024=
 =3D> 4,194,304bytes (*default)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 512=
 =3D> 2,097,152bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 256=
 =3D> 1,048,576bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 128=
 =3D> =C2=A0 524,288bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A064 =3D> =C2=A0 262,144bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A032 =3D> =C2=A0 131,072bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A016 =3D> =C2=A0 =C2=A065,536bytes
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 8 =3D> =C2=A0 =C2=A032,768bytes : for low-latency
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Use space befo=
re "bytes" in table above, please.
>
>> +
>> =C2=A0#
>> =C2=A0# Architectures with an unreliable sched_clock() should select=
 this:
>> =C2=A0#
>
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your c=
ode ***
Randy Dunlap. Thanks a lot.
I will modify contents that you commented.
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
