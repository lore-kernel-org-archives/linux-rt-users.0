From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
Date: Thu, 02 Aug 2018 19:43:36 +0200
Message-ID: <1533231816.12550.54.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <1533192980.11791.8.camel@gmx.de>
         <20180802123104.7fed73b4@gandalf.local.home>
         <1533228650.12550.15.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533228650.12550.15.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2018-08-02 at 18:50 +0200, Mike Galbraith wrote:
> On Thu, 2018-08-02 at 12:31 -0400, Steven Rostedt wrote:
> > On Thu, 02 Aug 2018 08:56:20 +0200
> > Mike Galbraith <efault@gmx.de> wrote:
> > 
> > > (arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 
> > > 
> > > v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()
> > 
> > I take it that this should be added to v4.16-rt and marked stable-rt?
> 
> Yeah, barring way sexier ideas of course.

Gah, wait.  WRT marking for stable-rt, only the pmu allocation splat
fix is applicable to @stable-rt, kvm locking woes start at 4.15.

	-Mike
