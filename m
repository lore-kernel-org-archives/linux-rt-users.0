Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB8202F70
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692955; cv=none; b=Daypkxlij0Re2B3yO85kTuMlOsy3fRjuDNK1eTqkdgn5MF6z5xMR1Ij3MEkY/14ivUEqw627c8ExHc9Bafmx+3wvNcf82c0jAFiCMBxovpsHwBrNn9ae0+5uSSXdpKfRHnLR/1rodMS4rR1Py8nNaSSiNGQULebic/rlPjVx3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692955; c=relaxed/simple;
	bh=rvDSA6/KS+rXwF1YQ+qrlv9sGDo9Gy1XTDUz5W/duxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKELwz16wdu4r0JRE80wFow62etYRWHYacYkkVhuIUz9qqLXcfFZEOikotWuHn8dxzqHObWRVOcQ/D4TlU31SmfaNQuGGArwEiaqOQbEIzICbApen7iyF7wKnjtTP9WBhIW+aXEE2ezYhbHA36SR73gOIKEg5+NmedJsLtW6zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMcuJ3Ak; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMcuJ3Ak"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bdff8c02b2so429365e0c.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692952; x=1784297752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X70oY8wqT+Ym33/pGXv9k0RNRw/IptVsgkCX4X90dU0=;
        b=MMcuJ3AkSK+Qk22GJ2gviW0RugpMXpJ56AT6kySMyUtiMZHWRIF+oC07FJfdBNlDyR
         yPeCq549L01icii6M597EaVuZG39tsf7ke+ziKGbeSEzfYYiBPTt2vYq0sBhdRz50HjN
         a/60jKwuVjLyXXqdzVYRWfmf3Q+DND8Qh7pkPUK1lerF9LOxui1dcy0e9XznVKoEv6iE
         5+GY0P9eiwONvhbzO6rJHzOp8xDPM0ghBMnxP+fp/1KrX+iR3UzKZIUuroqAFj3haCnb
         qvSq+PiSNe1YEAu7FOB/e0MLks4r9D+5yxCv3YZV+M8RDC4AxgSAyE8Ma8fH2RbheCu+
         K3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692952; x=1784297752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X70oY8wqT+Ym33/pGXv9k0RNRw/IptVsgkCX4X90dU0=;
        b=Xw7Os23vJltR0vy9XWANxx1fR1fUxVkht37cFDHBBvt4yaF8FXR/K2mUTH8oJt1bDz
         W7YcMyucJgdgSt3mXIk4uU81gi+CJlFRL2DhN7pG3mOooXa71TakHNxEoiBxTiBd3Vm5
         tz6NNTu8hUb7JgOf7a2BJ6Zf123iWRvw/nOfe54wb0nTgVqKXNoTuhTbx0lQgdZzN/Mu
         49MCGFa23yZv8gT7RaI91G3/L7ioTD9qzHIn050nkPQfMsL6P1EiJjKGVdU0bPsCK+6+
         n3LJrYt5wRzG97z6cFjCg0qTXaBf9mp4QJsgIvwEV1Ny2MNiUrEjodmph2JxyAlrJ4jw
         IeeA==
X-Gm-Message-State: AOJu0YzpeOSQs5na9px0qilANJkZwAq7mrBcZHLm+YnzzrJM5DWDLKi/
	Qgj/b/WL9BLD0xm4wlgIg/sRkOpLSP+3dmCcb9pyQXAjq9IAE0wCuquCNAU34A==
