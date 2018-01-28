From: Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [ANNOUNCE] v4.14.15-rt12
Date: Sun, 28 Jan 2018 16:10:51 +0100
Message-ID: <20180128151051.m3b3snwjm3xpqjbn@lorien.valinor.li>
References: <20180125151706.v6pgbeixt2jfpph2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180125151706.v6pgbeixt2jfpph2@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi 

On Thu, Jan 25, 2018 at 04:17:06PM +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v4.14.15-rt12 patch set. 
> 
> Changes since v4.14.15-rt11:
> 
>   - Drop ping-sysrq. Since it won't reach mainline in its current shape,
>     lets drop. Suggested by Carsten Emde.
[...]
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.15-rt12.tar.xz

Just a small heads-up: Whilst ping-sysrq.patch was dropped the
included series file still contains:

# NETWORK DEBUGGING AID
ping-sysrq.patch 

Regards,
Salvatore
