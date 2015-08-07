From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Fri, 7 Aug 2015 07:29:54 -0400
Message-ID: <20150807072954.1b086402@grimm.local.home>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
	<20150806192243.GD1342@windriver.com>
	<20150806153120.61186803@gandalf.local.home>
	<20150806213649.GB16853@twins.programming.kicks-ass.net>
	<20150806181412.5b474213@gandalf.local.home>
	<20150807092541.GE16853@twins.programming.kicks-ass.net>
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
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:56475 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752017AbbHGL37 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2015 07:29:59 -0400
In-Reply-To: <20150807092541.GE16853@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 7 Aug 2015 11:25:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> > For cwait? That's the complex wait queue (what the current wait queues
> > will be called in the future).
> 
> Urgh, I don't think we should go rename that.. that's going to be lots
> of pain for no to little gain.

I thought we decided that we would have the end result be that the
default be the simple wait queue, and those that need more complexity,
would have a complex wait queue, as IIRC, the simple wait queue can
replace the majority of the existing wait queues.

-- Steve
