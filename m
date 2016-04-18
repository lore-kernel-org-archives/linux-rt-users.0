From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Mon, 18 Apr 2016 19:55:32 +0200
Message-ID: <1461002132.3895.59.camel@gmail.com>
References: <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <57068F28.8010409@linutronix.de> <1460123044.16946.11.camel@gmail.com>
	 <5707B911.6090404@linutronix.de> <1460125010.16946.27.camel@gmail.com>
	 <5707C563.2050801@linutronix.de> <1460134168.3860.6.camel@gmail.com>
	 <20160418171550.GA21734@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418171550.GA21734@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2016-04-18 at 19:15 +0200, Sebastian Andrzej Siewior wrote:

> take 2. There is this else case in pin_current_cpu() where I take
> hp_lock. I didn't manage to get in there. So I *think* we can get rid of
> the lock now. Since there is no lock (or will be) we can drop the whole
> `do_mig_dis' checking and do the migrate_disable() _after_ we obtained
> the lock. We were not able to do so due to the lock hp_lock.
> 
> And with this, I didn't manage to triger the lockup you had with
> futextest.

I'll have to feed it to DL980, hotplug and jitter test it.  It seemed
to think that pinning post acquisition was a bad idea jitter wise, but
I was bending things up while juggling multiple boxen, so..

	-Mike