X-Gm-Gg: AfdE7cnq4QoLjRVAZ6mNPg3SAgvk6d8yv+EaMp6WN4C0zcqkP0pzOIW0op+HJlOuT6Z
	cviyesYbv/Pa0pb6W0omLf0KxCRewbk7qnVlrcQFOZZNaIH+GdcC/a7u+9dfjJoXL8HW/s+DacT
	o0W+AT1WefXtvWl3UMSEobIJBUq8Go79GwlhDuXUEwZCLSX0GdBIYyUhkhr0UEdymjC3Ydb9CHg
	Ma3BoJbxUZv4cPROriQp4hL5GZkvzbO/xm7OIOJZ/bsPdeOBPuyR9V75VDfjR5YI/+6ylzQIlqC
	mnX1ZoTjLeTOiNmExBfd7bJH15TrS9K/bTndMMa3SHl6NvgcO6dSpIFoz5anZDE5KFEOKoSIHsE
	3MmmWoxrtJ7P8RW3U1Lh/M3BU0gD5kkIX9DCXyB6E71Lq3v97TwJ2iSyh47YFlo7+xA6ggJJetg
	+iFZNOY+Tl0pb9RNf1cqS5nXkRvzI/2ZyCh0HiLKxgxqusnjxnE8tjqKgmWeY5CK1IQuDBjG6F9
	g==
X-Received: by 2002:a05:6102:41a2:b0:737:f0ba:508f with SMTP id ada2fe7eead31-744dff52b15mr6363694137.3.1783692952296;
        Fri, 10 Jul 2026 07:15:52 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:51 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 04/36] tuna: Enhance what_is command with new kernel thread descriptions and usability improvements
Date: Fri, 10 Jul 2026 10:14:42 -0400
Message-ID: <20260710141523.36440-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive help descriptions for 14 modern kernel threads including
kworker, threaded IRQs, memory management daemons (kswapd, kcompactd,
khugepaged, ksmd), and system threads (kauditd, kdevtmpfs, oom_reaper,
watchdogd, cpuhp, rcu_preempt, rcu_sched). Also add jbd2 for ext4 journaling.

Update and correct 5 existing descriptions:
- ksoftirqd: Fix misleading "networking only" description to reflect it
  handles all softirq types (timers, networking, block I/O, RCU, tasklets)
- watchdog: Fix incorrect sysctl references, correctly describe soft/hard
  lockup detection
- events, kblockd: Mark as legacy, explain modern kworker replacement
- kjournald: Mark as ext3-specific legacy, reference jbd2 for ext4

Improve pattern matching:
- Handle NUMA-numbered threads (kswapd0 -> kswapd, kcompactd1 -> kcompactd)
  by stripping trailing digits
- Fix kworker threads with multiple slashes (kworker/R-xfs-buf/nvme0n1p2)
  by special-casing the kworker/ prefix

Fix bugs:
- Reduce double blank line between title and description to single line
- Fix user threads printing title twice by returning empty help instead
  of duplicating the title

Enhance usability:
- Accept thread lists with flexible separators: "811, 950" (comma+space),
  "811,950" (comma), "811 950" (space), all without requiring quotes
- Support multiple positional arguments (nargs='+') and join them
- Split input by both comma and whitespace using regex
- Add blank lines between thread descriptions for better readability
- Apply same flexible parsing to IRQ and socket lists for consistency

