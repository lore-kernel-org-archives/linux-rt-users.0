From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [2.6.23-rt3] NMI watchdog trace of deadlock
Date: Sat, 27 Oct 2007 19:15:42 +1000
Message-ID: <200710271915.42363.nickpiggin@yahoo.com.au>
References: <1193245634.20679.8.camel@localhost.localdomain> <1193462494.25330.7.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:27048 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751366AbXJ0JW0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 05:22:26 -0400
In-Reply-To: <1193462494.25330.7.camel@Homer.simpson.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Saturday 27 October 2007 15:21, Mike Galbraith wrote:
> Greetings,
>
> For quite a while now, RT kernels have been locking up on me
> occasionally while my back is turned.  Yesterday, the little bugger
> finally pounced while my serial console box was up and waiting.
>
> [10138.162953] WARNING: at arch/i386/kernel/smp.c:581
> native_smp_call_function_mask() [10138.170583]  [<c01051da>]
> show_trace_log_lvl+0x1a/0x30
> [10138.175796]  [<c0105de3>] show_trace+0x12/0x14
> [10138.180291]  [<c0105dfb>] dump_stack+0x16/0x18
> [10138.184769]  [<c011609f>] native_smp_call_function_mask+0x138/0x13d
> [10138.191117]  [<c0117606>] smp_call_function+0x1e/0x24
> [10138.196210]  [<c012f85c>] on_each_cpu+0x25/0x50
> [10138.200807]  [<c0115c74>] flush_tlb_all+0x1e/0x20
> [10138.205553]  [<c016caaf>] kmap_high+0x1b6/0x417
> [10138.210118]  [<c011ec88>] kmap+0x4d/0x4f
> [10138.214102]  [<c026a9d8>] ntfs_end_buffer_async_read+0x228/0x2f9
> [10138.220163]  [<c01a0e9e>] end_bio_bh_io_sync+0x26/0x3f
> [10138.225352]  [<c01a2b09>] bio_endio+0x42/0x6d
> [10138.229769]  [<c02c2a08>] __end_that_request_first+0x115/0x4ac
> [10138.235682]  [<c02c2da7>] end_that_request_chunk+0x8/0xa
> [10138.241052]  [<c0365943>] ide_end_request+0x55/0x10a
> [10138.246058]  [<c036dae3>] ide_dma_intr+0x6f/0xac
> [10138.250727]  [<c0366d83>] ide_intr+0x93/0x1e0
> [10138.255125]  [<c015afb4>] handle_IRQ_event+0x5c/0xc9

Looks like ntfs is kmap()ing from interrupt context. Should
be using kmap_atomic instead, I think.

But the ntfs code I have seems to do just that...
