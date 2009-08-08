From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] fixup pi_state in futex_requeue on lock steal
Date: Sat, 8 Aug 2009 17:27:56 +0200
Message-ID: <20090808152756.GH28892@elte.hu>
References: <4A7A1D48.7040309@us.ibm.com> <1249576660.32113.585.camel@twins> <4A7B5D46.7080109@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	"lkml," <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	John Stultz <johnstul@linux.vnet.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52926 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbZHHP2r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Aug 2009 11:28:47 -0400
Content-Disposition: inline
In-Reply-To: <4A7B5D46.7080109@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Darren Hart <dvhltc@us.ibm.com> wrote:

> So, I think we're fine with respect to the pi_state ownership!  In 
> fact I finally managed to catch the lock steal in the requeue loop 
> in my tracing, and everything worked fine.  Going to go rerun a 
> bunch more tests and see if I hit any other issues, if I do, I 
> suspect they are unrelated to this.
>
> Thanks for the help in thinking this through.

i've got these queued up:

 00235fe: futex: Update woken requeued futex_q lock_ptr
 1bbf208: rtmutex: Avoid deadlock in rt_mutex_start_proxy_lock()

should i drop them?

	Ingo
