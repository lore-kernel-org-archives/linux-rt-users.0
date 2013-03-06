From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Threaded irqs + 100% CPU RT task = RCU stall
Date: Wed, 6 Mar 2013 16:58:54 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303061651360.22263@ionos>
References: <20130306154917.GA15249@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130306154917.GA15249@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 6 Mar 2013, Paul Gortmaker wrote:
> So, I guess the question is, whether we want to try and make the system
> fail in a more meaningful way -- kind of like the rt throttling message
> does - as it lets users know they've hit the wall?  Something watching

That Joe Doe should have noticed the throttler message, which came
before the stall, shouldn't he?

> for kstat_incr_softirqs traffic perhaps?  Or other options?

The rcu stall detector could use the softirq counter and if it did not
change in the stall period print: "Caused by softirq starvation" or
something like that.

Thanks,

	tglx
