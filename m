From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/3] tracing: Add NMI tracing in hwlat detector
Date: Fri, 5 Aug 2016 12:17:06 -0400
Message-ID: <20160805121706.2766ea1a@gandalf.local.home>
References: <20160804145708.158968389@goodmis.org>
	<20160804125618.6db9b5b3@gandalf.local.home>
	<20160804131645.1ba3244a@gandalf.local.home>
	<20160805143555.GB21312@linutronix.de>
	<20160805105207.16e26a41@gandalf.local.home>
	<903851a5-68a6-acaa-6604-c63f6aa11b4c@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:36830 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935016AbcHEQRN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Aug 2016 12:17:13 -0400
In-Reply-To: <903851a5-68a6-acaa-6604-c63f6aa11b4c@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 5 Aug 2016 17:40:43 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> > Ah, this is when we have GENERIC_SCHED_CLOCK, which would break tracing
> > if any arch that has this also has NMIs. Probably need to look at arm64.  
> 
> arm64 should use the generic code as they don't provide sched_clock()
> (and I doubt they go for the weak jiffy version).

And I'm guessing that arm64 supports NMIs. Is there no NMI safe clock?
I probably need to look at the tracing code. Because you can have the
same issue while tracing in an NMI as well.

-- Steve
