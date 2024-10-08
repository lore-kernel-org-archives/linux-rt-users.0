Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35A1E04AD;
	Tue,  8 Oct 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402694; cv=none; b=Hr1/LevGxdXuHzAGnp9blTIXtv1S2OMu9/owFPc3XGRzFLnJK0QNUH6P4r7vAUmiPAmpK8gcOGC7098t08rTMlohsSdcNVj59nyeay98whq20CpPdkuv9fhUNoECQ9POrX/7G7b7Fn2KPmTMME1A3e01DvlNAGaAyabm3v2QrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402694; c=relaxed/simple;
	bh=vDf4wLOCY3ZO8Qg41Dd8kFWNKbHVdPFKA9cIlW2pUGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOrupyKMmIWzYhWWJP6+ObbXK2yzOlLgcRRlkti3nXtT8GyLC/IlTqrPqf6YxoQiFGJZ2Nb35AFqwyJjBQKeG3JVWaZ0+K8FjAx7SUw7Xtb61tlqNBQA+ykeLYZuejFG0AhgcX8QGwKwvxLt+sGqnjIQM3v4VQKAZewH1jAW5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0P8/hX41; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYRxrR4U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0P8/hX41";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYRxrR4U"
Date: Tue, 8 Oct 2024 17:51:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728402691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDf4wLOCY3ZO8Qg41Dd8kFWNKbHVdPFKA9cIlW2pUGk=;
	b=0P8/hX41HrHvAMGUXmSjTKdyzDfZYvjSRLR9CjHxAivDXaoxAXIj5iSO1/dEeyN6H5n7Ie
	+IxPABtqeyw3ZrGMb8U7lsbglXFC6ob24GouSCf1vMN/qsiqNl9gtzm7fzGsL4DG5ua3Em
	FEwcK7ir//qhB6w6pI/GSdjftuOCkm4gAqnj9CmEdRZADWZr9CdviineGHQngbOUJQMddL
	eLuHNF9vxX6uwA2ipxyqpT46cpwaxtjMzSaLN1BiQIY0on90TO60puG60ztv/OOYWDACa3
	lvhXpK4vzdobRMj1z1w5eCJVgC0JrbnMWYahaWLQYPBAEnt3lBgg8FLdXO3B6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728402691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDf4wLOCY3ZO8Qg41Dd8kFWNKbHVdPFKA9cIlW2pUGk=;
	b=BYRxrR4U5pXYZ2iI3a7mLfNx0NuiZwpSP5hhcmz60BHMNchcJ/0ZZHNNmkCx3AIoV9sFuy
	dMoPiLHusmfPugCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <20241008155129.z7ZZVzW3@linutronix.de>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>

On 2024-10-08 12:38:11 [-0300], Andr=C3=A9 Almeida wrote:
> Em 08/10/2024 12:22, Juri Lelli escreveu:
>=20
> [...]
>=20
> > Now, of course by making the latency sensitive application tasks use a
> > higher priority than anything on housekeeping CPUs we could avoid the
> > issue, but the fact that an implicit in-kernel link between otherwise
> > unrelated tasks might cause priority inversion is probably not ideal?
> > Thus this email.
> >=20
> > Does this report make any sense? If it does, has this issue ever been
> > reported and possibly discussed? I guess it=E2=80=99s kind of a corner =
case, but
> > I wonder if anybody has suggestions already on how to possibly try to
> > tackle it from a kernel perspective.
> >=20
>=20
> That's right, unrelated apps can share the same futex bucket, causing tho=
se
> side effects. The bucket is determined by futex_hash() and then tasks get
> the hash bucket lock at futex_q_lock(), and none of those functions have
> awareness of priorities.

almost. Since Juri mentioned PREEMPT_RT the hb locks are aware of
priorities. So in his case there was a PI boost, the task with the
higher priority can grab the hb lock before others may however since the
owner is blocked by the NIC thread, it can't make progress.
Lifting the priority over the NIC-thread would bring the owner on the
CPU in order to drop the hb lock.

> There's this work from Thomas that aims to solve corner cases like this, =
by
> giving apps the option to instead of using the global hash table, to have
> their own allocated wait queue:
> https://lore.kernel.org/lkml/20160402095108.894519835@linutronix.de/
>=20
> "Collisions on that hash can lead to performance degradation
> and on real-time enabled kernels to unbound priority inversions."

This is correct. The problem is also that the hb lock is hashed on
several things so if you restart/ reboot you may no longer share the hb
lock with the "bad" application.

Now that I think about it, of all things we never tried a per-process
(shared by threads) hb-lock which could also be hashed. This would avoid
blocking on other applications, your would have to blame your own threads.

> > Thanks!
> > Juri

Sebastian
