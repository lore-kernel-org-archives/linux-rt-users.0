From: "Matthias Klein" <matthias.klein@optimeas.de>
Subject: [3.4.75-rt93] ftrace failed to modify ftrace_swap_recs
Date: Mon, 06 Jan 2014 08:03:02 +0000
Message-ID: <em7b84ae9d-9172-4cd4-bad7-b48fb9e3d834@nb-mak>
References: <20140103213308.10eda039@gandalf.local.home>
Reply-To: "Matthias Klein" <matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from optimeas.de ([78.46.18.2]:43082 "EHLO optimeas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbaAFIMb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jan 2014 03:12:31 -0500
Received: from [127.0.0.1] (p5DCF5945.dip0.t-ipconnect.de [93.207.89.69])
	by optimeas.de (Postfix) with ESMTPSA id 781944207A56
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Jan 2014 09:03:02 +0100 (CET)
In-Reply-To: <20140103213308.10eda039@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I updated from 3.4.69-rt86 to 3.4.75-rt93 on an iMX.537 ARM platform.

Basically the kernel works but I get the following error messages during 
boot:


Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
ftrace: allocating 13405 entries in 40 pages
------------[ cut here ]------------
WARNING: at kernel/trace/ftrace.c:1589 ftrace_bug+0x74/0x174()
Modules linked in:
Backtrace:
[<c0011bfc>] (dump_backtrace+0x0/0x10c) from [<c030dde4>] 
(dump_stack+0x20/0x24)
  r6:c0073060 r5:00000009 r4:00000000 r3:271ae957
[<c030ddc4>] (dump_stack+0x0/0x24) from [<c001f268>] 
(warn_slowpath_common+0x5c/0x74)
[<c001f20c>] (warn_slowpath_common+0x0/0x74) from [<c001f33c>] 
(warn_slowpath_null+0x2c/0x34)
  r8:000008c9 r7:60000153 r6:df807bc0 r5:c0071268 r4:c048a3a0
r3:00000009
[<c001f310>] (warn_slowpath_null+0x0/0x34) from [<c0073060>] 
(ftrace_bug+0x74/0x174)
[<c0072fec>] (ftrace_bug+0x0/0x174) from [<c0073600>] 
(ftrace_process_locs+0x39c/0x474)
  r5:c04d0f40 r4:00000000
[<c0073264>] (ftrace_process_locs+0x0/0x474) from [<c0426880>] 
(ftrace_init+0x98/0x1a4)
[<c04267e8>] (ftrace_init+0x0/0x1a4) from [<c041b7d0>] 
(start_kernel+0x294/0x2dc)
  r8:70004059 r7:c0911e80 r6:c043aeac r5:ffffffff r4:c0456860
[<c041b53c>] (start_kernel+0x0/0x2dc) from [<70008040>] (0x70008040)
  r7:c0459764 r6:c043aea8 r5:c0456050 r4:10c53c7d
---[ end trace 0000000000000001 ]---
ftrace failed to modify [<c0071268>] ftrace_swap_recs+0x2c/0x3c
  actual: 07:00:8e:e8
Setting up static identity map for 0x703136b8 - 0x70313710
devtmpfs: initialized

Has someone a tip whats the problem ?


Best regards,

Matthias


------ Originalnachricht ------
Von: "Steven Rostedt" <rostedt@goodmis.org>
An: "LKML" <linux-kernel@vger.kernel.org>; "linux-rt-users" 
<linux-rt-users@vger.kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>; "Carsten Emde" 
<C.Emde@osadl.org>; "John Kacur" <jkacur@redhat.com>; "Sebastian Andrzej 
Siewior" <bigeasy@linutronix.de>
Gesendet: 04.01.2014 03:33:08
Betreff: [ANNOUNCE] 3.4.75-rt93
>
>Dear RT Folks,
>
>I'm pleased to announce the 3.4.75-rt93 stable release.
>
>
>This release is just an update to the new stable 3.4.75 version
>and no RT specific changes have been made.
>
>
>You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v3.4-rt
>   Head SHA1: 9d111c9c3814158097723d27029a9d214a8cd20e
>
>
>Or to build 3.4.75-rt93 directly, the following patches should be 
>applied:
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.75.xz
>
>   
>http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.75-rt93.patch.xz
>
>
>
>
>Enjoy,
>
>-- Steve
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-rt-users" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at http://vger.kernel.org/majordomo-info.html
>

