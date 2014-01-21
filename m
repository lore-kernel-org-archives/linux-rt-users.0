From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [3.4.75-rt93] ftrace failed to modify ftrace_swap_recs
Date: Mon, 20 Jan 2014 21:10:17 -0500
Message-ID: <20140120211017.0947b07b@gandalf.local.home>
References: <20140103213308.10eda039@gandalf.local.home>
	<em7b84ae9d-9172-4cd4-bad7-b48fb9e3d834@nb-mak>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: "Matthias Klein" <matthias.klein@optimeas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:3904 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751543AbaAUCKT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jan 2014 21:10:19 -0500
In-Reply-To: <em7b84ae9d-9172-4cd4-bad7-b48fb9e3d834@nb-mak>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Don't be afraid to include me on Cc's. You'll get a quicker answer.

On Mon, 06 Jan 2014 08:03:02 +0000
"Matthias Klein" <matthias.klein@optimeas.de> wrote:

> Hello,
> 
> I updated from 3.4.69-rt86 to 3.4.75-rt93 on an iMX.537 ARM platform.
> 
> Basically the kernel works but I get the following error messages during 
> boot:
> 
> 
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> ftrace: allocating 13405 entries in 40 pages
> ------------[ cut here ]------------
> WARNING: at kernel/trace/ftrace.c:1589 ftrace_bug+0x74/0x174()
> Modules linked in:
> Backtrace:
> [<c0011bfc>] (dump_backtrace+0x0/0x10c) from [<c030dde4>] 
> (dump_stack+0x20/0x24)
>   r6:c0073060 r5:00000009 r4:00000000 r3:271ae957
> [<c030ddc4>] (dump_stack+0x0/0x24) from [<c001f268>] 
> (warn_slowpath_common+0x5c/0x74)
> [<c001f20c>] (warn_slowpath_common+0x0/0x74) from [<c001f33c>] 
> (warn_slowpath_null+0x2c/0x34)
>   r8:000008c9 r7:60000153 r6:df807bc0 r5:c0071268 r4:c048a3a0
> r3:00000009
> [<c001f310>] (warn_slowpath_null+0x0/0x34) from [<c0073060>] 
> (ftrace_bug+0x74/0x174)
> [<c0072fec>] (ftrace_bug+0x0/0x174) from [<c0073600>] 
> (ftrace_process_locs+0x39c/0x474)
>   r5:c04d0f40 r4:00000000
> [<c0073264>] (ftrace_process_locs+0x0/0x474) from [<c0426880>] 
> (ftrace_init+0x98/0x1a4)
> [<c04267e8>] (ftrace_init+0x0/0x1a4) from [<c041b7d0>] 
> (start_kernel+0x294/0x2dc)
>   r8:70004059 r7:c0911e80 r6:c043aeac r5:ffffffff r4:c0456860
> [<c041b53c>] (start_kernel+0x0/0x2dc) from [<70008040>] (0x70008040)
>   r7:c0459764 r6:c043aea8 r5:c0456050 r4:10c53c7d
> ---[ end trace 0000000000000001 ]---
> ftrace failed to modify [<c0071268>] ftrace_swap_recs+0x2c/0x3c
>   actual: 07:00:8e:e8
> Setting up static identity map for 0x703136b8 - 0x70313710
> devtmpfs: initialized
> 
> Has someone a tip whats the problem ?

Strange, it tried to convert ftrace_swap_recs, but that should not have
been even in the table to modify, as ftrace_swap_recs is in ftrace.c,
which disables all -pg added in the compile.

Try a make clean and build again. Something may have been screwed up in
the compile.

-- Steve
