From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Wed, 8 Feb 2017 15:01:09 -0500
Message-ID: <20170208150109.5919a2ea@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed,  8 Feb 2017 11:24:56 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

>     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
>                            pid=sched_switch:woken_pid \
>                            prio=sched_switch:woken_prio' >> \
>             /sys/kernel/debug/tracing/synthetic_events

I applied all your patches, did the above and then:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
 IP: free_synthetic_event+0x46/0xb0
 PGD 0 
 
 Oops: 0000 [#1] SMP
 Modules linked in: ip6table_filter ip6_tables x86_pkg_temp_thermal kvm_intel kvm snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core irqbypass snd_seq snd_seq_device snd_pcm snd_timer snd i2c_i801 soundcore wmi i915 i2c_algo_bit drm_kms_helper e1000e syscopyarea sysfillrect sysimgblt fb_sys_fops ptp drm pps_core i2c_core video
 CPU: 0 PID: 1389 Comm: bash Not tainted 4.10.0-rc2-test+ #36
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v02.05 05/07/2012
 task: ffff8800c8c48000 task.stack: ffffc90000a00000
 RIP: 0010:free_synthetic_event+0x46/0xb0
 RSP: 0018:ffffc90000a03cf8 EFLAGS: 00010282
 RAX: 0000000015675b00 RBX: ffff8800ccf4bcd0 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffffc90000a03d18 R08: 0000000000000000 R09: ffff8800ccea7c6c
 R10: 000000000000003d R11: ffff8800c8c48000 R12: 0000000000000001
 R13: ffff8800c8ca6000 R14: ffff8800ccea7d88 R15: 0000000000000001
 FS:  00007fde7acdb700(0000) GS:ffff88011ea00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000034 CR3: 00000000ccc44000 CR4: 00000000001406f0
 Call Trace:
  create_synthetic_event+0xcb/0x580
  ? parse_var_ref+0x120/0x120
  trace_run_command+0x5f/0x70
  trace_parse_run_command+0x76/0x150
  ? parse_var_ref+0x120/0x120
  synthetic_events_write+0x10/0x20
  __vfs_write+0x28/0x140
  ? vmacache_find+0xcc/0x180
  ? rw_verify_area+0xd8/0x190
  ? _cond_resched+0x2e/0x50
  ? __sb_start_write+0x82/0xe0
  vfs_write+0x138/0x260
  SyS_write+0x4f/0xa0
  entry_SYSCALL_64_fastpath+0x13/0x94


Anyway, I kinda like the approach. I'll go patch by patch to see what
you did and maybe even take a few now, if they seem appropriate as
helpers.

-- Steve
