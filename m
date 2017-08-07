From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt9
Date: Mon, 7 Aug 2017 09:52:54 +0200
Message-ID: <20170807075254.pdu7immtbakn7f7g@linutronix.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
 <1501913583.7917.42.camel@gmx.de>
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
In-Reply-To: <1501913583.7917.42.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-05 08:13:03 [+0200], Mike Galbraith wrote:
> 
> Steven's script annoyed the scheduler here, but woohoo regardless, it
> hasn't yet made boom, or stopped dead in its tracks.  I'll give it some
> exercise on my 64 core box, where death has never (modulo fugly hacks
> that survived 30 hrs of hell.. once) been more than minutes away.
> 
> [  190.589248] ------------[ cut here ]------------
> [  190.589273] WARNING: CPU: 1 PID: 5679 at kernel/sched/core.c:6346 __might_sleep+0x80/0x90
> [  190.589277] do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff810d2c45>] __finish_swait+0x5/0x60
> [  190.589340] CPU: 1 PID: 5679 Comm: stress-cpu-hotp Tainted: G            E   4.11.12-rt9-virgin #11
> [  190.589341] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [  190.589341] Call Trace:
> [  190.589355]  __might_sleep+0x80/0x90
> [  190.589358]  rt_mutex_lock_state+0x25/0x60
> [  190.589361]  rt_mutex_lock+0x13/0x20
> [  190.589362]  _mutex_lock+0x39/0x40
> [  190.589365]  stop_cpus+0x23/0x50
> [  190.589367]  stop_machine_cpuslocked+0xed/0x130
> [  190.589370]  takedown_cpu+0x80/0x110
> [  190.589372]  cpuhp_invoke_callback+0x248/0x9d0
> [  190.589376]  cpuhp_down_callbacks+0x42/0x80
> [  190.589378]  _cpu_down+0xc5/0x100
> [  190.589380]  do_cpu_down+0x3c/0x60
> [  190.589381]  cpu_down+0x10/0x20
> [  190.589384]  cpu_subsys_offline+0x14/0x20
> [  190.589385]  device_offline+0x8a/0xb0
> [  190.589387]  online_store+0x40/0x80
> [  190.589389]  dev_attr_store+0x18/0x30
> [  190.589391]  sysfs_kf_write+0x44/0x60
> [  190.589392]  kernfs_fop_write+0x13c/0x1d0
> [  190.589395]  __vfs_write+0x28/0x140

can you reproduce that one? I don't see where this TASK_UNINTERRUPTIBLE
is coming from.

Sebastian
