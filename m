From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 19:05:48 +0100
Message-ID: <20161108180548.GN3117@twins.programming.kicks-ass.net>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <20161108115958.GO3142@twins.programming.kicks-ass.net>
 <20161108090740.4226ffc9@gandalf.local.home>
 <20161108165133.GI3117@twins.programming.kicks-ass.net>
 <20161108121710.3e7eb664@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46210 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbcKHSFw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 13:05:52 -0500
Content-Disposition: inline
In-Reply-To: <20161108121710.3e7eb664@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 08, 2016 at 12:17:10PM -0500, Steven Rostedt wrote:
> On Tue, 8 Nov 2016 17:51:33 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > You really should already know this.
> 
> I know what we want to do, but there's some momentous problems that
> need to be solved first.

Like what?

> Until then, we may be forced to continue with
> hacks.

Well, the more ill specified hacks we put in, the harder if will be to
replace because people will end up depending on it.
