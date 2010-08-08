From: Maksym Parkachov <lazy.gopher@gmail.com>
Subject: Re: beagleboard RT problem
Date: Sun, 8 Aug 2010 14:27:21 +0200
Message-ID: <AANLkTimSmZ+nDtex6cip7=yTG=oLpxLD8VmHxcKZTote@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
	<1276514850.26993.4.camel@sven.thebigcorporation.com>
	<AANLkTimWSQfXQGedfHHLAbabPrRnUaWlPCMUEC3I9_G0@mail.gmail.com>
	<AANLkTikP0Z8NbhiCd9yJeNJrnJqJkoXkSSErR_9B6dYC@mail.gmail.com>
	<AANLkTilakntJf43kOkuT0EVu6v3s17VNJR6S60lB2ls3@mail.gmail.com>
	<AANLkTinojaU-FL3K3C09hV9-qrr8ZdjA8fzDMWTeQh_k@mail.gmail.com>
	<1277218015.10664.5.camel@sven.thebigcorporation.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED2FC9@dbde02.ent.ti.com>
	<AANLkTileTAXkfHwhSruyWhZqpPkEr4KnEGyf1fUQqaPw@mail.gmail.com>
	<AANLkTinXgWGaFX+yDvrgU-KnXfCFpcL+ccP1N4j6fmEX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53691 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0HHM1W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 8 Aug 2010 08:27:22 -0400
Received: by iwn33 with SMTP id 33so2873297iwn.19
        for <linux-rt-users@vger.kernel.org>; Sun, 08 Aug 2010 05:27:22 -0700 (PDT)
In-Reply-To: <AANLkTinXgWGaFX+yDvrgU-KnXfCFpcL+ccP1N4j6fmEX@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Folks,

one more thing, when I run pi_stess, I got on console:

sched: RT throttling activated

After I set root to be ext2, the result is very similar:

root@beagleboard:~/rt-tests# cat /proc/latency_stats
Latency Top version : v0.1
18 2317 387 do_wait sys_wait4 ret_fast_syscall
2 864 447 n_tty_read tty_read vfs_read sys_read ret_fast_syscall
1 1043 1043 sync_page __lock_page do_read_cache_page
read_cache_page_async read_cache_page ext2_get_page ext2_readdir
vfs_readdir sys_getdents64 ret_fast
3 2115 715 sync_buffer __wait_on_buffer __bread ext2_get_inode
ext2_iget ext2_lookup do_lookup link_path_walk path_walk
do_path_lookup user_path_at vfs_f
1 3457 3457 sync_buffer __wait_on_buffer __bread ext2_get_branch
ext2_get_block do_mpage_readpage mpage_readpages ext2_readpages
__do_page_cache_readahea
1 3695 3695 sync_page __lock_page find_lock_page filemap_fault
__do_fault handle_mm_fault do_page_fault do_translation_fault
do_DataAbort __dabt_svc __cl
1 1951545 1951545 sync_page wait_on_page_bit
truncate_inode_pages_range truncate_inode_pages truncate_pagecache
vmtruncate inode_setattr ext2_setattr not
1 119 119 get_signal_to_deliver do_notify_resume work_pending

Thanks,
Maksym.
