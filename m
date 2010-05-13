From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Subject: Re: [ltt-dev] lttctl locks up with RT Linux
Date: Thu, 13 May 2010 14:23:40 -0400
Message-ID: <20100513182340.GA23811@Krystal>
References: <A47866F933DF804684068A24BF04A9730862A74C@gdrs-exchange.gdrs.com> <20100422160601.GB28863@Krystal> <A47866F933DF804684068A24BF04A97309116C93@gdrs-exchange.gdrs.com> <20100511115939.GA17304@Krystal> <A47866F933DF804684068A24BF04A9730862A7EB@gdrs-exchange.gdrs.com> <20100511151120.GA5013@Krystal> <A47866F933DF804684068A24BF04A9730862A7F0@gdrs-exchange.gdrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: ltt-dev@lists.casi.polymtl.ca, paulmck@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org
To: jpaul@gdrs.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:48198 "EHLO
	tomts36-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754889Ab0EMSXy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 14:23:54 -0400
Received: from toip5.srvr.bell.ca ([209.226.175.88])
          by tomts36-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20100513182351.KVWY19420.tomts36-srv.bellnexxia.net@toip5.srvr.bell.ca>
          for <linux-rt-users@vger.kernel.org>;
          Thu, 13 May 2010 14:23:51 -0400
Content-Disposition: inline
In-Reply-To: <A47866F933DF804684068A24BF04A9730862A7F0@gdrs-exchange.gdrs.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Please double-check that you applied the last patch correctly. I tried
building a lttng-enabled -rt tree here (x86 64 box), and it works (I can
start/stop tracing and see the trace in lttv).

Note that I simply discarded the conflicting instrumentation patches for
this quick test.

I'm pretty sure an error could have been inserted in async_wakeup()
within ltt-tracer.c. Can you paste the code you have ?

Unbalanced rcu read lock/unlock could be causing this.

Thanks,

Mathieu

* jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> Turning off CONFIG_RCU_CPU_STALL_DETECTOR does not solve the issue with starting up "lttctl -C" ... that call never returns. I'm no longer getting the stack dumps in /var/log/messages and I still have to hard reboot the system as soft reboot doesn't work.
> 
> JP
> 
> 
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:compudj@krystal.dyndns.org]
> Sent: Tue 5/11/2010 11:11 AM
> To: John P. Paul
> Cc: ltt-dev@lists.casi.polymtl.ca; Paul E. McKenney; linux-rt-users@vger.kernel.org
> Subject: Re: [ltt-dev] lttctl locks up with RT Linux
>  
> * jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> > Thanks Mathieu. I'm going to have to look at this a bit more. This may
> > have fixed one problem and cause another as "lttctl -C -w /tmp/trace
> > trace1" does not return and I'm getting a stack dump in the messages
> > file (see below). The last msg I see from that "lttctl -C" command is
> > "lttctl: Creating trace". The "lttctl: Forking lttd" is not displayed.
> 
> If you disable RCU stalls detection, does it work ?
> 
> [Context for Paul: it's on a -RT kernel, with the LTTng patchset]
> 
> Thanks,
> 
> Mathieu
> 
> --
> This is an e-mail from General Dynamics Robotic Systems. It is for the intended recipient only and may contain confidential and privileged information. No one else may read, print, store, copy, forward or act in reliance on it or its attachments. If you are not the intended recipient, please return this message to the sender and delete the message and any attachments from your computer. Your cooperation is appreciated.
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
