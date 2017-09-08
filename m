From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 35/40] tracing: Reverse the order
 event_mutex/trace_types_lock are taken
Date: Fri, 8 Sep 2017 15:41:36 -0400
Message-ID: <20170908154136.096d49ff@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <4b52f9b1c49599780af1a193736df609b2785a63.1504642143.git.tom.zanussi@linux.intel.com>
        <20170908153135.14725f01@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756979AbdIHTlk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Sep 2017 15:41:40 -0400
In-Reply-To: <20170908153135.14725f01@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 8 Sep 2017 15:31:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  5 Sep 2017 16:57:47 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Change the order event_mutex and trace_types_lock are taken, to avoid
> > circular dependencies and lockdep spew.
> > 
> > Changing the order shouldn't matter to any current code, but does to
> > anything that takes the event_mutex first and then trace_types_lock.
> > This is the case when calling tracing_set_clock from inside an event
> > command, which already holds the event_mutex.  
> 
> This is a very scary patch. I'll apply it and run a bunch of tests with
> lockdep enabled. Let's see what blows up (or not).

Boom!

 ======================================================
 WARNING: possible circular locking dependency detected
 4.13.0-rc7-test+ #84 Not tainted
 ------------------------------------------------------
 mkdir/1674 is trying to acquire lock:
  (event_mutex){+.+.+.}, at: [<ffffffff811b18bd>] event_trace_add_tracer+0x1d/0xb0
 
               but task is already holding lock:
  (trace_types_lock){+.+.+.}, at: [<ffffffff811a121f>] instance_mkdir+0x2f/0x250
 
               which lock already depends on the new lock.

 
               the existing dependency chain (in reverse order) is:
 
               -> #1 (trace_types_lock){+.+.+.}:
        lock_acquire+0xe3/0x1d0
        __mutex_lock+0x81/0x950
        mutex_lock_nested+0x1b/0x20
        trace_module_notify+0x33/0x1b0
        notifier_call_chain+0x4a/0x70
        __blocking_notifier_call_chain+0x4d/0x70
        blocking_notifier_call_chain+0x16/0x20
        load_module+0x21df/0x2dd0
        SYSC_finit_module+0xbc/0xf0
        SyS_finit_module+0xe/0x10
        do_syscall_64+0x62/0x140
        return_from_SYSCALL_64+0x0/0x7a
 
               -> #0 (event_mutex){+.+.+.}:
        __lock_acquire+0x1026/0x11d0
        lock_acquire+0xe3/0x1d0
        __mutex_lock+0x81/0x950
        mutex_lock_nested+0x1b/0x20
        event_trace_add_tracer+0x1d/0xb0
        instance_mkdir+0x173/0x250
        tracefs_syscall_mkdir+0x40/0x70
        vfs_mkdir+0xfb/0x190
        SyS_mkdir+0x6b/0xd0
        entry_SYSCALL_64_fastpath+0x1f/0xbe
 
               other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(trace_types_lock);
                                lock(event_mutex);
                                lock(trace_types_lock);
   lock(event_mutex);
 
                *** DEADLOCK ***

 2 locks held by mkdir/1674:
  #0:  (sb_writers#10){.+.+.+}, at: [<ffffffff812b4824>] mnt_want_write+0x24/0x50
  #1:  (trace_types_lock){+.+.+.}, at: [<ffffffff811a121f>] instance_mkdir+0x2f/0x250
 
               stack backtrace:
 CPU: 3 PID: 1674 Comm: mkdir Not tainted 4.13.0-rc7-test+ #84
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Call Trace:
  dump_stack+0x86/0xcf
  print_circular_bug+0x1be/0x210
  __lock_acquire+0x1026/0x11d0
  lock_acquire+0xe3/0x1d0
  ? lock_acquire+0xe3/0x1d0
  ? event_trace_add_tracer+0x1d/0xb0
  ? event_trace_add_tracer+0x1d/0xb0
  __mutex_lock+0x81/0x950
  ? event_trace_add_tracer+0x1d/0xb0
  ? event_trace_add_tracer+0x1d/0xb0
  ? __create_dir+0xcb/0x130
  mutex_lock_nested+0x1b/0x20
  ? mutex_lock_nested+0x1b/0x20
  event_trace_add_tracer+0x1d/0xb0
  instance_mkdir+0x173/0x250
  tracefs_syscall_mkdir+0x40/0x70
  ? tracefs_syscall_mkdir+0x40/0x70
  vfs_mkdir+0xfb/0x190
  SyS_mkdir+0x6b/0xd0
  entry_SYSCALL_64_fastpath+0x1f/0xbe
 RIP: 0033:0x7f4867afa947
 RSP: 002b:00007ffd3dc35c08 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
 RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 00007f4867afa947
 RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffd3dc3764f
 RBP: ffffc90000f2ff98 R08: 00000000000001ff R09: 000055f96a551ac0
 R10: 000055f96b700010 R11: 0000000000000202 R12: 0000000000000001
 R13: 00007ffd3dc35f28 R14: 00000000000001ff R15: ffffffff8189316a
  ? entry_SYSCALL_64_after_swapgs+0x17/0x4f

It appears to be caused by instance creation. I'll look at that.


-- Steve
