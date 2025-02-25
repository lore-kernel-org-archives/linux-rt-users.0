Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316125D546
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496596; cv=none; b=n6dBmuaIGiAb+YvFPsI5iOrbZ57/NPNLlOC2zu5wGzchf+Jls8u3IBCIDRVU3HNPFeF8mKbYykVIECpM5VkMvSIPexhzQIts6/LQOlhh8+4ekKQi4OzJTSmQwuskpHWE4qONQgybSxfRnM7g6nFB3KmsoIsoJAwD7SR/9oZITYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496596; c=relaxed/simple;
	bh=O+CpRFaNxIChKEMjk0jv94RAb5t+NylyghGwGxcz3GY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YX+yZkvagmhVj9DSznA8nY8u6vu9WLiMoy37jhxg6lbq2TkqBvtwHExVmYho6kQJYeeTooIb94vxF7lCt7rwHFunipODmUw+Dmg8yEqiN/BWPyuI0ogv0E/RPVgsQ2odH/HUyCiBF8XgBRPwC4GMSSSeX37BId00Wu75L3FYJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=K0zKkz+r; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="K0zKkz+r"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250225151625711752c3d430b4ee9f
        for <linux-rt-users@vger.kernel.org>;
        Tue, 25 Feb 2025 16:16:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LcQ5yc1vLYen8jxY2aTpJ+7iKqHSfGpVG9MCK/21QIg=;
 b=K0zKkz+rj4NmQLvJdCicdf/2ebYmm+fQZ78BzQmQH6oLpEC80SaHopX4dMfpHtsgzboWdj
 KSgqyE+2H4J8/2kNEqr/PMig9DeNhypDWa/eDDeGYbUO/PAlw6PfzFbpnWwhpgYvShhPqgid
 mC5xNvSySIToDADz5r6oRAvduwRsFs+VFGiQzQ5TlL4UdC+AdmvUlaXHglcuR9TbYWg0IInN
 WQIg55YecqjkiR1xbpihKlV9TFKAzORIXLuKab8pkuJNzwA6B316s2fGPmmvZq3T443x2lOj
 pFAoGlvg7uZL8vs0kWH+bngglEEc0PjF/8ELE9Qi8nGpIcSkAOhKXKuQ==;
Message-ID: <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
 "Ziegler, Andreas" <ziegler.andreas@siemens.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "MOESSBAUER, Felix"	
 <felix.moessbauer@siemens.com>
Date: Tue, 25 Feb 2025 16:16:25 +0100
In-Reply-To: <20250224115557.AIFtijeu@linutronix.de>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
	 <20250224115557.AIFtijeu@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2025-02-24 at 12:55 +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-21 09:32:41 [+0000], Bezdeka, Florian wrote:
> > Hi all,
> Hi,
>=20
> > when stressing a 6.1-rt based system with network load we can
> > immediately see the following in the system log:
> >=20
> > [  165.260690] NOHZ tick-stop error: local softirq work is pending, han=
dler #80!!!
> > [  165.264689] NOHZ tick-stop error: local softirq work is pending, han=
dler #80!!!
> > [  165.268687] NOHZ tick-stop error: local softirq work is pending, han=
dler #80!!!
>=20
> which version is this? I think is is an imported issue. Is v6.1.119-rt45
> also affected?

This is a typo, right? You mean it is an important issue, no?

We can see that on

- v6.1.90-rt (Debian -rt kernel)
- v6.1.120-rt (Debian -rt kernel)
- v6.1.119-rt45 (So yes, this is also affected)
- v6.1.120-rt47

>=20
> > It seems that
> >=20
> > 96c1fa04f089 ("tick/rcu: Fix false positive "softirq work is pending" m=
essages")
> >=20
> > tried to fix this issue, but for some reason it does not work.
> >=20
> > Is that something that is really allowed to happen on RT (which means
> > that one of the conditions for the warning is still wrong) or a real
> > problem? We did not notice any negative impact on the system so far.
> >=20
> > Input welcome...
>=20
> The thing is that this may happen on PREEMPT_RT. Usually because
> softirqs can't be run as the CPU is blocked on locks and the lock-owner
> is either preempted on another CPU or blocked on something else.
> The thing is that a NO_HZ CPU should not go idle if there are softirqs
> pending as in "there is work to do, no nap for you". But as I explained
> earlier, on PREEMPT_RT it might happen that the work can't be handled
> and if no task can be run, the CPU goes to sleep.
>=20
> That means if you replace with PERIODIC, the warning goes away. If you
> start a CPU-hog (on per-CPU) the warning goes away.

With PERIODIC you mean CONFIG_HZ_PERIODIC, right?

We have CONFIG_NO_HZ_FULL=3Dy set but do net set the nohz_full=3D cmdline
parameter, so that we should get CONFIG_NO_HZ_IDLE behavior at the end.

I realized today that the warning is somehow related to our RT tuning.
Enabling NAPI threading makes the warning go away, even if NAPI threads
are tuned the same way as ksoftirqd.

I will have to look into that in more depth.

Thanks for your input Sebastian.

>=20
> > Best regards,
> > Florian
>=20
> Sebastian

