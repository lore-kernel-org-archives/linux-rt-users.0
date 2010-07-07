From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Wed, 07 Jul 2010 16:31:13 +0200
Message-ID: <1278513073.10564.12.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <4C348B1D.5060008@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Darren Hart <dvhltc@us.ibm.com>
To: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755650Ab0GGObN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 10:31:13 -0400
In-Reply-To: <4C348B1D.5060008@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-07-07 at 19:41 +0530, gowrishankar wrote:
> On Wednesday 07 July 2010 10:16 AM, Mike Galbraith wrote:
> > Greetings,
> >
> > Stress testing, looking to trigger RCU stalls, I've managed to find a
> > way to repeatably create fireworks.  (got RCU stall, see attached)
> >
> > 1. download ltp-full-20100630.  Needs to be this version because of
> > testcase bustage in earlier versions, and must be built with gcc>  4.3,
> > else testcases will segfault due to a gcc bug.
> >
> >    
> Hi Mike,
> I have seen this segfault esp with GCC v4.3.4. I am about to post this 
> patch
> in ltp:
> 
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> ---
>   testcases/realtime/include/librttest.h |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/realtime/include/librttest.h 
> b/testcases/realtime/include/librttest.h
> index e526ab4..273de6f 100644
> --- a/testcases/realtime/include/librttest.h
> +++ b/testcases/realtime/include/librttest.h
> @@ -118,9 +118,9 @@ static inline int atomic_add(int i, atomic_t *v)
>          int __i;
>          __i = i;
>          asm volatile(
> -                       "lock; xaddl %0, %1;"
> -                       :"=r"(i)
> -                       :"m"(v->counter), "0"(i));
> +                       "lock; xaddl %1, %0;"
> +                       :"=m"(v->counter)
> +                       :"r"(i), "m" (v->counter));
>          return i + __i;
>   #elif defined(__powerpc__)
>   #define ISYNC_ON_SMP   "\n\tisync\n"
> --
> 
> Please let me know if this patch helps.

Yup, all better.

	-Mike

