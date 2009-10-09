From: Jose Angel Martinez Conde <joseangel@taller-id.com>
Subject: Re: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Fri, 9 Oct 2009 11:11:03 +0200 (CEST)
Message-ID: <1160616534.641255079463849.JavaMail.root@groupware>
References: <658461008.621255079453937.JavaMail.root@groupware>
Reply-To: Jose Angel Martinez Conde <joseangel@taller-id.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hans-Peter.Bock@isw.uni-stuttgart.de,
	RT <linux-rt-users@vger.kernel.org>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 43.pool85-52-160.static.orange.es ([85.52.160.43]:63390 "EHLO
	groupware.taller-id.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751049AbZJIJKL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Oct 2009 05:10:11 -0400
In-Reply-To: <658461008.621255079453937.JavaMail.root@groupware>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Uwe,

we don't reproduce the error with a non-tainted kernel.

We have three computers (same configuration), one with non-tainted kern=
el and others with tainted kernel (nvidia module). One this get the nex=
t error,

Oct  8 21:47:50 tid31 kernel: [38901.704013] ------------[ cut here ]--=
----------
Oct  8 21:47:50 tid31 kernel: [38901.704016] WARNING: at net/sched/sch_=
generic.c:230 dev_watchdog+0x24c/0x260()
Oct  8 21:47:50 tid31 kernel: [38901.704018] Hardware name: System Prod=
uct Name
Oct  8 21:47:50 tid31 kernel: [38901.704020] NETDEV WATCHDOG: eth0 (e10=
00): transmit timed out
Oct  8 21:47:50 tid31 kernel: [38901.704021] Modules linked in: nls_utf=
8 cifs nls_base nvidia(P) vboxnetadp vboxnetflt vboxdrv autofs4 ipv6 ex=
t4 jbd2 crc16 coretemp it87 hwmon_vid firewire_sbp2 loop snd_hda_codec_=
realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss=
 snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_mid=
i_event snd_seq snd_timer snd_seq_device snd soundcore snd_page_alloc p=
cspkr evdev i2c_nforce2 i2c_core button ext3 jbd mbcache sd_mod crc_t10=
dif ide_gd_mod ide_pci_generic amd74xx ide_core usbhid hid firewire_ohc=
i firewire_core sata_nv ahci ata_generic forcedeth crc_itu_t e1000 liba=
ta ehci_hcd ohci_hcd scsi_mod thermal processor fan thermal_sys [last u=
nloaded: scsi_wait_scan]
Oct  8 21:47:50 tid31 kernel: [38901.704066] Pid: 5, comm: sirq-timer/0=
 Tainted: P           2.6.29.6-rt23 #3
Oct  8 21:47:50 tid31 kernel: [38901.704068] Call Trace:
Oct  8 21:47:50 tid31 kernel: [38901.704073]  [<ffffffff8024569a>] ? wa=
rn_slowpath+0xea/0x160
Oct  8 21:47:50 tid31 kernel: [38901.704076]  [<ffffffff8047a000>] ? ip=
_reply_glue_bits+0x50/0x60
Oct  8 21:47:50 tid31 kernel: [38901.704078]  [<ffffffff8047acfa>] ? ip=
_push_pending_frames+0x3ca/0x490
Oct  8 21:47:50 tid31 kernel: [38901.704081]  [<ffffffff8045568a>] ? __=
neigh_event_send+0x5a/0x230
Oct  8 21:47:50 tid31 kernel: [38901.704083]  [<ffffffff80457524>] ? ne=
igh_resolve_output+0x1c4/0x360
Oct  8 21:47:50 tid31 kernel: [38901.704085]  [<ffffffff8047b266>] ? ip=
_queue_xmit+0x246/0x470
Oct  8 21:47:50 tid31 kernel: [38901.704088]  [<ffffffff80475e6e>] ? ip=
_route_output_flow+0x7e/0x2d0
Oct  8 21:47:50 tid31 kernel: [38901.704090]  [<ffffffff80238d39>] ? pi=
ck_next_highest_task_rt+0xb9/0xe0
Oct  8 21:47:50 tid31 kernel: [38901.704093]  [<ffffffff8023a20d>] ? en=
queue_task_rt+0x11d/0x2e0
Oct  8 21:47:50 tid31 kernel: [38901.704096]  [<ffffffff802a61b5>] ? pe=
rf_counter_task_sched_in+0x65/0x210
Oct  8 21:47:50 tid31 kernel: [38901.704099]  [<ffffffff8037dab1>] ? st=
rlcpy+0x41/0x50
Oct  8 21:47:50 tid31 kernel: [38901.704101]  [<ffffffff8046348c>] ? de=
v_watchdog+0x24c/0x260
Oct  8 21:47:50 tid31 kernel: [38901.704104]  [<ffffffff804d4d96>] ? th=
read_return+0x3c/0x6e6
Oct  8 21:47:50 tid31 kernel: [38901.704106]  [<ffffffff80463240>] ? de=
v_watchdog+0x0/0x260
Oct  8 21:47:50 tid31 kernel: [38901.704109]  [<ffffffff8025058c>] ? ru=
n_timer_softirq+0x1ac/0x2f0
Oct  8 21:47:50 tid31 kernel: [38901.704111]  [<ffffffff8024acea>] ? ks=
oftirqd+0x18a/0x300
Oct  8 21:47:50 tid31 kernel: [38901.704113]  [<ffffffff8024ab60>] ? ks=
oftirqd+0x0/0x300
Oct  8 21:47:50 tid31 kernel: [38901.704116]  [<ffffffff8024ab60>] ? ks=
oftirqd+0x0/0x300
Oct  8 21:47:50 tid31 kernel: [38901.704118]  [<ffffffff8025cc17>] ? kt=
hread+0x47/0x90
Oct  8 21:47:50 tid31 kernel: [38901.704121]  [<ffffffff8020d04a>] ? ch=
ild_rip+0xa/0x20
Oct  8 21:47:50 tid31 kernel: [38901.704123]  [<ffffffff8025cbd0>] ? kt=
hread+0x0/0x90
Oct  8 21:47:50 tid31 kernel: [38901.704125]  [<ffffffff8020d040>] ? ch=
ild_rip+0x0/0x20
Oct  8 21:47:50 tid31 kernel: [38901.704126] ---[ end trace 8cd1cec32da=
fbb04 ]---

We come back to 2.6.29.5-rt22.

Thanks.

Regards,

--
jose angel

----- "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> On Mon, Oct 05, 2009 at 08:52:01PM +0200, Jose Angel Martinez Conde
> wrote:
> >=20
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704018] ------------[ cut here
> ]------------
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704023] WARNING: at
> net/sched/sch_generic.c:230 dev_watchdog+0x24c/0x260()
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704025] Hardware name: System
> Product Name
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704026] NETDEV WATCHDOG: eth1
> (e1000): transmit timed out
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704027] Modules linked in:
> nls_utf8 sg sr_mod cdrom usb_storage isofs udf nls_base i2c_dev
> nvidia(P) ipv6 firewire_sbp2 loop snd_hda_codec_realtek snd_hda_intel
> snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm
> snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event
> snd_seq snd_timer snd_seq_device snd pcspkr soundcore snd_page_alloc
> i2c_nforce2 evdev i2c_core button ext3 jbd mbcache sd_mod crc_t10dif
> ide_gd_mod ide_pci_generic amd74xx ide_core usbhid hid firewire_ohci
> firewire_core sata_nv ahci ata_generic crc_itu_t e1000 libata ohci_hc=
d
> ehci_hcd scsi_mod thermal processor fan thermal_sys [last unloaded:
> nvidia]
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704074] Pid: 5, comm:
> sirq-timer/0 Tainted: P           2.6.29.6-rt23 #1
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704076] Call Trace:
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704081]  [<ffffffff8024587a>] =
?
> warn_slowpath+0xea/0x160
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704258]  [<ffffffffa109cd77>] =
?
> _nv005972rm+0x1f/0x27 [nvidia]
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704378]  [<ffffffffa105eda4>] =
?
> _nv012325rm+0x3f/0x54 [nvidia]
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704490]  [<ffffffffa109cd77>] =
?
> _nv005972rm+0x1f/0x27 [nvidia]
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704499]  [<ffffffff80238bf9>] =
?
> pick_next_highest_task_rt+0xb9/0xe0
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704501]  [<ffffffff8023a0bf>] =
?
> enqueue_task_rt+0x11f/0x2e0
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704504]  [<ffffffff8037f9f1>] =
?
> strlcpy+0x41/0x50
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704506]  [<ffffffff8046712c>] =
?
> dev_watchdog+0x24c/0x260
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704508]  [<ffffffff80238210>] =
?
> activate_task+0x20/0x30
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704511]  [<ffffffff80240a16>] =
?
> try_to_wake_up+0x186/0x2b0
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704515]  [<ffffffff8025044b>] =
?
> cascade+0x7b/0xa0
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704517]  [<ffffffff80466ee0>] =
?
> dev_watchdog+0x0/0x260
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704519]  [<ffffffff8025094c>] =
?
> run_timer_softirq+0x1ac/0x2f0
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704522]  [<ffffffff8024b0aa>] =
?
> ksoftirqd+0x18a/0x300
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704524]  [<ffffffff8024af20>] =
?
> ksoftirqd+0x0/0x300
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704526]  [<ffffffff8024af20>] =
?
> ksoftirqd+0x0/0x300
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704529]  [<ffffffff8025d017>] =
?
> kthread+0x47/0x90
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704531]  [<ffffffff8020d04a>] =
?
> child_rip+0xa/0x20
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704533]  [<ffffffff8025cfd0>] =
?
> kthread+0x0/0x90
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704535]  [<ffffffff8020d040>] =
?
> child_rip+0x0/0x20
> > Sep 27 13:22:11 tid31 kernel: [ 1905.704537] ---[ end trace
> c3aee9954334308d ]---
> Can you please reproduce with a non-tainted kernel?  I.e. don't load
> the
> nvidia module.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                              | Uwe Kleine-K=C3=B6nig=
     =20
>      |
> Industrial Linux Solutions                    |
> http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
