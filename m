Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698123DE
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129701; cv=none; b=KpQoorN69gGpnDWMiqRcpJh1N2ieaUvfn+A8qgazgBmKnqtCzDi/CkIyhPbRMa/MX3qARfkRVQMP2TWhkNhogweLNtYS2BRKuOabZdjPgBW/lzh65VeQep/Hkk22MePovHX1ugNX8dTm1hpvedLcMXl2Apr2H0J7tLwI5qm2Mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129701; c=relaxed/simple;
	bh=TxFDmPmW7tEsz5guEbRajSBXKybTBURygzPSLi41GU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntrRSqgO0At5zcP/JpqjWsOazzSFfm38g4FE84Qm/Cn1KpT2D/9+349+yZtyV2NGlp50xn7w85dX3CxONTvkFS6w8c4BumhkTOQtQvo0nqBanmNaj7kIQhqTHzLbBzBpAO2T/jg6rN1IJKO8atuA/6mMWG+8fqLvDMAVhOZltkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzpyZwBl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lbS8114A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzpyZwBl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lbS8114A"
Date: Thu, 10 Jul 2025 08:41:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752129698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxFDmPmW7tEsz5guEbRajSBXKybTBURygzPSLi41GU4=;
	b=uzpyZwBlfTQQa5M8R7K7y2sF8vIro2v+MycEgpeEiFpbhl+N2rgO+UEU/dCQWsvlRto4Yl
	32urVaUows/RO2JUwjDUr/ci5UZ9qShO4+Il/nv31Mu4KXfrthhnXduRUnAHB/1yVC6xJT
	/TwNCH8i74SQ49Zgg12nxfS85LwEy0WJuFuyCa0K7ADifupKXB0HIB563wdELj3dtG2pdv
	WgMm5es56pvBzAJfq/J01xDI19rQRhrGKuVUcLqBwc0F2dUjndS4juvSKJcjfA+RcU8Uy8
	0Bmfhkigy7NHaTYSMfke/6DmtMdU+tQDDveBRQQ/z18qF1yEaoqMe8dQbwz/pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752129698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxFDmPmW7tEsz5guEbRajSBXKybTBURygzPSLi41GU4=;
	b=lbS8114AXm4BFVFCinyfD7bNgqwQGeLvlgPoMVoEvqF/LHWz4thJDZoCem1HY+OZ5BUIMx
	HFxqs9GeYUKTtLCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <20250710064136.rur6FoOU@linutronix.de>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aG7MckLkTuzZ5LBe@intel.com>

On 2025-07-09 23:09:22 [+0300], Ville Syrj=C3=A4l=C3=A4 wrote:
> On Wed, Jul 09, 2025 at 09:44:43PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-07-09 20:30:26 [+0300], Ville Syrj=C3=A4l=C3=A4 wrote:
> > > >=20
> > > > It seems like the critical uncore lock is currently held in a lot of
> > > > places and potentially for a long time.
> > >=20
> > > It shouldn't be held for that long. I think it should just be
> > > a raw spinlock.
> >=20
> > What about I resubmit the series and we look again? I don't think the
> > lock should be made raw just to be done with it.
>=20
> Until someone actually does the work to confirm the thing is working
> reliably there's no point in posting anything.

Well it works on my machine and this machine dose not pass the code
paths that I patch.

Every patch made was done because someone reported an error/ warning and
confirmed afterwards that the patch fixes it for them and they can use
the machine and don't observe anything.

> And IIRC the other remaining problem with RT was the spinlocks used
> inside tracepoints (which is uncore lock, and probably some vblank
> locks). So that too needs some kind of solution because it's going to
> very hard to debug the timing sensitive parts without the tracepoints.

no, not just that. Making the lock raw led to latency spikes in simple
spikes and I just disabled trace points. It could be worked around by
taking the lock if the tracepoint is enabled and then invoking the
tracepoint unconditionally and not taking the lock anymore. Steven made
a suggestion a while ago how to put this in macro as far as I remember.

Looking at series there are things like execlists_dequeue_irq() which do
local_irq_disable() follwed by spin_lock() which is a no-no and
explained in Documentation/locking/locktypes.rst. There is also
intel_guc_send_busy_loop() no considering RCU read-locks for their
atomic detection. I have 8 patches in total and one in the pipe.

I have patches with Acks by Tvrtko Ursulin but I remain caring them.
I can repost it but usually the bot complains, the bot gets retriggered.
The first patch in series is vblank detection and I've been told this is
old code and scares people. So that might be why the remaining part is
ignored.

Sebastian
