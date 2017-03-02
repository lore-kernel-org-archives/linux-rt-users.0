From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Thu, 2 Mar 2017 18:51:56 +0100
Message-ID: <20170302175155.rymagis536dnw5nh@linutronix.de>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
 <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
 <ef2c680e3ed541c4b0df5e0715ca8264@FE-MBX1012.de.bosch.com>
 <3c9395f9c6b944978c1f420276bde0ee@FE-MBX1012.de.bosch.com>
 <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdCBUEq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Mar 2017 15:04:46 -0500
Content-Disposition: inline
In-Reply-To: <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-27 14:04:35 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Sebastian,
Hi Mathias,

> In the error case, there is "prev_state=T|K".

The t|K should be okay.

        gdb-issue-8145  [001] .......  9315.877956: sched_process_fork: comm=gdb-issue pid=8145 child_comm=gdb-issue child_pid=8473
        gdb-issue-8145  [001] d...2..  9315.877958: sched_wakeup_new: comm=gdb-issue pid=8473 prio=39 target_cpu=001
        gdb-issue-8145  [001] d...212  9315.877964: sched_wakeup: comm=gdb pid=8138 prio=120 target_cpu=004
        gdb-issue-8145  [001] .....12  9315.877964: signal_generate: sig=17 errno=0 code=262148 comm=gdb pid=8138 grp=1 res=0
        gdb-issue-8145  [001] d...2..  9315.877966: sched_switch: prev_comm=gdb-issue prev_pid=8145 prev_prio=39 prev_state=t|K ==> next_comm =gdb-issue next_pid=8473 next_prio=39
           <idle>-0     [004] d...2..  9315.877990: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=gdb  next_pid=8138 next_prio=120
              gdb-8138  [004] .......  9315.877992: sys_exit: NR 7 = -516
              gdb-8138  [004] .....11  9315.877993: signal_deliver: sig=17 errno=0 code=262148 sa_handler=5623f7c281e0 sa_flags=14000000
…

The gdb task deals with each new child and releases it later:

              gdb-8138  [004] .......  9315.878159: sys_enter: NR 101 (11, 2119, 0, 0, 10, 30)
              gdb-8138  [004] d...2..  9315.878160: sched_wait_task: comm=gdb-issue pid=8473 prio=39
              gdb-8138  [004] d...212  9315.878163: sched_wakeup: comm=gdb-issue pid=8473 prio=39 target_cpu=001
              gdb-8138  [004] .......  9315.878164: sys_exit: NR 101 = 0

later it is gone. So that looks fine. When it hangs

        gdb-issue-8424  [000] d...212  9315.738204: sched_wakeup: comm=gdb pid=8138 prio=120 target_cpu=004
(8424 will sched out due to ptrace)
              gdb-8138  [004] .......  9315.738207: sys_exit: NR 61 = 8424
              gdb-8138  [004] .......  9315.738214: sys_enter: NR 15 (c, 5623f7fff84b, 1, 0, 8, 30)
              gdb-8138  [004] .......  9315.738215: sys_exit: NR -1 = 8424
              gdb-8138  [004] .......  9315.738216: sys_enter: NR 101 (11, 20e8, 0, 0, 10, 30)
              gdb-8138  [004] d...2..  9315.738217: sched_wait_task: comm=gdb-issue pid=8424 prio=39
              gdb-8138  [004] d...112  9315.738218: sched_waking: comm=gdb-issue pid=8424 prio=39 target_cpu=000
              gdb-8138  [004] d...212  9315.738220: sched_wakeup: comm=gdb-issue pid=8424 prio=39 target_cpu=000
              gdb-8138  [004] .......  9315.738221: sys_exit: NR 101 = 0
        gdb-issue-8144  [000] .......  9315.738246: sys_exit: NR 56 = 8424
        gdb-issue-8144  [000] .......  9315.738261: sched_process_wait: comm=gdb-issue pid=8424 prio=39

and 8144 blocks in wait for 8424 which is never completes without
additional help (like a manual SIGCONT). Right now it looks like the
PTRACE_DETACH (syscall 101, 11) which should remove the task from ptrace
and wakeup did not work but I see a wakeup…
The wakeup worked (most likely) but since it is stuck I guess that there
was a second signal it is processing and waiting for gdb.

> Please find the trace extract and the test executable in the attachment.
> 
> Any idea or feedback on the issue is highly welcome!
> 
> Thanks
> 
> Best regards
> 
> Mathias

Sebastian
