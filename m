From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: rcu: Merge RCU-bh into RCU-preempt
Date: Thu, 8 Nov 2018 08:42:47 -0800
Message-ID: <20181108164247.GL4170@linux.ibm.com>
References: <20181101231804.GA11280@linux.ibm.com>
 <20181108160256.xpawe65h5lm65soi@linutronix.de>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108160256.xpawe65h5lm65soi@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 08, 2018 at 05:02:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-01 16:18:04 [-0700], Paul E. McKenney wrote:
> > The need for this goes away as of the current merge window because
> > RCU-bh has gone away.  (Aside from still being able to do things
> > like rcu_read_lock_bh() as a documentation device.)
> 
> So in -RT rcu_read_lock_bh() does
>  { local_bh_disable() ;  rcu_read_lock() }
> 
> So you are saying that this is also the case in v4.20?

No, rcu_read_lock_bh() and rcu_read_unlock_bh() are unchanged in v4.20.
With the new RCU grace-period mechanism, local_bh_disable() blocks future
grace periods on its own.

Unless I am missing something (quite probable, actually), the v4.20
definitions of rcu_read_lock_bh() and rcu_read_unlock_bh() should work
as-is for -rt.

							Thanx, Paul
