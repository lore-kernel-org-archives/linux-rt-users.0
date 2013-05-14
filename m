From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Tue, 14 May 2013 10:08:21 -0300
Message-ID: <20130514130821.GA4591@uudg.org>
References: <5178F0DE.8030808@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:45068 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3ENNI1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 May 2013 09:08:27 -0400
Received: by mail-yh0-f50.google.com with SMTP id z20so76989yhz.9
        for <linux-rt-users@vger.kernel.org>; Tue, 14 May 2013 06:08:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5178F0DE.8030808@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 25, 2013 at 05:01:18PM +0800, Qiang Huang wrote:
| This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
| (commit 0d939066acdcb in v3.4-rt),.
| 
| Select_fallback_rq() can be easilly called during system boot, because
| select_task_rq_fair() just return task_cpu(p) for bounded kernel threads,
| which is 0 during system boot and not in tsk_cpus_allowed, so
| select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
| box, 1/3 bounded kernel threads will clear that flag after boot.
| 
| And it will cause problems, for example:
| # for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
| this command will cause system hung.
| 
| What's more, I don't see why we need to clear this flag any more,
| because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
| optimization for PF_THREAD_BOUND on migrate_disable/enable.
| 
| Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
| ---
|  kernel/sched/core.c |    6 ------
|  1 files changed, 0 insertions(+), 6 deletions(-)
| 
| diff --git a/kernel/sched/core.c b/kernel/sched/core.c
| index 751ec60..8db6e3b 100644
| --- a/kernel/sched/core.c
| +++ b/kernel/sched/core.c
| @@ -1327,12 +1327,6 @@ out:
|  		}
|  	}
| 
| -	/*
| -	 * Clear PF_THREAD_BOUND, otherwise we wreckage
| -	 * migrate_disable/enable. See optimization for
| -	 * PF_THREAD_BOUND tasks there.
| -	 */
| -	p->flags &= ~PF_THREAD_BOUND;
|  	return dest_cpu;
|  }
| 
| -- 1.7.1

Sorry for the late post on this thread, but I just saw two occurrences of
the Warning below (pretty close to the original report on this thread) on
3.8.11-rt8. As this patch solved/mitigated the issue on my 3.6-rt kernel, I
am trying it on 3.8.11-rt8.

The funny thing is that I was not running the cgroups_fj nor the shell
script reproducer, just using the box to browse the web and listen to
_good_ music.


[19806.691965] ------------[ cut here ]------------
[19806.691979] WARNING: at /home/lclaudio/SANDBOX/v2-devel/kernel/workqueue.c:1575 worker_enter_idle+0xd8/0x130()
[19806.691981] Hardware name: KQ260AA-AC4 a6540br
[19806.691984] Modules linked in: vfat fat fuse nf_conntrack_netbios_ns nf_conntrack_broadcast ipt_MASQUERADE ip6table_mangle ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 iptable_nat nf_nat_ipv4 nf_nat iptable_mangle nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ebtable_filter ebtables ip6table_filter ip6_tables ext3 jbd ext2 iTCO_wdt iTCO_vendor_support coretemp snd_hda_codec_realtek microcode snd_hda_intel snd_hda_codec snd_hwdep snd_seq serio_raw snd_seq_device snd_pcm snd_page_alloc pcspkr snd_timer i2c_i801 lpc_ich mfd_core snd r8169 soundcore mii nfsd auth_rpcgss nfs_acl lockd sunrpc vhost_net tun macvtap macvlan kvm_intel kvm binfmt_misc uinput usb_storage firewire_ohci firewire_core crc_itu_t i915 video i2c_algo_bit drm_kms_helper drm i2c_core
[19806.692131] Pid: 9609, comm: kworker/3:3 Not tainted 3.8.11-rt8+ #11
[19806.692134] Call Trace:
[19806.692142]  [<ffffffff81062c2f>] warn_slowpath_common+0x7f/0xc0
[19806.692145]  [<ffffffff81062c8a>] warn_slowpath_null+0x1a/0x20
[19806.692147]  [<ffffffff81080fa8>] worker_enter_idle+0xd8/0x130
[19806.692148]  [<ffffffff81083fa7>] worker_thread+0x1f7/0x440
[19806.692151]  [<ffffffff81083db0>] ? rescuer_thread+0x240/0x240
[19806.692153]  [<ffffffff8108a57d>] kthread+0xcd/0xe0
[19806.692156]  [<ffffffff8108a4b0>] ? kthread_create_on_node+0x140/0x140
[19806.692160]  [<ffffffff8166106c>] ret_from_fork+0x7c/0xb0
[19806.692162]  [<ffffffff8108a4b0>] ? kthread_create_on_node+0x140/0x140
[19806.692163] ---[ end trace 0000000000000002 ]---

-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

