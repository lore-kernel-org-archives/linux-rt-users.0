From: Li Zefan <lizefan@huawei.com>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Tue, 23 Apr 2013 13:51:58 +0800
Message-ID: <5176217E.8030008@huawei.com>
References: <5170F28F.3060002@huawei.com> <51750563.8050301@huawei.com> <1366646447.9609.131.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Qiang Huang <h.huangqiang@huawei.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:52924 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3DWFwY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Apr 2013 01:52:24 -0400
In-Reply-To: <1366646447.9609.131.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013/4/23 0:00, Steven Rostedt wrote:
> On Mon, 2013-04-22 at 17:39 +0800, Li Zefan wrote:
>> On 2013/4/19 15:30, Qiang Huang wrote:
>>> Hi,
>>>
>>> I ran cgroup_fj tests on RT kernel with PREEMPT_RT_FULL disabled, it will
>>> stick the system when ran cpuset stress tests, it happens everytime.
>>>
>>> Here stick the system means there are almost no response from the system and
>>> we can hardly do anything on the terminal, but kernel isn't crash nor deadlocked
>>> (according to the lockdep message), and it may do some response sometimes.
>>>
>>> The problem exists on all RT versions from 3.4.18-rt29 to 3.4.37-rt51 AFAIK, but
>>> without RT patches or with PREEMPT_RT_FULL enabled, the problem isn't exists.
>>>
>>> When the system is stuck, we will get the following message:
>>> # dmesg
>>> ...
>>
>> I've found the culprit after some investigation:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Fri, 04 Nov 2011 19:48:36 +0000
>> Subject: sched-clear-pf-thread-bound-on-fallback-rq.patch
>>
>> At system boot when some cpus haven't been up, the scheduler calls select_fallback_rq()
>> and schedules tasks in other cpus, which ends up clearing some kernel threads'
>> PF_THREAD_BOUND flag...
> 
> I'm curious to why this doesn't break when PREEMPT_RT_FULL is enabled. I
> would think it would also cause issues there too.
> 

I was wrong in saying that PF_THREAD_BOUND is cleared because some cpus are not
online yet. It's because select_task_rq_fair() just returns prev_cpu, which is
task_cpu(p), which is 0 during system boot or some other cpu after boot, which
is not in tsk_cpus_allowed, so select_fallback_rq() is called and it clears
PF_THREAD_BOUND.

I don't know why it didn't cause trouble when RT_FULL is enabled for Huang Qiang,
but I did encoutner problems when testing in my box.

I can trigger the bug with cgroup_fj.sh, or with taskset:

  # for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done

But system hung or tasks hung may not happen right in the test, but will happen
after some random operations (try compile kernel).

And while running test I saw lots of warnings like this:

[  146.702056] BUG: using smp_processor_id() in preemptible [00000000 00000000] code: kworker/
4:0/23
[  146.702069] caller is vmstat_update+0x22/0x60
[  146.702075] Pid: 23, comm: kworker/4:0 Not tainted 3.4.24.05+ #49
[  146.702077] Call Trace:
[  146.702087]  [<ffffffff8125f685>] debug_smp_processor_id+0x145/0x150
[  146.702091]  [<ffffffff8113c872>] vmstat_update+0x22/0x60
[  146.702097]  [<ffffffff81061033>] process_one_work+0x203/0x610
[  146.702101]  [<ffffffff81060f70>] ? process_one_work+0x140/0x610
[  146.702105]  [<ffffffff81061fdd>] ? worker_thread+0x6d/0x450
[  146.702109]  [<ffffffff8113c850>] ? refresh_cpu_vm_stats+0x1d0/0x1d0
[  146.702114]  [<ffffffff81062116>] worker_thread+0x1a6/0x450
[  146.702118]  [<ffffffff81061f70>] ? manage_workers+0x250/0x250
[  146.702122]  [<ffffffff810680f6>] kthread+0xb6/0xc0
[  146.702130]  [<ffffffff81474ab4>] kernel_thread_helper+0x4/0x10
[  146.702137]  [<ffffffff81076930>] ? finish_task_switch+0x90/0x100
[  146.702142]  [<ffffffff8146bb34>] ? retint_restore_args+0x13/0x13
[  146.702145]  [<ffffffff81068040>] ? kthreadd+0x310/0x310
[  146.702149]  [<ffffffff81474ab0>] ? gs_change+0x13/0x13

and after a while those warnings stopped, instead warnings like this popped up,
even after I stopped the test:

[  252.896103] ------------[ cut here ]------------
[  252.896107] WARNING: at kernel/cpu.c:157 unpin_current_cpu+0x7d/0x90()
[  252.896110] Hardware name: Tecal RH2285
[  252.896112] Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi bridge
ipv6 stp llc cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf binfm
t_misc fuse loop dm_mod tpm_tis tpm coretemp crc32c_intel ghash_clmulni_intel aesni_intel sg s
erio_raw cryptd aes_x86_64 tpm_bios microcode i2c_i801 iTCO_wdt i2c_core bnx2 iTCO_vendor_supp
ort mptctl button usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10dif edd ext3 m
bcache jbd fan processor ide_pci_generic ide_core ata_generic ata_piix libata mptsas mptscsih
mptbase scsi_transport_sas scsi_mod thermal thermal_sys hwmon
[  252.896201] Pid: 9893, comm: dmesg Tainted: G        W    3.4.24.05+ #49
[  252.896203] Call Trace:
[  252.896208]  [<ffffffff810404ed>] ? unpin_current_cpu+0x7d/0x90
[  252.896212]  [<ffffffff810404ed>] ? unpin_current_cpu+0x7d/0x90
[  252.896217]  [<ffffffff8103d83f>] warn_slowpath_common+0x7f/0xc0
[  252.896221]  [<ffffffff8103d89a>] warn_slowpath_null+0x1a/0x20
[  252.896226]  [<ffffffff810404ed>] unpin_current_cpu+0x7d/0x90
[  252.896231]  [<ffffffff81078ddb>] migrate_enable+0xeb/0x1e0
[  252.896235]  [<ffffffff81146b7b>] handle_pte_fault+0x34b/0x980
[  252.896240]  [<ffffffff81076431>] ? get_parent_ip+0x11/0x50
[  252.896244]  [<ffffffff81076431>] ? get_parent_ip+0x11/0x50
[  252.896250]  [<ffffffff811472fc>] handle_mm_fault+0x14c/0x1e0
[  252.896254]  [<ffffffff8146ef47>] do_page_fault+0x257/0x550
[  252.896260]  [<ffffffff8114c995>] ? do_mmap_pgoff+0x375/0x3a0
[  252.896264]  [<ffffffff8146bfb6>] ? error_sti+0x5/0x6
[  252.896269]  [<ffffffff81259175>] ? trace_hardirqs_off_thunk+0x3a/0x3c
[  252.896274]  [<ffffffff8146bd75>] page_fault+0x25/0x30
[  252.896277] ---[ end trace 000000000000ae6e ]---

I didn't see those warnings if !RT_FULL.

