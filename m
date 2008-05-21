From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compile warning rtmutex code on 2.6.24.7-rt8 (CC:LKML added)
Date: Wed, 21 May 2008 15:14:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805211504430.19141@gandalf.stny.rr.com>
References: <3efb10970805201356x4552859bof5f3f4f56f2ba676@mail.gmail.com>
 <Pine.LNX.4.58.0805201718530.21440@gandalf.stny.rr.com>
 <3efb10970805211135k422a0153i28613e74d42d1ed2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936915AbYEUTO1@vger.kernel.org>
In-Reply-To: <3efb10970805211135k422a0153i28613e74d42d1ed2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 21 May 2008, Remy Bohmer wrote:

> Now I understood your hint in some other mail, and I am going to take
> a look at ftrace for ARM. Just for the fun of it...
> I hope it is not too intrusive for these ARM cores (old implementation
> was...), these Atmel cores are just not that fast as the common X86's.

If you feel brave, take a crack at the DYNAMIC_FTRACE. It's been done for
x86 (both 32 and 64 bit), PPC (also both 32 and 64 bit) as well as
Sparc64.

The dynamic ftrace is self modifying code, that will start off having
mcount simply call a nop. Then later it will change that to call a
"record_ip" function. A daemon is kicked off to change all the IPs that
are called into NOPs. When tracing is enabled, all the NOPs are converted
into calls to the trace function.

Dynamic ftrace also adds a "set_filter_function" in the /debugfs/tracing
directory that lets you echo in function names, and only those functions
will enable have tracing enabled.

All this helps tremendously in tracing performance and normal bootup. One
thing that you need to understand though. That daemon needs to call
kstop_machine to do the modifications. The daemon wakes up once a second,
checks to see if there is any new functions that have been recorded. If
not, then it simply goes back to sleep. But if there are new functions,
then it calls kstopmachine. This daemon stops when tracing is enabled, but
can cause unsuspecting latencies when tracing is disabled.

I'll probably add a something to disable the daemon just before firing off
init if PREEMPT_RT is enabled.

Any questions on porting ftrace, feel free to ask.

Cheers,

-- Steve
