From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Fri, 01 Jan 2016 10:45:45 +0100
Message-ID: <1451641545.15556.8.camel@gmail.com>
References: <20151223225755.GA21121@linutronix.de>
	 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
	 <1451632781.9800.22.camel@gmail.com>
	 <alpine.DEB.2.11.1601011012540.28591@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601011012540.28591@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2016-01-01 at 10:14 +0100, Thomas Gleixner wrote:
> On Fri, 1 Jan 2016, Mike Galbraith wrote:
> > On Thu, 2015-12-31 at 10:24 -0600, Clark Williams wrote:
> > > I pulled this update and tried it on my laptop (i7 quad-core with HT)
> > > and an Atom testbox. I'm seeing a change in the cpu utilization of
> > > ksoftirqd between 4.1.15-rt17 and 4.4-rc2-rt1, where the per-cpu
> > > ksoftirqd threads are running at between 25-40% utilization:
> > > 
> > > top - 10:15:57 up 13:46,  2 users,  load average: 9.44, 9.30, 8.93
> > > Tasks: 188 total,   2 running, 186 sleeping,   0 stopped,   0 zombie
> > > %Cpu(s):  4.7 us, 53.6 sy,  0.0 ni, 37.4 id,  0.1 wa,  0.0 hi,  4.2 si,  0.0 st
> > > KiB Mem :  4046064 total,   480548 free,   179528 used,  3385988 buff/cache
> > > KiB Swap:  5177340 total,  5169908 free,     7432 used.  3785624 avail Mem 
> > > 
> > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                      
> > >     3 root      -2   0       0      0      0 S  37.3  0.0 307:52.44 ksoftirqd/0                  
> > >    32 root      -2   0       0      0      0 S  37.3  0.0 308:08.72 ksoftirqd/2                  
> > >    42 root      -2   0       0      0      0 R  37.3  0.0 308:32.84 ksoftirqd/3                  
> > >    22 root      -2   0       0      0      0 S  26.9  0.0 222:29.82 ksoftirqd/1                  
> > >     1 root      20   0   46628   6980   4976 S   1.3  0.2   0:13.98 systemd                      
> > > 22358 williams  20   0  159980   4552   3780 R   1.0  0.1   0:00.39 top       
> > 
> > Heh, I didn't notice immediately because I throttle nohz, am seeing
> > only tiny utilization (but nohz idle isn't working).  With throttle
> > patch removed, box is screaming, expires=4294990471 pokes eyeball.
> > 
> >          swapper     0 [003]   392.708321: timer:hrtimer_cancel: hrtimer=0xffff88041ecce720
> >          swapper     0 [003]   392.708321: timer:hrtimer_start: hrtimer=0xffff88041ecce720 function=tick_sched_timer/0x0 expires=4294990471 softexpires=4294990471
> 
> There is a major hickup in the hrtimer RT conversion. I'll have a look next
> week.

Yeah, fixing up the screaming didn't do wonderful things, box is a
lethargic slug.  I'll have a poke over the weekend, see how close I get
to fixing hickups up properly.

	-Mike
