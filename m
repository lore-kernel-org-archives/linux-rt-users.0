Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249066BFB0
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Jun 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732277; cv=none; b=fTt9Yb4cIzJLV2b0Zww6/cvCOReViADPg9oCj8X5GwUU9fTvK370NaWosQxP/zsv6IWCgYM5YaaFTccaVaWz+22cb7suKWFn0KlHmSz9k1M0Ml83vgjhX6ldEsxmITZOPitrunOJWWl5Rug2VaxhtBxWEE/qtXLrM4QMcwcKErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732277; c=relaxed/simple;
	bh=xTOlixnOjCXBRUTnU3x6iTX7lhvk0rmAcejVRJ/KGE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MI9RFcqqnJYiae6LKqzR4OzpDaVHTlhdh6Bis73UFfM+EREbZTPWHMcVmexflDgrJK2Fcqms3AGXF3jEbjOLT+Twqb5x+s2SVu8faJSK93NyJ5YurEsXwTWdYqqHekPgFPm0j+4chi1+LxOwxlppmP3JGdyLALUTzm59vEacbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4umBgyP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4umBgyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718732273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mgYcOe2C5KVnL45iO9/OIJYGaLtsqSULC2wkwzh/GbQ=;
	b=X4umBgyPsfT04nWrm2i5GlIY13vT8hZNQ9sm6j5kfqzD/Sd7aZCeGxX2+e3xXltSsJhMbz
	pB/Vkoz1rO/om73Jqp0gG4DY3Bk/lWnrcsZ/CC9r/SpZLWePqlVrrEdv789olyhHY3Ta0H
	yLc3R57gFet7JbYYgJmhszf+kish0mE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-1B6QQANmMuaP7PMGP_CnMA-1; Tue,
 18 Jun 2024 13:37:49 -0400
X-MC-Unique: 1B6QQANmMuaP7PMGP_CnMA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DAE019560BB;
	Tue, 18 Jun 2024 17:37:48 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.8.160])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED5751956048;
	Tue, 18 Jun 2024 17:37:44 +0000 (UTC)
Date: Tue, 18 Jun 2024 13:37:42 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: williams@redhat.com, jlelli@redhat.com, ahalaney@redhat.com,
	lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for 78s
Message-ID: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

Apologies for the resend. My email client borked the headers...

The realtime team at Red Hat has recently backported the latest printk changes
present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon: move locked_port flag to
struct uart_port) to CentOS Stream 9 for performance improvements and
printk-related bugfixes.

Since merging this said code, we've hit an interesting bug during testing,
specifically, on larger systems, a softlockup may be reported by the watchdog
when there is a heavy amount of printing to tty devices (whether it be through
printk, /dev/kmsg, etc).

