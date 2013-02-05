From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.11-rt26
Date: Tue, 5 Feb 2013 11:18:12 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302051116380.11905@ionos>
References: <alpine.LFD.2.02.1302041537230.11905@ionos> <5110B552.9030903@huawei.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	peterz@infradead.org
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48371 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3BEKSO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Feb 2013 05:18:14 -0500
In-Reply-To: <5110B552.9030903@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 5 Feb 2013, Qiang Huang wrote:
> On 2013/2/4 22:58, Thomas Gleixner wrote:
> >From patches-3.6.11-rt28.patch.gz, your patch x86-highmem-make-it-work.patch
> did this work. And you said
> "It had been enabled quite some time, but never really worked."
> 
> But I think there is a previous patch mm-rt-kmap-atomic-scheduling.patch did
> the job, so I think RT highmem on x86 should have worked.
> 
> Now with your patch, if we use kmap instead of kmap_atomic on RT, do we need
> to revert Peter's patch as well?

I should have done that, yes.
 
> I haven't tested it, but if Peter's patch did solved the problem, is his way
> better than use kmap? Because we can use more highmem virtual address,
> although with some switch latency in some small probability scenarios.

In theory it's better. Though I ran into some issues with that
approach. It's on my todo list to revisit that problem, but for now
the kmap way is at least safer.

Thanks,

	tglx


