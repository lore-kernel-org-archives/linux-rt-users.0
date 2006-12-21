From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.20-rc1-rt1 Panic on reboot after fresh kernel compile
Date: Thu, 21 Dec 2006 16:31:45 +0100
Message-ID: <20061221153142.GA19242@elte.hu>
References: <458AA2F4.4080601@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	"Gautam H. Thaker" <gthaker@atl.lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46969 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422868AbWLUPej (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Dec 2006 10:34:39 -0500
To: Jonathan Walsh <jwalsh@atl.lmco.com>
Content-Disposition: inline
In-Reply-To: <458AA2F4.4080601@atl.lmco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Jonathan Walsh <jwalsh@atl.lmco.com> wrote:

> I also saw this yesterday in 2.6.19.1-rt15, retried today with the ne=
w=20
> patch and saw the same result.  This error only occurs with the RT=20
> patches applied, 2.6.20-rc1 (and 2.6.19.1) boots fine with the same=20
> config.  After a clean compilation and install run, I reboot and=20
> receive the following console error message before hanging:
>=20
> ...
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12ac
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enab=
led
> =FFserial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a NS16550A
> [a few hundred junk characters]
> Creating root deKernel panic - not syncing: Attempted to kill init!
> [<c0118c60>] panic+0x50/0x100
> [<c011bd59>] do_exit+0x6d9/0xa50
> [<c0158fe9>] remove_vma+0x39/0x50
> [<c015a56a>] do_munmap+0x19a/0x1f0
> [<c011c104>] do_group_exit+0x34/0xb0
> [<c015a608>] sys_munmap+0x48/0x60
> [<c010316f>] syscall_call+0x7/0xb
> [<c044007b>] packet_seq_start+0x2b/0x80
>=20
> This is of course snipped to the last few relevant lines.  This is a=20
> reproducible message so I can rerun and give the entire console log i=
f=20
> it would be helpful, or if any other information at all would be=20
> useful.

yeah, please try to capture a full (serial?) log of the incident. Also=20
please enable CONFIG_UNWIND_INFO and CONFIG_STACK_UNWIND to get easier=20
to read stack-traces. (the packet_seq_start() entry looks really out of=
=20
place in the trace above)

	Ingo