We have a modicum of reasonable suspicion to believe that nbcon_reacquire, or
some other nbcon mechanism *may* be causing such behavior.

Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
(osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this bug
upstream.

Anyway, here is a more in-depth description, along with some call traces.

Description:

On x86 systems with a large amount of logical cores (nproc ~> 60), a softlockup can
be observed with accompanying call trace when a large amount of "printing"
activity is taking place.

As shown in the call traces appended below, during some kind of numa
balancing/numa_migration after a task_numa_fault --where a set of processess are being migrated/swapped
between two CPUs-- there is a busy thread that is being waited on (in the order
of seconds), causing a livelock. Additional investigation of collected vmcores
by toggling panic on softlockup shows that the waiting thread may be waiting for
a thread looping with nbcon_reacquire.

I suspect that some logic within nbcon_context_try_acquire may be a good place
to start. My understanding of the code becomes a bit fuzzy here, so apologies
in advance for any erroneous statements. As I see it, there may be something
happening during migration (or under heavy load) in which nbcon_reacquire() is in
a non-migratable or non-preemtible state as it is attempting to regain access to
a lost/taken console. It could very well be a situation in which context
was forcefully taken from the printing thread.

Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it is the loop within
nbcon_kthread_func() -- since there is nothing that would yield the task in said
loop (cant_migrate()), the migrate code would be essentially waiting forever for
the aforementioned loop to "finish". I believe in PREEMPT_RT, there would be a
preemption point here. Furthermore, in his investigation, there were signs that the
loop was just iterating up until the crash, leaving reason to
believe that task would be the culprit.

In fact, with the following diff, we noticed this output:

```
ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index bb9689f94d30..d716b72bf2f8 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
      *
      * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
      */
+    trace_printk("Before rcuwait_wait_event()\n");
     ret = rcuwait_wait_event(&con->rcuwait,
                  nbcon_kthread_should_wakeup(con, ctxt),
                  TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
@@ -1086,7 +1087,10 @@ static int nbcon_kthread_func(void *__console)
     if (ret)
         goto wait_for_event;

+    trace_printk("Starting do while(backlog) loop \n");
+    unsigned long int loop = 0;
     do {
+        trace_printk("On loop %lu\n", ++loop);
         backlog = false;

         cookie = console_srcu_read_lock();
@@ -1121,6 +1125,7 @@ static int nbcon_kthread_func(void *__console)
         console_srcu_read_unlock(cookie);

     } while (backlog);
+    trace_printk("End of while(backlog) loop, looped %lu times \n", loop);

     goto wait_for_event;
```

The output:

```
[ 1681.309720] pr/ttyS0-18       21.N... 893365994us : nbcon_kthread_func: On loop 2117
[ 1681.309727] pr/ttyS0-18       21.N... 893374418us : nbcon_kthread_func: On loop 2118
[ 1681.309734] pr/ttyS0-18       21.N... 893382860us : nbcon_kthread_func: On loop 2119
(...)
[ 1681.396193] pr/ttyS0-18       21.N... 954571399us : nbcon_kthread_func: On loop 14025
[ 1681.396200] pr/ttyS0-18       21.N... 954576525us : nbcon_kthread_func: On loop 14026
[ 1681.396207] pr/ttyS0-18       21.N... 954581561us : nbcon_kthread_func: On loop 14027
[ 1681.396213] pr/ttyS0-18       21.N... 954584954us : nbcon_kthread_func: On loop 14028
[ 1681.396220] pr/ttyS0-18       21.N... 954590111us : nbcon_kthread_func: On loop 14029
[ 1681.396223] ---------------------------------
[ 1681.396230] Kernel panic - not syncing: softlockup: hung tasks
(...)
```

Demonstrating evidence that the nbcon kthread function is invoked continuously
up until the point of panic. I do believe that this approach is more sound than
my initial hints (or it could be more than a handful of threads). Some traces
around serial8250_console_write_thread() also denote continuous calls without
any holdups.

As a sidenote, we are seeing the softlockup with !CONFIG_PREEMPT_RT

Some questions arise from this, as we've never encountered this in our testing
with John Ogness' console_blast (kudos to <jwyatt@redhat.com>) and other printk torture
tests that have been compiled [here](https://gitlab.com/debarbos/printktorture).

We are curious to understand why is it that the printing thread is chosen by the
NUMA balancer for migration/swap, and how that interaction is handled within the
code (in other words, how else would nbcon handle a migrated printing thread?).

Our next round of tests aim to disable numa balancing on
large-multi-core-systems to determine whether it is the NUMA mechanisms + nbcon
interactions are at fault here.


How to reproduce:

Provision an x86 machine with a large amount of logical cores with a kernel that
contains the latest printk code, such as linux-rt-devel 6.10 rc3-rt5
(for reference, we are able to consistently reproduce this on machines with
nproc == 128).

Additionally, use LTP pty03 && 06. from ltp/testcase/kernel/pty{03,06}


Use the following reproducer

```

#!/bin/bash

echo 1 > /proc/sys/kernel/softlockup_panic

while true; do ./ltp/testcases/kernel/pty/pty03; ./ltp/testcases/kernel/pty/pty06; done

```

Alternatively, anything that places a great deal of strain on /dev/kmsg may also
do the trick.


Attachments:

Appended below are the call traces collected across various machines.

The first trace contains some additional backtraces and dissassembly.

The second trace was collected with kernel.softlockup_panic set to 1

The third trace was collected without any additional cmdline arguments.

Finally, fourth trace was collected with kernel.softlockup_all_cpu_backtrace
set to 1.

Please let me know if you would like for me to append the configs for said
kernels as well.

---- FIRST TRACE ----

kudos to Audra Baker <aubaker@redhat.com> for this investigation:
 
[42895.891462] pps pps2: removed
[42923.776618] watchdog: BUG: soft lockup - CPU#32 stuck for 26s! [migration/32:212]
[42923.776621] Modules linked in: n_gsm pps_ldisc ppp_synctty n_hdlc ppp_async ppp_generic slhc serport rfkill intel_
rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200 i2c_algo_bit 
drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt irqbypass fb_sys_fops rapl iTCO_wdt iTCO_vendor_sup
port joydev pcspkr intel_cstate intel_uncore ioatdma mei_me i2c_i801 i2c_smbus lpc_ich ipmi_si ipmi_devintf ipmi_msgh
andler mei acpi_pad acpi_power_meter mxm_wmi drm fuse xfs libcrc32c sd_mod t10_pi sg ahci libahci crct10dif_pclmul cr
c32_pclmul ixgbe libata crc32c_intel megaraid_sas ghash_clmulni_intel mdio dca wmi dm_mirror dm_region_hash dm_log dm
_mod
[42923.776655] CPU: 32 PID: 212 Comm: migration/32 Kdump: loaded Not tainted 5.14.0-452.el9.x86_64 #1
[42923.776657] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/201
6
[42923.776658] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xb4/0x110
[42923.776666] RIP: 0010:stop_machine_yield+0x2/0x10
[42923.776669] Code: cc cc cc b8 fe ff ff ff eb df e8 d9 c3 a8 00 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 f3 90 <c3> cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
[42923.776670] RSP: 0018:ffffab0906ca7e70 EFLAGS: 00000246
[42923.776672] RAX: 0000000000000000 RBX: ffffab0927fef948 RCX: 0000000000000002
[42923.776673] RDX: 0000000000000004 RSI: ffffab0927fef9a0 RDI: ffffffff98a371c0
[42923.776674] RBP: ffffab0927fef96c R08: ffff9d55ffc241d0 R09: ffff9d46d36fec00
[42923.776675] R10: 0000000000000193 R11: 0000000000000000 R12: 0000000000000001
[42923.776676] R13: ffffffff98a371c0 R14: 0000000000000000 R15: 0000000000000001
[42923.776677] FS:  0000000000000000(0000) GS:ffff9d55ffc00000(0000) knlGS:0000000000000000
[42923.776679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[42923.776680] CR2: 00007ff24c9190e8 CR3: 00000010a06a2004 CR4: 00000000001706f0
[42923.776681] Call Trace:
[42923.776682]  <IRQ>
[42923.776684]  ? show_trace_log_lvl+0x1c4/0x2df
[42923.776686]  ? show_trace_log_lvl+0x1c4/0x2df
[42923.776688]  ? multi_cpu_stop+0x94/0x100
[42923.776689]  ? watchdog_timer_fn+0x1ad/0x210
[42923.776692]  ? __pfx_watchdog_timer_fn+0x10/0x10
[42923.776694]  ? __hrtimer_run_queues+0x112/0x2b0
[42923.776698]  ? hrtimer_interrupt+0xfc/0x210
[42923.776701]  ? __sysvec_apic_timer_interrupt+0x4e/0x100
[42923.776704]  ? sysvec_apic_timer_interrupt+0x6d/0x90
[42923.776708]  </IRQ>
[42923.776709]  <TASK>
[42923.776709]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[42923.776713]  ? stop_machine_yield+0x2/0x10
[42923.776714]  multi_cpu_stop+0x94/0x100
[42923.776716]  ? __pfx_multi_cpu_stop+0x10/0x10
[42923.776717]  cpu_stopper_thread+0x93/0x140
[42923.776719]  ? __pfx_smpboot_thread_fn+0x10/0x10
[42923.776723]  smpboot_thread_fn+0xd6/0x1a0
[42923.776725]  kthread+0xe0/0x100
[42923.776728]  ? __pfx_kthread+0x10/0x10
[42923.776729]  ret_from_fork+0x2c/0x50
[42923.776734]  </TASK>
 
Looking at the soft lock up- when we hit the soft lock up we were in stop_machine_yield(). 
This expects a cpumask to be passed as the first argument:
 
notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
{
cpu_relax();
}
 
Looks like we are waiting on CPU 27
 
crash> struct cpumask ffffffff98a371c0
struct cpumask {
  bits = \{0x8000000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
}
 
crash> eval -b 0x8000000,
eval: invalid expression: (0x8000000,)
crash> eval -b 0x8000000
hexadecimal: 8000000  (128MB)
    decimal: 134217728  
      octal: 1000000000
     binary: 0000000000000000000000000000000000001000000000000000000000000000
   bits set: 27 
 
 
The function that calls stop_machine_yield() is multi_cpu_stop() which expects a data pointer as its argument. Looking at the assembly, we can work out that this should be our multi_stop_data. Looks like we were migrating two threads, one is already done:
 
crash> struct multi_stop_data ffffab0927fef948 
struct multi_stop_data {
  fn = 0xffffffff97b516c0 <migrate_swap_stop>,
  data = 0xffffab0927fefa08,
  num_threads = 0x2,
  active_cpus = 0xffffffff98a371c0 <cpu_bit_bitmap+28672>,
  state = MULTI_STOP_PREPARE,
  thread_ack = {
    counter = 0x1
  }
}
 
Here is the task we were waiting on. Its been running for a long while:
 
crash> ps -m 17
[0 00:01:50.403] [RU]  PID: 17       TASK: ffff9d46c0b9d580  CPU: 27   COMMAND: "pr/ttyS0"
 
crash> bt  -c 27
PID: 17       TASK: ffff9d46c0b9d580  CPU: 27   COMMAND: "pr/ttyS0"
#0 [fffffe5a17a51bd8] crash_nmi_callback at ffffffff97a6a581
#1 [fffffe5a17a51be0] nmi_panic_self_stop at ffffffff97a6a9f1
#2 [fffffe5a17a51bf8] watchdog_overflow_callback.cold at ffffffff98654315
#3 [fffffe5a17a51c08] __perf_event_overflow at ffffffff97d19a75
#4 [fffffe5a17a51c38] handle_pmi_common at ffffffff97a12bd8
#5 [fffffe5a17a51e08] intel_pmu_handle_irq at ffffffff97a13243
#6 [fffffe5a17a51e48] perf_event_nmi_handler at ffffffff97a04d38
#7 [fffffe5a17a51e68] nmi_handle at ffffffff97a306be
#8 [fffffe5a17a51eb0] default_do_nmi at ffffffff986a00e0
#9 [fffffe5a17a51ed0] exc_nmi at ffffffff986a02f2
#10 [fffffe5a17a51ef0] end_repeat_nmi at ffffffff988015e7
    [exception RIP: nbcon_reacquire+0x11]
    RIP: ffffffff97b96621  RSP: ffffab090431fdf0  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffffab090431feb0  RCX: 00000000000006cc
    RDX: 000000000000001b  RSI: ffffffff99ad5360  RDI: ffffab090431feb0
    RBP: ffffffff99ad5360   R8: 0000000000000000   R9: 0000000000000001
    R10: 0000000000000001  R11: 6465646461207070  R12: ffffffff9a7ad120
    R13: 0000000000000032  R14: 0000000000000000  R15: 000000000000001a
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
#11 [ffffab090431fdf0] nbcon_reacquire at ffffffff97b96621
#12 [ffffab090431fe00] serial8250_console_write_thread at ffffffff981ce209
#13 [ffffab090431fe40] nbcon_emit_next_record at ffffffff97b96baf
#14 [ffffab090431fea0] nbcon_kthread_func at ffffffff97b96e36
#15 [ffffab090431ff18] kthread at ffffffff97b36430
#16 [ffffab090431ff50] ret_from_fork at ffffffff97a02d0c
 
We could be looping within nbcon_reacquire:
 
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/kernel/printk/nbcon.c: 850
0xffffffff97b96610 <nbcon_reacquire>:   nopl   0x0(%rax,%rax,1) [FTRACE NOP]
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/kernel/printk/nbcon.c: 852
0xffffffff97b96615 <nbcon_reacquire+0x5>:       push   %rbp
0xffffffff97b96616 <nbcon_reacquire+0x6>:       push   %rbx
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/kernel/printk/nbcon.c: 850
0xffffffff97b96617 <nbcon_reacquire+0x7>:       mov    %rdi,%rbx
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/kernel/printk/nbcon.c: 852
0xffffffff97b9661a <nbcon_reacquire+0xa>:       mov    (%rdi),%rbp
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/kernel/printk/nbcon.c: 855
0xffffffff97b9661d <nbcon_reacquire+0xd>:       jmp    0xffffffff97b96621 <nbcon_reacquire+0x11>
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/./arch/x86/include/asm/vdso/processor.h: 13
0xffffffff97b9661f <nbcon_reacquire+0xf>:       pause  
/usr/src/debug/kernel-5.14.0-452.el9/linux-5.14.0-452.el9.x86_64/kernel/printk/nbcon.c: 855
0xffffffff97b96621 <nbcon_reacquire+0x11>:      mov    %rbx,%rdi
0xffffffff97b96624 <nbcon_reacquire+0x14>:      call   0xffffffff97b962e0 <nbcon_context_try_acquire>
0xffffffff97b96629 <nbcon_reacquire+0x19>:      test   %al,%al
0xffffffff97b9662b <nbcon_reacquire+0x1b>:      je     0xffffffff97b9661f <nbcon_reacquire+0xf>
 
 
We know that the watchdog timer gets touched at the start of serial8250_console_write_thread:
 
bool serial8250_console_write_thread(struct uart_8250_port *up,
                             struct nbcon_write_context *wctxt)
{
struct uart_8250_em485 *em485 = up->em485;
struct uart_port *port = &up->port;
bool done = false;
unsigned int ier;multi_stop_data
 
touch_nmi_watchdog();
 
Looking at the other tasks, it looks like the other task that was part of the migration was pid 30259- this matches the data pointer in the multi_stop_data as the address is within pid 30259's stack. It doesn't look like this is part of the problem because we have been in blocked state for 1 min 49 sec- which is just under the 1 min 50 seconds CPU 27 has been running on the CPU.  
 
crash> ps -S
  RU: 70
  IN: 314
  ID: 347
  UN: 3
  
crash> ps -m | grep UN
[0 00:00:53.425] [UN]  PID: 30307    TASK: ffff9d5646760000  CPU: 57   COMMAND: "pty03"
[0 00:01:46.341] [UN]  PID: 477      TASK: ffff9d46c54b8000  CPU: 38   COMMAND: "khugepaged"
[0 00:01:49.401] [UN]  PID: 30259    TASK: ffff9d56733c1c80  CPU: 0    COMMAND: "pty03"
 
crash> bt 30259
PID: 30259    TASK: ffff9d56733c1c80  CPU: 0    COMMAND: "pty03"
#0 [ffffab0927fef7b8] __schedule at ffffffff986ae36b
#1 [ffffab0927fef820] schedule at ffffffff986ae6de
#2 [ffffab0927fef838] schedule_timeout at ffffffff986b431f
#3 [ffffab0927fef8a0] __wait_for_common at ffffffff986af393
#4 [ffffab0927fef918] stop_two_cpus at ffffffff97c16d77
#5 [ffffab0927fefa00] migrate_swap at ffffffff97b51df4
#6 [ffffab0927fefa28] task_numa_migrate at ffffffff97b5fcaa
#7 [ffffab0927fefb28] task_numa_fault at ffffffff97b63e4d
#8 [ffffab0927fefb80] do_numa_page at ffffffff97d8abf2
#9 [ffffab0927fefbd0] __handle_mm_fault at ffffffff97d8da1b
#10 [ffffab0927fefcb0] handle_mm_fault at ffffffff97d8de9c
#11 [ffffab0927fefce8] do_user_addr_fault at ffffffff97a8b984
#12 [ffffab0927fefd38] exc_page_fault at ffffffff986a2d52
#13 [ffffab0927fefd60] asm_exc_page_fault at ffffffff98800b52
    [exception RIP: __get_user_8+0xd]
    RIP: ffffffff9808dc9d  RSP: ffffab0927fefe10  RFLAGS: 00010206
    RAX: 00007ff24c9190e8  RBX: ffff9d56733c1c80  RCX: 00000074a1ab6020
    RDX: 0000000000000000  RSI: ffffab0927fefe40  RDI: ffff9d56733c1c80
    RBP: ffffab0927fefeb8   R8: ffff9d476014e400   R9: ffffffff99afa120
    R10: ffffab0927fefd38  R11: ffffab0927fefd40  R12: 0000000000000002
    R13: 00007ff24c70357b  R14: ffffab0927feff58  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#14 [ffffab0927fefe10] rseq_get_rseq_cs at ffffffff97d30a9d
#15 [ffffab0927fefe38] rseq_ip_fixup at ffffffff97d30d16
#16 [ffffab0927fefec0] __rseq_handle_notify_resume at ffffffff97d31216
#17 [ffffab0927fefed8] exit_to_user_mode_loop at ffffffff97bc3f09
#18 [ffffab0927fefef8] exit_to_user_mode_prepare at ffffffff97bc4026
#19 [ffffab0927feff10] syscall_exit_to_user_mode at ffffffff986a31f2
#20 [ffffab0927feff20] do_syscall_64 at ffffffff9869e46b
#21 [ffffab0927feff50] entry_SYSCALL_64_after_hwframe at ffffffff988000e6
    RIP: 00007ff24c70357b  RSP: 00007ffde2a53378  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 0000000000434790  RCX: 00007ff24c70357b
    RDX: 0000000004a75c54  RSI: 0000000000005437  RDI: 000000000000000a
    RBP: 0000000000000007   R8: 00000000295d6934   R9: 0000000000000000
    R10: 00007ffde2b13170  R11: 0000000000000246  R12: 000000000000000a
    R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000003
    ORIG_RAX: 0000000000000010  CS: 0033  SS: 002b

---- SECOND TRACE ----

[ 2680.882153] watchdog: BUG: soft lockup - CPU#5 stuck for 26s! [migration/5:49] 
[ 2680.882157] Modules linked in: n_gsm pps_ldisc slcan can_dev ppp_synctty n_hdlc ppp_async ppp_generic slip slhc serport nfsv3 nfs_acl tun brd overlay exfat vfat fat loop ext4 mbcache jbd2 tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs sunrpc intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel dell_wmi_descriptor sparse_keymap kvm ipmi_ssif rfkill video mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper cdc_ether iTCO_wdt rapl syscopyarea usbnet ipmi_si iTCO_vendor_support sysfillrect ipmi_devintf mii intel_cstate mei_me ipmi_msghandler dcdbas sysimgblt mei lpc_ich intel_uncore fb_sys_fops mxm_wmi ioatdma pcspkr acpi_power_meter drm fuse xfs libcrc32c ahci qede libahci sd_mod t10_pi crct10dif_pclmul crc32_pclmul sg ixgbe qed libata crc32c_intel megaraid_sas tg3 ghash_clmulni_intel mdio crc8 dca wmi dm_mirror dm_region_hash dm_log dm_mod [last unloaded: hwpoison_inject] 
[ 2680.882211] CPU: 5 PID: 49 Comm: migration/5 Kdump: loaded Tainted: G           OE  X  -------  ---  5.14.0-458.4417_1319993482.el9.x86_64 #1 
[ 2680.882214] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.12.1 12/04/2020 
[ 2680.882215] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xb4/0x110 
[ 2680.882225] RIP: 0010:multi_cpu_stop+0x94/0x100 
[ 2680.882228] Code: ff 4d 00 75 0f 8b 43 20 8b 4b 10 83 c0 01 89 4b 24 89 43 20 e8 0d 21 fa ff 41 83 ff 04 74 2e 45 89 fc 4c 89 ef e8 4c ff ff ff <44> 8b 7b 20 45 39 fc 75 aa 41 83 ff 01 76 0a e8 e8 09 02 00 e8 b3 
[ 2680.882230] RSP: 0000:ffffade1066d7e78 EFLAGS: 00000246 
[ 2680.882232] RAX: 0000000000000000 RBX: ffffade108f57988 RCX: 0000000000000002 
[ 2680.882233] RDX: 0000000000000004 RSI: ffffade108f579b0 RDI: ffffffffac432e60 
[ 2680.882235] RBP: ffffade108f579ac R08: ffff897b7f8a41d0 R09: ffff896bd16f3800 
[ 2680.882236] R10: 00000000000002f8 R11: 0000000000000001 R12: 0000000000000001 
[ 2680.882237] R13: ffffffffac432e60 R14: 0000000000000000 R15: 0000000000000001 
[ 2680.882238] FS:  0000000000000000(0000) GS:ffff897b7f880000(0000) knlGS:0000000000000000 
[ 2680.882240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 2680.882241] CR2: 00007f0069887fe8 CR3: 000000108a7ba004 CR4: 00000000001706f0 
[ 2680.882243] Call Trace: 
[ 2680.882245]  <IRQ> 
[ 2680.882246]  ? show_trace_log_lvl+0x1c4/0x2df 
[ 2680.882250]  ? show_trace_log_lvl+0x1c4/0x2df 
[ 2680.882252]  ? cpu_stopper_thread+0x93/0x140 
[ 2680.882255]  ? watchdog_timer_fn+0x1ad/0x210 
[ 2680.882258]  ? __pfx_watchdog_timer_fn+0x10/0x10 
[ 2680.882261]  ? __hrtimer_run_queues+0x112/0x2b0 
[ 2680.882266]  ? hrtimer_interrupt+0xfc/0x210 
[ 2680.882270]  ? __sysvec_apic_timer_interrupt+0x4e/0x100 
[ 2680.882274]  ? sysvec_apic_timer_interrupt+0x6d/0x90 
[ 2680.882278]  </IRQ> 
[ 2680.882279]  <TASK> 
[ 2680.882280]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20 
[ 2680.882285]  ? multi_cpu_stop+0x94/0x100 
[ 2680.882287]  ? multi_cpu_stop+0x94/0x100 
[ 2680.882289]  ? __pfx_multi_cpu_stop+0x10/0x10 
[ 2680.882292]  cpu_stopper_thread+0x93/0x140 
[ 2680.882294]  ? __pfx_smpboot_thread_fn+0x10/0x10 
[ 2680.882299]  smpboot_thread_fn+0xd6/0x1a0 
[ 2680.882302]  kthread+0xe0/0x100 
[ 2680.882305]  ? __pfx_kthread+0x10/0x10 
[ 2680.882308]  ret_from_fork+0x2c/0x50 
[ 2680.882312]  </TASK>

---- THIRD TRACE ----
 7602.894128] Modules linked in: n_gsm pps_ldisc slcan can_dev ppp_synctty n_hdlc ppp_async ppp_generic slip slhc serport rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel vfat fat ipmi_ssif kvm rapl pmt_telemetry iTCO_wdt dax_hmem intel_cstate mei_me iTCO_vendor_support pmt_class intel_sdsi cxl_acpi dcdbas mgag200 dell_smbios cxl_core isst_if_mbox_pci isst_if_mmio i2c_i801 acpi_power_meter intel_uncore mei einj dell_wmi_descriptor pcspkr wmi_bmof intel_vsec i2c_ismt i2c_algo_bit isst_if_common i2c_smbus ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs iaa_crypto nvme ahci crct10dif_pclmul libahci crc32_pclmul nvme_core crc32c_intel idxd libata ghash_clmulni_intel idxd_bus tg3 nvme_auth wmi t10_pi pinctrl_emmitsburg dm_mirror dm_region_hash dm_log dm_mod
[ 7602.894175] CPU: 63 PID: 402 Comm: migration/63 Kdump: loaded Not tainted 6.10.0-0.rc3.f8dba31b0a82.33.test.eln137.x86_64 #1
[ 7602.894178] Hardware name: Dell Inc. PowerEdge R760/030NDG, BIOS 1.4.4 05/15/2023
[ 7602.894179] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xa9/0x130
[ 7602.894188] RIP: 0010:stop_machine_yield+0x6/0x10
[ 7602.894191] Code: ff ff eb df e8 bb 85 bb 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 f3 90 <c3> cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
[ 7602.894193] RSP: 0000:ff75cb01445efe38 EFLAGS: 00000246
[ 7602.894195] RAX: 0000000000000000 RBX: ff75cb014c103b78 RCX: ff4186fcaeba5650
[ 7602.894197] RDX: ff4186fcaeb80000 RSI: ff75cb014c103bd0 RDI: ffffffff8e039ce0
[ 7602.894197] RBP: ff75cb014c103b9c R08: 00000000000001cc R09: 0000000000000000
[ 7602.894198] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[ 7602.894199] R13: ffffffff8e039ce0 R14: 0000000000000001 R15: ffffffff8d044700
[ 7602.894200] FS:  0000000000000000(0000) GS:ff4186fcaeb80000(0000) knlGS:0000000000000000
[ 7602.894201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7602.894203] CR2: 0000000000434ea4 CR3: 0000000159c08004 CR4: 0000000000f71ef0
[ 7602.894204] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7602.894204] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 7602.894205] PKRU: 55555554
[ 7602.894206] Call Trace:
[ 7602.894207]  <IRQ>
[ 7602.894209]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 7602.894212]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 7602.894215]  ? multi_cpu_stop+0x99/0x100
[ 7602.894217]  ? watchdog_timer_fn.cold+0x3d/0xa0
[ 7602.894220]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 7602.894223]  ? __hrtimer_run_queues+0x139/0x2a0
[ 7602.894226]  ? hrtimer_interrupt+0xfa/0x210
[ 7602.894228]  ? __sysvec_apic_timer_interrupt+0x52/0x100
[ 7602.894230]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[ 7602.894234]  </IRQ>
[ 7602.894234]  <TASK>
[ 7602.894235]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 7602.894239]  ? stop_one_cpu+0xb0/0xe0
[ 7602.894242]  ? stop_machine_yield+0x6/0x10
[ 7602.894245]  multi_cpu_stop+0x99/0x100
[ 7602.894247]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 7602.894249]  cpu_stopper_thread+0x94/0x150
[ 7602.894252]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 7602.894255]  smpboot_thread_fn+0xda/0x1d0
[ 7602.894257]  kthread+0xcf/0x100
[ 7602.894260]  ? __pfx_kthread+0x10/0x10
[ 7602.894261]  ret_from_fork+0x31/0x50
[ 7602.894265]  ? __pfx_kthread+0x10/0x10
[ 7602.894267]  ret_from_fork_asm+0x1a/0x30
[ 7602.894270]  </TASK>
[ 7630.894558] watchdog: BUG: soft lockup - CPU#63 stuck for 48s! [migration/63:402]
[ 7630.894561] Modules linked in: n_gsm pps_ldisc slcan can_dev ppp_synctty n_hdlc ppp_async ppp_generic slip slhc serport rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel vfat fat ipmi_ssif kvm rapl pmt_telemetry iTCO_wdt dax_hmem intel_cstate mei_me iTCO_vendor_support pmt_class intel_sdsi cxl_acpi dcdbas mgag200 dell_smbios cxl_core isst_if_mbox_pci isst_if_mmio i2c_i801 acpi_power_meter intel_uncore mei einj dell_wmi_descriptor pcspkr wmi_bmof intel_vsec i2c_ismt i2c_algo_bit isst_if_common i2c_smbus ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs iaa_crypto nvme ahci crct10dif_pclmul libahci crc32_pclmul nvme_core crc32c_intel idxd libata ghash_clmulni_intel idxd_bus tg3 nvme_auth wmi t10_pi pinctrl_emmitsburg dm_mirror dm_region_hash dm_log dm_mod
[ 7630.894585] CPU: 63 PID: 402 Comm: migration/63 Kdump: loaded Tainted: G             L    -------  ---  6.10.0-0.rc3.f8dba31b0a82.33.test.eln137.x86_64 #1
[ 7630.894587] Hardware name: Dell Inc. PowerEdge R760/030NDG, BIOS 1.4.4 05/15/2023
[ 7630.894587] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xa9/0x130
[ 7630.894592] RIP: 0010:stop_machine_yield+0x6/0x10
[ 7630.894594] Code: ff ff eb df e8 bb 85 bb 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 f3 90 <c3> cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
[ 7630.894595] RSP: 0000:ff75cb01445efe38 EFLAGS: 00000246
[ 7630.894597] RAX: 0000000000000000 RBX: ff75cb014c103b78 RCX: ff4186fcaeba5650
[ 7630.894598] RDX: ff4186fcaeb80000 RSI: ff75cb014c103bd0 RDI: ffffffff8e039ce0
[ 7630.894599] RBP: ff75cb014c103b9c R08: 00000000000001cc R09: 0000000000000000
[ 7630.894600] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[ 7630.894601] R13: ffffffff8e039ce0 R14: 0000000000000001 R15: ffffffff8d044700
[ 7630.894602] FS:  0000000000000000(0000) GS:ff4186fcaeb80000(0000) knlGS:0000000000000000
[ 7630.894603] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7630.894604] CR2: 0000000000434ea4 CR3: 0000000159c08004 CR4: 0000000000f71ef0
[ 7630.894605] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7630.894606] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 7630.894607] PKRU: 55555554
[ 7630.894607] Call Trace:
[ 7630.894608]  <IRQ>
[ 7630.894608]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 7630.894611]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 7630.894613]  ? multi_cpu_stop+0x99/0x100
[ 7630.894615]  ? watchdog_timer_fn.cold+0x3d/0xa0
[ 7630.894617]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 7630.894620]  ? __hrtimer_run_queues+0x139/0x2a0
[ 7630.894621]  ? hrtimer_interrupt+0xfa/0x210
[ 7630.894623]  ? __sysvec_apic_timer_interrupt+0x52/0x100
[ 7630.894625]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[ 7630.894627]  </IRQ>
[ 7630.894628]  <TASK>
[ 7630.894628]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 7630.894631]  ? stop_one_cpu+0xb0/0xe0
[ 7630.894634]  ? stop_machine_yield+0x6/0x10
[ 7630.894636]  multi_cpu_stop+0x99/0x100
[ 7630.894638]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 7630.894640]  cpu_stopper_thread+0x94/0x150
[ 7630.894642]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 7630.894644]  smpboot_thread_fn+0xda/0x1d0
[ 7630.894646]  kthread+0xcf/0x100
[ 7630.894647]  ? __pfx_kthread+0x10/0x10
[ 7630.894649]  ret_from_fork+0x31/0x50
[ 7630.894651]  ? __pfx_kthread+0x10/0x10
[ 7630.894653]  ret_from_fork_asm+0x1a/0x30
[ 7630.894655]  </TASK>
[ 7658.894993] watchdog: BUG: soft lockup - CPU#63 stuck for 74s! [migration/63:402]
[ 7658.894996] Modules linked in: n_gsm pps_ldisc slcan can_dev ppp_synctty n_hdlc ppp_async ppp_generic slip slhc serport rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel vfat fat ipmi_ssif kvm rapl pmt_telemetry iTCO_wdt dax_hmem intel_cstate mei_me iTCO_vendor_support pmt_class intel_sdsi cxl_acpi dcdbas mgag200 dell_smbios cxl_core isst_if_mbox_pci isst_if_mmio i2c_i801 acpi_power_meter intel_uncore mei einj dell_wmi_descriptor pcspkr wmi_bmof intel_vsec i2c_ismt i2c_algo_bit isst_if_common i2c_smbus ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs iaa_crypto nvme ahci crct10dif_pclmul libahci crc32_pclmul nvme_core crc32c_intel idxd libata ghash_clmulni_intel idxd_bus tg3 nvme_auth wmi t10_pi pinctrl_emmitsburg dm_mirror dm_region_hash dm_log dm_mod
[ 7658.895019] CPU: 63 PID: 402 Comm: migration/63 Kdump: loaded Tainted: G             L    -------  ---  6.10.0-0.rc3.f8dba31b0a82.33.test.eln137.x86_64 #1
[ 7658.895021] Hardware name: Dell Inc. PowerEdge R760/030NDG, BIOS 1.4.4 05/15/2023
[ 7658.895022] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xa9/0x130
[ 7658.895025] RIP: 0010:rcu_momentary_dyntick_idle+0xc/0x50
[ 7658.895027] Code: e9 e9 ee fe ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 c6 05 18 a4 05 73 00 <65> 48 8b 15 14 d6 03 73 b8 08 00 00 00 f0 0f c1 82 c8 05 03 00 a8
[ 7658.895029] RSP: 0000:ff75cb01445efe38 EFLAGS: 00000246
[ 7658.895030] RAX: 0000000000000000 RBX: ff75cb014c103b78 RCX: ff4186fcaeba5650
[ 7658.895031] RDX: ff4186fcaeb80000 RSI: ff75cb014c103bd0 RDI: ffffffff8e039ce0
[ 7658.895032] RBP: ff75cb014c103b9c R08: 00000000000001cc R09: 0000000000000000
[ 7658.895032] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[ 7658.895033] R13: ffffffff8e039ce0 R14: 0000000000000001 R15: ffffffff8d044700
[ 7658.895034] FS:  0000000000000000(0000) GS:ff4186fcaeb80000(0000) knlGS:0000000000000000
[ 7658.895035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7658.895036] CR2: 0000000000434ea4 CR3: 0000000159c08004 CR4: 0000000000f71ef0
[ 7658.895037] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7658.895037] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 7658.895038] PKRU: 55555554
[ 7658.895039] Call Trace:
[ 7658.895039]  <IRQ>
[ 7658.895040]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 7658.895042]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 7658.895044]  ? multi_cpu_stop+0xb7/0x100
[ 7658.895047]  ? watchdog_timer_fn.cold+0x3d/0xa0
[ 7658.895048]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 7658.895051]  ? __hrtimer_run_queues+0x139/0x2a0
[ 7658.895052]  ? hrtimer_interrupt+0xfa/0x210
[ 7658.895054]  ? __sysvec_apic_timer_interrupt+0x52/0x100
[ 7658.895055]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[ 7658.895058]  </IRQ>
[ 7658.895058]  <TASK>
[ 7658.895059]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 7658.895061]  ? stop_one_cpu+0xb0/0xe0
[ 7658.895064]  ? rcu_momentary_dyntick_idle+0xc/0x50
[ 7658.895066]  multi_cpu_stop+0xb7/0x100
[ 7658.895068]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 7658.895070]  cpu_stopper_thread+0x94/0x150
[ 7658.895072]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 7658.895074]  smpboot_thread_fn+0xda/0x1d0
[ 7658.895075]  kthread+0xcf/0x100
[ 7658.895077]  ? __pfx_kthread+0x10/0x10
[ 7658.895079]  ret_from_fork+0x31/0x50
[ 7658.895081]  ? __pfx_kthread+0x10/0x10
[ 7658.895083]  ret_from_fork_asm+0x1a/0x30
[ 7658.895085]  </TASK>

