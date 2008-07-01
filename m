From: "Noah Watkins" <noahwatkins@gmail.com>
Subject: Re: [BUG RT] 2.6.25.8-rt7 on 8-way
Date: Tue, 1 Jul 2008 14:08:51 -0500
Message-ID: <7618ba960807011208n3aacbc65l41255e3996d2ee4b@mail.gmail.com>
References: <7618ba960806291432l20b7b6b5lea4b60bafa68c3bf@mail.gmail.com>
	 <1214778205.13292.6.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0806300835050.5403@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sven-Thorsten Dietrich" <sven@thebigcorporation.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	paulmck <paulmck@linux.vnet.ibm.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:65379 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbYGATIw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Jul 2008 15:08:52 -0400
Received: by yx-out-2324.google.com with SMTP id 8so17586yxm.1
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Jul 2008 12:08:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0806300835050.5403@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

While I have disabled RCU tracing to suppress the messages, I am
getting them in another context:

BUG: using smp_processor_id() in preemptible [00000000] code: sshd/3114
caller is __qdisc_run+0x12e/0x1b5
Pid: 3114, comm: sshd Not tainted 2.6.25.8-rt7 #3

Call Trace:
 [<ffffffff8112da39>] debug_smp_processor_id+0xad/0xb8
 [<ffffffff8120e264>] __qdisc_run+0x12e/0x1b5
 [<ffffffff811ff1c8>] dev_queue_xmit+0x140/0x278
 [<ffffffff8122239e>] ip_queue_xmit+0x2c2/0x350
 [<ffffffff8127f8a6>] add_preempt_count+0x12/0x94
 [<ffffffff8108263e>] __inc_zone_state+0x6a/0x88
 [<ffffffff81231ffe>] tcp_transmit_skb+0x77e/0x7ba
 [<ffffffff8109aa60>] kmem_cache_alloc_node+0x129/0x152
 [<ffffffff81233a75>] __tcp_push_pending_frames+0x713/0x7df
 [<ffffffff81228da2>] tcp_sendmsg+0x93a/0xa52
 [<ffffffff811f0e97>] sock_aio_write+0xf8/0x110
 [<ffffffff8109feeb>] do_sync_write+0xc9/0x10c
 [<ffffffff81046da6>] autoremove_wake_function+0x0/0x2e
 [<ffffffff8103868b>] current_fs_time+0x1e/0x24
 [<ffffffff810a06ae>] vfs_write+0xc0/0x156
 [<ffffffff810a0c67>] sys_write+0x48/0x74
 [<ffffffff8100bf6b>] tracesys+0xdc/0xe1


On Mon, Jun 30, 2008 at 7:37 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 29 Jun 2008, Sven-Thorsten Dietrich wrote:
>
>>
>> On Sun, 2008-06-29 at 16:32 -0500, Noah Watkins wrote:
>> > My kernel is very, very noisy with the following bug:
>> >
>> > - Full dmesg below
>> > - Please CC me
>> >
>>
>> I found this as well (adding Paul).
>>
>> If you disable CONFIG_PREEMPT_RCU_BOOST, does it go away?
>>
>
> Turning off CONFIG_RCU_TRACE will also make it go away. The bug is that
> the tracing of the RCU boost code uses smp_processor_id while the RCU
> boost code is not in an atomic section.
>
> Paul has a fix for this already, and will be out in the next releases.
>
> -- Steve
>
