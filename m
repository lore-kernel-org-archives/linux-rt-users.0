From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v5] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Thu, 26 Mar 2015 09:24:22 +0800
Message-ID: <20150326012422.GA12167@kernel>
References: <20150318144946.2f3cc982@gandalf.local.home>
 <20150320103120.GZ23123@twins.programming.kicks-ass.net>
 <20150320103005.3914fd8d@gandalf.local.home>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>,
	Wanpeng Li <wanpeng.li@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35875 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbbCZBmW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Mar 2015 21:42:22 -0400
Content-Disposition: inline
In-Reply-To: <20150320103005.3914fd8d@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 20, 2015 at 10:30:05AM -0400, Steven Rostedt wrote:
>On Fri, 20 Mar 2015 11:31:20 +0100
>Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > Parts-suggested-by: Peter Zijlstra <peterz@infradead.org>
>> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> 
>> OK, queued it.
>
>Feel free to update that loop.
>
>> Do we want to look into making the same change for
>> deadline once this has settled?
>
>Hmm, looks like it could use it as well. Should that code be made a bit
>more generic to share the same algorithm? Would need to pass in a
>pointer to the mask to check.

Is there any one doing it currently? Otherwise, I can be the volunteer 
for dealine part. ;)

Regards,
Wanpeng Li 

>
>-- Steve
>--
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
