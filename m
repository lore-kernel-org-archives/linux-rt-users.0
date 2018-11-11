From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
Date: Sun, 11 Nov 2018 21:16:00 +0100
Message-ID: <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11.11.2018 20:13, Oleksandr Natalenko wrote:
> Hi.
> 
> I was just curious about PREEMPT_RT and decided to give it a (small)
> shot on my laptop. As a safety measure, I've enabled netconsole to
> catch all the weird stuff that can pop up, and immediately it indeed
> did… in the netconsole code itself (irony):
> 
> ===
> [   64.018949] WARNING: CPU: 0 PID: 1204 at net/core/netpoll.c:372
> netpoll_send_udp+0x3e8/0x3ef
> …
> [   64.019057] CPU: 0 PID: 1204 Comm: bash Not tainted 4.19.0-ig1 #1
> [   64.019058] Hardware name: Dell Inc.          Vostro 3360/0F5DWF,
> BIOS A18 09/25/2013
> [   64.019063] RIP: 0010:netpoll_send_udp+0x3e8/0x3ef
>                                                                [
> 64.019066] Code: dd ff ff 41 ba 86 dd ff ff 49 2b 96 d0 00 00 00 66 41
> 89 96 c6 00 00 00 66 44 89 48 0c 66 45 89 96 c0 00 00 00 e9
>  93 fe ff ff <0f> 0b e9 40 fc ff ff 0f 1f 44 00 00 53 0f b7 57 42 48 89 
> fb 48 8b
> [   64.019068] RSP: 0018:ffffaa6743f87c98 EFLAGS: 00010202
> [   64.019070] RAX: 0000000000000292 RBX: 0000000000000014 RCX: 
> 0000000000000028
> [   64.019072] RDX: 0000000000000014 RSI: ffffffffb1e6a300 RDI: 
> ffff95973d905668
> [   64.019073] RBP: ffffaa6743f87cd8 R08: ffffffffc11f6ba0 R09: 
> 0000000000000000
> [   64.019075] R10: 0000000000000008 R11: 0000000000000000 R12: 
> 00000000000003e8
> [   64.019076] R13: ffff95973d905668 R14: 0000000000000014 R15: 
> ffff95973d905668
> [   64.019079] FS:  00007f2f8b809b80(0000) GS:ffff95976f000000(0000)
> knlGS:0000000000000000
> [   64.019081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   64.019083] CR2: 000055b8e126fbc8 CR3: 0000000415440006 CR4: 
> 00000000001606f0
> [   64.019084] Call Trace:
> [   64.019098]  write_msg+0xd1/0xe0 [netconsole]
> [   64.019107]  console_unlock.part.6+0x55b/0x5a0
> [   64.019115]  ? _raw_spin_unlock_irqrestore+0x20/0x60
> [   64.019120]  vprintk_emit+0x16a/0x1a0
> [   64.019125]  printk_emit+0x44/0x5b
> [   64.019130]  ? _raw_spin_trylock+0x13/0x80
> [   64.019134]  devkmsg_write.cold.16+0x21/0x4e
> [   64.019140]  __vfs_write+0x136/0x1a0
> [   64.019145]  vfs_write+0xa9/0x1a0
> [   64.019149]  ksys_write+0x52/0xc0
> [   64.019156]  do_syscall_64+0x5b/0x170
> [   64.019160]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> …
> ===
> 
> This is a v4.19.1-rt3-based kernel.
> 
> The WARN_ON() is:
> 
> 362 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
> 363 {
> …
> 372     WARN_ON_ONCE(!irqs_disabled());
> …
> 
> If that matters, I have "threadirqs" passed to the kernel.
> 
> Netconsole seems to work even after this warning. Is this OK/expected?
> 
> Thanks.

Oh, I see that write_msg() calls netpoll_send_udp() under 
spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable 
interrupts.

So, the real question here is whether the interrupts should be indeed 
disabled. And if so, -rt should replace spin_lock_irqsave() call there 
with what? local_irq_save()? and get rid of the warning?

-- 
   Oleksandr Natalenko (post-factum)
