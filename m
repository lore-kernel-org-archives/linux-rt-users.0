From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG RT] WARNING: at kernel/sched.c:5071 2.6.23-rc1-rt7
Date: Sun, 05 Aug 2007 18:36:46 -0400
Message-ID: <1186353406.13885.2.camel@localhost.localdomain>
References: <1186290816.636.14.camel@localhost.localdomain>
	 <20070805065646.GA515@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:52282 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbXHEWhC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 18:37:02 -0400
In-Reply-To: <20070805065646.GA515@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-08-05 at 08:56 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> > P.S. I really found out that the system becomes VERY non-responsive 
> > when you run with both hard and softirqs as threads, but with 
> > PREEMPT_NONE ;-)
> 
> hm. That's not supposed to happen. Could there be some wakeup or softirq 
> processing problem?
> 
> 	Ingo

Well, it happened right after I installed the ath driver (from
http://svn.madwifi.org/trunk ).  But I've recompiled my system with
PREEMPT_RT and it works fine now.  I can investigate it later, but I
currently need this system working with a PREEMPT_RT kernel.

-- Steve
