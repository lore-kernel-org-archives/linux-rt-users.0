From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 00/32]  tracing: Inter-event (e.g. latency) support
Date: Wed, 28 Jun 2017 23:21:44 +0900
Message-ID: <20170628232144.faa4b925cab7a9b3d563fb6d@kernel.org>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
        <cover.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbdF1OVz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2017 10:21:55 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tom,

On Mon, 26 Jun 2017 17:49:01 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> This patchset adds support for 'inter-event' quantities to the trace
> event subsystem.  The most important example of inter-event quantities
> are latencies, or the time differences between two events.
> 

Thank you for your great work!
I'm playing this and found some issues.

(1) new event format
----
# echo "wakeup_latency u64 lat; pid_t pid; int prio" > synthetic_events 
# cat /sys/kernel/debug/tracing # cat events/synthetic/wakeup_latency/format 
name: wakeup_latency
ID: 972
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:u64 lat;	offset:16;	size:8;	signed:0;
	field:pid_t pid;	offset:24;	size:4;	signed:1;
	field:int prio;	offset:32;	size:4;	signed:1;

print fmt: "lat: 0x%08lx, pid: 0x%08lx, prio: 0x%08lx", ((u64)(REC->lat)), ((u64)(REC->pid)), ((u64)(REC->prio))
----
Here, IMO, this format would be better "lat=0x%08lx pid=0x%08lx prio=0x%08lx" so that perf-script can parse it correctly.

