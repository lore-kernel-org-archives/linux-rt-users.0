From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 15:38:35 +0200
Message-ID: <20070725133835.GA17616@elte.hu>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu> <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu> <46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr> <20070725130536.GA12334@elte.hu> <46A74E05.50504@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51132 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759464AbXGYNil (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 09:38:41 -0400
Content-Disposition: inline
In-Reply-To: <46A74E05.50504@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* John Sigler <linux.kernel@free.fr> wrote:

> > does your test-app have higher priority than softirq--4 ?
> 
> PID 4 is [softirq-timer/0] and has priority 50 in SCHED_FIFO. My 
> process has priority 80 in SCHED_RR. It is waiting for IRQ10.
> 
> My user-space app has higher priority than everything except PID 2 
> which is [posix_cpu_timer]

well what priority does the IRQ 10 kernel thread have? It should be prio 
80 too if it's in your critical path.

	Ingo
