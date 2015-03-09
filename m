From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU stalls on heavy socket traffic
Date: Mon, 9 Mar 2015 13:44:33 -0700
Message-ID: <20150309204433.GA5236@linux.vnet.ibm.com>
References: <20150309152651.GD13768@linutronix.de>
 <20150309155947.GW5236@linux.vnet.ibm.com>
 <20150309163915.GF13768@linutronix.de>
 <20150309180212.GX5236@linux.vnet.ibm.com>
 <54FE0177.7010407@linutronix.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54FE0177.7010407@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 09, 2015 at 09:24:23PM +0100, Sebastian Andrzej Siewior wrote:
> On 03/09/2015 07:02 PM, Paul E. McKenney wrote:
> > abaf3f9d275b (rcu: Revert "Allow post-unlock reference for rt_mutex" to avoid priority-inversion)
> > 
> > This patch fixed a priority-inversion problem, so might well fix your
> > RCU CPU stall-warning problem.
> 
> Yes, it fixes the problem. Thank you.

Glad it helped!  Whew!!!  ;-)

							Thanx, Paul
