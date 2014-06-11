From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC PATCH V2] rt/aio: fix rcu garbage collection might_sleep()
 splat
Date: Wed, 11 Jun 2014 06:10:04 +0200
Message-ID: <1402459804.5195.19.camel@marge.simpson.net>
References: <1402216538.31630.7.camel@marge.simpson.net>
	 <5395172E.4010007@cn.fujitsu.com>
	 <1402372048.5124.20.camel@marge.simpson.net>
	 <20140610175001.GF27015@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Kent Overstreet <kmo@daterainc.com>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140610175001.GF27015@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2014-06-10 at 13:50 -0400, Benjamin LaHaise wrote: 
> On Tue, Jun 10, 2014 at 05:47:28AM +0200, Mike Galbraith wrote:
> > On Mon, 2014-06-09 at 10:08 +0800, Lai Jiangshan wrote: 
> > > Hi, rt-people
> > > 
> > > I don't think it is the correct direction.
> > > Softirq (including local_bh_disable()) in RT kernel should be preemptible.
> > 
> > How about the below then?
> > 
> > I was sorely tempted to post a tiny variant that dropped taking ctx_lock
> > in free_ioctx_users() entirely, as someone diddling with no reference
> > didn't make sense.  Cc Ben, he would know.
> 
> That should be okay...  Let's ask Kent to chime in on whether this looks 
> safe to him on the percpu ref front as well, since he's the one who wrote 
> this code.

Looking at the gizzard of our in-tree user of kiocb_set_cancel_fn()
(gadget), cancel() leads to dequeue() methods, which take other sleeping
locks, so tiniest variant is not an option, patchlet stands.

-Mike
