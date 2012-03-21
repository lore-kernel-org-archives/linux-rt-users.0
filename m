From: "Christian Meier" <chmeie@gmx.com>
Subject: Different priorities for different softirqs
Date: Wed, 21 Mar 2012 14:04:10 +0100
Message-ID: <013401cd0763$1bd93970$538bac50$@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:46368 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758538Ab2CUNAf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 09:00:35 -0400
Content-Language: de
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On https://rt.wiki.kernel.org/articles/r/t/_/RT_PREEMPT_HOWTO_6bc9.html I
noticed that there are different softirq kthreads for every softirq. So they
could be prioritized differently.
In my rt-patched kernels 3.2.11-rt20 and 3.0.24-rt42 I can only see one
ksoftirqd instance per cpu.

I did not find any hints in kernel/softirq.c where each of those kthreads is
generated. I only see ksoftirqd.

>From RT_PREEMPT_HOWTO_6bc9.html:
...
2 ?        S      0:00 [softirq-high/0] 
3 ?        S      0:00 [softirq-timer/0] 
4 ?        S      0:00 [softirq-net-tx/] 
5 ?        S      0:00 [softirq-net-rx/] 
6 ?        S      0:00 [softirq-block/0] 
7 ?        S      0:00 [softirq-tasklet] 
8 ?        S      0:00 [softirq-hrtreal] 
9 ?        S      0:00 [softirq-hrtmono]
...

How can I get these softirq different threads? Did I miss a configuration
option?

Thanks
Christian

