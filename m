From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Subject: Re: [ltt-dev] lttctl locks up with RT Linux
Date: Fri, 14 May 2010 10:56:55 -0400
Message-ID: <20100514145655.GA9145@Krystal>
References: <A47866F933DF804684068A24BF04A9730862A74C@gdrs-exchange.gdrs.com> <20100422160601.GB28863@Krystal> <A47866F933DF804684068A24BF04A97309116C93@gdrs-exchange.gdrs.com> <20100511115939.GA17304@Krystal> <A47866F933DF804684068A24BF04A9730862A7EB@gdrs-exchange.gdrs.com> <20100511151120.GA5013@Krystal> <A47866F933DF804684068A24BF04A9730862A7F0@gdrs-exchange.gdrs.com> <20100513182340.GA23811@Krystal> <A47866F933DF804684068A24BF04A9730862A80B@gdrs-exchange.gdrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, ltt-dev@lists.casi.polymtl.ca,
	linux-rt-users@vger.kernel.org
To: jpaul@gdrs.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tomts13.bellnexxia.net ([209.226.175.34]:64537 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab0ENO5K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 10:57:10 -0400
Received: from toip4.srvr.bell.ca ([209.226.175.87])
          by tomts13-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20100514145705.RQEO12176.tomts13-srv.bellnexxia.net@toip4.srvr.bell.ca>
          for <linux-rt-users@vger.kernel.org>;
          Fri, 14 May 2010 10:57:05 -0400
Content-Disposition: inline
In-Reply-To: <A47866F933DF804684068A24BF04A9730862A80B@gdrs-exchange.gdrs.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ah! I think I brought debugging to a whole new level here, including
developer interaction in the bissection. ;)

Thanks for the reports, they have been very useful to re-enable LTTng
for -rt kernels,

Mathieu

* jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> Thanks Mathieu.  This was my fault .. I couldn't apply your patch
> (kept getting failures on hunks 2-8 for some reason) so I hand patched
> the file and in doing so, transposed a rcu unlock with an rcu lock
> (just as you suspected). So, after correcting that, all is well and
> I'm able to perform tracing under 2.6.33.2 RT.
> 
> Thanks Much!
> 
> JP
> 
> 
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:compudj@krystal.dyndns.org]
> Sent: Thu 5/13/2010 2:23 PM
> To: John P. Paul
> Cc: ltt-dev@lists.casi.polymtl.ca; paulmck@linux.vnet.ibm.com; linux-rt-users@vger.kernel.org
> Subject: Re: [ltt-dev] lttctl locks up with RT Linux
>  
> Please double-check that you applied the last patch correctly. I tried
> building a lttng-enabled -rt tree here (x86 64 box), and it works (I can
> start/stop tracing and see the trace in lttv).
> 
> Note that I simply discarded the conflicting instrumentation patches for
> this quick test.
> 
> I'm pretty sure an error could have been inserted in async_wakeup()
> within ltt-tracer.c. Can you paste the code you have ?
> 
> Unbalanced rcu read lock/unlock could be causing this.
> 
> Thanks,
> 
> Mathieu
> 
> * jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> > Turning off CONFIG_RCU_CPU_STALL_DETECTOR does not solve the issue with starting up "lttctl -C" ... that call never returns. I'm no longer getting the stack dumps in /var/log/messages and I still have to hard reboot the system as soft reboot doesn't work.
> > 
> > JP
> 
> --
> This is an e-mail from General Dynamics Robotic Systems. It is for the intended recipient only and may contain confidential and privileged information. No one else may read, print, store, copy, forward or act in reliance on it or its attachments. If you are not the intended recipient, please return this message to the sender and delete the message and any attachments from your computer. Your cooperation is appreciated.
> 
> 
> _______________________________________________
> ltt-dev mailing list
> ltt-dev@lists.casi.polymtl.ca
> http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