(2) lockdep found a dead lock case
When I added a histogram trigger, it happened.
----
# echo 'hist:keys=pid:ts0=$common_timestamp.usecs' >>  /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
[33967.672485] 
[33967.673117] ======================================================
[33967.673117] WARNING: possible circular locking dependency detected
[33967.673117] 4.12.0-rc5+ #1 Not tainted
[33967.673117] ------------------------------------------------------
[33967.673117] bash/708 is trying to acquire lock:
[33967.673117]  (trace_types_lock){+.+.+.}, at: [<ffffffff811307e6>] tracing_set_clock+0x66/0xe0
[33967.673117] 
[33967.673117] but task is already holding lock:
[33967.673117]  (trigger_cmd_mutex){+.+.+.}, at: [<ffffffff81144264>] event_trigger_write+0xb4/0x1a0
[33967.673117] 
[33967.673117] which lock already depends on the new lock.
[33967.673117] 
[33967.673117] 
[33967.673117] the existing dependency chain (in reverse order) is:
[33967.673117] 
[33967.673117] -> #2 (trigger_cmd_mutex){+.+.+.}:
[33967.673117]        lock_acquire+0xe3/0x1d0
[33967.673117]        __mutex_lock+0x81/0x950
[33967.673117]        mutex_lock_nested+0x1b/0x20
[33967.673117]        event_trigger_write+0xb4/0x1a0
[33967.673117]        __vfs_write+0x28/0x120
[33967.673117]        vfs_write+0xc7/0x1b0
[33967.673117]        SyS_write+0x49/0xa0
[33967.673117]        entry_SYSCALL_64_fastpath+0x1f/0xbe
[33967.673117] 
[33967.673117] -> #1 (event_mutex){+.+.+.}:
[33967.673117]        lock_acquire+0xe3/0x1d0
[33967.673117]        __mutex_lock+0x81/0x950
[33967.673117]        mutex_lock_nested+0x1b/0x20
[33967.673117]        trace_add_event_call+0x28/0xc0
[33967.673117]        create_synth_event+0x40a/0x880
[33967.673117]        trace_run_command+0x54/0x60
[33967.673117]        trace_parse_run_command+0xc4/0x160
[33967.673117]        synth_events_write+0x10/0x20
[33967.673117]        __vfs_write+0x28/0x120
[33967.673117]        vfs_write+0xc7/0x1b0
[33967.673117]        SyS_write+0x49/0xa0
[33967.673117]        entry_SYSCALL_64_fastpath+0x1f/0xbe
[33967.673117] 
[33967.673117] -> #0 (trace_types_lock){+.+.+.}:
[33967.673117]        __lock_acquire+0x1026/0x11d0
[33967.673117]        lock_acquire+0xe3/0x1d0
[33967.673117]        __mutex_lock+0x81/0x950
[33967.673117]        mutex_lock_nested+0x1b/0x20
[33967.673117]        tracing_set_clock+0x66/0xe0
[33967.673117]        hist_register_trigger+0x209/0x2a0
[33967.673117]        event_hist_trigger_func+0xc6b/0x2610
[33967.673117]        event_trigger_write+0xfa/0x1a0
[33967.673117]        __vfs_write+0x28/0x120
[33967.673117]        vfs_write+0xc7/0x1b0
[33967.673117]        SyS_write+0x49/0xa0
[33967.673117]        entry_SYSCALL_64_fastpath+0x1f/0xbe
[33967.673117] 
[33967.673117] other info that might help us debug this:
[33967.673117] 
[33967.673117] Chain exists of:
[33967.673117]   trace_types_lock --> event_mutex --> trigger_cmd_mutex
[33967.673117] 
[33967.673117]  Possible unsafe locking scenario:
[33967.673117] 
[33967.673117]        CPU0                    CPU1
[33967.673117]        ----                    ----
[33967.673117]   lock(trigger_cmd_mutex);
[33967.673117]                                lock(event_mutex);
[33967.673117]                                lock(trigger_cmd_mutex);
[33967.673117]   lock(trace_types_lock);
[33967.673117] 
[33967.673117]  *** DEADLOCK ***
[33967.673117] 
[33967.673117] 3 locks held by bash/708:
[33967.673117]  #0:  (sb_writers#8){.+.+.+}, at: [<ffffffff811ef42f>] vfs_write+0x18f/0x1b0
[33967.673117]  #1:  (event_mutex){+.+.+.}, at: [<ffffffff8114421c>] event_trigger_write+0x6c/0x1a0
[33967.673117]  #2:  (trigger_cmd_mutex){+.+.+.}, at: [<ffffffff81144264>] event_trigger_write+0xb4/0x1a0
[33967.673117] 
[33967.673117] stack backtrace:
[33967.673117] CPU: 4 PID: 708 Comm: bash Not tainted 4.12.0-rc5+ #1
[33967.673117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014
[33967.673117] Call Trace:
[33967.673117]  dump_stack+0x86/0xcf
[33967.673117]  print_circular_bug+0x1be/0x210
[33967.673117]  __lock_acquire+0x1026/0x11d0
[33967.673117]  lock_acquire+0xe3/0x1d0
[33967.673117]  ? lock_acquire+0xe3/0x1d0
[33967.673117]  ? tracing_set_clock+0x66/0xe0
[33967.673117]  ? tracing_set_clock+0x66/0xe0
[33967.673117]  __mutex_lock+0x81/0x950
[33967.673117]  ? tracing_set_clock+0x66/0xe0
[33967.673117]  ? rcu_read_lock_sched_held+0x4a/0x80
[33967.673117]  ? tracing_set_clock+0x66/0xe0
[33967.673117]  mutex_lock_nested+0x1b/0x20
[33967.673117]  ? mutex_lock_nested+0x1b/0x20
[33967.673117]  tracing_set_clock+0x66/0xe0
[33967.673117]  hist_register_trigger+0x209/0x2a0
[33967.673117]  event_hist_trigger_func+0xc6b/0x2610
[33967.673117]  ? event_trigger_write+0xb4/0x1a0
[33967.673117]  ? __mutex_lock+0x81/0x950
[33967.673117]  ? event_trigger_write+0xb4/0x1a0
[33967.673117]  ? event_trigger_write+0xb4/0x1a0
[33967.673117]  event_trigger_write+0xfa/0x1a0
[33967.673117]  __vfs_write+0x28/0x120
[33967.673117]  ? rcu_read_lock_sched_held+0x4a/0x80
[33967.673117]  ? rcu_sync_lockdep_assert+0x2f/0x60
[33967.673117]  ? __sb_start_write+0xe7/0x1e0
[33967.673117]  ? vfs_write+0x18f/0x1b0
[33967.673117]  vfs_write+0xc7/0x1b0
[33967.673117]  SyS_write+0x49/0xa0
[33967.673117]  entry_SYSCALL_64_fastpath+0x1f/0xbe
[33967.673117] RIP: 0033:0x4bb040
[33967.673117] RSP: 002b:00007ffd79e44288 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[33967.673117] RAX: ffffffffffffffda RBX: 0000000002829220 RCX: 00000000004bb040
[33967.673117] RDX: 000000000000002a RSI: 00000000028288f0 RDI: 0000000000000001
[33967.673117] RBP: 0000000002828000 R08: fefefefefefefeff R09: ff8772626471ff72
[33967.673117] R10: 00000000028288f0 R11: 0000000000000246 R12: 0000000002827f90
[33967.673117] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000000000071
----

Anyway I just started to run this series, I'll also try to check other
features.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