---- FOURTH TRACE ----
kernel.softlockup_all_cpu_backtrace set to 1

kudos to Andrew Halaney <ahalaney@redhat.com> for this trace + investigation 

[30435.183265] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
[30435.183266] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xa9/0x130
[30435.183276] RIP: 0010:rcu_momentary_dyntick_idle+0x21/0x50
[30435.183279] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 c6 05 38 c4 45 47 00 65 48 8b 15 34 f6 43 47 b8 08 00 00 00 f0 0f c1 82 c8 05 03 00 <a8> 04 74 0d 65 48 8b 3d 03 a5 45 47 e9 ce fe ff ff 0f 0b 65 48 8b
[30435.183282] RSP: 0000:ffffa96f469dbe38 EFLAGS: 00000212
[30435.183284] RAX: 00000000457705fc RBX: ffffa96f6bebbb78 RCX: ffff8c81bef25650
[30435.183286] RDX: ffff8c81bef00000 RSI: ffffa96f6bebbbd0 RDI: ffffffffb9a328e0
[30435.183287] RBP: ffffa96f6bebbb9c R08: 0000000000000155 R09: 0000000000000000
[30435.183288] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[30435.183289] R13: ffffffffb9a328e0 R14: 0000000000000001 R15: ffffffffb8c41a00
[30435.183290] FS:  0000000000000000(0000) GS:ffff8c81bef00000(0000) knlGS:0000000000000000
[30435.183292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[30435.183293] CR2: 0000000000434ea4 CR3: 0000000284088006 CR4: 00000000001706f0
[30435.183294] Call Trace:
[30435.183296]  <IRQ>
[30435.183297]  ? show_trace_log_lvl+0x1b0/0x2f0
[30435.183302]  ? show_trace_log_lvl+0x1b0/0x2f0
[30435.183305]  ? multi_cpu_stop+0xb7/0x100
[30435.183307]  ? watchdog_timer_fn.cold+0x3d/0xa0
[30435.183311]  ? __pfx_watchdog_timer_fn+0x10/0x10
[30435.183315]  ? __hrtimer_run_queues+0x13c/0x2a0
[30435.183318]  ? hrtimer_interrupt+0xfa/0x210
[30435.183321]  ? __sysvec_apic_timer_interrupt+0x55/0x100
[30435.183323]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[30435.183327]  </IRQ>
[30435.183328]  <TASK>
[30435.183329]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[30435.183339]  ? __pfx_multi_cpu_stop+0x10/0x10
[30435.183342]  ? rcu_momentary_dyntick_idle+0x21/0x50
[30435.183344]  multi_cpu_stop+0xb7/0x100
[30435.183359]  ? __pfx_multi_cpu_stop+0x10/0x10
[30435.183361]  cpu_stopper_thread+0x97/0x150
[30435.183363]  ? __pfx_smpboot_thread_fn+0x10/0x10
[30435.183366]  smpboot_thread_fn+0xdd/0x1d0
[30435.183368]  kthread+0xd2/0x100
[30435.183371]  ? __pfx_kthread+0x10/0x10
[30435.183373]  ret_from_fork+0x34/0x50
[30435.183377]  ? __pfx_kthread+0x10/0x10
[30435.183379]  ret_from_fork_asm+0x1a/0x30
[30435.183382]  </TASK>
[30435.183384] Sending NMI from CPU 18 to CPUs 0-17,19-63:
[30435.183389] NMI backtrace for cpu 15
[30435.183392] CPU: 15 PID: 350429 Comm: pty03 Kdump: loaded Not tainted 6.10.0-0.rc2.28nbcontest.eln137.x86_64 #1
[30435.183396] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
[30435.183397] RIP: 0033:0x405f4f
[30435.183431] Code: 45 84 c0 0f 85 5c 01 00 00 8b 15 68 ef 02 00 8b 05 66 ef 02 00 39 c2 7d 22 8b 05 60 ef 02 00 85 c0 75 18 83 05 29 ef 02 00 01 <8b> 15 47 ef 02 00 8b 05 45 ef 02 00 39 c2 7c df 90 44 89 e1 31 d2
[30435.183433] RSP: 002b:00007fffd5cc4130 EFLAGS: 00000206
[30435.183436] RAX: 0000000000000000 RBX: 00000000004347f0 RCX: 000000000284a074
[30435.183439] RDX: 00000000000d15ca RSI: 0000000000434e28 RDI: 00007f4de8e5f1b8
[30435.183440] RBP: 0000000000000009 R08: 0000000000000000 R09: 00000000ffffffff
[30435.183442] R10: 0000000000000000 R11: 00007f4de8e5f178 R12: 0000000000000008
[30435.183444] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
[30435.183445] FS:  00007f4de8e53740 GS:  0000000000000000
[30435.183448] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x59/0xa0
...
[30435.183608] NMI backtrace for cpu 9
[30435.183610] CPU: 9 PID: 18 Comm: pr/ttyS0 Kdump: loaded Not tainted 6.10.0-0.rc2.28nbcontest.eln137.x86_64 #1
[30435.183613] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
[30435.183615] RIP: 0010:io_serial_in+0x1a/0x30
[30435.183620] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 0f b6 87 c1 00 00 00 c4 e2 79 f7 d6 66 03 57 08 ec <0f> b6 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
[30435.183622] RSP: 0018:ffffa96f4431fd58 EFLAGS: 00000002
[30435.183624] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000009
[30435.183625] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffbb990b60
[30435.183626] RBP: 000000000000270a R08: 00000000000008f7 R09: 0000000000000009
[30435.183628] R10: ffffa96f4431fd38 R11: 6465646461207070 R12: 0000000000000020
[30435.183629] R13: ffffffffbb990b60 R14: 0000000000000005 R15: 0000000000000032
[30435.183630] FS:  0000000000000000(0000) GS:ffff8c71bf480000(0000) knlGS:0000000000000000
[30435.183632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[30435.183633] CR2: 00007f16ec050330 CR3: 000000000b420005 CR4: 00000000001706f0
[30435.183634] Call Trace:
[30435.183636]  <NMI>
[30435.183637]  ? show_trace_log_lvl+0x1b0/0x2f0
[30435.183642]  ? show_trace_log_lvl+0x1b0/0x2f0
[30435.183645]  ? wait_for_xmitr+0x4a/0xc0
[30435.183647]  ? nmi_cpu_backtrace.cold+0x32/0x63
[30435.183651]  ? nmi_cpu_backtrace_handler+0x11/0x20
[30435.183655]  ? nmi_handle+0x61/0x120
[30435.183659]  ? default_do_nmi+0x40/0x130
[30435.183662]  ? exc_nmi+0x103/0x180
[30435.183665]  ? end_repeat_nmi+0xf/0x53
[30435.183668]  ? io_serial_in+0x1a/0x30
[30435.183671]  ? io_serial_in+0x1a/0x30
[30435.183674]  ? io_serial_in+0x1a/0x30
[30435.183676]  </NMI>
[30435.183677]  <TASK>
[30435.183677]  wait_for_xmitr+0x4a/0xc0
[30435.183679]  serial8250_console_putchar+0x1a/0x40
[30435.183681]  ? __pfx_serial8250_console_putchar+0x10/0x10
[30435.183682]  uart_console_write+0x47/0x60
[30435.183686]  serial8250_console_write_thread+0xec/0x1d0
[30435.183688]  nbcon_emit_next_record+0x1b9/0x270
[30435.183692]  nbcon_kthread_func+0x1ff/0x260
[30435.183695]  ? __pfx_nbcon_kthread_func+0x10/0x10
[30435.183697]  kthread+0xd2/0x100
[30435.183700]  ? __pfx_kthread+0x10/0x10
[30435.183702]  ret_from_fork+0x34/0x50
[30435.183705]  ? __pfx_kthread+0x10/0x10
[30435.183707]  ret_from_fork_asm+0x1a/0x30
[30435.183710]  </TASK>
...
[30435.183893] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x59/0xa0
[30435.183899] NMI backtrace for cpu 17
[30435.183903] CPU: 17 PID: 1312 Comm: systemd-udevd Kdump: loaded Not tainted 6.10.0-0.rc2.28nbcontest.eln137.x86_64 #1
[30435.183907] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
[30435.183909] RIP: 0033:0x5635e2eee50e
[30435.183928] Code: 8b 9b 80 00 00 00 83 78 10 01 75 e0 48 8b 85 78 ff ff ff 48 8b 08 48 85 c9 0f 84 2d 08 00 00 48 8b 85 78 ff ff ff 48 8b 50 30 <48> 8b 40 28 48 39 c2 0f 87 35 08 00 00 48 8b b5 78 ff ff ff 48 83
[30435.183931] RSP: 002b:00007ffc66ab47f0 EFLAGS: 00000206
[30435.183934] RAX: 0000563600dcc7e0 RBX: 0000563600797130 RCX: 00005636006cda60
[30435.183936] RDX: 0000000011d07ae3 RSI: 0000000000000000 RDI: 0000000000000007
[30435.183938] RBP: 00007ffc66ab4890 R08: 00005635e2f1eef0 R09: 00007ffc66ab46d0
[30435.183940] R10: 0000000000000000 R11: 0000000000000000 R12: 000056360136bee0
[30435.183942] R13: 0000563601d38610 R14: 000056360097a330 R15: 00005635e2f1d95b
[30435.183944] FS:  00007fa9bcb24b40 GS:  0000000000000000
[30435.184389] Kernel panic - not syncing: softlockup: hung tasks
[30509.409049] CPU: 18 PID: 130 Comm: migration/18 Kdump: loaded Tainted: G             L    -------  ---  6.10.0-0.rc2.28nbcontest.eln137.x86_64 #1
[30509.423608] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
[30509.435255] Stopper: multi_cpu_stop+0x0/0x100 <- migrate_swap+0xa9/0x130
[30509.442738] Call Trace:
[30509.445463]  <IRQ>
[30509.447705]  dump_stack_lvl+0x4e/0x70
[30509.451785]  panic+0x113/0x2c8
[30509.455194]  watchdog_timer_fn.cold+0x99/0xa0
[30509.460047]  ? __pfx_watchdog_timer_fn+0x10/0x10
[30509.465200]  __hrtimer_run_queues+0x13c/0x2a0
[30509.470061]  hrtimer_interrupt+0xfa/0x210
[30509.474542]  __sysvec_apic_timer_interrupt+0x55/0x100
[30509.480178]  sysvec_apic_timer_interrupt+0x6c/0x90
[30509.485537]  </IRQ>
[30509.487873]  <TASK>
[30509.490210]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[30509.495947] RIP: 0010:rcu_momentary_dyntick_idle+0x21/0x50
[30509.502068] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 c6 05 38 c4 45 47 00 65 48 8b 15 34 f6 43 47 b8 08 00 00 00 f0 0f c1 82 c8 05 03 00 <a8> 04 74 0d 65 48 8b 3d 03 a5 45 47 e9 ce fe ff ff 0f 0b 65 48 8b
[30509.523024] RSP: 0000:ffffa96f469dbe38 EFLAGS: 00000212
[30509.528854] RAX: 00000000457705fc RBX: ffffa96f6bebbb78 RCX: ffff8c81bef25650
[30509.536821] RDX: ffff8c81bef00000 RSI: ffffa96f6bebbbd0 RDI: ffffffffb9a328e0
[30509.544794] RBP: ffffa96f6bebbb9c R08: 0000000000000155 R09: 0000000000000000
[30509.552755] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[30509.560716] R13: ffffffffb9a328e0 R14: 0000000000000001 R15: ffffffffb8c41a00
[30509.568678]  ? __pfx_multi_cpu_stop+0x10/0x10
[30509.573542]  multi_cpu_stop+0xb7/0x100
[30509.577735]  ? __pfx_multi_cpu_stop+0x10/0x10
[30509.582594]  cpu_stopper_thread+0x97/0x150
[30509.587163]  ? __pfx_smpboot_thread_fn+0x10/0x10
[30509.592315]  smpboot_thread_fn+0xdd/0x1d0
[30509.596795]  kthread+0xd2/0x100
[30509.600298]  ? __pfx_kthread+0x10/0x10
[30509.604479]  ret_from_fork+0x34/0x50
[30509.608468]  ? __pfx_kthread+0x10/0x10
[30509.612649]  ret_from_fork_asm+0x1a/0x30
[30509.617025]  </TASK>

