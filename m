From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 15 May 2012 13:25:32 -0400
Message-ID: <1337102732.14207.336.camel@gandalf.stny.rr.com>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>
	 <1337094383.27694.62.camel@twins>
	 <1337096542.14207.315.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7668 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965223Ab2EORZd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 13:25:33 -0400
In-Reply-To: <1337096542.14207.315.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-15 at 11:42 -0400, Steven Rostedt wrote:
> On Tue, 2012-05-15 at 17:06 +0200, Peter Zijlstra wrote:
> > On Tue, 2012-05-15 at 10:03 -0400, Steven Rostedt wrote:
> > > 
> > > where readers may nest (the same task may grab the same rwsem for
> > > read multiple times), but only one task may hold the rwsem at any
> > > given
> > > time (for read or write).
> > 
> > Humm, that sounds iffy, rwsem isn't a recursive read lock only rwlock_t
> > is.
> 
> In that case, current -rt is broken. As it has it being a recursive lock
> (without my patch).
> 

Why wouldn't it be recursive. If two different tasks are allowed to grab
a read lock at the same time, why can't the same task grab a read lock
twice? As long as it releases it the same amount of times.

Now you can't grab a read lock if you have the write lock.

-- Steve


