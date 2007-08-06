From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RT] put in a relatively high number for rcu read lock upper limit.
Date: Sun, 5 Aug 2007 20:20:31 -0700
Message-ID: <20070806032031.GE13916@linux.vnet.ibm.com>
References: <1186289484.636.5.camel@localhost.localdomain> <1186290332.636.8.camel@localhost.localdomain> <20070805065948.GB515@elte.hu> <Pine.LNX.4.58.0708051019560.8421@gandalf.stny.rr.com> <20070805150449.GA19418@linux.vnet.ibm.com> <1186328100.636.19.camel@localhost.localdomain> <20070805175310.GB3244@elte.hu>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762062AbXHFDUs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070805175310.GB3244@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Aug 05, 2007 at 07:53:10PM +0200, Ingo Molnar wrote:
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Paul and Ingo,
> > 
> > Should we just remove the upper limit check, or is something like this 
> > patch sound?
> 
> i've changed the limit to 30 (the same depth limit is used by lockdep).
> 
> beyond that we could get stack overflow, etc.

Works for me!

						Thanx, Paul
