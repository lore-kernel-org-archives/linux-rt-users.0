From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Tue, 24 Feb 2015 13:19:22 -0300
Message-ID: <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	<1424785301.8767.11.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424785301.8767.11.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Feb 24, 2015 at 10:41 AM, Mike Galbraith
<umgwanakikbuti@gmail.com> wrote:
> locking, ww_mutex: fix ww_mutex vs self-deadlock
>
> If the caller already holds the mutex, task_blocks_on_rt_mutex()
> returns -EDEADLK, we proceed directly to rt_mutex_handle_deadlock()
> where it's instant game over.
>
> Let ww_mutexes return EDEADLK/EALREADY as they want to instead.
>
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---
>  kernel/locking/rtmutex.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c

The deadlock returned after I applied this patch in v3.18.7-rt2. Here is my log:

[  244.476210] BUG: scheduling while atomic: Xorg/1549/0x00000002
[  244.476258] Modules linked in: ctr ccm nouveau arc4 ath9k
ath9k_common ath9k_hw ath mac80211 uvcvideo snd_hda_codec_hdmi
videobuf2_vmalloc snd_hda_codec_realtek videobuf2_memops
videobuf2_core snd_hda_codec_generic v4l2_common snd_hda_intel
videodev mxm_wmi wmi i2c_algo_bit drm_kms_helper snd_hda_controller
snd_hda_codec ttm drm snd_pcm snd_hwdep snd_seq_midi
snd_seq_midi_event snd_rawmidi intel_rapl snd_seq bnep
x86_pkg_temp_thermal cfg80211 intel_powerclamp snd_timer mei_me
snd_seq_device rfcomm snd btusb mei joydev soundcore bluetooth
serio_raw mac_hid coretemp lpc_ich sony_laptop crc32_pclmul video
parport_pc ppdev lp parport firewire_ohci psmouse ahci sdhci_pci
firewire_core r8169 libahci sdhci mii crc_itu_t
[  244.476261] Preemption disabled at:[<c1685f5b>] rt_mutex_slowlock+0x3b/0x200
[  244.476262]
[  244.476263] CPU: 2 PID: 1549 Comm: Xorg Tainted: G        W
3.18.7-rt2-00002-g8c033b9 #3
[  244.476264] Hardware name: Sony Corporation VPCF215FB/VAIO, BIOS
R0200V3 02/10/2011
[  244.476271]  00000000 00000000 f1a5fc5c c1681e38 f1968f20 f1a5fc74
c167eacf c18f581c
[  244.476278]  c1685f5b c1685f5b 00000002 f1a5fcf8 c1684a3e f1a5fcfc
c187136c 0000001d
[  244.476287]  c1adabc0 c1adabc0 00000000 f168fc00 00000038 f1968f20
f7774bc0 f1968f20
[  244.476288] Call Trace:
[  244.476291]  [<c1681e38>] dump_stack+0x4b/0x88
[  244.476294]  [<c167eacf>] __schedule_bug+0x9e/0xac
[  244.476297]  [<c1685f5b>] ? rt_mutex_slowlock+0x3b/0x200
[  244.476300]  [<c1685f5b>] ? rt_mutex_slowlock+0x3b/0x200
[  244.476303]  [<c1684a3e>] __schedule+0x6ce/0x7a0
[  244.476306]  [<c105fb6b>] ? print_oops_end_marker+0x3b/0x40
[  244.476308]  [<c105fbff>] ? warn_slowpath_common+0x8f/0xa0
[  244.476311]  [<c167ec42>] ?
rt_mutex_handle_deadlock.isra.21.part.22+0x2f/0x48
[  244.476313]  [<c167ec42>] ?
rt_mutex_handle_deadlock.isra.21.part.22+0x2f/0x48
[  244.476315]  [<c1684b3b>] schedule+0x2b/0x90
[  244.476318]  [<c167ec59>] rt_mutex_handle_deadlock.isra.21.part.22+0x46/0x48
[  244.476320]  [<c168610d>] rt_mutex_slowlock+0x1ed/0x200
[  244.476322]  [<c10848eb>] ? get_parent_ip+0xb/0x40
[  244.476325]  [<c1686142>] __ww_mutex_lock_interruptible+0x22/0x30
[  244.476343]  [<f8ddb7fb>] nouveau_gem_ioctl_pushbuf+0x68b/0x13c0 [nouveau]
[  244.476345]  [<c132d022>] ? debug_smp_processor_id+0x12/0x20
[  244.476348]  [<c1060283>] ? unpin_current_cpu+0x13/0x60
[  244.476365]  [<f8ddb170>] ? nouveau_gem_ioctl_new+0x1d0/0x1d0 [nouveau]
[  244.476373]  [<f891d137>] drm_ioctl+0x1b7/0x510 [drm]
[  244.476390]  [<f8ddb170>] ? nouveau_gem_ioctl_new+0x1d0/0x1d0 [nouveau]
[  244.476393]  [<c132d022>] ? debug_smp_processor_id+0x12/0x20
[  244.476395]  [<c1060283>] ? unpin_current_cpu+0x13/0x60
[  244.476397]  [<c1084e40>] ? migrate_enable+0xa0/0x1c0
[  244.476400]  [<c143f6b1>] ? __pm_runtime_resume+0x41/0x50
[  244.476417]  [<f8dd2707>] nouveau_drm_ioctl+0x47/0xb0 [nouveau]
[  244.476434]  [<f8dd26c0>] ? nouveau_pmops_thaw+0x20/0x20 [nouveau]
[  244.476436]  [<c11a9e82>] do_vfs_ioctl+0x2f2/0x4f0
[  244.476438]  [<c10c5132>] ? ktime_get_ts64+0x52/0x1a0
[  244.476441]  [<c10be330>] ? __remove_hrtimer+0xd0/0xd0
[  244.476443]  [<c11aa0e0>] SyS_ioctl+0x60/0x90
[  244.476446]  [<c1687d70>] sysenter_do_call+0x12/0x12
