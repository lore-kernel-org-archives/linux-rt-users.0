From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 14:35:44 -0400
Message-ID: <1363631744.25967.199.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
	 <1363623799.25967.172.camel@gandalf.local.home>
	 <1363624020.25967.175.camel@gandalf.local.home>
	 <1363624243.25967.178.camel@gandalf.local.home>
	 <20130318164351.GA21516@mtj.dyndns.org>
	 <1363631036.25967.193.camel@gandalf.local.home>
	 <20130318182631.GB3042@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:8296 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab3CRSfq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Mar 2013 14:35:46 -0400
In-Reply-To: <20130318182631.GB3042@htj.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-03-18 at 11:26 -0700, Tejun Heo wrote:

> > Hmm, the issue is that a "use to be" idle thread got migrated, and is
> > now being woken up by another worker. What can cause an established
> > worker to migrate without HOTPLUG being active?
> 
> It doesn't.  I think it's trying to wakeup the idle_list head.
> 

That definitely makes sense. I'll go and write up a patch.

Thanks!!!

-- Steve


