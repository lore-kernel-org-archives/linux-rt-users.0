Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D34C1512
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Sep 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604522; cv=none; b=NZ6+BDkSwIFgVczuTm26JFQRnZotjarBzZNMMS0CrFtQkX48RqYAMelsfeTiMtjS5RASELd9cD89IgkRW4rKdZTm+qZZ6BHnHR+nIDg8vXdsk3QVN4pMsAuPURAvI57o3M5NQZ0/Qd5fiPtyhHXCWqzAv5iqz2nCbaDVYd3xoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604522; c=relaxed/simple;
	bh=iWNjDj7lN8WBIJirbGQqgElppDK5qh62I7oKqKFsGZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIxsI8a5X1ATvUlA43oxWqEYVjudQeZ/L86GSSeW8vSsdhl6TdJt3qYxdOKVsGpQwAv7y0PmPEsxXb2jxw/LZYy6g0w76QzSHgfq+by0aAtVJwd5fTZpRo/Qrwnf0bnvUh57mgo5DYhVQpms4t/4hg3sMD3qRkYY72l+8uX/IXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kN0TZrZm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TG05UkxN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kN0TZrZm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TG05UkxN"
Date: Mon, 28 Sep 2026 16:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790604519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnEQigdlHG1ypjNnz0cF9LkUkgWGPsA/O36jjadZOOA=;
	b=kN0TZrZmYjikSGBBFCPxevPZQb5H8+P4MQzg90p4htnK2t1qr3lIVQUP/R+5iDT14uK9pr
	PoEx0gY3JynADcdi3AZUWdlq2EBVKGk4Thycv7Zd6vPrrzrCjlkoIbf88Wl4YDbWFIkiaO
	OsLI2gQmgnLseNqanm1JkbTH1qGx/j0SjwHHOYoshxB1UIEv+mDzoPJTcep3DglkX1RHz3
	ClTHxGfwsWU/s+MqnazMw22gDXi8Lhu2G/Vli+/TsS2cWDMfgWzhHqsqXk1+iwOzX+9R8B
	WaCRdgrJwi8Qxq78nfTVO18r6R7vOMXVTdCk0v9uGVv3+Q0DAnEodcJJOtY/TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790604519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnEQigdlHG1ypjNnz0cF9LkUkgWGPsA/O36jjadZOOA=;
	b=TG05UkxNYltbXdvf79TLN4WKukn0yhlVR36zQPeW8Wzz1hKP9QzymhefiwUMJrn9mP0cyq
	vyGxOLs47CNgr0BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: williams@redhat.com, vkuznets@redhat.com,
	linux-rt-users@vger.kernel.org
Subject: Re: Console Hang on SMP Secondary CPU Bringup
Message-ID: <20260928140837.058IIp53@linutronix.de>
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>

On 2026-09-23 12:02:31 [-0400], Derek Barbosa wrote:
> In the v6.6-rt-rebase branch in the linux-stable-rt kernel trees, buildin=
g (with
> defconfig and additional HV drivers enabled), installing, then booting a =
kernel
> in a paravirtualized Virtual Machine environment (HyperV in this case) vi=
a UEFI
> boot may result in a unrecoverable "hang"

Does this also occur in v6.6-rt15? If so, can you check v7.3-rc5 and if
it does not occur, try other RT kernels where this started happening?
This HyperV is something I can't try here, can I?

=E2=80=A6
> In any case, the system is completely unresponsive over the any serial co=
nsoles,
> responding to neither SysRQs nor NMIs, even with the appropriate cmdline
> arguments to invoke such behavior.

Does this run in qemu where you could attach gdb and check what the CPUs
are doing?

> It appears as though the behavior in question has been bisected to af3a81=
62581e
> ("serial: 8250: Switch to nbcon console")
>=20
> <snip>
> $ git describe --contains af3a8162581e
>=20
> v6.6.156-rt79-rebase~63
>=20
> $ git show v6.6.156-rt79
> </snip>
>=20
> and is not reproducible prior to this point (it has not been bisectable t=
o any
> HV/HyperV/Xen/etc commits _yet_).
>=20
> IIRC, this commit was reverted in mainline for the time being, as a signi=
ficant
> amount of work was/is being done in tty/serial, etc...

As far as I remember, it was dropped because other driver fall apart.

> It is not entirely clear what effect the commit introduces with regard to=
 the
> smp secondary CPU masking/bringup, and why it would cause a
> seemingly-unrecoverable state prior to the cpuhp callbacks.

It could be unrelated to the driver, just some printk corner case.

> IIUC (and from what I have seen in the traces) at this point in the init
> process, we've disabled earlycon/earlyserial, and have brought up nbcon.
=E2=80=A6
> I have seen in some cases where nbcon 8250 can be slightly slower at boot=
 time,
> which could introduce the possibility of some contention between the incr=
eased
> console verbosity and replacement of send_IPI_all/self() with
> hv_send_ipi_all/self() (this is just conjecturing).

Not sure how this is related. Maybe it is a wakeup for the nbcon thread
on the remote CPU.

=E2=80=A6
> Specifically, I was curious if serial8250_console_write_thread() could
> potentially be the culprit, especially given the fact that we are running=
 in
> CONFIG_PREEMPT_VOLUNTARY as opposed to CONFIG_PREEMPT_RT.

So we are not doing PREEMPT_RT?

> My understanding is shaky at best here, but specifically:
>=20
> <snip>
> 	while (!nbcon_enter_unsafe(wctxt))
> 		nbcon_reacquire(wctxt);
>=20
> 	/* Finally, wait for transmitter to become empty and restore IER. */
> 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> 	if (em485) {
> 		mdelay(port->rs485.delay_rts_after_send);
> 		if (em485->tx_stopped)
> 			up->rs485_stop_tx(up);
> 	}
> 	serial_port_out(port, UART_IER, ier);
> </snip>
>=20
> Is it possible that we just spin here? That we somehow lost ownership at =
some
> point during the secondary CPU startup sequence and cannot restore UART_I=
ER?
> Would this explain the silent console + hang at PID1?

The regular printk path acquires the uart lock. If my memory serves me
right, the take over takes place in atomic context (say from panic()).

> If that is not the case (very plausible) -- what I am still very unsure o=
f, is
> how the atomic 8250 implementation here could affect the rdmsr()s in
> save/get_fixed_ranges(), to the point of intermittently stalling in the H=
yper-V
> VM (MTRR virtualization / SMT sibling) environment?

Me, too. It is just all callback to CPU0 with waiting until it is done.
If CPU1 stalls then CPU0 did not finish=E2=80=A6 CPU0 should be more or less
idle here.

=E2=80=A6
> Many thanks in advance,

The printk version is a bit old but still functional :) If the problem
does not occur in a later kernel then could think about backporting that
printk version back to v6.6 (unless there is a single obvious cause).

Sebastian
