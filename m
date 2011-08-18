From: Remy Bohmer <linux@bohmer.net>
Subject: Re: BUG: sleeping function called from invalid context at kernel/rtmutex.c:644
Date: Thu, 18 Aug 2011 20:15:16 +0200
Message-ID: <CANqCtQLV4x86kU6eWoA+DFmcxqrp3_BuxdG2ZKvGrPVf7p6Y5w@mail.gmail.com>
References: <CANFJ_uhVEU+iGMnqA-Kbk=VEx84Y750fyQPnKvB8Qh2t8Qz_pA@mail.gmail.com>
	<CANFJ_uhSJofc9uc0vMGbc_WpupNAtqP2xx=j1qmnzJmqDp-nEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Rosh shah <trinityrosh@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60368 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1HRSPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Aug 2011 14:15:18 -0400
Received: by ewy4 with SMTP id 4so872755ewy.19
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2011 11:15:17 -0700 (PDT)
In-Reply-To: <CANFJ_uhSJofc9uc0vMGbc_WpupNAtqP2xx=j1qmnzJmqDp-nEg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Roshni,

2011/8/18 Rosh shah <trinityrosh@gmail.com>:
> Hi,
>
> I have ported Davinci DM6467T support to the 2.6.33.9-rt for a
> project. I am running into the following issue every time I run the
> encode application gets a DMA interrupt. I have referred to the
> various other instances of the same issue on older RT kernels, but
> haven't gathered a solution for the same. Kindly help me understand
> the issue / throw some light on how I can approach the solution.
> Any thoughts are greatly appreciated.
>
> Aug 16 14:44:01 dm6467t-evm user.debug kernel: dma complete=A0 <INSER=
TED
> BY B.J this is when the DMA ISR is called>
> Aug 16 14:44:01 dm6467t-evm user.err kernel: BUG: sleeping function
> called from invalid context at kernel/rtmutex.c:644

Looking at the backtrace, first guess: the dmaIsr() function tries to
call complete() with preemption and/or interrupts disabled.
In that case it runs into a regular spinlock that is converted to a
rt_mutex which, due to its nature, might sleep, which on its turn is
illegal in that context.

Kind regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
