From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: 2.6.33.1-rt11 BUG: sleeping function called from invalid context
 at kernel/rtmutex.c:684
Date: Sun, 04 Apr 2010 11:17:56 +0200
Message-ID: <4BB85944.8000304@xs4all.nl>
References: <4BB8587F.40307@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:39190 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0DDJYX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Apr 2010 05:24:23 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
	by pindarots.xs4all.nl (8.14.3/8.14.3) with ESMTP id o349Huel003410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Sun, 4 Apr 2010 11:17:56 +0200
In-Reply-To: <4BB8587F.40307@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On 2010-04-04 11:14, Udo van den Heuvel wrote:
> I see a load of these after booting into 2.6.33.1-rt11:
> 
> BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
> pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 1507, name: md1_raid5
> Pid: 1507, comm: md1_raid5 Not tainted 2.6.33.1-rt11 #1
> Call Trace:
>  [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
>  [<ffffffff812becc4>] ? __raid_run_ops+0x304/0xc60
>  [<ffffffff812c0ccd>] ? handle_stripe+0x6bd/0x1a70
>  [<ffffffff8104b460>] ? mod_timer+0x150/0x200
>  [<ffffffff812c23f6>] ? raid5d+0x376/0x4f0
>  [<ffffffff8138e5bd>] ? schedule_timeout+0x22d/0x2b0
>  [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
>  [<ffffffff812cd0f3>] ? md_thread+0x53/0x120
>  [<ffffffff810573a0>] ? autoremove_wake_function+0x0/0x30
>  [<ffffffff812cd0a0>] ? md_thread+0x0/0x120
>  [<ffffffff81057016>] ? kthread+0x96/0xa0
>  [<ffffffff81037908>] ? finish_task_switch+0x58/0xd0
>  [<ffffffff810032d4>] ? kernel_thread_helper+0x4/0x10
>  [<ffffffff81056f80>] ? kthread+0x0/0xa0
>  [<ffffffff810032d0>] ? kernel_thread_helper+0x0/0x10
> 

I also see this one happing in 2.6.33.1-rt1 in between a number of the
BUGs I mentioned up on this page:

#
BUG: scheduling while atomic: md1_raid5/0x00000001/1507, CPU#2
#
Modules linked in: radeon ttm drm_kms_helper drm fb i2c_algo_bit
cfbcopyarea cfbimgblt cfbfillrect nfsd nfs_acl exportfs eeprom it87
hwmon_vid lockd sunrpc cpufreq_ondemand powernow_k8 ipt_REJECT
nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables
nf_conntrack_netbios_ns ip6t_REJECT xt_tcpudp nf_conntrack_ipv6 xt_state
nf_conntrack ip6table_filter ip6_tables x_tables ipv6 microcode
binfmt_misc ext4 jbd2 crc16 snd_hda_codec_realtek snd_ice1712
snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_ac97_codec ac97_bus
snd_i2c snd_mpu401_uart snd_hda_intel snd_hda_codec snd_seq snd_rawmidi
snd_pcm snd_seq_device snd_timer i2c_nforce2 ppdev snd ehci_hcd
parport_pc ohci1394 ohci_hcd parport ieee1394 sg snd_page_alloc evdev
k10temp button floppy [last unloaded: scsi_wait_scan]
#
Pid: 1507, comm: md1_raid5 Not tainted 2.6.33.1-rt11 #1
#
Call Trace:
#
 [<ffffffff8138da5a>] ? __schedule+0x38a/0x920
#
 [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
#
 [<ffffffff8138fe30>] ? _raw_spin_unlock+0x10/0x40
#
 [<ffffffff8106a54f>] ? task_blocks_on_rt_mutex+0x17f/0x1e0
#
 [<ffffffff8138e110>] ? schedule+0x10/0x20
#
 [<ffffffff8138f22f>] ? rt_spin_lock_slowlock+0x1ef/0x2c0
#
 [<ffffffff812bcf38>] ? release_stripe+0x28/0x50
#
 [<ffffffff81196d4e>] ? async_xor+0x13e/0x170
#
 [<ffffffff812bee4a>] ? __raid_run_ops+0x48a/0xc60
#
 [<ffffffff812bd140>] ? ops_complete_reconstruct+0x0/0xa0
#
 [<ffffffff812c0ccd>] ? handle_stripe+0x6bd/0x1a70
#
 [<ffffffff812c23f6>] ? raid5d+0x376/0x4f0
#
 [<ffffffff812cd0f3>] ? md_thread+0x53/0x120
#
 [<ffffffff810573a0>] ? autoremove_wake_function+0x0/0x30
#
 [<ffffffff812cd0a0>] ? md_thread+0x0/0x120
#
 [<ffffffff81057016>] ? kthread+0x96/0xa0
#
 [<ffffffff81037908>] ? finish_task_switch+0x58/0xd0
#
 [<ffffffff810032d4>] ? kernel_thread_helper+0x4/0x10
#
 [<ffffffff81056f80>] ? kthread+0x0/0xa0
#
 [<ffffffff810032d0>] ? kernel_thread_helper+0x0/0x10


Udo
