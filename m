From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 15 May 2012 14:14:43 -0400
Message-ID: <1337105683.14207.344.camel@gandalf.stny.rr.com>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.00.1205151956500.8461@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5972 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887Ab2EOSOp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 14:14:45 -0400
In-Reply-To: <alpine.LFD.2.00.1205151956500.8461@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-15 at 20:00 +0200, John Kacur wrote:
> 

> It looks interesting. I wanted to compile it and test it, but started 
> running into some problems, I fixed two simple things, but wanted to wait
> to see if you would follow Peter's suggestion for lockdep before
> proceeding too far.

I wouldn't bother compiling it with lockdep (yet), as it is completely
broken. I'll need to implement Peter's suggestion.

-- Steve