The what_is command is now significantly more useful for understanding
modern kernel threads, with better formatting and more intuitive input
handling.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py  | 29 +++++++++++++++++++++--------
 tuna/help.py | 26 ++++++++++++++++++++------
 tuna/tuna.py | 21 +++++++++++++++++++--
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index c4bd55fac3df..6cb0a679cc60 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -86,7 +86,7 @@ def gen_parser():
 
     POS = {
             "cpu_list": dict(metavar='CPU-LIST', type=tuna.cpustring_to_list, help="CPU-LIST affected by commands"),
-            "thread_list": dict(metavar='THREAD-LIST', type=str, help="THREAD-LIST affected by commands"),
+            "thread_list": dict(metavar='THREAD-LIST', nargs='+', help="THREAD-LIST affected by commands"),
             "filename": dict(metavar='FILENAME', type=str, help="Save kthreads sched tunables to this file"),
             "profilename": dict(type=str, help="Apply changes described in this file"),
             "run_command": dict(metavar='COMMAND', type=str, help="fork a new process and run the \"COMMAND\""),
@@ -255,7 +255,7 @@ def thread_help(tid, ps):
     pinfo = ps[tid]
     cmdline = procfs.process_cmdline(pinfo)
     help, title = tuna.kthread_help_plain_text(tid, cmdline)
-    print(title, "\n\n")
+    print(title, "\n")
     if help.isspace():
         help = "No help description available."
     print(help)
@@ -545,7 +545,9 @@ def threadstring_to_list(threadstr, ps=None):
     thread_list = []
     if not threadstr:
         return thread_list, match_requested
-    thread_strings = list(set(threadstr.split(',')))
+    # Split by both comma and whitespace to handle "811,950" and "811, 950" and "811 950"
+    import re
+    thread_strings = list(set(s.strip() for s in re.split(r'[,\s]+', threadstr) if s.strip()))
     for s in thread_strings:
         if s.isdigit():
             thread_list.append(int(s))
@@ -563,7 +565,9 @@ def irqstring_to_list(irqstr):
     irq_list = []
     if not irqstr:
         return irq_list, match_requested
-    irq_strings = list(set(irqstr.split(',')))
+    # Split by both comma and whitespace
+    import re
+    irq_strings = list(set(s.strip() for s in re.split(r'[,\s]+', irqstr) if s.strip()))
     for s in irq_strings:
         if s.isdigit():
             irq_list.append(int(s))
@@ -575,7 +579,9 @@ def irqstring_to_list(irqstr):
 
 def socketstring_to_list(socketstr):
     cpu_list = []
-    socket_strings = list(set(socketstr.split(',')))
+    # Split by both comma and whitespace
+    import re
+    socket_strings = list(set(s.strip() for s in re.split(r'[,\s]+', socketstr) if s.strip()))
     cpu_info = sysfs.cpus()
 
     for s in socket_strings:
@@ -673,8 +679,12 @@ def main():
 
     # Convert thread_list from string to list
     if 'thread_list' in vars(args) and args.thread_list:
-        if isinstance(args.thread_list, str):
-            args.thread_list, match_requested = threadstring_to_list(args.thread_list, ps)
+        # Join multiple arguments into a single string (handles "811, 950" without quotes)
+        if isinstance(args.thread_list, list):
+            thread_str = ' '.join(args.thread_list)
+        else:
+            thread_str = args.thread_list
+        args.thread_list, match_requested = threadstring_to_list(thread_str, ps)
 
     # Convert irq_list from string to list
     if 'irq_list' in vars(args) and args.irq_list:
@@ -792,8 +802,11 @@ def main():
     elif args.command in ['W', 'what_is']:
         if not ps:
             ps = procfs.pidstats()
-        for tid in args.thread_list:
+        for i, tid in enumerate(args.thread_list):
             thread_help(tid, ps)
+            # Add blank line between threads (but not after the last one)
+            if i < len(args.thread_list) - 1:
+                print()
 
     elif args.command in ['g', 'gui']:
         # Don't try to start the gui if no display is available
diff --git a/tuna/help.py b/tuna/help.py
index 1a9473a86875..458897e01fb8 100644
--- a/tuna/help.py
+++ b/tuna/help.py
@@ -14,23 +14,37 @@ KTHREAD_HELP = {
 'sirq-rcu/':N_('Pushes the RCU grace period along (if possible) and will handle dereferenced RCU callbacks, such as freeing structures after a grace period. \n[One per CPU]'),
 'khelper':N_('Used to call user mode helpers from the kernel, such as /sbin/bridge-stp, ocfs2_hb_ctl, pnpbios, poweroff, request-key, etc."'),
 'group_balance':N_('Scheduler load balance monitoring.'),
-'kjournald':N_('Main thread function used to manage a filesystem logging device journal. This kernel thread is responsible for two things: <b>COMMIT</b>: Every so often we need to commit the current state of the filesystem to disk.  The journal thread is responsible for writing all of the metadata buffers to disk. <b>CHECKPOINT</b>: We cannot reuse a used section of the log file until all of the data in that part of the log has been rewritten elsewhere on the disk.  Flushing these old buffers to reclaim space in the log is known as checkpointing, and this thread is responsible for that job.'),
+'kjournald':N_('Legacy: Journal thread for ext3 filesystems. Responsible for two main tasks: <b>COMMIT</b>: Periodically commits filesystem state to disk by writing metadata buffers. <b>CHECKPOINT</b>: Flushes old buffers to reclaim log space (checkpointing). Modern systems using ext4 use jbd2/device-name threads instead (e.g., jbd2/sda1-8).'),
+'jbd2/':N_('Journal block device thread for ext4 filesystems (JBD2 = Journaling Block Device version 2). Handles commit and checkpoint operations for ext4 journaling. Named as jbd2/device-name (e.g., jbd2/sda1-8, jbd2/dm-0). Runs at normal priority but can be tuned for latency-sensitive workloads.'),
 'lockd':N_('Locking arbiter for NFS on the system'),
 'sirq-sched/':N_('Triggered when a rebalance of tasks is needed to CPU domains. This handles balancing of SCHED_OTHER tasks across CPUs. RT tasks balancing is done directly in schedule and wakeup paths.  Runs at prio 1 because it needs to schedule above all SCHED_OTHER tasks. If the user has the same issue but doesn"t mind having latencies against other kernel threads that run here, then its fine. But it should definitely be documented that PRIO 1 has other threads on it at boot up. \n[One per CPU]'),
 'sirq-high/':N_('This is from a poor attempt to prioritize tasklets. Some tasklets wanted to run before anything else. Thus there were two tasklet softirqs made. tasklet_vec and tasklet_hi_vec. A driver writer could put their "critical" tasklets into the tasklet_hi_vec and it would run before other softirqs. This never really worked as intended. \n[One per CPU]'),
-'kblockd/':N_('Workqueue used to process IO requests. Used by IO schedulers and block device drivers. \n[One per CPU]'),
+'kblockd/':N_('Legacy: In older kernels, dedicated per-CPU threads for the block I/O subsystem workqueue. In modern kernels, this work is handled by kworker threads. You may see "kblockd" in kworker names like "kworker/0:1H-kblockd", indicating block I/O work. Used by IO schedulers and block device drivers. \n[One per CPU - Legacy only]'),
 'sirq-net-rx/':N_('When receiving a packet the device will place the packet on a queue with its hard interrupt (threaded in RT). The sirq-net-rx is responsible for finding out what to do with the packet. It may forward it to another box if the current box is used as a router, or it will find the task the packet is for. If that task is currently waiting for the packet, the softirq might hand it off to that task and the task will handle the rest of the processing of the packet. \n[One per CPU]'),
 'krcupreemptd':N_('This should run at the lowest RT priority. With preemptible RCU, a loaded system may have tasks that hold RCU locks but have a high nice value. These tasks may be pushed off for seconds, and if the system is tight on memory, the RCU deferred freeing may not occur. The result can be drastic.  The krcupreemptd is a daemon that runs just above SCHED_OTHER and wakes up once a second and performs a synchronize RCU. With RCU boosting, all those that hold RCU locks will inherit the priority of the krcupreemptd and wake up and release the RCU locks.  This is only a concern for loaded systems and SCHED_OTHER tasks. If there is an issue of RT tasks starving out SCHED_OTHER tasks and causing problems with freeing memory, then the RT tasks are designed badly.'),
-'ksoftirqd/':N_('Activated when under heavy networking activity. Used to avoid monopolizing the CPUs doing just software interrupt processing. \n[One per CPU]'),
+'ksoftirqd/':N_('Handles softirq processing in process context. When softirqs (timers, networking, block I/O, RCU, tasklets, etc.) accumulate or take too long, this thread prevents them from monopolizing CPU time in interrupt context. Wakes up when softirq load is high or when in_interrupt() processing would exceed time limits. \n[One per CPU]'),
 'sirq-timer/':N_('Basically the timer wheel. Things that add itself to the timer wheel timeouts will be handled by this softirq. Parts of the kernel that need timeouts will use this softirq (i.e. network timeouts). The resolution to these timeouts are defined by the HZ value. \n[One per CPU]'),
-'events/':N_('Global workqueue, used to schedule work to be done in process context. \n[One per CPU]'),
-'watchdog/':N_('Run briefly once per second to reset the softlockup timestamp.  If this gets delayed for more than 60 seconds then a message will be printed.  Use /proc/sys/kernel/hung_task_timeout_secs and /proc/sys/kernel/hung_task_check_count to control this behaviour.  Setting /proc/sys/kernel/hung_task_timeout_secs to zero will disable this check. \n[One per CPU]'),
+'events/':N_('Legacy: In older kernels, these were dedicated per-CPU threads for the global "events" workqueue. In modern kernels (since ~2.6.36), workqueues are handled by kworker threads. You may still see "events" in kworker names like "kworker/0:1-events", indicating work from the events workqueue. \n[One per CPU - Legacy only]'),
+'watchdog/':N_('Per-CPU watchdog thread that detects soft lockups (CPU stuck in kernel mode with preemption disabled) and hard lockups (CPU stuck with interrupts disabled). Runs at highest priority (SCHED_FIFO 99) and touches a timestamp periodically. If the timestamp is not updated within the threshold period, a lockup is detected and logged. Can be configured via /proc/sys/kernel/watchdog_thresh. \n[One per CPU]'),
 'sirq-net-tx/':N_('This is the network transmit queue. Most of the time the network packets will be handled by the task that is sending the packets out, and doing so at the priority of that task. But if the protocol window or the network device queue is full, then the packets will be pushed off to later. The sirq-net-tx softirq is responsible for sending out these packets. \n[One per CPU]'),
 'sirq-block/':N_('Called after a completion to a block device is made. Looking further into this call, I only see a couple of users. The SCSI driver uses this as well as cciss. \n[One per CPU]'),
 'sirq-tasklet/':N_('Catch all for those devices that couldn"t use softirqs directly and mostly made before work queues were around. The difference between a tasklet and a softirq is that the same tasklet can not run on two different CPUs at the same time. In this regard it acts like a "task" (hence the name "tasklet"). Various devices use tasklets. \n[One per CPU]'),
 'usb-storage':N_('Per USB storage device virtual SCSI controller.  Persistant across device insertion/removal, as is the SCSI node. This is done so that a device which is removed can be re-attached and be granted the same /dev node as before, creating persistance between connections of the target unit.  Gets commands from the SCSI mid-layer and, after sanity checking several things, sends the command to the "protocol" handler. This handler is responsible for re-writing the command (if necessary) into a form which the device will accept. For example, ATAPI devices do not support 6-byte commands. Thus, they must be re-written into 10-byte variants.'),
 'migration/':N_('High priority system thread that performs thread migration by bumping thread off CPU then pushing onto another runqueue. \n[One per CPU]'),
-'rpciod/':N_('Handles Sun RPC network messages (mainly for NFS) \n[One per CPU]')
+'rpciod/':N_('Handles Sun RPC network messages (mainly for NFS) \n[One per CPU]'),
+'irq/':N_('Threaded IRQ handler. Modern kernels can run interrupt handlers in kernel threads instead of hardirq context, allowing them to be preempted and scheduled like other tasks. This is especially important for PREEMPT_RT kernels. Named as irq/NUMBER-handler_name (e.g., irq/197-iwlwifi:default_queue). The thread priority and CPU affinity can be controlled to reduce latency. Use /proc/irq/NUMBER/smp_affinity to control CPU binding.'),
+'kworker/':N_('Kernel workqueue threads. These handle deferred work from various kernel subsystems. Work items are queued and processed asynchronously in process context. The naming format is kworker/CPU:ID-workqueue_name (e.g., kworker/0:1-events). High priority workqueues use "H" suffix. Modern kernels use "R-" prefix for rescue threads. \n[Multiple per CPU]'),
+'kswapd':N_('Virtual memory pageout daemon. Responsible for reclaiming memory pages when the system is low on free memory. It writes dirty pages to swap and reclaims clean pages. Wakes up periodically or when free memory falls below certain thresholds. On NUMA systems, there is one instance per memory node (kswapd0, kswapd1, etc.).'),
+'khugepaged':N_('Transparent Huge Pages (THP) daemon. Scans memory to find sequences of 4KB pages that can be collapsed into a single 2MB huge page to reduce TLB pressure and improve performance. Can be controlled via /sys/kernel/mm/transparent_hugepage/.'),
+'kcompactd':N_('Memory compaction daemon. Performs memory defragmentation to create larger contiguous blocks of free memory, which is essential for huge page allocations. Runs periodically and when memory fragmentation is detected. On NUMA systems, there is one instance per memory node (kcompactd0, kcompactd1, etc.).'),
+'ksmd':N_('Kernel Samepage Merging daemon. Scans memory to find identical pages and merges them to save memory. Primarily used in virtualized environments where multiple VMs may have identical pages. Can be controlled via /sys/kernel/mm/ksm/.'),
+'kdevtmpfs':N_('Device filesystem daemon. Manages the devtmpfs filesystem, automatically creating and removing device nodes in /dev as devices are added or removed from the system.'),
+'kauditd':N_('Kernel audit daemon. Handles audit records generated by the Linux audit subsystem, writing them to the audit log. Part of the security auditing framework.'),
+'oom_reaper':N_('Out-of-Memory reaper thread. Reclaims memory from processes that have been killed by the OOM killer. Runs asynchronously to quickly free memory without waiting for the dying process to exit completely.'),
+'watchdogd':N_('Hardware watchdog daemon. Periodically writes to the hardware watchdog device to prevent system resets. Different from the per-CPU softlockup watchdog threads (watchdog/).'),
+'cpuhp/':N_('CPU hotplug state machine threads. Manage the CPU hotplug process, handling the complex state transitions when CPUs are brought online or taken offline. \n[One per CPU]'),
+'rcu_preempt':N_('RCU (Read-Copy-Update) thread for preemptible RCU. Handles grace period detection and callback processing for the preemptible variant of RCU used in PREEMPT kernels.'),
+'rcu_sched':N_('RCU (Read-Copy-Update) scheduler thread. Handles grace period detection for non-preemptible RCU, ensuring readers have completed before allowing writers to free old data structures.')
 }
 
 PROC_SYS_HELP = {
diff --git a/tuna/tuna.py b/tuna/tuna.py
index 8e57cddd0c13..be3ca5017ef0 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -22,9 +22,26 @@ except NameError:
     fntable = []
 
 def kthread_help(key):
+    # Special case: kworker threads (can have multiple slashes in workqueue name)
+    if key.startswith('kworker/'):
+        return help.KTHREAD_HELP.get('kworker/', " ")
+
+    # Handle per-CPU threads with / suffix (e.g., ksoftirqd/0 -> ksoftirqd/)
     if '/' in key:
         key = key[:key.rfind('/')+1]
-    return help.KTHREAD_HELP.get(key, " ")
+        return help.KTHREAD_HELP.get(key, " ")
+
+    # Try exact match first
+    result = help.KTHREAD_HELP.get(key)
+    if result and result != " ":
+        return result
+
+    # Strip trailing digits for NUMA threads (e.g., kswapd0 -> kswapd, kcompactd1 -> kcompactd)
+    base_key = re.sub(r'\d+$', '', key)
+    if base_key != key:  # Had digits to strip
+        return help.KTHREAD_HELP.get(base_key, " ")
+
+    return " "
 
 def proc_sys_help(key):
     if not fntable:
@@ -50,7 +67,7 @@ def kthread_help_plain_text(pid, cmdline):
         help = kthread_help(cmdline)
     else:
         title = _("User Thread %(pid)d (%(cmdline)s):") % params
-        help = title
+        help = " "  # No help available for user threads
 
     return help, title
 
-- 
2.54.0

