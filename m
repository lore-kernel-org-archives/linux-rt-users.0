From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Different priorities for different softirqs
Date: Wed, 21 Mar 2012 10:08:24 -0300
Message-ID: <20120321130824.GC6028@uudg.org>
References: <013401cd0763$1bd93970$538bac50$@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Christian Meier <chmeie@gmx.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62476 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964964Ab2CUNLb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 09:11:31 -0400
Received: by ghrr11 with SMTP id r11so877437ghr.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 06:11:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <013401cd0763$1bd93970$538bac50$@gmx.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 21, 2012 at 02:04:10PM +0100, Christian Meier wrote:
| Hi,
| 
| On https://rt.wiki.kernel.org/articles/r/t/_/RT_PREEMPT_HOWTO_6bc9.html I
| noticed that there are different softirq kthreads for every softirq. So they
| could be prioritized differently.
| In my rt-patched kernels 3.2.11-rt20 and 3.0.24-rt42 I can only see one
| ksoftirqd instance per cpu.
| 
| I did not find any hints in kernel/softirq.c where each of those kthreads is
| generated. I only see ksoftirqd.
| 
| >From RT_PREEMPT_HOWTO_6bc9.html:
| ...
| 2 ?        S      0:00 [softirq-high/0] 
| 3 ?        S      0:00 [softirq-timer/0] 
| 4 ?        S      0:00 [softirq-net-tx/] 
| 5 ?        S      0:00 [softirq-net-rx/] 
| 6 ?        S      0:00 [softirq-block/0] 
| 7 ?        S      0:00 [softirq-tasklet] 
| 8 ?        S      0:00 [softirq-hrtreal] 
| 9 ?        S      0:00 [softirq-hrtmono]
| ...
| 
| How can I get these softirq different threads? Did I miss a configuration
| option?

The examples there are from older kernels (probably 2.6.18 and 2.6.23).
Several changes happened since then, to the kernels and even to the general
model of the RT patch. Among these changes, more than once softirqs have
been folded inside ksoftirqd and later unfolded. As of now, they are folded
and it seems to have helped to minimize a performance loss someone (tglx?)
observed in the early 3.0.x-rt days.

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

