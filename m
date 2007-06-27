From: Manfred Gruber <m.gruber@tirol.com>
Subject: poison_obj latency
Date: Wed, 27 Jun 2007 12:51:57 +0200
Message-ID: <200706271251.58092.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 85-126-107-146.static.sdsl-line.inode.at ([85.126.107.146]:4236
	"EHLO mail.contec.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbXF0KwC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2007 06:52:02 -0400
Received: from comixs.contec-int.at (unknown [192.168.1.250])
	by mail.contec.at (Firewall Mailer Daemon) with ESMTP id 03FD7C086F
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2007 12:51:58 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi !

I use a arm4vt ep93xx processor with 2.6.21.5-rt18. 
When i run cyclictest with -i 10000 and -n -p 90 -b 1000 i see some strange 
latencies in poison_obj.

the output from /proc/latency_trace where the latency is shown:
OLD:cyclicte-884   0.... 13493us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 13830us+:   336us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 13848us+:    18us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 47181us!:     4us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 47514us+:   333us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 47533us+:    18us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 90226us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 90564us+:   338us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 90584us+:    19us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 125182us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 125520us+:   338us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 125540us+:    19us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 157308us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 157644us+:   335us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 157661us+:    17us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0D..1 193339us!:     5us: 
trace_stop_sched_switched+0x14/0x374 (__schedule+0x478/0x5a4)
ACT:cyclicte-884   0.... 193662us+:   323us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 193683us+:    21us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 226083us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 226419us+:   335us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 226438us+:    19us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 258101us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 258438us+:   336us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 258456us+:    18us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 290710us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 291047us+:   336us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 291063us+:    16us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)
OLD:cyclicte-884   0.... 327645us!:     5us: check_poison_obj+0x14/0x1bc 
(cache_alloc_debugcheck_after+0x38/0x160)
ACT:cyclicte-884   0.... 327982us+:   336us: poison_obj+0x10/0x40 
(cache_alloc_debugcheck_after+0x48/0x160)
NEW:cyclicte-884   0.... 328002us+:    20us: get_unused_fd+0x10/0xf4 
(do_sys_open+0x3c/0xe8)

does someone have an idea where this comes from ?

the hole /proc/latency output is shown here:
https://dev.contec.at/micro9/tmp/l_t.txt

-- 
regards
	Manfred Gruber
