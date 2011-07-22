From: Trulan Martin <trulanm@gmail.com>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Fri, 22 Jul 2011 10:06:14 +0000 (UTC)
Message-ID: <loom.20110722T120429-224@post.gmane.org>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>  <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>  <1311313414.2940.8.camel@box>  <20110722065711.GD16561@pengutronix.de> <1311320450.2940.11.camel@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38501 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab1GVKPQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 06:15:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1QkClA-0005vC-3G
	for linux-rt-users@vger.kernel.org; Fri, 22 Jul 2011 12:15:10 +0200
Received: from pool-71-114-139-153.hrbgpa.dsl-w.verizon.net ([71.114.139.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jul 2011 12:15:08 +0200
Received: from trulanm by pool-71-114-139-153.hrbgpa.dsl-w.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jul 2011 12:15:08 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hermann <brummer- <at> web.de> writes:

>=20
> Am Freitag, den 22.07.2011, 08:57 +0200 schrieb Uwe Kleine-K=C3=B6nig=
:
> > > second was with CONFIG_LGUEST_GUEST enabled, module build stage 2
> > failed
> > > with Documentation/lguest not found
> > Hmm, there is Documentation/virtual/lguest. Didn't find where
> > Documentation/lguest is used from a quick look. Rusty?
> >=20
> > Best regards
> > Uwe=20
>=20
> Sorry, I'm far from being a expert, all I can say is that disable=20
> CONFIG_LGUEST and
> CONFIG_LGUEST_GUEST also (auto)disable
> CONFIG_PARAVIRT_SPINLOCKS
> and then it works, at least here.
>=20
> regards
> hermann
>=20
> --

CONFIG_LGUEST, etc., had to be disabled for me on 3.0-rc7 as well, I do=
n't think
this is an RT issue.  I'm not sure about CONFIG_PARAVIRT_SPINLOCKS.

But, I am seeing this call trace, related to the b43-lpphy wireless dri=
ver
loading.  Everything appears to keep functioning.

[   16.616613] ------------[ cut here ]------------
[   16.616640] WARNING: at net/mac80211/rx.c:2856 ieee80211_rx+0x23/0x6=
db
[mac80211]()
[   16.616642] Hardware name: Latitude E5500                 =20
[   16.616644] Modules linked in: af_packet uinput binfmt_misc parport_=
pc ppdev
lp parport bridge stp bnep rfcomm vboxnetadp vboxnetflt vboxdrv ext3 jb=
d ipv6
cpufreq_powersave cpufreq_stats cpufreq_ondemand cpufreq_userspace
cpufreq_conservative speedstep_lib fuse loop snd_aloop acpi_cpufreq fre=
q_table
mperf snd_hda_codec_hdmi snd_hda_codec_idt btusb snd_hda_intel snd_hda_=
codec
bluetooth snd_pcm_oss snd_mixer_oss snd_pcm i915 drm_kms_helper drm
snd_seq_dummy snd_seq_oss snd_seq_midi i2c_algo_bit snd_rawmidi
snd_seq_midi_event snd_seq snd_timer arc4 joydev b43 video snd_seq_devi=
ce
dell_laptop battery processor ac button dell_wmi sparse_keymap pcspkr w=
mi dcdbas
yenta_socket pcmcia_rsrc psmouse i2c_i801 i2c_core serio_raw evdev rng_=
core
mac80211 snd intel_agp intel_gtt soundcore tpm_tis tpm tpm_bios snd_pag=
e_alloc
cfg80211 rfkill agpgart ext4 mbcache jbd2 crc16 dm_mirror dm_region_has=
h dm_log
dm_mod usbhid hid sg sr_mod cdrom sd_mod uhci_hcd ahci ehci_hcd libahci=
 ssb
sdhci_pci usbcore tg3 firewire_ohci libata sdhci pcmcia firewire_core m=
mc_core
thermal pcmcia_core thermal_sys libphy crc_itu_t [last unloaded: scsi_w=
ait_scan]
[   16.616710] Pid: 2770, comm: irq/17-b43 Not tainted 3.0.0-rc7-rt0-1 =
#1
[   16.616712] Call Trace:
[   16.616718]  [<c102c807>] ? warn_slowpath_common+0x68/0x79
[   16.616725]  [<f876261a>] ? ieee80211_rx+0x23/0x6db [mac80211]
[   16.616728]  [<c102c825>] ? warn_slowpath_null+0xd/0x10
[   16.616735]  [<f876261a>] ? ieee80211_rx+0x23/0x6db [mac80211]
[   16.616738]  [<c1020e2a>] ? task_rq_lock+0x36/0x64
[   16.616740]  [<c1020d13>] ? set_cpus_allowed_rt+0x11/0xb2
[   16.616743]  [<c1027033>] ? migrate_disable+0xd8/0xf3
[   16.616750]  [<f89e2512>] ? b43_rx+0x40f/0x436 [b43]
[   16.616757]  [<f89e6393>] ? b43_dma_rx+0x211/0x284 [b43]
[   16.616763]  [<f89cfdb3>] ? b43_do_interrupt_thread+0x41c/0x4dd [b43=
]
[   16.616767]  [<c1015841>] ? __io_apic_modify_irq+0x39/0x57
[   16.616771]  [<c10691aa>] ? unmask_irq+0x11/0x1a
[   16.616776]  [<f89cfe89>] ? b43_interrupt_thread_handler+0x15/0x27 [=
b43]
[   16.616779]  [<c10680dc>] ? irq_thread_fn+0x10/0x23
[   16.616781]  [<c106801a>] ? irq_thread+0xa0/0x152
[   16.616783]  [<c10680cc>] ? irq_thread+0x152/0x152
[   16.616786]  [<c1067f7a>] ? irq_finalize_oneshot+0x9d/0x9d
[   16.616788]  [<c103fcb4>] ? kthread+0x63/0x68
[   16.616791]  [<c103fc51>] ? __init_kthread_worker+0x36/0x36
[   16.616794]  [<c1248936>] ? kernel_thread_helper+0x6/0xd
[   16.616795] ---[ end trace 0000000000000002 ]---

Thanks,
Trulan



--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
