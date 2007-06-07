From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG in 2.6.20-rt8
Date: Thu, 07 Jun 2007 11:47:41 -0400
Message-ID: <1181231261.10408.4.camel@localhost.localdomain>
References: <20070225050212.GA17258@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53357 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbXFGPrn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 11:47:43 -0400
Received: from gandalf.stny.rr.com (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-03.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id l57FlfA5004304
	for <linux-rt-users@vger.kernel.org>; Thu, 7 Jun 2007 11:47:42 -0400 (EDT)
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=rostedt)
	by gandalf.stny.rr.com with esmtp (Exim 4.63)
	(envelope-from <rostedt@goodmis.org>)
	id 1HwKD7-0002zS-Pi
	for linux-rt-users@vger.kernel.org; Thu, 07 Jun 2007 11:47:41 -0400
In-Reply-To: <20070225050212.GA17258@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-02-24 at 21:02 -0800, Paul E. McKenney wrote:
> Hello!
> 
> I got the following running stock 2.6.20-rt8 on an 4-CPU 1.8GHz Opteron
> box.  The machine continued to run a few rounds of kernbench and LTP.
> Looks a bit scary -- a tasklet was "stolen" from __tasklet_action().
> 
> Thoughts?  In the meantime, kicking it off again to see if it repeats.
> 
> 						Thanx, Paul
> 
> BUG: at kernel/softirq.c:559 __tasklet_action()
> 
> Call Trace:
>  [<ffffffff8022ec1b>] __tasklet_action+0xdb/0x120
>  [<ffffffff8022ee12>] ksoftirqd+0xf3/0x179
>  [<ffffffff8022ed1f>] ksoftirqd+0x0/0x179
>  [<ffffffff8023be23>] kthread+0xc8/0xf1
>  [<ffffffff8020a708>] child_rip+0xa/0x12
>  [<ffffffff8023bf27>] kthread_create+0x6e/0x159
>  [<ffffffff8023bd5b>] kthread+0x0/0xf1
>  [<ffffffff8020a6fe>] child_rip+0x0/0x12

Just updating linux-rt

John Stultz found the bug and provided a patch.

http://marc.info/?l=linux-kernel&m=118109631711031&w=2

-- Steve
