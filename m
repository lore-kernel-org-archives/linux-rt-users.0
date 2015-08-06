From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Thu, 6 Aug 2015 18:14:12 -0400
Message-ID: <20150806181412.5b474213@gandalf.local.home>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
	<20150806192243.GD1342@windriver.com>
	<20150806153120.61186803@gandalf.local.home>
	<20150806213649.GB16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:33893 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751861AbbHFWOP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Aug 2015 18:14:15 -0400
In-Reply-To: <20150806213649.GB16853@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 6 Aug 2015 23:36:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Aug 06, 2015 at 03:31:20PM -0400, Steven Rostedt wrote:
> > > 4) poll_wait: currently it and poll_table_entry are both hard coupled
> > >    to wait_queue_head_t -- so any users of poll_wait are not eligible
> > >    for conversion to simple wait. (I just happened to notice that
> > >    recently.)  A quick grep shows ~500 poll_wait users.
> > 
> > Looks like a good candidate to test the cwait on :-)
> 
> Poll uses custom wake functions, which disqualifies them on the spot.

For cwait? That's the complex wait queue (what the current wait queues
will be called in the future).

-- Steve
