From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
Date: Wed, 1 Dec 2010 10:59:12 +0100
Message-ID: <AANLkTimnxhzdpuixSaN=g2bVo2gT8Ys1qxQQ6X_AX5bV@mail.gmail.com>
References: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Dumazet <eric.dumazet@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53965 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0LAJ7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Dec 2010 04:59:13 -0500
Received: by wwa36 with SMTP id 36so7175322wwa.1
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Dec 2010 01:59:12 -0800 (PST)
In-Reply-To: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/12/1 Jean-Michel Hautbois <jhautbois@gmail.com>:
> Hi lists !
>
> I measured the latency and the jitter of the RX and TX ethernet paths
> on my MPC5200 board.
> The RX path is quite good, but the TX path can be slow.
>
> [ 1218.976762] [mpc52xx_fec_start_xmit]Delay >30us for dma_map_single
> =3D> 76364 ns
> [ 1219.188405] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single =3D> 34515 ns
> [ 1220.628785] [mpc52xx_fec_start_xmit]Delay >30us for
> bcom_submit_next_buffer =3D> 97273 ns
> [ 1225.776784] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single =3D> 95273 ns
>
> As one can see, this is obviously problematic.
> The first function I analyzed is bcom_submit_next_buffer() =3D> This
> function doesn't do lots of things, except a call to mb().
>
> I have been looking to the "MPC603e RISC Microprocessor User's Manual=
"
> and especially the chapter named "2.3.4.7 Memory Synchronization
> Instructions=E2=80=94UISA".
>
> Here is a paragraph which explains a lot :
>
> "The functions performed by the sync instruction normally take a
> signi=EF=AC=81cant amount of time
> to complete; as a result, frequent use of this instruction may
> adversely affect performance.
> In addition, the number of cycles required to complete a sync
> instruction depends on system
> parameters and on the processor's state when the instruction is issue=
d."
>
> I am using a real time kernel, and this is a problem, as it is not
> deterministic to use this instruction.
> Is there a way to avoid this ?
>
> I will now focus on the dma_map_single() and dma_unmap_single functio=
ns...
>
> Thanks in advance for your help,
> Best Regards,
>
> JM
>

dma_map_single() and dma_unmap_single() have the same instruction set
used inside (sync) because there is a cleaning of cache.
eieio instruction doesn't seem to be faster and I think that because
cache is not inhibited, this is not a good way to do that.

The delay introduced by the use of these instructions can be really
big (about 70-90=C2=B5s) whereas in most cases it is relatively good (a=
bout
10-20=C2=B5s).
This jitter is a problem in my use case, and I think I am not the only =
one :).

One other thing to say : I am using little packets (about 200 bytes).

JM
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
