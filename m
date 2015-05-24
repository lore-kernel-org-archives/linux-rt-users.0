From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Sun, 24 May 2015 13:59:46 -0700
Message-ID: <55623BC2.80307@localhost>
References: <20150519213923.GA26363@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nando@ccrma.Stanford.EDU, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519213923.GA26363@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/19/2015 02:39 PM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.0.4-rt1 patch set.

Great!!

> Changes since v3.18.13-rt10
>
> - Rebase to v4.0.
>
> - David Hildenbrand's series of decouple of preempt_disable from
>    pagefault_disable is part of the series.
>
> While doing the v4.0 I stumbled upon a few things. Therefore I plan t=
o
> reorder the -RT queue and merge patches where possible. Also I intend=
 to
> drop PREEMPT_RTB and PREEMPT_RT_BASE unless there is need for it=E2=80=
=A6

=2E..

I had to do this to get it to build (looks like it is not rt specific,=20
probably just a typo in mainline):

--------
--- linux-4.0/sound/soc/intel/sst/sst.c~	2015-04-12 15:12:50.000000000 =
-0700
+++ linux-4.0/sound/soc/intel/sst/sst.c	2015-05-23 21:51:46.000000000 -=
0700
@@ -368,8 +368,8 @@
  	 * initialize by FW or driver when firmware is loaded
  	 */
  	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
-	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx),
-	sst_shim_write64(shim, SST_CSR, shim_regs->csr),
+	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx);
+	sst_shim_write64(shim, SST_CSR, shim_regs->csr);
  	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
  }

--------

On a desktop with an i7-3770k it seems to run fine (but I have not have=
=20
time to test for latency problems).

On my laptop, a lenovo w540, I get this continuously - so it is not=20
really usable at this point:

--------
May 24 13:51:41 localhost kernel: ------------[ cut here ]------------
May 24 13:51:41 localhost kernel: WARNING: CPU: 5 PID: 361 at=20
drivers/gpu/drm/i915/intel_display.c:9748=20
intel_check_page_flip+0xaa/0xf0 [i915]()
May 24 13:51:41 localhost kernel: WARN_ON(!in_interrupt())
May 24 13:51:41 localhost kernel: Modules linked in:
May 24 13:51:41 localhost kernel: rfcomm fuse ccm xt_CHECKSUM=20
ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netbios_ns=20
nf_conntrack_broadcast ip6t_rpfilter ip6t_REJ\
ECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge stp=20
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6=20
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mang\
le ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_na=
t=20
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack=20
iptable_mangle iptable_security\
  iptable_raw bnep bbswitch(OE) vfat fat iTCO_wdt iTCO_vendor_support=20
arc4 intel_rapl iosf_mbi coretemp kvm_intel kvm uvcvideo=20
crct10dif_pclmul videobuf2_vmalloc videobuf\
2_core crc32_pclmul crc32c_intel videobuf2_memops ghash_clmulni_intel=20
v4l2_common videodev media iwlmvm btusb serio_raw mac80211 bluetooth=20
snd_hda_codec_realtek
May 24 13:51:41 localhost kernel: snd_hda_codec_hdmi=20
snd_hda_codec_generic iwlwifi snd_hda_intel sdhci_pci snd_hda_controlle=
r=20
cfg80211 sdhci snd_hda_codec mmc_core snd_h\
wdep lpc_ich snd_seq mei_me i2c_i801 mfd_core snd_seq_device mei snd_pc=
m=20
thinkpad_acpi snd_timer ie31200_edac snd shpchp edac_core soundcore=20
tpm_tis rfkill tpm nfsd auth\
_rpcgss nfs_acl lockd grace sunrpc i915 i2c_algo_bit e1000e=20
drm_kms_helper ptp drm pps_core wmi video
May 24 13:51:41 localhost kernel: CPU: 5 PID: 361 Comm: irq/30-i915=20
Tainted: G        W  OE   4.0.4-201.rt1.2.fc21.ccrma.x86_64+rt #1
May 24 13:51:41 localhost kernel: Hardware name: LENOVO=20
20BGCTO1WW/20BGCTO1WW, BIOS GNET65WW (2.13 ) 06/20/2014
May 24 13:51:41 localhost kernel: 0000000000000000 000000001f35af7b=20
ffff8804651afc78 ffffffff8179c0b9
May 24 13:51:41 localhost kernel: 0000000000000000 ffff8804651afcd0=20
ffff8804651afcb8 ffffffff8109ee1a
May 24 13:51:41 localhost kernel: ffff8804651afcb8 ffff88046638c000=20
ffff880469dd7800 0000000000000001
May 24 13:51:41 localhost kernel: Call Trace:
May 24 13:51:41 localhost kernel: [<ffffffff8179c0b9>] dump_stack+0x4c/=
0x81
May 24 13:51:41 localhost kernel: [<ffffffff8109ee1a>]=20
warn_slowpath_common+0x8a/0xe0
May 24 13:51:41 localhost kernel: [<ffffffff8109eec5>]=20
warn_slowpath_fmt+0x55/0x70
May 24 13:51:41 localhost kernel: [<ffffffffa0186dda>]=20
intel_check_page_flip+0xaa/0xf0 [i915]
May 24 13:51:41 localhost kernel: [<ffffffffa0152018>]=20
ironlake_irq_handler+0x2e8/0x1000 [i915]
May 24 13:51:41 localhost kernel: [<ffffffff81014610>] ?=20
__switch_to+0x150/0x610
May 24 13:51:41 localhost kernel: [<ffffffff810fb040>] ?=20
irq_thread_fn+0x50/0x50
May 24 13:51:41 localhost kernel: [<ffffffff810fb067>]=20
irq_forced_thread_fn+0x27/0x80
May 24 13:51:41 localhost kernel: [<ffffffff810fb61f>]=20
irq_thread+0x12f/0x180
May 24 13:51:41 localhost kernel: [<ffffffff810fb0f0>] ?=20
wake_threads_waitq+0x30/0x30
May 24 13:51:41 localhost kernel: [<ffffffff810fb4f0>] ?=20
irq_thread_check_affinity+0x90/0x90
May 24 13:51:41 localhost kernel: [<ffffffff810bf4ba>] kthread+0xca/0xe=
0
May 24 13:51:41 localhost kernel: [<ffffffff810bf3f0>] ?=20
kthread_worker_fn+0x180/0x180
May 24 13:51:41 localhost kernel: [<ffffffff817a2098>]=20
ret_from_fork+0x58/0x90
May 24 13:51:41 localhost kernel: [<ffffffff810bf3f0>] ?=20
kthread_worker_fn+0x180/0x180
May 24 13:51:41 localhost kernel: ---[ end trace 00000000000005fe ]---
May 24 13:51:41 localhost kernel: ------------[ cut here ]------------
--------

Any patches I could try to fix this?
-- Fernando
