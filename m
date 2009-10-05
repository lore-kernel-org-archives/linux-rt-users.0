From: Jose Angel Martinez Conde <joseangel@taller-id.com>
Subject: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Mon, 5 Oct 2009 20:52:01 +0200 (CEST)
Message-ID: <369171892.211254768721569.JavaMail.root@groupware>
References: <1804966706.191254768514851.JavaMail.root@groupware>
Reply-To: Jose Angel Martinez Conde <joseangel@taller-id.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 43.pool85-52-160.static.orange.es ([85.52.160.43]:55559 "EHLO
	groupware.taller-id.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754748AbZJESvR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2009 14:51:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by groupware.taller-id.com (Postfix) with ESMTP id 046D253E097
	for <linux-rt-users@vger.kernel.org>; Mon,  5 Oct 2009 20:52:02 +0200 (CEST)
Received: from groupware.taller-id.com ([127.0.0.1])
	by localhost (groupware.taller-id.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xm8ZsjXkkLPe for <linux-rt-users@vger.kernel.org>;
	Mon,  5 Oct 2009 20:52:01 +0200 (CEST)
Received: from groupware.taller-id.com (groupware.taller-id.com [192.168.0.15])
	by groupware.taller-id.com (Postfix) with ESMTP id 9D85E53E073
	for <linux-rt-users@vger.kernel.org>; Mon,  5 Oct 2009 20:52:01 +0200 (CEST)
In-Reply-To: <1804966706.191254768514851.JavaMail.root@groupware>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Sep 27 13:22:11 tid31 kernel: [ 1905.704018] ------------[ cut here ]------------
Sep 27 13:22:11 tid31 kernel: [ 1905.704023] WARNING: at net/sched/sch_generic.c:230 dev_watchdog+0x24c/0x260()
Sep 27 13:22:11 tid31 kernel: [ 1905.704025] Hardware name: System Product Name
Sep 27 13:22:11 tid31 kernel: [ 1905.704026] NETDEV WATCHDOG: eth1 (e1000): transmit timed out
Sep 27 13:22:11 tid31 kernel: [ 1905.704027] Modules linked in: nls_utf8 sg sr_mod cdrom usb_storage isofs udf nls_base i2c_dev nvidia(P) ipv6 firewire_sbp2 loop snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd pcspkr soundcore snd_page_alloc i2c_nforce2 evdev i2c_core button ext3 jbd mbcache sd_mod crc_t10dif ide_gd_mod ide_pci_generic amd74xx ide_core usbhid hid firewire_ohci firewire_core sata_nv ahci ata_generic crc_itu_t e1000 libata ohci_hcd ehci_hcd scsi_mod thermal processor fan thermal_sys [last unloaded: nvidia]
Sep 27 13:22:11 tid31 kernel: [ 1905.704074] Pid: 5, comm: sirq-timer/0 Tainted: P           2.6.29.6-rt23 #1
Sep 27 13:22:11 tid31 kernel: [ 1905.704076] Call Trace:
Sep 27 13:22:11 tid31 kernel: [ 1905.704081]  [<ffffffff8024587a>] ? warn_slowpath+0xea/0x160
Sep 27 13:22:11 tid31 kernel: [ 1905.704258]  [<ffffffffa109cd77>] ? _nv005972rm+0x1f/0x27 [nvidia]
Sep 27 13:22:11 tid31 kernel: [ 1905.704378]  [<ffffffffa105eda4>] ? _nv012325rm+0x3f/0x54 [nvidia]
Sep 27 13:22:11 tid31 kernel: [ 1905.704490]  [<ffffffffa109cd77>] ? _nv005972rm+0x1f/0x27 [nvidia]
Sep 27 13:22:11 tid31 kernel: [ 1905.704499]  [<ffffffff80238bf9>] ? pick_next_highest_task_rt+0xb9/0xe0
Sep 27 13:22:11 tid31 kernel: [ 1905.704501]  [<ffffffff8023a0bf>] ? enqueue_task_rt+0x11f/0x2e0
Sep 27 13:22:11 tid31 kernel: [ 1905.704504]  [<ffffffff8037f9f1>] ? strlcpy+0x41/0x50
Sep 27 13:22:11 tid31 kernel: [ 1905.704506]  [<ffffffff8046712c>] ? dev_watchdog+0x24c/0x260
Sep 27 13:22:11 tid31 kernel: [ 1905.704508]  [<ffffffff80238210>] ? activate_task+0x20/0x30
Sep 27 13:22:11 tid31 kernel: [ 1905.704511]  [<ffffffff80240a16>] ? try_to_wake_up+0x186/0x2b0
Sep 27 13:22:11 tid31 kernel: [ 1905.704515]  [<ffffffff8025044b>] ? cascade+0x7b/0xa0
Sep 27 13:22:11 tid31 kernel: [ 1905.704517]  [<ffffffff80466ee0>] ? dev_watchdog+0x0/0x260
Sep 27 13:22:11 tid31 kernel: [ 1905.704519]  [<ffffffff8025094c>] ? run_timer_softirq+0x1ac/0x2f0
Sep 27 13:22:11 tid31 kernel: [ 1905.704522]  [<ffffffff8024b0aa>] ? ksoftirqd+0x18a/0x300
Sep 27 13:22:11 tid31 kernel: [ 1905.704524]  [<ffffffff8024af20>] ? ksoftirqd+0x0/0x300
Sep 27 13:22:11 tid31 kernel: [ 1905.704526]  [<ffffffff8024af20>] ? ksoftirqd+0x0/0x300
Sep 27 13:22:11 tid31 kernel: [ 1905.704529]  [<ffffffff8025d017>] ? kthread+0x47/0x90
Sep 27 13:22:11 tid31 kernel: [ 1905.704531]  [<ffffffff8020d04a>] ? child_rip+0xa/0x20
Sep 27 13:22:11 tid31 kernel: [ 1905.704533]  [<ffffffff8025cfd0>] ? kthread+0x0/0x90
Sep 27 13:22:11 tid31 kernel: [ 1905.704535]  [<ffffffff8020d040>] ? child_rip+0x0/0x20
Sep 27 13:22:11 tid31 kernel: [ 1905.704537] ---[ end trace c3aee9954334308d ]---


Oct  5 20:29:20 localhost kernel: [37190.704011] ------------[ cut here ]------------
Oct  5 20:29:20 localhost kernel: [37190.704015] WARNING: at net/sched/sch_generic.c:230 dev_watchdog+0x24c/0x260()
Oct  5 20:29:20 localhost kernel: [37190.704017] Hardware name: System Product Name
Oct  5 20:29:20 localhost kernel: [37190.704018] NETDEV WATCHDOG: eth0 (e1000): transmit timed out
Oct  5 20:29:20 localhost kernel: [37190.704019] Modules linked in: nvidia(P) vboxnetadp vboxnetflt vboxdrv ipv6 ext4 jbd2 crc16 coretemp it87 hwmon_vid firewire_sbp2 loop snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore pcspkr snd_page_alloc i2c_nforce2 evdev i2c_core button ext3 jbd mbcache sd_mod crc_t10dif ide_gd_mod ide_pci_generic amd74xx ide_core usbhid hid e1000 firewire_ohci firewire_core crc_itu_t sata_nv ahci ata_generic ohci_hcd ehci_hcd libata scsi_mod thermal processor fan thermal_sys [last unloaded: scsi_wait_scan]
Oct  5 20:29:20 localhost kernel: [37190.704059] Pid: 5, comm: sirq-timer/0 Tainted: P           2.6.29.6-rt23 #1
Oct  5 20:29:20 localhost kernel: [37190.704061] Call Trace:
Oct  5 20:29:20 localhost kernel: [37190.704065]  [<ffffffff8024587a>] ? warn_slowpath+0xea/0x160
Oct  5 20:29:20 localhost kernel: [37190.704068]  [<ffffffff8047dc00>] ? ip_send_check+0x0/0x50
Oct  5 20:29:20 localhost kernel: [37190.704071]  [<ffffffff8047e99a>] ? ip_push_pending_frames+0x3ca/0x490
Oct  5 20:29:20 localhost kernel: [37190.704074]  [<ffffffff8037ea10>] ? rb_insert_color+0x90/0x130
Oct  5 20:29:20 localhost kernel: [37190.704078]  [<ffffffff8023ab3b>] ? enqueue_task_fair+0x3b/0xb0
Oct  5 20:29:20 localhost kernel: [37190.704080]  [<ffffffff802380ff>] ? enqueue_task+0x5f/0x70
Oct  5 20:29:20 localhost kernel: [37190.704082]  [<ffffffff80238bf9>] ? pick_next_highest_task_rt+0xb9/0xe0
Oct  5 20:29:20 localhost kernel: [37190.704084]  [<ffffffff8023a0bf>] ? enqueue_task_rt+0x11f/0x2e0
Oct  5 20:29:20 localhost kernel: [37190.704088]  [<ffffffff802a7c85>] ? perf_counter_task_sched_in+0x65/0x210
Oct  5 20:29:20 localhost kernel: [37190.704090]  [<ffffffff8037f9f1>] ? strlcpy+0x41/0x50
Oct  5 20:29:20 localhost kernel: [37190.704092]  [<ffffffff8046712c>] ? dev_watchdog+0x24c/0x260
Oct  5 20:29:20 localhost kernel: [37190.704094]  [<ffffffff804d8b86>] ? thread_return+0x3c/0x716
Oct  5 20:29:20 localhost kernel: [37190.704096]  [<ffffffff80466ee0>] ? dev_watchdog+0x0/0x260
Oct  5 20:29:20 localhost kernel: [37190.704099]  [<ffffffff8025094c>] ? run_timer_softirq+0x1ac/0x2f0
Oct  5 20:29:20 localhost kernel: [37190.704101]  [<ffffffff8024b0aa>] ? ksoftirqd+0x18a/0x300
Oct  5 20:29:20 localhost kernel: [37190.704103]  [<ffffffff8024af20>] ? ksoftirqd+0x0/0x300
Oct  5 20:29:20 localhost kernel: [37190.704105]  [<ffffffff8024af20>] ? ksoftirqd+0x0/0x300
Oct  5 20:29:20 localhost kernel: [37190.704108]  [<ffffffff8025d017>] ? kthread+0x47/0x90
Oct  5 20:29:20 localhost kernel: [37190.704111]  [<ffffffff8020d04a>] ? child_rip+0xa/0x20
Oct  5 20:29:20 localhost kernel: [37190.704113]  [<ffffffff8025cfd0>] ? kthread+0x0/0x90
Oct  5 20:29:20 localhost kernel: [37190.704115]  [<ffffffff8020d040>] ? child_rip+0x0/0x20
Oct  5 20:29:20 localhost kernel: [37190.704116] ---[ end trace 2597bfd61f8b4c6d ]---


Regards,

--
jose angel
