From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: __HAVE_ARCH_CMPXCHG on ARM?
Date: Wed, 18 Feb 2015 11:43:25 +0100
Message-ID: <20150218104325.GC28763@linutronix.de>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yong Zhang <yong.zhang0@gmail.com>,
	Nathan Sullivan <nathan.sullivan@ni.com>,
	Yong Zhang <yong.zhang@windriver.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
	rostedt@goodmis.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47270 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbbBRKny (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 05:43:54 -0500
Content-Disposition: inline
In-Reply-To: <20150202133933.GD31847@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Will Deacon | 2015-02-02 13:39:33 [+0000]:

>> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
>> index 7eb18c1..a91b44e 100644
>> --- a/arch/arm/include/asm/cmpxchg.h
>> +++ b/arch/arm/include/asm/cmpxchg.h
>> @@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>> 
>>  #else  /* min ARCH >= ARMv6 */
>> 
>> +#define __HAVE_ARCH_CMPXCHG 1
>
>Is it even possible to have CONFIG_SMP=y on an architecture that doesn't
>support native cmpxchg? Certainly, the asm-generic cmpxchg.h barfs if
>SMP, so couldn't we just change/extend the __HAVE_ARCH_CMPXCHG check in
>rtmutex.c to work automatically with SMP architectures? That would help
>arm64 too.

RT mutex was first introduced in 23f78d4a0 ("[PATCH] pi-futex: rt mutex core")
which is v2.6.18. The generic cmpxchg was introduced laster in
068fbad288 ("Add cmpxchg_local to asm-generic for per cpu atomic
operations") which is v2.6.25.
Back then something was required to get RT mutex working with the fast
path on architectures without cmpxchg and this seems to be the result.
Please correct me if I'm wrong.

On the other hand, how do you implement a SMP systems without native cmpxchg()
support? Isn't this a prerequisite?

Right now I don't see a reason why we should not remove
__HAVE_ARCH_CMPXCHG and assume cmpxchg() is always there.

>Will

Sebastian
