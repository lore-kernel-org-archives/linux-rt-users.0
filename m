From: <jpaul@gdrs.com>
Subject: RE: [ltt-dev] lttctl locks up with RT Linux
Date: Fri, 14 May 2010 10:33:30 -0400
Message-ID: <A47866F933DF804684068A24BF04A9730862A80B@gdrs-exchange.gdrs.com>
References: <A47866F933DF804684068A24BF04A9730862A74C@gdrs-exchange.gdrs.com> <20100422160601.GB28863@Krystal> <A47866F933DF804684068A24BF04A97309116C93@gdrs-exchange.gdrs.com> <20100511115939.GA17304@Krystal> <A47866F933DF804684068A24BF04A9730862A7EB@gdrs-exchange.gdrs.com> <20100511151120.GA5013@Krystal> <A47866F933DF804684068A24BF04A9730862A7F0@gdrs-exchange.gdrs.com> <20100513182340.GA23811@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <ltt-dev@lists.casi.polymtl.ca>, <paulmck@linux.vnet.ibm.com>,
	<linux-rt-users@vger.kernel.org>
To: <compudj@krystal.dyndns.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gdrs.com ([198.136.134.18]:57037 "EHLO mail.gdrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab0ENOgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 10:36:19 -0400
Received: from gdrs-exchange.gdrs.com (gdrs-exchange.gdrs.com [192.168.8.21])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.gdrs.com (Postfix) with ESMTPS id 01CD896A007
	for <linux-rt-users@vger.kernel.org>; Fri, 14 May 2010 10:36:07 -0400 (EDT)
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks Mathieu.  This was my fault .. I couldn't apply your patch (kept getting failures on hunks 2-8 for some reason) so I hand patched the file and in doing so, transposed a rcu unlock with an rcu lock (just as you suspected). So, after correcting that, all is well and I'm able to perform tracing under 2.6.33.2 RT.

Thanks Much!

JP


-----Original Message-----
From: Mathieu Desnoyers [mailto:compudj@krystal.dyndns.org]
Sent: Thu 5/13/2010 2:23 PM
To: John P. Paul
Cc: ltt-dev@lists.casi.polymtl.ca; paulmck@linux.vnet.ibm.com; linux-rt-users@vger.kernel.org
Subject: Re: [ltt-dev] lttctl locks up with RT Linux
 
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

--
This is an e-mail from General Dynamics Robotic Systems. It is for the intended recipient only and may contain confidential and privileged information. No one else may read, print, store, copy, forward or act in reliance on it or its attachments. If you are not the intended recipient, please return this message to the sender and delete the message and any attachments from your computer. Your cooperation is appreciated.

