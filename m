From: John Kacur <jkacur@redhat.com>
Subject: Re: traceback on 3.2.7-rt13
Date: Thu, 1 Mar 2012 20:14:42 +0100
Message-ID: <CAONaPpFqas6RK1PNbiuzCg=LcVf1J9DuBxqxZDc2gHPgbDU91g@mail.gmail.com>
References: <20120225105502.0f4553a3@gmail.com>
	<alpine.LFD.2.02.1203011619530.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49722 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617Ab2CATOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Mar 2012 14:14:43 -0500
Received: by vbbff1 with SMTP id ff1so777339vbb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Mar 2012 11:14:42 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1203011619530.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 1, 2012 at 4:23 PM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> On Sat, 25 Feb 2012, Clark Williams wrote:
>
>> Thomas,
>>
>> I just saw the following traceback on my laptop running 3.2.7-rt13:
>>
>> [32943.463901] Modules linked in: tun vfat fat usb_storage uas tcp_l=
p
>> ppdev parport_pc lp parport fuse be2iscsi iscsi_boot_sysfs bnx2i cni=
c
>> uio cxgb4i cxgb4 lockd cxgb3i libcxgbi cxgb3 mdio iscsi_tcp
>> libiscsi_tcp libiscsi scsi_transport_iscsi rfcomm bnep
>> nf_conntrack_ipv4 ip6t_REJECT nf_defrag_ipv4 nf_conntrack_ipv6
>> nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables
>> snd_hda_codec_hdmi arc4 snd_hda_codec_conexant iwlwifi snd_hda_intel
>> snd_hda_codec btusb bluetooth snd_hwdep mac80211 snd_seq uvcvideo
>> snd_seq_device snd_pcm thinkpad_acpi snd_timer videodev snd cfg80211
>> e1000e i7core_edac media v4l2_compat_ioctl32 xhci_hcd edac_core
>> i2c_i801 snd_page_alloc rfkill iTCO_wdt pcspkr iTCO_vendor_support
>> soundcore microcode uinput sunrpc ipv6 sdhci_pci sdhci mmc_core
>> ehci_hcd nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wm=
i
>> wmi video [last unloaded: scsi_wait_scan] [32943.463949] Pid: 63, co=
mm:
>> irq/9-acpi Tainted: G =A0 =A0 =A0 =A0W =A0 =A03.2.7-rt13+ #40 [32943=
=2E463951] Call
>> Trace: [32943.463958] =A0[<ffffffff815ca1b8>] __schedule_bug+0x5e/0x=
62
>> [32943.463963] =A0[<ffffffff815dedcd>] __schedule+0x6ed/0x760
>> [32943.463966] =A0[<ffffffff815df27e>] schedule+0x2e/0xa0 [32943.463=
970]
>> [<ffffffff815e0951>] rt_spin_lock_slowlock+0x150/0x1ef [32943.463975=
]
>> [<ffffffff81056d01>] ? check_same_owner+0x31/0x80 [32943.463978]
>> [<ffffffff815e0ee6>] rt_spin_lock+0x26/0x30 [32943.463983]
>> [<ffffffff81160cdc>] kmem_cache_alloc_trace+0x6c/0x320 [32943.463987=
]
>> [<ffffffff8135a307>] ? acpi_hw_write_port+0x43/0x98 [32943.463991]
>> [<ffffffff81346714>] ? acpi_ec_sync_query+0x102/0x102 [32943.463995]
>> [<ffffffff81340fcd>] __acpi_os_execute+0x35/0xc6 [32943.463998]
>> [<ffffffff8134106e>] acpi_os_execute+0x10/0x12 [32943.464001]
>> [<ffffffff81346e1f>] acpi_ec_gpe_handler+0xad/0xb6 [32943.464004]
>> [<ffffffff81351baa>] acpi_ev_gpe_dispatch+0xc5/0x13e [32943.464007]
>> [<ffffffff81351cd8>] acpi_ev_gpe_detect+0xb5/0x10d [32943.464012]
>> [<ffffffff810d7560>] ? irq_thread_fn+0x50/0x50 [32943.464015]
>> [<ffffffff813502a6>] acpi_ev_sci_xrupt_handler+0x22/0x2b
>> [32943.464017] =A0[<ffffffff81341086>] acpi_irq+0x16/0x31 [32943.464=
020]
>> [<ffffffff810d758e>] irq_forced_thread_fn+0x2e/0x70 [32943.464023]
>> [<ffffffff810d748a>] irq_thread+0x17a/0x200 [32943.464026]
>> [<ffffffff810d7310>] ? irq_finalize_oneshot+0x20/0x20 [32943.464030]
>> [<ffffffff81094578>] kthread+0x98/0xa0 [32943.464034]
>> [<ffffffff815e9d74>] kernel_thread_helper+0x4/0x10 [32943.464037]
>> [<ffffffff810944e0>] ? __init_kthread_worker+0x70/0x70 [32943.464040=
]
>> [<ffffffff815e9d70>] ? gs_change+0x13/0x13
>>
>>
>> I'll dig into it a bit more but my guess is that it was something
>> battery releated (I'd accidentally kicked the power cord out at a
>> coffee shop and noticed that I was down to 28% battery, when I then
>> noticed that I had a traceback).
>
> That's a known issue and has been reported over and over. That's due
> to making the acpi locks raw. Now I can't find any bug report which
> tells me WHY the heck we made those locks raw in the first place. All
> I can remember is that the trace back came deep from the idle code.
>
> That's why I asked to revert the
>
> =A0 =A0 =A0 acpi-make-gbl-hardware-lock-raw.patch
> =A0 =A0 =A0 acpi-make-ec-lock-raw-as-well.patch
>
> patches, so we can get that information.
>
> It might be a non issue on 3.2 and only a 3.0 problem, but as I can't
> find anything I'm going to drop those patches from the next 3.2
> release and wait for proper bugreports coming again :)
>

=46WIW
I believe the latter comes from here: https://lkml.org/lkml/2011/12/3/5=
3

Thanks
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
