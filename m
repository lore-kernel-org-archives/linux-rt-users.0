From: Wolfgang Steinwender <wolfgang@psysteme.de>
Subject: Problem with hwlat detector in smp_processor_id()
Date: Thu, 09 Jul 2009 13:32:10 +0200
Message-ID: <4A55D53A.6040108@psysteme.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60484 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbZGILcN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2009 07:32:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone,

I'm doing some testing here. When I'm trying
the hardware latency test (hwlatdetect.py) I'm
getting the following messages:

hwlat_detector: version 1.0.0
BUG: using smp_processor_id() in preemptible [00000000] code:
hwlatdetect/3755
caller is debug_sample_fread+0x138/0x1ea [hwlat_detector]
Pid: 3755, comm: hwlatdetect Tainted: G          N
2.6.29.5-M-jen80-rtpae-debug #1
Call Trace:
 [<c035be0b>] ? printk+0x14/0x19
 [<c02403df>] debug_smp_processor_id+0xb3/0xc8
 [<f855061f>] debug_sample_fread+0x138/0x1ea [hwlat_detector]
 [<c020fed8>] ? security_file_permission+0x14/0x16
 [<c01b8a65>] ? rw_verify_area+0x8f/0xb1
 [<f85504e7>] ? debug_sample_fread+0x0/0x1ea [hwlat_detector]
 [<c01b93b5>] vfs_read+0x8e/0x138
 [<c01b9502>] sys_read+0x40/0x65
 [<c0102cdc>] sysenter_do_call+0x12/0x2d

The message is printed for every poll.
Manually loading the hwlat module and reading "sample" produces
the same message.

I'm using a SuSE kernel with RT-Patches from j.eng (recompiled
with hwlat Module). Version should roughly be 2.6.29.5-rt20,
PAE is enabled. CPU is a dual core.

The offending source could be:
mutex_lock(&ring_buffer_mutex);
e = ring_buffer_consume(ring_buffer, smp_processor_id(), NULL);

I'm wondering, because the seems to run at least for some people.
Can it be a problem with my kernel?


Best regards,
W. Steinwender

