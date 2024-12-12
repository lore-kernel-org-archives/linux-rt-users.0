Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62B21C166
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023020; cv=none; b=dbpAly5FeH8XAzjLL9AxHOVSogvGDPbyhrozrdLAWIjL51KseHx87QeekIFDw2yGUL0Vkc6kpj6ubuxGpl7aOYliVYxmUfG2/Y6Y9Ng188RJs+qFV2aMWAxCyNdsSu2DefVqvDsGA6XA2pTthD/+BndYWtUFdqiEnNKJZLuAMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023020; c=relaxed/simple;
	bh=nqNBEtnUBJkNqp3dnNfC4P+zWV1s8Apkqp5DjrkP1M4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENZnlRYLg24bQNQr9BPKo4eNXmy+Pf3Gbs9a3+QUEzAktqEpp6LuvMg0vWcxDgURSOgUGsDItDRlgf1Cqj3cWwDzXBg+clx/XLW+mESXU3a+LZ/+2onmp5qdKthRiX2h/sps6aDShw5KVVfmm1vs+eGoNSs/tWKjtAoqhq3TYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/Qimr/M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yGN5mhne; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/Qimr/M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGN5mhne"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734023015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2p40DtoayRYtw9vSEUqrkjXRoAsWFFvUBwRPhgNL4vU=;
	b=X/Qimr/MO/pvPDfmP/HPGJP/qwoKEfTVVxdolm9TWvl1nzWaYSpT+pj+LToA/Mfo/UEgSO
	CpfgYBjYwoSxJQwxf3Ei/TJEhANomx8mSMnnTSKmI6bD3Wu5k/z50KSqPcFJzTL11Ac7sm
	gX2t0TneGvb4GUF0medc/cr4UQ4VWsUYFYZ1Kmgt04uHbIyCI9km9oX1vx2xSRLa/OrqTW
	lgDfNC6QdiYTf+HwYg58lPmw3SKvPYBRucMohfVipCjHznCRHu3g76r/G+OVVjRsuV5zZ2
	t3e583DR2y20e0xiW8MkmfO+DeKwTyud2CpYJeZkeKb+6JRE4HOpLFjKFmNcBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734023015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2p40DtoayRYtw9vSEUqrkjXRoAsWFFvUBwRPhgNL4vU=;
	b=yGN5mhneaoz2TaRtoaz4xjtku1ziwGL5ZOMtDqYS3dTvQy/SedX7FJfJq+IEXISlsJzuNc
	EUpj1P+BhBbICaCQ==
To: "Weber (US), Matthew L" <matthew.l.weber3@boeing.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Real-time app developer documentation
In-Reply-To: <BN0P110MB20671E1AA07D1F79721DB0B0F33FA@BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM>
References: <BN0P110MB20671E1AA07D1F79721DB0B0F33FA@BN0P110MB2067.NAMP110.PROD.OUTLOOK.COM>
Date: Thu, 12 Dec 2024 18:09:35 +0106
Message-ID: <84a5d06dg8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Matthew,

On 2024-12-12, "Weber (US), Matthew L" <matthew.l.weber3@boeing.com> wrote:
> The ELISA (Linux in safety applications) foundation had a workshop
> this week with NASA and the topic of RT focused documentation came up.
> My team at Boeing is working on material to help application
> developers understand how to integrate their source code on a
> real-time Linux system.
>
> 1) Has anyone else sent a RFC with something similar that we should
> look at?

Not that I am aware of. This is also something that Linutronix has on
our roadmap as a "next step" after bringing PREEMPT_RT mainline.

> 2) We'd like to collaborate on this if anyone else is willing to
> contribute parts of the material.

Excellent!

> 3) Suggestions on how to start?  Should we RFC to this list and work
> to build up a submission for the main kernel list?

I am not the one to coordinate such efforts, but RFC'ing to this list is
certainly not a bad move. Linutronix also has ideas about what such
documentation should include.

> I've CC'd you as we noticed a lot of great material from your previous
> talks/checklist on real-time.

Thank you.

> Do you mind if we use that as an outline and for some of the content?

Please do. That is why I do such talks! In particular I want to point
out my talk in 2023 about real-time application development issues:

    https://www.youtube.com/watch?v=E5cTgiHJKc0

my talk from 2020 about things to consider:

    https://www.youtube.com/watch?v=NrjXEaTSyrw

my blog post on the topic:

    https://www.linutronix.de/blog/A-Checklist-for-Real-Time-Applications-in-Linux

and although the video was not recorded, I did a detailed (longer) talk
about building real-time applications in 2018:

    https://cm.e-ale.org/2018/rt-apps/e-ale-rt-apps-SLIDES.pdf

As with all things, it really depends on the real-time requirements and
involved hardware. So the trick to the documentation will be to convey
all the details to the developer in such a way that it is understood how
the software should be implemented and why such implementations provide
real-time results under PREEMPT_RT Linux (as well as helping to choose
the necessary hardware). The documentation will not be so simple as "Do
X, Y, Z and all is good."

BTW: Linutronix is currently working on the RT monitor that was proposed
in my 2023 talk. We expect it will be quite helpful for developers new
to PREEMPT_RT. I hope we can post an initial version to LKML early next
year.

John Ogness
