From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
Date: Wed, 01 Dec 2010 09:52:10 -0500
Message-ID: <1291215130.4881.55.camel@gandalf.stny.rr.com>
References: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-rt-users@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:50484 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0LAOwN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Dec 2010 09:52:13 -0500
In-Reply-To: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-12-01 at 09:16 +0100, Jean-Michel Hautbois wrote:
> Hi lists !
>=20
> I measured the latency and the jitter of the RX and TX ethernet paths
> on my MPC5200 board.
> The RX path is quite good, but the TX path can be slow.
>=20
> [ 1218.976762] [mpc52xx_fec_start_xmit]Delay >30us for dma_map_single
> =3D> 76364 ns
> [ 1219.188405] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single =3D> 34515 ns
> [ 1220.628785] [mpc52xx_fec_start_xmit]Delay >30us for
> bcom_submit_next_buffer =3D> 97273 ns
> [ 1225.776784] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single =3D> 95273 ns
>=20
> As one can see, this is obviously problematic.
> The first function I analyzed is bcom_submit_next_buffer() =3D> This
> function doesn't do lots of things, except a call to mb().
>=20
> I have been looking to the "MPC603e RISC Microprocessor User's Manual=
"
> and especially the chapter named "2.3.4.7 Memory Synchronization
> Instructions=E2=80=94UISA".
>=20
> Here is a paragraph which explains a lot :
>=20
> "The functions performed by the sync instruction normally take a
> signi=EF=AC=81cant amount of time
> to complete; as a result, frequent use of this instruction may
> adversely affect performance.
> In addition, the number of cycles required to complete a sync
> instruction depends on system
> parameters and on the processor's state when the instruction is issue=
d."
>=20
> I am using a real time kernel, and this is a problem, as it is not
> deterministic to use this instruction.
> Is there a way to avoid this ?

Don't use that hardware.

When working with drivers there are times you must sync with the device=
=2E
And if the device is nondeterministic, then find another set of hardwar=
e
to use. Unfortunately, I think you may not find any.

A mb() is usually used if you do a write to device and read from it.
With out it, the CPU could perform the read before the write, which
would give you an incorrect result. There's no other way around that.

-- Steve

>=20
> I will now focus on the dma_map_single() and dma_unmap_single functio=
ns...
>=20
> Thanks in advance for your help,
> Best Regards,
>=20
> JM


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
