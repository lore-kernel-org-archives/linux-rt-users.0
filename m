Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB378F58
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147170; cv=none; b=fsB9nzXBcfYIvOu8zVg3jq4+4/QoKDmyH82yMc2PtRUSS7ob8IRglttyBSdxZY3qQNP4Tf4QOlSA+jfXenBRBo23cDP1VjftRWYJR0W97hDYd0oD7tDlLq1DD55BOOCs9JUEsn+/Imt9b+qK5dY3QCMfeCcRTfxVWng712v2Ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147170; c=relaxed/simple;
	bh=kpvcZo230ZMNzMaEpiHq5aViOHFAo/IkoIvr42A9J+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfeFKPiRKaB7s2Xb/o7SmojoOLecHggmdk4BX2NS0rvhUXDy8IUeOZz7DdluRAAvpePTJVGbHMvTKwZYzhEt+K0IpHe8oeUH26Pohj8H4DLsExa6q9AzBNhcenfJWz6PA/yjBlQSbnK32KOw0wgMNm7KcqaP2fdVhVlmi7NUoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MA1c1sVY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFJ/tVBd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MA1c1sVY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFJ/tVBd"
Date: Wed, 29 Jan 2025 11:39:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738147167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9LG22vKI3RGc6mRnifVsQJb1d5U3tY+VWphxpMTdQ8=;
	b=MA1c1sVYK2ENyH3FUvXq39fI/EoEUgRPjvbPgseK45Hn0Fhdx3gA3VEQN9hY6WNQT7MjzG
	Cx9IOhDM97qRiCtEuHU8i6Nv5X0BBOD4/6QoFBjS5ChunfW7yIunT03Ln3F/2NfGbDSFmX
	N6wXYsdsFxRW+3Zu/uhZwCMykaiXZUrMZQfjtweG86kg9SJh5HKTQ2q8CBTledPeGKg6+I
	+CydPbahnjmodvv68HJyObkSCvIMJyB7+eRrQRSj2PHPNphIPvJjDz3ecQvEoiGatYAauz
	xWz841h7yD/4AHvnGoSjctXeASCMghfg7XJC5ayqn48y2xom8AiTjadWC4JLYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738147167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9LG22vKI3RGc6mRnifVsQJb1d5U3tY+VWphxpMTdQ8=;
	b=gFJ/tVBdmNdenLfI+rHCtBX7dgm4R+WYf1vwpyPQy8YVGSE3R5A9Nc19ZVv6YOxVrshCpb
	vK4o10oKvJR59yCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jillian Donahue <jilliandonahue58@gmail.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petesarik@suse.de>,
	linux-rt-users@vger.kernel.org
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
Message-ID: <20250129103925.7TEmpCt_@linutronix.de>
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz>
 <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>

On 2025-01-24 15:21:21 [-0700], Jillian Donahue wrote:
=E2=80=A6
> I have tried the proposed fixes and cherry-picked commits c7d9efdff68e
> and 8653d71ce376 (the equivalent fix in f_midi.c), and upgraded to
> v5.10rt. I still see the spin lock in both cases but the trace is
> slightly different:
>=20
> [  193.010603] kernel BUG at /kernel-source//kernel/locking/rtmutex.c:104=
8!

This means the caller already owns the lock it asked for.

> [  193.010609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  193.010644] Process kworker/4:2H (pid: 847, stack limit =3D 0x00000000=
6e538c8b)
=E2=80=A6
> [  193.010729] Call trace:
=E2=80=A6
> [  193.010742]  f_midi_transmit+0x90/0x5d8 [usb_f_midi]
The lock it asks for

> [  193.010745]  f_midi_complete+0x11c/0x138 [usb_f_midi]
> [  193.010754]  usb_gadget_giveback_request+0x10/0x18
> [  193.010758]  __usbhsg_queue_pop+0x3c/0x58
> [  193.010760]  usbhsg_queue_done+0x44/0x60
> [  193.010763]  usbhsf_pkt_handler+0x80/0x120
> [  193.010766]  usbhs_pkt_start+0x10/0x18
> [  193.010768]  usbhsg_queue_push.isra.0+0x44/0x50
> [  193.010771]  usbhsg_ep_queue+0x2c/0x40
> [  193.010773]  usb_ep_queue+0x24/0x40
> [  193.010776]  f_midi_transmit+0x238/0x5d8 [usb_f_midi]
The lock it already acquired.

> [  193.010779]  f_midi_in_work+0x10/0x18 [usb_f_midi]
> [  193.010786]  process_one_work+0x1e8/0x340
> [  193.010788]  worker_thread+0x40/0x458
> [  193.010792]  kthread+0x16c/0x170
> [  193.010797]  ret_from_fork+0x10/0x1c
=E2=80=A6
>=20
> Let me know if there is anything more useful here or if there's any
> other information I can provide.

Looking at v6.13, the code flow is still the same. I don't see how !RT
is not affected by this. The tasklet to workqueue change didn't change
the logic here, it only changed the API and the context but the
recursion remains.

So a simple "tasklet_hi_schedule(&midi->tasklet);" instead of
"f_midi_transmit(midi)" in f_midi_complete() might do the trick.

> Thanks

Sebastian
