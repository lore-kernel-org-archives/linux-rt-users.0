From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 26/39] scheduling while atomic in cgroup code
Date: Wed, 18 Mar 2015 09:20:17 -0400
Message-ID: <20150318092017.7948f390@gandalf.local.home>
References: <20150312191307.081068717@goodmis.org>
	<20150312191411.381735145@goodmis.org>
	<20150317201010.GB26043@windriver.com>
	<5509392E.8000701@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org,
	Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5509392E.8000701@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 18 Mar 2015 09:37:02 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 03/17/2015 09:10 PM, Paul Gortmaker wrote:
> > [[PATCH RT 26/39] scheduling while atomic in cgroup code] On 12/03/2015 (Thu 15:13) Steven Rostedt wrote:
> > 
> >> 3.14.34-rt32-rc1 stable review patch.
> >> If anyone has any objections, please let me know.
> >>
> >> ------------------
> >>
> >> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> >>
> >> mm, memcg: make refill_stock() use get_cpu_light()
> > 
> > This looks like only 1/2 of Mike's original patch:
> > 
> > https://lkml.org/lkml/2014/6/21/11 
> > 
> > I suspect that is because 3.18 could only use 1/2 of it, and based on
> > the SOB lines, this is backported from 3.18.
> 
> no. I didn't take the upper chunk because get_cpu_var() does only a
> preempt_disable() and in that section there is not point of preemption
> or a lock in involved. So it is fine the way it is.
> The suggest change does a migrate_disable() which is a little more code.
> 
> The lower part (the chunk I applied) invokes drain_stock() and that is
> where the sleeping-while-atomic warning came from.
> 
> So is the upper half really required and if so, why?

Ug, you are right. I was trying to get this all working that I just
applied it based on Paul's suggestion. Looking into it, the part of the
patch that was dropped is not needed.

/me goes and reverts that change :-(

-- Steve


> 
> > The other half applies to 3.14 -- testing in progress; not sure about
> > the 3.10-rt and earlier....
> > 
> > P.
> 
> Sebastian
