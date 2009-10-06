From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Tue, 6 Oct 2009 08:41:21 +0200
Message-ID: <20091006064121.GA22242@pengutronix.de>
References: <1804966706.191254768514851.JavaMail.root@groupware> <369171892.211254768721569.JavaMail.root@groupware>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Jose Angel Martinez Conde <joseangel@taller-id.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36366 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZJFGl6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2009 02:41:58 -0400
Content-Disposition: inline
In-Reply-To: <369171892.211254768721569.JavaMail.root@groupware>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Mon, Oct 05, 2009 at 08:52:01PM +0200, Jose Angel Martinez Conde wro=
te:
>=20
> Sep 27 13:22:11 tid31 kernel: [ 1905.704018] ------------[ cut here ]=
------------
> Sep 27 13:22:11 tid31 kernel: [ 1905.704023] WARNING: at net/sched/sc=
h_generic.c:230 dev_watchdog+0x24c/0x260()
> Sep 27 13:22:11 tid31 kernel: [ 1905.704025] Hardware name: System Pr=
oduct Name
> Sep 27 13:22:11 tid31 kernel: [ 1905.704026] NETDEV WATCHDOG: eth1 (e=
1000): transmit timed out
> Sep 27 13:22:11 tid31 kernel: [ 1905.704027] Modules linked in: nls_u=
tf8 sg sr_mod cdrom usb_storage isofs udf nls_base i2c_dev nvidia(P) ip=
v6 firewire_sbp2 loop snd_hda_codec_realtek snd_hda_intel snd_hda_codec=
 snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss =
snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_d=
evice snd pcspkr soundcore snd_page_alloc i2c_nforce2 evdev i2c_core bu=
tton ext3 jbd mbcache sd_mod crc_t10dif ide_gd_mod ide_pci_generic amd7=
4xx ide_core usbhid hid firewire_ohci firewire_core sata_nv ahci ata_ge=
neric crc_itu_t e1000 libata ohci_hcd ehci_hcd scsi_mod thermal process=
or fan thermal_sys [last unloaded: nvidia]
> Sep 27 13:22:11 tid31 kernel: [ 1905.704074] Pid: 5, comm: sirq-timer=
/0 Tainted: P           2.6.29.6-rt23 #1
> Sep 27 13:22:11 tid31 kernel: [ 1905.704076] Call Trace:
> Sep 27 13:22:11 tid31 kernel: [ 1905.704081]  [<ffffffff8024587a>] ? =
warn_slowpath+0xea/0x160
> Sep 27 13:22:11 tid31 kernel: [ 1905.704258]  [<ffffffffa109cd77>] ? =
_nv005972rm+0x1f/0x27 [nvidia]
> Sep 27 13:22:11 tid31 kernel: [ 1905.704378]  [<ffffffffa105eda4>] ? =
_nv012325rm+0x3f/0x54 [nvidia]
> Sep 27 13:22:11 tid31 kernel: [ 1905.704490]  [<ffffffffa109cd77>] ? =
_nv005972rm+0x1f/0x27 [nvidia]
> Sep 27 13:22:11 tid31 kernel: [ 1905.704499]  [<ffffffff80238bf9>] ? =
pick_next_highest_task_rt+0xb9/0xe0
> Sep 27 13:22:11 tid31 kernel: [ 1905.704501]  [<ffffffff8023a0bf>] ? =
enqueue_task_rt+0x11f/0x2e0
> Sep 27 13:22:11 tid31 kernel: [ 1905.704504]  [<ffffffff8037f9f1>] ? =
strlcpy+0x41/0x50
> Sep 27 13:22:11 tid31 kernel: [ 1905.704506]  [<ffffffff8046712c>] ? =
dev_watchdog+0x24c/0x260
> Sep 27 13:22:11 tid31 kernel: [ 1905.704508]  [<ffffffff80238210>] ? =
activate_task+0x20/0x30
> Sep 27 13:22:11 tid31 kernel: [ 1905.704511]  [<ffffffff80240a16>] ? =
try_to_wake_up+0x186/0x2b0
> Sep 27 13:22:11 tid31 kernel: [ 1905.704515]  [<ffffffff8025044b>] ? =
cascade+0x7b/0xa0
> Sep 27 13:22:11 tid31 kernel: [ 1905.704517]  [<ffffffff80466ee0>] ? =
dev_watchdog+0x0/0x260
> Sep 27 13:22:11 tid31 kernel: [ 1905.704519]  [<ffffffff8025094c>] ? =
run_timer_softirq+0x1ac/0x2f0
> Sep 27 13:22:11 tid31 kernel: [ 1905.704522]  [<ffffffff8024b0aa>] ? =
ksoftirqd+0x18a/0x300
> Sep 27 13:22:11 tid31 kernel: [ 1905.704524]  [<ffffffff8024af20>] ? =
ksoftirqd+0x0/0x300
> Sep 27 13:22:11 tid31 kernel: [ 1905.704526]  [<ffffffff8024af20>] ? =
ksoftirqd+0x0/0x300
> Sep 27 13:22:11 tid31 kernel: [ 1905.704529]  [<ffffffff8025d017>] ? =
kthread+0x47/0x90
> Sep 27 13:22:11 tid31 kernel: [ 1905.704531]  [<ffffffff8020d04a>] ? =
child_rip+0xa/0x20
> Sep 27 13:22:11 tid31 kernel: [ 1905.704533]  [<ffffffff8025cfd0>] ? =
kthread+0x0/0x90
> Sep 27 13:22:11 tid31 kernel: [ 1905.704535]  [<ffffffff8020d040>] ? =
child_rip+0x0/0x20
> Sep 27 13:22:11 tid31 kernel: [ 1905.704537] ---[ end trace c3aee9954=
334308d ]---
Can you please reproduce with a non-tainted kernel?  I.e. don't load th=
e
nvidia module.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
