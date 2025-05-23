Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85681157A6C;
	Fri, 23 May 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012433; cv=none; b=ggOKfDMFhwSO+l9jdC65EhuVyX8K3RsOIBaUH9JZdl+0AXNzl8J8mXRI9eQ+jR0Ou/3j+lcYD39wvGsK0jWCv3r8Boe57LEaIUmXBVRjCG7uGwZaISFHXdDj6Rib/qdAVAhvU5xeKRK2xIWD4w9Kal4rS4yCvGYgYrL4ZzUE+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012433; c=relaxed/simple;
	bh=8LaSKHYLrGNtZRPW5U5KGJGcYBammh0wxgBbB9yaJEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeHLGUjT3ORvZT1I4JYn+zwMYJN7Zur0/YkAQH5ymoujwRwHu2RoSXXAXFehNtNs3cwaFdpBjrxiGMFL2Th4STPp2W4OzKLrydHJKSNrutsEdkVfO4MKoQ0J6cAkVnsvXn41MFbws2hMttTGXu9Utakz62TJpAlbVmO/kS0F8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJTaBtcI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+IUjOwf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJTaBtcI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+IUjOwf"
Date: Fri, 23 May 2025 17:00:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748012429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m7V+4ADDQzTpXOvpXf66IydzWsoghTpN0KKBhwdRXg=;
	b=rJTaBtcI45CCUYyjzn1nUm/z6/+BT8JyGKXSdYngJSZu2gqpEkOCB2Oc4ZiyiWKpuEBkiz
	DjZkRpppTibCLt3fOGWDZbKXH+Ve7h6kxFe5eO/miGysp/pX8PgIIvjhmh4peaLm2eKJbb
	5cgJwuqHUQxet2bi2P8Vc++bQCEUb3wgcsU7GN/mc+UgRjqMTEN+eKFuq4i8Y93GDeV3Dm
	WVQunUkEL0s6AlU35/JjNnNirojKhbfEquglr8sOfgygGbOqm6r/Um1N2Ph80s1uPG3EbN
	Cy9PceKLvipsk7uA+U+rVvL8AlV6kiW37Y9P5DQjkzfzyRTp6ke9c3rth80j7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748012429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m7V+4ADDQzTpXOvpXf66IydzWsoghTpN0KKBhwdRXg=;
	b=1+IUjOwfwt4CerviJW4ALkZLtLQii30D53dPTJF3aM9lO5bj1c+jg1Y6htk2br5uiaBEBP
	5+5wq+bJdCXm9pBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alison Chaiken <alison@she-devel.com>
Cc: corbet@lwn.net, gratian.crisan@ni.com, triegel@redhat.com,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, achaiken@aurora.tech
Subject: Re: [PATCH] Documentation: locking: update libc support status of PI
 futexes
Message-ID: <20250523150028.62N5N42-@linutronix.de>
References: <20241228181546.1315328-1-alison@she-devel.com>
 <20250107153121.wAL-TfKG@linutronix.de>
 <619bfa123308eeb3a548fae36a3f9e4c@she-devel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <619bfa123308eeb3a548fae36a3f9e4c@she-devel.com>

On 2025-01-11 10:55:55 [-0800], Alison Chaiken wrote:
> > Are you sure? My memory is that glibc avoided using the internal mutex.
> > The old problem should be gone and pthread_cond_signal() and
> > pthread_cond_wait() should work.
>=20
> Ignoring support for 64-bit time, the last substantive change to
> pthread_cond_wait() and pthread_cond_signal() was Torvald Riegel's  commit
> ed19993b5b0d05d62cc883571519a67dae481a14 "New condvar implementation that
> provides stronger ordering guarantees," which fixed problems with waking =
of
> ineligible futex waiters and with ABA issues concerning the futex word.
> What the patch does not do is made clear by the commit message:
>=20
>      This condvar doesn't yet use a requeue optimization (ie, on a
> broadcast,
>      waking just one thread and requeueing all others on the futex of the
>      mutex supplied by the program).
>=20
> What futex-requeue-pi.rst directs is
>=20
>      In order to support PI-aware pthread_condvar's, the kernel needs to
>      be able to requeue tasks to PI futexes.
>=20
> Riegel and Darren Hart discussed Riegel's patch in at length at the 2016 =
RT
> Summit:
>=20
> https://wiki.linuxfoundation.org/realtime/events/rt-summit2016/schedule
>=20
> The related glibc bug report by Darren may be found at
>=20
>     https://sourceware.org/bugzilla/show_bug.cgi?id=3D11588
>=20
> The last comment on the bug from 2017 is by Riegel:
>=20
>     So far, there is no known solution for how to achieve PI support given
> the current constraints we have (eg, available futex operations, POSIX
> requirements, ...).
>=20
> I ran the bug reproducer posted by Darren in Qemu and found that it did n=
ot
> fail.   I'm not sure if the result is valid given the peculiarities of Qe=
mu,
> or whether I made some other mistake.

I've been looking at this again for other reasons and looked at the
code again=E2=80=A6

Back then we use futex-requeue API and required both futex-object to
have the PI bit set. This wasn't the case originally, hence the patch by
Darren which did not make it into the official libc.

With the rework by Riegel, the mutex within pthread's condvar
implementation is gone also the usage of the requeue API. The
pthread_cond_wait()/ pthread_cond_signal() API is back to use futex'
wait/ wake.
The glibc comments write something about important ordering constrains.
The futex wait enqueues the waiter according to its priority. So the
task with highest priority gets always a front seat. The futex wake
function wakes always the first waiter in the queue.

With all this I would say that the glib'c condvar implementation does
not have any issues since the rework.
There were a few loops, with a 0 retry counter (basically dead) and they
have been removed.

Sebastian
