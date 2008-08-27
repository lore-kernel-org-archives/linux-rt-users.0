From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/6] sched: make double-lock-balance fair
Date: Wed, 27 Aug 2008 13:07:04 +0200
Message-ID: <1219835224.6462.81.camel@twins>
References: <20080826173131.16413.17862.stgit@dev.haskins.net>
	 <20080826173500.16413.40514.stgit@dev.haskins.net>
	 <1219825295.6462.54.camel@twins> <20080827102646.GA5818@wotan.suse.de>
	 <1219833668.6462.72.camel@twins>  <20080827105615.GB5818@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	srostedt@redhat.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, gregory.haskins@gmail.com,
	Russell King <rmk+lkml@arm.linux.org.uk>, ralf@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Nick Piggin <npiggin@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46453 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYH0LHJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Aug 2008 07:07:09 -0400
In-Reply-To: <20080827105615.GB5818@wotan.suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2008-08-27 at 12:56 +0200, Nick Piggin wrote:

> BTW. I wonder about other architectures that are of interest to -rt? Like
> mips or arm perhaps... Any plans to implement ticket locks on those, or
> do they not tend to be used in SMP configurations on -rt yte?

I think both are starting to show more and more SMP machines, so yes,
eventually we'll want ticket locks for them too.

That said, I'm not aware of anyone working on it - I suppose we could
poke the regular arch maintainers.. Ralf, Russell ?

