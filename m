From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21.5-rt19 (sched_getaffinity?)
Date: Tue, 17 Jul 2007 22:12:42 +0200
Message-ID: <20070717201242.GB2426@elte.hu>
References: <1183582155.3291.160.camel@chaos> <9609.194.65.103.1.1183731007.squirrel@www.rncbc.org> <1183758545.20747.34.camel@cmn3.stanford.edu> <20070707092401.GB21234@elte.hu> <1183934205.11854.11.camel@cmn3.stanford.edu> <46917678.70700@googlemail.com> <Pine.LNX.4.63.0707082047130.12404@cmn3.stanford.edu> <1183957703.12681.4.camel@cmn3.stanford.edu> <20070717193223.GJ26283@elte.hu> <1184702217.21931.19.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel C <nix.or.die@googlemail.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	"jcaceres@ccrma.Stanford.EDU" <jcaceres@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rui Nuno Capela <rncbc@rncbc.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41437 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329AbXGQUNV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Jul 2007 16:13:21 -0400
Content-Disposition: inline
In-Reply-To: <1184702217.21931.19.camel@cmn3.stanford.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Tue, 2007-07-17 at 21:32 +0200, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > I do get flash 9 (I know, not the best example) and tomboy to hang as 
> > > reported by one of my Planet CCRMA users - flash 9 tested working on 
> > > stock fedora 7 kernel - and both seem to hang in the same system call:
> > > 
> > > sched_getaffinity(3528, 32, <unfinished ...>
> > > 
> > > Full output of strace attached for both cases.
> > 
> > hm, that's weird. Is it completely unkillable at that time? Could you do 
> > a few things: enable CONFIG_PROVE_LOCKING (lockdep), and also try to get 
> > a full task state dump via:
> > 
> >   echo t > /proc/sysrq-trigger
> 
> Trace attached... the process stays in D state no matter what. 

hm, seems to be related to:

Jul 17 12:51:18 localhost kernel: sched-powersa D [f0aaf930] 00000005  6584  3420   3407

which blocks the cpu-hotplug mutex:

Jul 17 12:51:18 localhost kernel: Call Trace:
Jul 17 12:51:18 localhost kernel:  [<c0603f46>] schedule+0xe0/0xfa
Jul 17 12:51:18 localhost kernel:  [<c0604d0d>] rt_mutex_slowlock+0x164/0x20b
Jul 17 12:51:18 localhost kernel:  [<c0604a5c>] rt_mutex_lock+0x3c/0x3f
Jul 17 12:51:18 localhost kernel:  [<c0423bb4>] sched_getaffinity+0x14/0x94
Jul 17 12:51:18 localhost kernel:  [<c045a647>] __synchronize_sched+0xd/0x5a
Jul 17 12:51:18 localhost kernel:  [<c0423732>] arch_reinit_sched_domains+0x18/0x33
Jul 17 12:51:18 localhost kernel:  [<c0423789>] sched_power_savings_store+0x3c/0x49
Jul 17 12:51:18 localhost kernel:  [<c0552cd4>] sysdev_class_store+0x1e/0x22
Jul 17 12:51:18 localhost kernel:  [<c04b195b>] sysfs_write_file+0xa3/0xc6
Jul 17 12:51:18 localhost kernel:  [<c047a64a>] vfs_write+0xa8/0x154
Jul 17 12:51:18 localhost kernel:  [<c047ac65>] sys_write+0x41/0x67
Jul 17 12:51:18 localhost kernel:  [<c0404f7c>] syscall_call+0x7/0xb

and firefox blocks on the same mutex too:

Jul 17 12:51:18 localhost kernel: firefox-bin   D [efc44670] 00000012  6368  4388      1
Jul 17 12:51:18 localhost kernel: Call Trace:
Jul 17 12:51:18 localhost kernel:  [<c0603f46>] schedule+0xe0/0xfa
Jul 17 12:51:18 localhost kernel:  [<c0604d0d>] rt_mutex_slowlock+0x164/0x20b
Jul 17 12:51:18 localhost kernel:  [<c0604a5c>] rt_mutex_lock+0x3c/0x3f
Jul 17 12:51:18 localhost kernel:  [<c0423bb4>] sched_getaffinity+0x14/0x94
Jul 17 12:51:18 localhost kernel:  [<c0423c53>] sys_sched_getaffinity+0x1f/0x41
Jul 17 12:51:18 localhost kernel:  [<c0404f7c>] syscall_call+0x7/0xb
Jul 17 12:51:18 localhost kernel:  [<b7f0f410>] 0xb7f0f410

does lockdep pinpoint anything?

	Ingo
