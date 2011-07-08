From: "N, Mugunthan V" <mugunthanvnm@ti.com>
Subject: cyclic test crashing
Date: Fri, 8 Jul 2011 22:36:50 +0530
Message-ID: <45EE9921DD12714AB1D7B7B9D2FE208B022EDE626ABD@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52211 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab1GHRG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Jul 2011 13:06:56 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p68H6rB1019843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 8 Jul 2011 12:06:55 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p68H6qxc001927
	for <linux-rt-users@vger.kernel.org>; Fri, 8 Jul 2011 22:36:52 +0530 (IST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I am testing main lined RT features in 2.6.39. When I am testing cyclictest with loading the device with hackbench.

I am using ramdisk of size 125536. At around 3857615 cycles, cyclictest crashes due to data abort. When I increase ramdisk size cyclic test crash cycle count increases.

Pasting the Back Trace

[<c032b0ac>] (dump_stack+0x0/0x1c) from [<c009a870>] (dump_header+0x84/0x19c)
[<c009a7ec>] (dump_header+0x0/0x19c) from [<c009ad0c>] (oom_kill_process+0x4c/0x288)
[<c009acc0>] (oom_kill_process+0x0/0x288) from [<c009b218>] (out_of_memory+0x2d0/0x39c)
[<c009af48>] (out_of_memory+0x0/0x39c) from [<c009e688>] (__alloc_pages_nodemask+0x4ac/0x620)
[<c009e1dc>] (__alloc_pages_nodemask+0x0/0x620) from [<c00a04bc>] (__do_page_cache_readahead+0xe0/0x244)
[<c00a03dc>] (__do_page_cache_readahead+0x0/0x244) from [<c00a064c>] (ra_submit+0x2c/0x34)
[<c00a0620>] (ra_submit+0x0/0x34) from [<c00a08f8>] (ondemand_readahead+0x1c8/0x1d8)
[<c00a0730>] (ondemand_readahead+0x0/0x1d8) from [<c00a0a20>] (page_cache_sync_readahead+0x70/0x78)
[<c00a09b0>] (page_cache_sync_readahead+0x0/0x78) from [<c0098420>] (filemap_fault+0x14c/0x44c)
[<c00982d4>] (filemap_fault+0x0/0x44c) from [<c00aee90>] (__do_fault+0x58/0x400)
[<c00aee38>] (__do_fault+0x0/0x400) from [<c00aff28>] (handle_pte_fault+0x290/0x6b4)
[<c00afc98>] (handle_pte_fault+0x0/0x6b4) from [<c00b08f4>] (handle_mm_fault+0xd8/0xec)
[<c00b081c>] (handle_mm_fault+0x0/0xec) from [<c032fc58>] (do_page_fault+0x164/0x25c)
[<c032faf4>] (do_page_fault+0x0/0x25c) from [<c00342e4>] (do_DataAbort+0x3c/0x9c)
[<c00342a8>] (do_DataAbort+0x0/0x9c) from [<c032de64>] (ret_from_exception+0x0/0x10)

---
Regards,
Mugunthan V N. 

