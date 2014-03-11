From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/5] a few open coded completions
Date: Tue, 11 Mar 2014 11:54:20 -0400
Message-ID: <20140311115420.4904b7ed@gandalf.local.home>
References: <20131211003732.351606520@goodmis.org>
	<20131211003801.836995968@goodmis.org>
	<20131211144946.27d82a78@gandalf.local.home>
	<1394324841.2861.56.camel@deadeye.wl.decadent.org.uk>
	<20140310102928.7b2a2cfa@gandalf.local.home>
	<1394473962.23624.3.camel@deadeye.wl.decadent.org.uk>
	<20140310141449.6b99c7eb@gandalf.local.home>
	<1394503606.23624.27.camel@deadeye.wl.decadent.org.uk>
	<20140310225623.0cad071a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Corey Minyard <cminyard@mvista.com>
To: Ben Hutchings <ben@decadent.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:49074 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752707AbaCKPyX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Mar 2014 11:54:23 -0400
In-Reply-To: <20140310225623.0cad071a@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 10 Mar 2014 22:56:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> Thanks, I ran an allmodconfig, and you're right, the orinoco driver
> failed to compile on v3.2-rt. I ran allmodconfig on 3.10-rt and it
> passed fine. Seems that one of the headers there pulls in swait.
> 
> Looking deeper, 3.10-rt has completion as a simple-wait, and
> completion.h pulls in wait-simple.h, which is why it works there. 3.2
> does not have completions there. I wonder if I should pull in the patch
> that converts completions into swaits, and that may fix other locations
> as well.

The swait code for 3.2 can't even handle the changes that were made.
That is, the patch used swait functions not created in 3.2-rt.

I'll just revert those from 3.2-rt and be done with it.

Thanks for the report.

-- Steve
