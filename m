From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 0/4] munmap: Flexible mem unmap operation interface for
 scheduling latency
Date: Wed, 27 Apr 2011 08:57:24 +0900
Message-ID: <BANLkTi=V8gU6ax1b69dOwB_apB-s6eS2xg@mail.gmail.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	<1303760837.4865.22.camel@laptop>
	<BANLkTimoG7muVanF6P8YYvfZA7WUT+9XKg@mail.gmail.com>
	<1303802572.20212.4.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64130 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab1DZX5Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Apr 2011 19:57:25 -0400
In-Reply-To: <1303802572.20212.4.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 26, 2011 at 4:22 PM, Peter Zijlstra <a.p.zijlstra@chello.nl=
> wrote:
> On Tue, 2011-04-26 at 10:20 +0900, Geunsik Lim wrote:
>> Yes. I also checked the patch that you stated at LKML mailing list p=
reviously.
>> In my thinking. I want to keep ZAP_BLOCK_SIZE related contents
>> that adjusted by Ingo, Robert, Andrew, and so on a long time ago
>> because I believe that we can overcome below problems sufficiently
>> in real world.
>> . LKML archive - http://lkml.org/lkml/2002/7/24/273
>> . LKML archive - http://lkml.org/lkml/2004/9/14/101
>
> Real ancient world, that was 2004, well before we grew preemptible
> mmu_gather.
>
>> In my experience, I did overcome below problems with this patch
>> based on ZAP_BLOCK_SIZE.
>>
>> 1) To solve temporal CPU contention
>> =C2=A0 =C2=A0 (e.g: case that cpu contention is 93% ~ 96% according =
to mmap/munmap
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to access mass files )
>> 2) To get real-time or real-fast selectively on specified linux syst=
em
>
> I still don't get it, what kernel are you targeting here and why?
In my case, I tested at embedded target(e.g: 2.6.29 , 2.6.32) based on
arm cortex-a series for user responsiveness when trying to access mass =
files.
>
> -RT doesn't care, and clearly PREEMPT=3Dn doesn't care because its no=
t
> about latency at all, the only half-way point is PREEMPT=3Dy and for =
that
> you could simply reduce ZAP_BLOCK_SIZE.
Thank you for your reviews.  yes. we can simply reduce ZAP_BLOCK_SIZE.
I mean that we can control ZAP_BLOCK_SIZE after consider a suitable
munmap() operation size both preemptive mode and non-preemptive mode.
>
> Then again, what's the point, simply remove the whole thing (like I d=
id)
> and your problem is solved too.
If we can get real-fast or real-time with advanced preemptive mmu_gathe=
r
sufficiently according to user needs sometimes, I also think that
that's good certainly.
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
