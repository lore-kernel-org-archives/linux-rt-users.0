From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] rtmutex: take the waiter lock with irqs off
Date: Fri, 22 Nov 2013 17:21:02 +0100
Message-ID: <528F846E.4000703@linutronix.de>
References: <1383798668.5441.25.camel@marge.simpson.net> <alpine.DEB.2.02.1311071158350.23353@ionos.tec.linutronix.de> <20131107125923.GB24644@localhost.localdomain> <alpine.DEB.2.02.1311071402380.23353@ionos.tec.linutronix.de> <1384243595.15180.63.camel@marge.simpson.net> <alpine.DEB.2.02.1311121024590.30673@ionos.tec.linutronix.de> <20131115163008.GB12164@linutronix.de> <20131115201436.GC12164@linutronix.de> <20131118141021.GA10022@twins.programming.kicks-ass.net> <20131122135931.GA8698@linutronix.de> <20131122160841.GS3866@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <bitbucket@online.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45863 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab3KVQVI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 11:21:08 -0500
In-Reply-To: <20131122160841.GS3866@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/22/2013 05:08 PM, Peter Zijlstra wrote:
> On Fri, Nov 22, 2013 at 02:59:31PM +0100, Sebastian Andrzej Siewior wrote:
>> +extern void __lockfunc rt_spin_try_unlock(spinlock_t *lock);
> 
> I know what you mean, but.. try_unlock() just sounds wrong, how can we
> attempt but fail to unlock a lock we hold ;-)

what about
- rt_spin_unlock_try_or_fail();
- __rt_spin_unlock_dont_use_me()

Couldn't we tell lockdep to bend the rules in this case?

> 
> 
> /me crawls back under his rock ;-)
:)

Sebastian
