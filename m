From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: rcu: enable rcu_normal_after_boot by default for RT
Date: Thu, 8 Nov 2018 08:12:25 -0800
Message-ID: <20181108161225.GK4170@linux.ibm.com>
References: <20181101230235.GA8757@linux.ibm.com>
 <20181108155225.d2m6sx5z7tvzurft@linutronix.de>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lcapitulino@redhat.com, julia@ni.com,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108155225.d2m6sx5z7tvzurft@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 08, 2018 at 04:52:26PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-01 16:02:35 [-0700], Paul E. McKenney wrote:
> > > The forcing of an expedited grace period is an expensive and very
> > > RT-application unfriendly operation, as it forcibly preempts all running
> > > tasks on CPUs which are preventing the gp from expiring.
> > > 
> > > By default, as a policy decision, disable the expediting of grace
> > > periods (after boot) on configurations which enable PREEMPT_RT_FULL.
> > > 
> > > Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
> > > Signed-off-by: Julia Cartwright <julia@ni.com>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > In case it matters:
> > 
> > Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > Alternatively, any reason that I should not pull this into -rcu?

> because we don't have CONFIG_PREEMPT_RT_FULL yet.

Fair enough.  This particular case works without CONFIG_PREEMPT_RT_FULL
defined, but up to you guys.

							Thanx, Paul
