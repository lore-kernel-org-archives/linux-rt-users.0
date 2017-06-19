From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 16:06:03 +0200
Message-ID: <20170619140603.dbdpqz2pw2vf6y3x@linutronix.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
 <1497687277.6908.31.camel@gmx.de>
 <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
 <1497867291.19618.52.camel@gmx.de>
 <20170619104459.prmicsbbmljc6smb@linutronix.de>
 <1497871888.19618.90.camel@gmx.de>
 <20170619115019.6zpsoiwubl22mjqs@linutronix.de>
 <1497876935.19618.122.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497876935.19618.122.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-19 14:55:35 [+0200], Mike Galbraith wrote:
> On Mon, 2017-06-19 at 13:50 +0200, Sebastian Andrzej Siewior wrote:
> > 
> > rt20…rt21 is just
> >   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/sched-Prevent-task-state-corruption-by-spurious-lock.patch?h=linux-4.9.y-rt-patches
> 
> Yup.  I got there via git checkout v4.9.x-rtx, build/test.
> 
> > Let me verify that here and fire maybe the four socket box.
> 
> One thing perhaps interesting about the DL980 is that it is 8 socket,
> but with 7 memoryless nodes (poor thing).  I wouldn't be surprised if
> you had to try a lot harder than I.
> DL980 now seems happy with master-rt21 fwtw.  It's not virgin though,
> not even considering continuous merge 4.9..today.
> 
> Hopefully desktop will cease with the comatose widget business too, I
> really don't want to go there.  These things give tglx headaches, might
> well blow the point clean off of my head. 

I am suppressed that your desktop shows any symptoms on rt21. I tried my
smaller AMD box (A10), an Intel two sockets and a four socket box. Each
of them was fine with the run.sh and manual futex_wait invocation.
Could you please send the config of your desktop box?

> 	-Mike

Sebastian
