From: Mike Galbraith <efault@gmx.de>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
Date: Sat, 18 Aug 2018 12:29:02 +0200
Message-ID: <1534588142.2516.10.camel@gmx.de>
References: <20180817162340.6e8482fd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817162340.6e8482fd@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2018-08-17 at 16:23 -0400, Steven Rostedt wrote:
> Pulling in stable releases into v4.14-rt I triggered this with my CPU
> hotplug test:
> 
> ------------[ cut here ]------------
> kernel BUG at /work/rt/stable-rt.git/kernel/sched/core.c:1639!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> Modules linked in: sunrpc ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables uinput snd_hda_codec_idt snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd shpchp i2c_i801 soundcore floppy i915 drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea i2c_algo_bit iosf_mbi video [last unloaded: speedstep_lib]
> CPU: 1 PID: 2944 Comm: mkdumprd Not tainted 4.14.63-test-rt40+ #782
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
> task: ffff880037888d80 task.stack: ffffc90000538000
> RIP: 0010:select_fallback_rq+0xc3/0x122

I noticed this upstream, and had started hunting for the origin, but
had thought that 4.14-rt was OK.  Clearly not the case, but it's not
4.14.60.. stable changes interacting badly either, virgin 4.14.59-rt37
just reproduced in a vm clone of my workstation.

	-Mike
