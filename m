From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Re: Re: Hard lockup with 2.6.24.7-rt26 on x86 - cause found
Date: Fri, 06 Feb 2009 12:28:24 +0100
Message-ID: <1233919704.10894.5.camel@laptop>
References: <49725.1233916457@vtxmail.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ghaskins@novell.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten.Emde@osadl.org, rostedt@goodmis.org
To: m.luescher@vtxmail.ch
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46143 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZBFL3F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2009 06:29:05 -0500
In-Reply-To: <49725.1233916457@vtxmail.ch>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-02-06 at 11:34 +0100, Matthias Luescher wrote:
> Hi
> 
> I finally found out which patch does not work well with my configuration:
> 
> 2.6.24.7-rt12 seems to be ok, with 2.6.24.7-rt13 the command cyclictest -p99 -t10 -n -i250 crashes the kernel.
> 
> 2.6.24.7-rt13 has the follwing new patches:
> ftrace-hotplug-fix.patch
> ftrace-wakeup-rawspinlock.patch
> radix-tree-lockdep-plus1.patch
> sched-cpupri-hotplug-support.patch
> sched-cpupri-priocount.patch
> 
> No I went again to 2.6.24.7-rt26 but removed some patches:
> 2.6.24.7-rt26 with all patches -> CRASH
> 2.6.24.7-rt26 without sched-cpupri-hotplug-support.patch and without sched-cpupri-priocount.patch ->OK
> 2.6.24.7-rt26 without sched-cpupri-hotplug-support.patch ->CRASH

sched-cpupri-priocount.patch is buggy

+#define CPUPRI_NR_PRI_WORDS (CPUPRI_NR_PRIORITIES + BITS_PER_LONG/2)/BITS_PER_LONG

Should read:

#define CPUPRI_NR_PRI_WORDS BITS_TO_LONG(CPUPRI_NR_PRIORITIES)

Can't remember much about that other patch, although I was involved back
then.

Does -tip work OK? Most of that cpupri stuff went upstream iirc.

