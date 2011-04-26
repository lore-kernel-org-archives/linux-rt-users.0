From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 0/4] munmap: Flexible mem unmap operation interface for
 scheduling latency
Date: Tue, 26 Apr 2011 10:20:58 +0900
Message-ID: <BANLkTimoG7muVanF6P8YYvfZA7WUT+9XKg@mail.gmail.com>
References: <1303728272-11408-1-git-send-email-leemgs1@gmail.com>
	<1303760837.4865.22.camel@laptop>
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
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53629 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194Ab1DZBVA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2011 21:21:00 -0400
In-Reply-To: <1303760837.4865.22.camel@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 26, 2011 at 4:47 AM, Peter Zijlstra <a.p.zijlstra@chello.nl=
> wrote:
> On Mon, 2011-04-25 at 19:44 +0900, Geunsik Lim wrote:
>> =C2=A0 =C2=A0 Originally, We aim to not hold locks for too long (for=
 scheduling latency reasons).
>> =C2=A0 =C2=A0 So zap pages in ZAP_BLOCK_SIZE byte counts.
>> =C2=A0 =C2=A0 This means we need to return the ending mmu_gather to =
the caller.
>
> Please have a look at the mmu_gather rewrite that hit -mm last week,
> that completely does away with ZAP_BLOCK_SIZE and renders these patch=
es
> obsolete.
Yes. I also checked the patch that you stated at LKML mailing list prev=
iously.
In my thinking. I want to keep ZAP_BLOCK_SIZE related contents
that adjusted by Ingo, Robert, Andrew, and so on a long time ago
because I believe that we can overcome below problems sufficiently
in real world.
=2E LKML archive - http://lkml.org/lkml/2002/7/24/273
=2E LKML archive - http://lkml.org/lkml/2004/9/14/101

In my experience, I did overcome below problems with this patch
based on ZAP_BLOCK_SIZE.

1) To solve temporal CPU contention
    (e.g: case that cpu contention is 93% ~ 96% according to mmap/munma=
p
            to access mass files )
2) To get real-time or real-fast selectively on specified linux system
    ( demo: http://www.youtube.com/watch?v=3DPxcgvDTY5F0 )


>
> Also, -rt doesn't care since it already has preemptible mmu_gather.
>
> Furthermore:
>
>> +L: =C2=A0 =C2=A0 linux-rt-users@vger.kernel.org
Sorry. I think that I have to add "linux-rt-users@vger.kernel.org" beca=
use  this
patch is related to scheduling latencies although this modification
is in ./linux-2.6/mm/ directory. I will remove "+L: linux-rt-users*****=
*" if
really linux-rt-users mailing list can not care.
>
> is complete crap, linux-rt-users is _NOT_ a development list.
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
