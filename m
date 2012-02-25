From: Clark Williams <clark.williams@gmail.com>
Subject: traceback on 3.2.7-rt13
Date: Sat, 25 Feb 2012 10:55:02 -0600
Message-ID: <20120225105502.0f4553a3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/O=M1VNCLK=.lD4ru=Av90mD"; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46616 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab2BYQzI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Feb 2012 11:55:08 -0500
Received: by qcqw6 with SMTP id w6so340308qcq.19
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Feb 2012 08:55:07 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/O=M1VNCLK=.lD4ru=Av90mD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thomas,

I just saw the following traceback on my laptop running 3.2.7-rt13:

[32943.463901] Modules linked in: tun vfat fat usb_storage uas tcp_lp
ppdev parport_pc lp parport fuse be2iscsi iscsi_boot_sysfs bnx2i cnic
uio cxgb4i cxgb4 lockd cxgb3i libcxgbi cxgb3 mdio iscsi_tcp
libiscsi_tcp libiscsi scsi_transport_iscsi rfcomm bnep
nf_conntrack_ipv4 ip6t_REJECT nf_defrag_ipv4 nf_conntrack_ipv6
nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables
snd_hda_codec_hdmi arc4 snd_hda_codec_conexant iwlwifi snd_hda_intel
snd_hda_codec btusb bluetooth snd_hwdep mac80211 snd_seq uvcvideo
snd_seq_device snd_pcm thinkpad_acpi snd_timer videodev snd cfg80211
e1000e i7core_edac media v4l2_compat_ioctl32 xhci_hcd edac_core
i2c_i801 snd_page_alloc rfkill iTCO_wdt pcspkr iTCO_vendor_support
soundcore microcode uinput sunrpc ipv6 sdhci_pci sdhci mmc_core
ehci_hcd nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi
wmi video [last unloaded: scsi_wait_scan] [32943.463949] Pid: 63, comm:
irq/9-acpi Tainted: G        W    3.2.7-rt13+ #40 [32943.463951] Call
Trace: [32943.463958]  [<ffffffff815ca1b8>] __schedule_bug+0x5e/0x62
[32943.463963]  [<ffffffff815dedcd>] __schedule+0x6ed/0x760
[32943.463966]  [<ffffffff815df27e>] schedule+0x2e/0xa0 [32943.463970]
[<ffffffff815e0951>] rt_spin_lock_slowlock+0x150/0x1ef [32943.463975]
[<ffffffff81056d01>] ? check_same_owner+0x31/0x80 [32943.463978]
[<ffffffff815e0ee6>] rt_spin_lock+0x26/0x30 [32943.463983]
[<ffffffff81160cdc>] kmem_cache_alloc_trace+0x6c/0x320 [32943.463987]
[<ffffffff8135a307>] ? acpi_hw_write_port+0x43/0x98 [32943.463991]
[<ffffffff81346714>] ? acpi_ec_sync_query+0x102/0x102 [32943.463995]
[<ffffffff81340fcd>] __acpi_os_execute+0x35/0xc6 [32943.463998]
[<ffffffff8134106e>] acpi_os_execute+0x10/0x12 [32943.464001]
[<ffffffff81346e1f>] acpi_ec_gpe_handler+0xad/0xb6 [32943.464004]
[<ffffffff81351baa>] acpi_ev_gpe_dispatch+0xc5/0x13e [32943.464007]
[<ffffffff81351cd8>] acpi_ev_gpe_detect+0xb5/0x10d [32943.464012]
[<ffffffff810d7560>] ? irq_thread_fn+0x50/0x50 [32943.464015]
[<ffffffff813502a6>] acpi_ev_sci_xrupt_handler+0x22/0x2b
[32943.464017]  [<ffffffff81341086>] acpi_irq+0x16/0x31 [32943.464020]
[<ffffffff810d758e>] irq_forced_thread_fn+0x2e/0x70 [32943.464023]
[<ffffffff810d748a>] irq_thread+0x17a/0x200 [32943.464026]
[<ffffffff810d7310>] ? irq_finalize_oneshot+0x20/0x20 [32943.464030]
[<ffffffff81094578>] kthread+0x98/0xa0 [32943.464034]
[<ffffffff815e9d74>] kernel_thread_helper+0x4/0x10 [32943.464037]
[<ffffffff810944e0>] ? __init_kthread_worker+0x70/0x70 [32943.464040]
[<ffffffff815e9d70>] ? gs_change+0x13/0x13


I'll dig into it a bit more but my guess is that it was something
battery releated (I'd accidentally kicked the power cord out at a
coffee shop and noticed that I was down to 28% battery, when I then
noticed that I had a traceback).=20

Clark

--Sig_/O=M1VNCLK=.lD4ru=Av90mD
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPSRJmAAoJEOIu7msziWiGPaoH/j6bzNdG5aZpAWi96ibT9U2A
jFiC1z9nrnwnhXhYqdEtPrNOW4wKmgZVM0LoS49iOgPtL/xHQs2uL/0di/KonLS0
nJhm5AaR/E1zfLBxZZzhFC6DWwdKv9xFsGJra+k5mpZPi1WjQTCTtDGBVKf+K0uT
DED3lceK2WTbSrXZcaM1eqD3mfS8N3LoSCFI6eGk16lfYG0Hs+G+lotKnIf90qt/
9jeKOo4heGfOZnELxxnteoVQWD0QweZKCToBHzzgq5gpKpi4sgmTfGZzBrmGWo+I
17QMfUVlaqtV5qqgMFNCF6sNAUMLZupitY9bRZ9Czd5iOhYddMkBx4yrI51Gtfs=
=tvzS
-----END PGP SIGNATURE-----

--Sig_/O=M1VNCLK=.lD4ru=Av90mD--
