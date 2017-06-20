From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Tue, 20 Jun 2017 09:45:06 +0200
Message-ID: <1497944706.5454.7.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497687277.6908.31.camel@gmx.de>
         <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
         <1497867291.19618.52.camel@gmx.de>
         <20170619100838.343faaee@gandalf.local.home>
         <20170619141341.m243ivutmwlzyhc4@linutronix.de>
         <20170619104131.05fdc76f@gandalf.local.home>
         <1497889784.15817.17.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497889784.15817.17.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-06-19 at 18:29 +0200, Mike Galbraith wrote:
> On Mon, 2017-06-19 at 10:41 -0400, Steven Rostedt wrote:
> > On Mon, 19 Jun 2017 16:13:41 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > 
> > > > Hmm, it shouldn't affect futexes, as it's only called by rtmutex when
> > > > waiter->savestate is true. And that should always be false for futex.  
> > > 
> > > you still have sleeping locks like the hb-lock (which might matter in
> > > case the task blocks on the lock and does not continue for some reason).
> > 
> > But then I'd expect this to be an issue with any spinlock in the kernel.
> 
> Thing to do is set a trap for the bugger.

See ! and ?

vogelweide:~/:[1]# grep MIKE trace 
MIKE 913.728104: start
MIKE  futex_wait-7496  [031] .......   913.729160: sched_process_fork: comm=futex_wait pid=7496 child_comm=futex_wait child_pid=7497
MIKE  futex_wait-7496  [031] .......   913.729253: sched_process_fork: comm=futex_wait pid=7496 child_comm=futex_wait child_pid=7499
MIKE  futex_wait-7496  [031] .......   913.729307: sched_process_fork: comm=futex_wait pid=7496 child_comm=futex_wait child_pid=7500
MIKE  futex_wait-7496  [031] .......   913.729348: sched_process_fork: comm=futex_wait pid=7496 child_comm=futex_wait child_pid=7501
MIKE  futex_wait-7496  [031] d...2..   913.729430: sched_switch: prev_comm=futex_wait prev_pid=7496 prev_prio=120 prev_state=S ==> next_comm=swapper/31 next_pid=0 next_prio=120
MIKE--futex_wait-7500  [005] d...2..   920.040320: sched_switch: prev_comm=futex_wait prev_pid=7500 prev_prio=120 prev_state=S ==> next_comm=swapper/5 next_pid=0 next_prio=120
MIKE  futex_wait-7497  [058] d...211   920.060009: sched_waking: comm=futex_wait pid=7501 prio=120 target_cpu=044
MIKE  futex_wait-7497  [058] d...311   920.060012: sched_wake_idle_without_ipi: cpu=44
MIKE  futex_wait-7497  [058] d...311   920.060012: sched_wakeup: comm=futex_wait pid=7501 prio=120 target_cpu=044
MIKE--futex_wait-7497  [058] d...2..   920.060035: sched_switch: prev_comm=futex_wait prev_pid=7497 prev_prio=120 prev_state=S ==> next_comm=swapper/58 next_pid=0 next_prio=120
MIKE  futex_wait-7499  [043] dN..411   920.060035: sched_wakeup: comm=ktimersoftd/43 pid=438 prio=0 target_cpu=043
MIKE! futex_wait-7499  [043] .N..111   920.060037: wake_up_lock_sleeper: futex_wait:7497 state:1 saved_state:0
MIKE! futex_wait-7499  [043] dN..211   920.060037: try_to_wake_up: futex_wait:7497 WF_LOCK_SLEEPER !(p->state:1 & state:2) bailing
MIKE 920.060037: futex_wait-7497 is never awakened again until ^C cleanup, 7499/7501 still standing
MIKE  futex_wait-7499  [043] ....111   920.060066: wake_up_lock_sleeper: futex_wait:7501 state:2 saved_state:0
MIKE  futex_wait-7499  [043] d...211   920.060066: try_to_wake_up: futex_wait:7501 WF_LOCK_SLEEPER !(p->state:0 & state:2) bailing
MIKE  futex_wait-7499  [043] ....111   920.060606: wake_up_lock_sleeper: futex_wait:7501 state:2 saved_state:0
MIKE 920.355048: huh? wake_up_lock_sleeper sees state=2 but try_to_wake_up then sees state=0 and bails ?!?
MIKE  futex_wait-7501  [044] ....111   920.355048: wake_up_lock_sleeper: futex_wait:7499 state:2 saved_state:0
MIKE  futex_wait-7501  [044] d...211   920.355049: try_to_wake_up: futex_wait:7499 WF_LOCK_SLEEPER !(p->state:0 & state:2) bailing
MIKE  futex_wait-7499  [048] d..h311   920.355060: sched_stat_runtime: comm=futex_wait pid=7499 runtime=168537 [ns] vruntime=4850005377 [ns]
MIKE  futex_wait-7499  [048] d...311   920.355061: sched_waking: comm=ksoftirqd/48 pid=489 prio=120 target_cpu=048
MIKE  futex_wait-7499  [048] d...411   920.355062: sched_stat_runtime: comm=futex_wait pid=7499 runtime=2972 [ns] vruntime=4850008349 [ns]
MIKE  futex_wait-7499  [048] d.L.411   920.355063: sched_wakeup: comm=ksoftirqd/48 pid=489 prio=120 target_cpu=048
MIKE  futex_wait-7499  [048] d.L.311   920.355064: sched_waking: comm=ktimersoftd/48 pid=488 prio=0 target_cpu=048
MIKE  futex_wait-7499  [048] dNL.411   920.355065: sched_wakeup: comm=ktimersoftd/48 pid=488 prio=0 target_cpu=048
MIKE  futex_wait-7499  [048] .NL.111   920.355066: wake_up_lock_sleeper: futex_wait:7501 state:0 saved_state:0
MIKE  futex_wait-7499  [048] dNL.211   920.355067: try_to_wake_up: futex_wait:7501 WF_LOCK_SLEEPER !(p->state:0 & state:2) bailing
MIKE  futex_wait-7499  [048] dNL.211   920.355067: sched_stat_runtime: comm=futex_wait pid=7499 runtime=2011 [ns] vruntime=4850010360 [ns]
MIKE  futex_wait-7499  [048] d...211   920.355068: sched_switch: prev_comm=futex_wait prev_pid=7499 prev_prio=120 prev_state=R+ ==> next_comm=ktimersoftd/48 next_pid=488 next_prio=0
MIKE       <...>-488   [048] d...2..   920.355070: sched_switch: prev_comm=ktimersoftd/48 prev_pid=488 prev_prio=0 prev_state=S ==> next_comm=ksoftirqd/48 next_pid=489 next_prio=120
MIKE       <...>-489   [048] d...2..   920.355071: sched_stat_runtime: comm=ksoftirqd/48 pid=489 runtime=1925 [ns] vruntime=4838010274 [ns]
MIKE       <...>-489   [048] d...2..   920.355072: sched_switch: prev_comm=ksoftirqd/48 prev_pid=489 prev_prio=120 prev_state=S ==> next_comm=futex_wait next_pid=7499 next_prio=120
MIKE  futex_wait-7501  [044] d...2..   920.355072: sched_stat_runtime: comm=futex_wait pid=7501 runtime=32398 [ns] vruntime=6632181410 [ns]
MIKE--futex_wait-7501  [044] d...2..   920.355074: sched_switch: prev_comm=futex_wait prev_pid=7501 prev_prio=120 prev_state=S ==> next_comm=swapper/44 next_pid=0 next_prio=120
MIKE 920.355074: 7499 is last man standing, but bored, just waking ktimersoftd
MIKE  futex_wait-7499  [048] d..h1..   920.356060: sched_stat_runtime: comm=futex_wait pid=7499 runtime=988793 [ns] vruntime=4850999153 [ns]
MIKE  futex_wait-7499  [048] d...1..   920.356061: sched_waking: comm=ktimersoftd/48 pid=488 prio=0 target_cpu=048
MIKE  futex_wait-7499  [048] dN..2..   920.356063: sched_wakeup: comm=ktimersoftd/48 pid=488 prio=0 target_cpu=048
MIKE  futex_wait-7499  [048] dN..2..   920.356063: sched_stat_runtime: comm=futex_wait pid=7499 runtime=1854 [ns] vruntime=4851001007 [ns]
MIKE  futex_wait-7499  [048] d...2..   920.356064: sched_switch: prev_comm=futex_wait prev_pid=7499 prev_prio=120 prev_state=R ==> next_comm=ktimersoftd/48 next_pid=488 next_prio=0
MIKE       <...>-488   [048] d...2..   920.356065: sched_switch: prev_comm=ktimersoftd/48 prev_pid=488 prev_prio=0 prev_state=S ==> next_comm=futex_wait next_pid=7499 next_prio=120
MIKE  futex_wait-7499  [048] d..h1..   920.384055: sched_stat_runtime: comm=futex_wait pid=7499 runtime=997267 [ns] vruntime=4878950744 [ns]
MIKE  futex_wait-7499  [048] d...1..   920.384056: sched_waking: comm=ktimersoftd/48 pid=488 prio=0 target_cpu=048
MIKE  futex_wait-7499  [048] dN..2..   920.384056: sched_wakeup: comm=ktimersoftd/48 pid=488 prio=0 target_cpu=048
MIKE  futex_wait-7499  [048] dN..2..   920.384057: sched_stat_runtime: comm=futex_wait pid=7499 runtime=1161 [ns] vruntime=4878951905 [ns]
MIKE  futex_wait-7499  [048] d...2..   920.384057: sched_switch: prev_comm=futex_wait prev_pid=7499 prev_prio=120 prev_state=R ==> next_comm=ktimersoftd/48 next_pid=488 next_prio=0
MIKE           <...>-488   [048] d...2..   920.384058: sched_switch: prev_comm=ktimersoftd/48 prev_pid=488 prev_prio=0 prev_state=S ==> next_comm=futex_wait next_pid=7499 next_prio=120
MIKE  futex_wait-7499  [048] d...2..   920.384271: sched_stat_runtime: comm=futex_wait pid=7499 runtime=213243 [ns] vruntime=4879165148 [ns]
MIKE  futex_wait-7499  [048] d...2..   920.384271: sched_switch: prev_comm=futex_wait prev_pid=7499 prev_prio=120 prev_state=S ==> next_comm=swapper/48 next_pid=0 next_prio=120
MIKE 920.384271: we're stalled, all futex_wait have scheduled off, elide gap
MIKE 981.447247: nothing to see above /me poking ^C, elide to EOF
