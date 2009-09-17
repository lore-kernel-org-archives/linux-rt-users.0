From: Georg Mill <info@georgmill.de>
Subject: xjadeo
Date: Thu, 17 Sep 2009 15:19:02 +0200
Message-ID: <20090917151902.f6676667.info@georgmill.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from csmtp2.one.com ([195.47.247.206]:47566 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbZIQN3Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Sep 2009 09:29:16 -0400
Received: from myLap (port-92-192-49-198.dynamic.qsc.de [92.192.49.198])
	by csmtp2.one.com (Postfix) with ESMTP id 6A4D61B00681F
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Sep 2009 13:19:03 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I found the following bug on a machine with 4 cpu's. I tried to synchronize sound and video with xjadeo and ardour and jackd and got the following error.
This error appears also within the other cpu's. I used the last svn-sources (svn co https://xjadeo.svn.sourceforge.net/svnroot/xjadeo xjadeo). With kernel 2.6.29.6-rt23 that problem didn't appear.

---snip---

kernel: [  199.899987] BUG: scheduling while atomic: xjadeo/0x1000020b/5117, CPU#3
Sep 17 14:17:01 myLap kernel: [  199.899990] Modules linked in: snd_usb_audio snd_usb_lib snd_hwdep cbc cryptd aes_x86_64 aes_generic ppdev bridge stp bnep capifs binfmt_misc coretemp lp parport xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ipt_REJECT snd_hda_codec_nvhdmi xt_limit snd_hda_codec_realtek ipt_LOG joydev snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss arc4 ecb nf_conntrack_ftp snd_pcm nf_conntrack iptable_filter snd_seq_dummy ip_tables iwlagn snd_seq_oss x_tables iwlcore snd_seq_midi snd_rawmidi snd_seq_midi_event uvcvideo snd_seq snd_timer snd_seq_device acer_wmi mac80211 videodev snd psmouse v4l1_compat iTCO_wdt soundcore v4l2_compat_ioctl32 serio_raw cfg80211 led_class iTCO_vendor_support snd_page_alloc pcspkr video nvidia(P) output usbhid tg3
Sep 17 14:17:01 myLap kernel: [  199.900044] Pid: 5117, comm: xjadeo Tainted: P           2.6.31-rt10-rev01 #1
Sep 17 14:17:01 myLap kernel: [  199.900046] Call Trace:
Sep 17 14:17:01 myLap kernel: [  199.900050]  [<ffffffff8104ed2d>] ? finish_task_switch+0x6d/0x130
Sep 17 14:17:01 myLap kernel: [  199.900054]  [<ffffffff8104ecaa>] __schedule_bug+0x6a/0x80
Sep 17 14:17:01 myLap kernel: [  199.900058]  [<ffffffff81510d10>] thread_return+0x1ae/0x78e
Sep 17 14:17:01 myLap kernel: [  199.900062]  [<ffffffff81015f07>] ? show_trace_log_lvl+0x57/0x70
Sep 17 14:17:01 myLap kernel: [  199.900067]  [<ffffffff81052a67>] __cond_resched+0x27/ 199.900509]  [<ffffffff810df0fc>] ra_submit+0x1c/0x20
Sep 17 14:17:01 myLap kernel: [  199.900512]  [<ffffffff810df32b>] ondemand_readahead+0x12b/0x260
Sep 17 14:17:01 myLap kernel: [  199.900517]  [<ffffffff810df4f9>] page_cache_async_readahead+0x99/0xb0
Sep 17 14:17:01 myLap kernel: [  199.900521]  [<ffffffff810d75e7>] generic_file_aio_read+0x377/0x690
Sep 17 14:17:01 myLap kernel: [  199.900525]  [<ffffffff8108e303>] ? is_module_text_address+0x53/0x60
Sep 17 14:17:01 myLap kernel: [  199.900530]  [<ffffffff811ea8a0>] ecryptfs_read_update_atime+0x20/0x70
Sep 17 14:17:01 myLap kernel: [  199.900534]  [<ffffffff8110ff21>] do_sync_read+0xf1/0x140
Sep 17 14:17:01 myLap kernel: [  199.900538]  [<ffffffff81075c40>] ? autoremove_wake_function+0x0/0x40
Sep 17 14:17:01 myLap kernel: [  199.900542]  [<ffffffff8107fb96>] ? ktime_get_ts+0xb6/0xe0
Sep 17 14:17:01 myLap kernel: [  199.900546]  [<ffffffff81120a47>] ? poll_select_copy_remaining+0xf7/0x150
Sep 17 14:17:01 myLap kernel: [  199.900551]  [<ffffffff81213a31>] ? security_file_permission+0x11/0x20
Sep 17 14:17:01 myLap kernel: [  199.900555]  [<ffffffff81110728>] vfs_read+0xc8/0x1a0
Sep 17 14:17:01 myLap kernel: [  199.900558]  [<ffffffff811108f0>] sys_read+0x50/0x90
Sep 17 14:17:01 myLap kernel: [  199.900563]  [<ffffffff81012002>] system_call_fastpath+0x16/0x1b
Sep 17 14:17:01 myLap kernel: [  199.900695] BUG: scheduling while atomic: xjadeo/0x0000020b/5117, CPU#3
Sep 17 14:17:01 myLap kernel: [  199.900698] Modules linked in: snd_usb_audio snd_usb_lib snd_hwdep cbc cryptd aes_x86_64 aes_generic ppdev bridge stp bnep capifs binfmt_misc coretemp lp parport xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state ipt_REJECT snd_hda_codec_nvhdmi xt_limit snd_hda_codec_realtek ipt_LOG joydev snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss arc4 ecb nf_conntrack_ftp snd_pcm nf_conntrack iptable_filter snd_seq_dummy ip_tables iwlagn snd_seq_oss x_tables iwlcore snd_seq_midi snd_rawmidi snd_seq_midi_event uvcvideo snd_seq snd_timer snd_seq_device acer_wmi mac80211 videodev snd psmouse v4l1_compat iTCO_wdt soundcore v4l2_compat_ioctl32 serio_raw cfg80211 led_class iTCO_vendor_support snd_page_alloc pcspkr video nvidia(P) output usbhid tg3
Sep 17 14:17:01 myLap kernel: [  199.900750] Pid: 5117, comm: xjadeo Tainted: P           2.6.31-rt10-rev01 #1
Sep 17 14:17:01 myLap kernel: [  199.900752] Call Trace:
Sep 17 14:17:01 myLap kernel: [  199.900756]  [<ffffffff8104ecaa>] __schedule_bug+0x6a/0x80
Sep 17 14:17:01 myLap kernel: [  199.900760]  [<ffffffff81510d10>] thread_return+0x1ae/0x78e
Sep 17 14:17:01 myLap kernel: [  199.900764]  [<ffffffff81015f07>] ? show_trace_log_lvl+0x57/0x70
Sep 17 14:17:01 myLap kernel: [  199.900769]  [<ffffffff81010505>] ? __switch_to+0x2a5/0x320
Sep 17 14:17:01 myLap kernel: [  199.900772]  [<ffffffff815114c4>] schedule+0x14/0x30
Sep 17 14:17:01 myLap kernel: [  199.900776]  [<ffffffff81511517>] io_schedule+0x37/0x50
Sep 17 14:17:01 myLap /USR/SBIN/CRON[5139]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
Sep 17 14:17:01 myLap kernel: [  199.900780]  [<ffffffff810d5e2d>] sync_page+0x3d/0x70
Sep 17 14:17:01 myLap kernel: [  199.900784]  [<ffffffff810d5e69>] sync_page_killable+0x9/0x50
Sep 17 14:17:01 myLap kernel: [  199.900787]  [<ffffffff81511972>] __wait_on_bit_lock+0x52/0xb0
Sep 17 14:17:01 myLap kernel: [  199.900791]  [<ffffffff810d5e60>] ? sync_page_killable+0x0/0x50
Sep 17 14:17:01 myLap kernel: [  199.900795]  [<ffffffff810d5d64>] __lock_page_killable+0x64/0x70
Sep 17 14:17:01 myLap kernel: [  199.900799]  [<ffffffff81075c80>] ? wake_bit_function+0x0/0x40
Sep 17 14:17:01 myLap kernel: [  199.900804]  [<ffffffff810d7625>] generic_file_aio_read+0x3b5/0x690
Sep 17 14:17:01 myLap kernel: [  199.900808]  [<ffffffff8110ff21>] do_sync_read+0xf1/0x140
Sep 17 14:17:01 myLap kernel: [  199.900812]  [<ffffffff81075c40>] ? autoremove_wake_function+0x0/0x40
Sep 17 14:17:01 myLap kernel: [  199.900816]  [<ffffffff810dc2d9>] ? __alloc_pages_nodemask+0x109/0x660
Sep 17 14:17:01 myLap kernel: [  199.900821]  [<ffffffffa0d36710>] ? aes_decrypt+0x0/0x10 [aes_x86_64]
Sep 17 14:17:01 myLap kernel: [  199.900826]  [<ffffffff81213a31>] ? security_file_permission+0x11/0x20
Sep 17 14:17:01 myLap kernel: [  199.900829]  [<ffffffff81110728>] vfs_read+0xc8/0x1a0
Sep 17 14:17:01 myLap kernel: [  199.900833]  [<ffffffff811ee71f>] ecryptfs_read_lower+0x6f/0xd0
Sep 17 14:17:01 myLap kernel: [  199.900837]  [<ffffffff811f0c6c>] ecryptfs_decrypt_page+0x16c/0x4d0
Sep 17 14:17:01 myLap kernel: [  199.900841]  [<ffffffff8110cf2b>] ? mem_cgroup_cache_charge+0x10b/0x140
Sep 17 14:17:01 myLap kernel: [  199.900845]  [<ffffffff810e002b>] ? __lru_cache_add+0xcb/0xf0
Sep 17 14:17:01 myLap kernel: [  199.900849]  [<ffffffff811ee0c8>] ecryptfs_readpage+0xd8/0x160
Sep 17 14:17:01 myLap kernel: [  199.900852]  [<ffffffff810df052>] __do_page_cache_readahead+0x1b2/0x240
Sep 17 14:17:01 myLap kernel: [  199.900856]  [<ffffffff81267457>] ? vsnprintf+0x217/0x5f0
Sep 17 14:17:01 myLap kernel: [  199.900860]  [<ffffffff810df0fc>] ra_submit+0x1c/0x20
Sep 17 14:17:01 myLap kernel: [  199.900863]  [<ffffffff810df32b>] ondemand_readahead+0x12b/0x260
Sep 17 14:17:01 myLap kernel: [  199.900867]  [<ffffffff810df4f9>] page_cache_async_readahead+0x99/0xb0
Sep 17 14:17:01 myLap kernel: [  199.900872]  [<ffffffff810d75e7>] generic_file_aio_read+0x377/0x690
Sep 17 14:17:01 myLap kernel: [  199.900876]  [<ffffffff8108e303>] ? is_module_text_address+0x53/0x60
Sep 17 14:17:01 myLap kernel: [  199..902328]  [<ffffffff8104ed2d>] ? finish_task_switch+0x6d/0x130
Sep 17 14:17:01 myLap kernel: [  199.902332]  [<ffffffff8104ecaa>] __schedule_bug+0x6a/0x80
Sep 17 14:17:01 myLap kernel: [  199.902336]  [<ffffffff81510d10>] thread_return+0x1ae/0x78e
Sep 17 14:17:01 myLap kernel: [  199.902340]  [<ffffffff81010505>] ? __switch_to+0x2a5/0x320
Sep 17 14:17:01 myLap kernel: [  199.902344]  [<ffffffff815114c4>] schedule+0x14/0x30
Sep 17 14:17:01 myLap kernel: [  199.902347]  [<ffffffff81511517>] io_schedule+0x37/0x50
Sep 17 14:17:01 myLap kernel: [  199.902351]  [<ffffffff810d5e2d>] sync_page+0x3d/0x70
Sep 17 14:17:01 myLap kernel: [  199.902355]  [<ffffffff810d5e69>] sync_page_killable+0x9/0x50
Sep 17 14:17:01 myLap kernel: [  199.902359]  [<ffffffff81511972>] __wait_on_bit_lock+0x52/0xb0
Sep 17 14:17:01 myLap kernel: [  199.902363]  [<ffffffff810d5e60>] ? sync_page_killable+0x0/0x50
Sep 17 14:17:01 myLap kernel: [  199.902367]  [<ffffffff810d5d64>] __lock_page_killable+0x64/0x70
Sep 17 14:17:01 myLap kernel: [  199.902371]  [<ffffffff81075c80>] ? wake_bit_function+0x0/0x40
Sep 17 14:17:01 myLap kernel: [  199.902375]  [<ffffffff810d7625>] generic_file_aio_read+0x3b5/0x690
Sep 17 14:17:01 myLap kernel: [  199.902380]  [<ffffffff8110ff21>] do_sync_read+0xf1/0x140
Sep 17 14:17:01 myLap kernel: [  199.902384]  [<ffffffff81075c40>] ? autoremove_wake_function+0x0/0x40
Sep 17 14:17:01 myLap kernel: [  199.902388]  [<ffffffff810dc2d9>] ? __alloc_pages_nodemask+0x109/0x660
Sep 17 14:17:01 myLap kernel: [  199.902393]  [<ffffffffa0d36710>] ? aes_decrypt+0x0/0x10 [aes_x86_64]
Sep 17 14:17:01 myLap kernel: [  199.902397]  [<ffffffff81213a31>] ? security_file_permission+0x11/0x20
Sep 17 14:17:01 myLap kernel: [  199.902401]  [<ffffffff81110728>] vfs_read+0xc8/0x1a0
Sep 17 14:17:01 myLap kernel: [  199.902405]  [<ffffffff811ee71f>] ecryptfs_read_lower+0x6f/0xd0
Sep 17 14:17:01 myLap kernel: [  199.902409]  [<ffffffff811f0c6c>] ecryptfs_decrypt_page+0x16c/0x4d0
Sep 17 14:17:01 myLap kernel: [  199.902413]  [<ffffffff8110cf2b>] ? mem_cgroup_cache_charge+0x10b/0x140
Sep 17 14:17:01 myLap kernel: [  199.902417]  [<ffffffff810e002b>] ? __lru_cache_add+0xcb/0xf0
Sep 17 14:17:01 myLap kernel: [  199.902420]  [<ffffffff811ee0c8>] ecryptfs_readpage+0xd8/0x160
Sep 17 14:17:01 myLap kernel: [  199.902424]  [<ffffffff810df052>] __do_page_cache_readahead+0x1b2/0x240
Sep 17 14:17:01 myLap kernel: [  199.902428]  [<ffffffff81267457>] ? vsnprintf+0x217/0x5f0
Sep 17 14:17:01 myLap kernel: [  199.902432]  [<ffffffff810df0fc>] ra_submit+0x1c/0x20
Sep 17 14:17:01 myLap kernel: [  199.902435]  [<ffffffff810df32b>] ondemand_readahead+0x12b/0x260
Sep 17 14:17:01 myLap kernel: [  199.902439]  [<ffffffff810df4f9>] page_cache_async_readahead+0x99/0xb0
Sep 17 14:17:01 myLap kernel: [  199.902444]  [<ffffffff810d75e7>] generic_file_aio_read+0x377/0x690
Sep 17 14:17:01 myLap kernel: [  199.902448]  [<ffffffff8108e303>] ? is_module_text_address+0x53/0x60
Sep 17 14:17:01 myLap kernel: [  199.902452]  [<ffffffff811ea8a0>] ecryptfs_read_update_atime+0x20/0x70
Sep 17 14:17:01 myLap kernel: [  199.902456]  [<ffffffff8110ff21>] do_sync_read+0xf1/0x140
Sep 17 14:17:01 myLap kernel: [  199.902460]  [<ffffffff81075c40>] ? autoremove_wake_function+0x0/0x40
Sep 17 14:17:01 myLap kernel: [  199.902464]  [<ffffffff8107fb96>] ? ktime_get_ts+0xb6/0xe0
Sep 17 14:17:01 myLap kernel: [  199.902468]  [<ffffffff81120a47>] ? poll_select_copy_remaining+0xf7/0x150
Sep 17 14:17:01 myLap kernel: [  199.902473]  [<ffffffff81213a31>] ? security_file_permission+0x11/0x20
Sep 17 14:17:01 myLap kernel: [  199.902476]  [<ffffffff81110728>] vfs_read+0xc8/0x1a0
Sep 17 14:17:01 myLap kernel: [  199.902480]  [<ffffffff811108f0>] sys_read+0x50/0x90
Sep 17 14:17:01 myLap kernel: [  199.902484]  [<ffffffff81012002>] system_call_fastpath+0x16/0x1b

--snap--
