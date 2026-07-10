Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7C3BC680
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666933; cv=none; b=SuMfhqHYUOG33naWIEn3Hv61uTShg6xT0oYM5+LmRgP1J/qVToN1RcXEIyN5jDmCChx89p5q5fX08B+jZc/WbI4sQPPrv66NAdOhdVB2p5UjWPJHQL17qgXRTGMjcHGwGEnQi8/5FvUxfFyM6//K9blyDi3ZxfPPtF6Nl8+Hyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666933; c=relaxed/simple;
	bh=0bktztnLdZ5F+KmH6lgrLLBINMaESMK87pR69afJ5qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6ktOPOYh6/x1HSzkcicKLu8CWtE3DN3SfVv+DyTdjBes15qLJH13f3fxaoKZbqIAUZF//msW65sbKqRDmjij+zyH+opaps2S+De3MLk9XtbuRboQBSk11lu5o+dCE1PmkMT2s2k6tNG69LFBwOqlEdNAbDmBqEegtCidccQQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySTzZPr+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+M9VUqO6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySTzZPr+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+M9VUqO6"
Date: Fri, 10 Jul 2026 09:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783666922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ez91DZFw8JCnWtjNYRGKlXW7ANZVlPrHtsrWC05g750=;
	b=ySTzZPr+aWVI3qCepHE4X8jvu3/SKq7wLLn+9sCd6epIf/Jb0MxbGRrH0vxHfISYROmkqL
	GI9fo652rkqDv1g+0cPOMCmwGsAnZkvkXpSM5YxK7ROQsbsvitBA7rntkY5VaLOSIZsNKQ
	ARv1lGMcKVT+2f65dwGYyRfKF5FXQn+CP2HlJwAs8cxQmgfDrWqBa7SXt7/UPCtSd/xsXJ
	8AXfpeFzIMNNbkdloFaxcUGDwZKkWk8mqGA+l3arf/XW2a0ofq3CxkQkqVAR2DfHfpGGCW
	2bshBsBWscyG7SIyweEBcU9DovVwKPWS1gL5mbrXlJQIIJNlT38HF6zfjSRCOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783666922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ez91DZFw8JCnWtjNYRGKlXW7ANZVlPrHtsrWC05g750=;
	b=+M9VUqO6kbN/cu6IoaIoKCbR8meYxHJvZg3o8WL1A4kFxx7KUZrRYOcccDWzfLjnLOerd3
	WAdA1utHuzUm50Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <williams@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260710070200.9H_smn5E@linutronix.de>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
 <ak_GDsJS6kVoUM2f@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ak_GDsJS6kVoUM2f@lysander>

On 2026-07-09 11:02:22 [-0500], Clark Williams wrote:
> I'm hesitant to call for it's removal, because the only other way for
> startup code that want's to know if it's on a realtime kernel is to look
> for PREEMPT_RT in the 'uname -v' output. I know that the financials and
> the telcos tune specifically for RT, pretty sure there are others.=20

And the "uname -v" still reveals that. Even after PREEMPT_DYNAMIC and
other changes over years.

> > There is custom "software" that is designed for realtime environment and
> > if it is run on a regular kernel then it missed its timing requirements
> > and the software goes usually in a fail state and people start debugging
> > what has happen. If this happens often enough (booting a non-RT kernel)
> > they tend to add a check so that the software complains early enough
> > since checking the kernel is usually the last thing that is done.
> >=20
> > This could work with the file (or folder) or by parsing uname output. I
> > know of at least two individuals that switched to uname because the
> > upstream RT does not have that file.
> >=20
>=20
> Really? We always took the absence of that file to mean Not Realtime.

The upstream (without the RT queue) never had that but uname was
working.

=E2=80=A6
> The question I have is, would a folder with RT-specific information be us=
eful?=20

We did not have anything so far which does not mean we don't have it in
the future. The features were so far always part of a specific
subsystem and on by default on a RT system. For example PREEMPT_LAZY is
exposed via the scheduler. There is RCU-normal (not -expedited) which is
exposed via RCU. Ah. We have threaded interrupts which is not exposed at
all, you just see the threads in ps.

> Someone just wanting to know if they're on RT could still check for exist=
ance
> if that's all they want to know, but I'm not really coming up with any
> other information that would prove useful for someone tuning for an RT
> workload.=20
>=20
> Is there a "better" way to indicate that the system is running a
> PREEMPT_RT kernel?

I always checked for uname. Thinking about it, we could try to get a
ConditionIsRealtime for systemd unit file syntax similar to
ConditionKernelVersion and all the other things it has
	https://www.man7.org/linux/man-pages/man5/systemd.unit.5.html

That would "solve" the startup issue. It might make sense to hold off
adding the file until we have a reason to add a folder with features.
Changing it afterwards will break "test -f" users.

> Clark

Sebastian
