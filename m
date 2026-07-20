Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1741CB34
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552293; cv=none; b=DyWRcSQ5rDkp4u86AEe84D+C/DnhbJw2wQLn04gPenXXmRGLEDrfis4BnYwOmBwY7WH3kW/5l5c7xHqbTQSzvP/wM/uNdV8zyBfiqynCYRubjmIakAf99zTz7Myl1sRq1fPgT4zwLFLQeChAX93SKDEakLPW5oy7UMX0TlaZADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552293; c=relaxed/simple;
	bh=z836zTZ2vuUnnFitOBttWUZgl+8m8KGUknMd7hzmgs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJssymIgDWGTuGjeSOTrISc2q5jdfv0TDUvd2vkNatvQ0j9nWZvGDUEKuEoKvvyFdJAo1u62Qd7n9FE9S8YF3Qmju03wXkJUtjFgoBwdyG/N6h7l8dwsTF/JOPcQIEjJjJQIyEgxTf97EQwYDCZmy1QuNzaCdvFlkNpmUkcRwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2hhZ48K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=czJ1mpgK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2hhZ48K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="czJ1mpgK"
Date: Mon, 20 Jul 2026 14:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784552287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecn6jYtDP/XOP8xt88+SXsAsBjJMyc/eFqCs6RtwLGk=;
	b=r2hhZ48Ksb9UzmPZDHBK9OIxjgGeNpX3gq8t0RVymMYlvi5VDyQ1YSghjgVUTbCYWB//hf
	VNlgcsangRWmVDMlbzrMT2rlDH51RejB8CjBeVs3O0a3odTG7Kx/B01cOvJhWe1io5eLjS
	V9ZxQIBLZLJX0mFzurfm+y9UsFGQdTU+rwo4OntpQlU3J5L9ukAeiZUrg3Dh8F4fz1K8xh
	urIN6NkwmwDJV5DcYXJLxjpJDvMo12iLPxgu2Cj4V/M6zYx8cqGpnfJHTOmRpQ5LhlvKqY
	BupeuToUriZ9pf6ZwbHO3TTfPkgh9mbtYz2f/hRdcLsENVKwktASq3szdEs2aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784552287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecn6jYtDP/XOP8xt88+SXsAsBjJMyc/eFqCs6RtwLGk=;
	b=czJ1mpgKyutG2RwQ/MPSY9U9fJbeDrAaOr/5hoI9yHOrfLS6P9izCGMWElhk/DU5fAl7bs
	aL0rgfi/VhqRWVDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Runge <dave@sleepmap.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Issues building RT patchset v6.18.13-rt4-rebase on top of
 v6.18.39
Message-ID: <20260720125805.wN3NFiBj@linutronix.de>
References: <al3YymTiIicX2Vin@hmbx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <al3YymTiIicX2Vin@hmbx>

On 2026-07-20 10:14:02 [+0200], David Runge wrote:
> Hi,
Hi,

> I'm not sure who is currently working on the patchset for the 6.18 LTS br=
anch,
> but I guess it is worth exploring to drop/adjust the commit and release a=
 new
> patchset?
> Is the patch still needed?

It is there
   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/lo=
g/?h=3Dlinux-6.18.y-rt
   https://www.kernel.org/pub/linux/kernel/projects/rt/6.18/patches-6.18.37=
-rt6.tar.xz

the problem is probably that it is not in the stable tree=E2=80=A6

> Best,
> David

Sebastian
