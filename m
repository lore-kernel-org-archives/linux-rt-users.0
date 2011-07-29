From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Fri, 29 Jul 2011 17:38:47 +0200
Message-ID: <1311953927.30862.64.camel@marge.simson.net>
References: <20110729151340.419467771@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43366 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab1G2Pit (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:38:49 -0400
In-Reply-To: <20110729151340.419467771@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-07-29 at 11:13 -0400, Steven Rostedt wrote:
> Hi Mike,
> 
> Could you try this patch set out. Add the first patch and then
> run your tests. The first patch only adds benchmarking, and does not
> modify the scheduler algorithm.

I will happily do all of the below.

> Do this:
> 
> 1. apply first patch, build and boot
> 2. # mount -t debugfs nodev /sys/kernel/debug
> 3. # echo 0 > /sys/kernel/debug/cpupri; ./runtest; cat /sys/kernel/debug/cpupri > output
> 
> The output will give you the contention of the vector locks in the
> cpupri algorithm.
> 
> Then apply the second patch and do the same thing.
> 
> Then apply the third patch and do the same thing.
> 
> After that, could you send me the results of the output file for all
> three runs?  The final patch should probably be the best overall
> results.
> 
> Thanks!

Thank you.

	-Mike

