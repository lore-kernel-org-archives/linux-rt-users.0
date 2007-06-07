From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] convert RCU Preempt tasklet into softirq.
Date: Thu, 07 Jun 2007 14:51:47 -0400
Message-ID: <1181242307.10408.17.camel@localhost.localdomain>
References: <1181180051.18444.31.camel@localhost.localdomain>
	 <20070607041411.GB1783@linux.vnet.ibm.com>
	 <1181226138.18444.54.camel@localhost.localdomain>
	 <20070607161754.GA11941@linux.vnet.ibm.com>
	 <1181240819.10408.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41071 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbXFGSwi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 14:52:38 -0400
In-Reply-To: <1181240819.10408.14.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-07 at 14:26 -0400, Steven Rostedt wrote:
> Following Dipankar's lead, I converted the tasklet in rcupreempt.c into
> a softirq.
> 
> I've compiled and booted with this patch, but ran no other tests.


There might still be an issue here. With the patch I'm getting a really
slow response time on networking. But that be because of other patches I
have applied.

I'll remove those other patches and see if this is still an issue.

/me booting with noapic to avoid the IO APIC issues.

-- Steve
