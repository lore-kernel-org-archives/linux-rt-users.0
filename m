Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BC25CC70
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608621; cv=none; b=tdobQfYE9KAT1Bn1bFPj20HxWjdBUsn/AjwKcyEtfo/fUSdwybknjE8apSbIOgSwmulzgNaZtR6IiAROG6BqmQnJFhg+RY6QGQA60Ca08Nfc7p98vpa6c+Bmex869vQnjItMJabC2IX2p666BFp1dVOlaXNzIedg8zVzI1EAwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608621; c=relaxed/simple;
	bh=lioPPyEULcmp1uJjfXLFp9+qSLICIJur3D4ztbaeH8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m1zHm8PvdFFpM4FiClnpR0rXr8P3RnMMbbjh7ftn/HKM6c12poEGEkX9Ipke6+lApt/f1d24zb7gEk4duBsbr7Sg9Y0JSFI2OAZR7z4f1Z1b6zs16GlrXsMCGFBfnnlHMqR9TS0pYLoxMx8a0LE1X62tt8C5HWPFDi9TcnT41ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZYn4npH2; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZYn4npH2"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202502262223301c966b1022cbd1ad98
        for <linux-rt-users@vger.kernel.org>;
        Wed, 26 Feb 2025 23:23:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JgLRQOpb3bXCSsSxcGtcBnW8ceNSpd+wJNOy1S8YaGQ=;
 b=ZYn4npH2eiJO7LKg8q9tODEDrbJaYii2BwO98+IaR5969lTbmj6HJzCotuO+O9rmVJscM2
 M9QDjGz210hyBaRplyYTd+KSKw8rq+QtlC/dUIkIVmAQVxdBmrch/d26e3glgCAU4RXH/zdP
 1ngmU7QS/Q37NxRcbC19Tw6CHGsnfVnnOZtgxGUeXPAkJ1VKb51M9eA+H80DUNggTUgmDcYd
 eqDCwOgsifBVGpwrPmHKZ6mZg/2JX5ybM0L/ruNuasDSnmrcjueYNKuiAp+Aw2X6KvKOtkb1
 YjhcKnahOHrxkSz+dqNQ2CaaXpI/1GOVHNPzusplvfT+DY0KlFzDkD4w==;
Message-ID: <7cace5d70278f8ae1debe8cb8d392fb3f59291ff.camel@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
 "Ziegler, Andreas" <ziegler.andreas@siemens.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "MOESSBAUER, Felix"	
 <felix.moessbauer@siemens.com>
Date: Wed, 26 Feb 2025 23:23:30 +0100
In-Reply-To: <20250226091752.jCsLqq66@linutronix.de>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
	 <20250224115557.AIFtijeu@linutronix.de>
	 <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
	 <20250226091752.jCsLqq66@linutronix.de>
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

On Wed, 2025-02-26 at 10:17 +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-25 16:16:25 [+0100], Florian Bezdeka wrote:
> > > which version is this? I think is is an imported issue. Is v6.1.119-r=
t45
> > > also affected?
> >=20
> > This is a typo, right? You mean it is an important issue, no?
>=20
> No, the version is correct. And I meant "imported" as in we got it from
> the stable queue.
>=20
> > We can see that on
> >=20
> > - v6.1.90-rt (Debian -rt kernel)
> > - v6.1.120-rt (Debian -rt kernel)
> > - v6.1.119-rt45 (So yes, this is also affected)
> > - v6.1.120-rt47
>=20
> But if this is visible on v6.1.90-rt then it is not originating from
> what I assumed.
>=20
> > With PERIODIC you mean CONFIG_HZ_PERIODIC, right?
> correct.
>=20
> > We have CONFIG_NO_HZ_FULL=3Dy set but do net set the nohz_full=3D cmdli=
ne
> > parameter, so that we should get CONFIG_NO_HZ_IDLE behavior at the end.
> >=20
> > I realized today that the warning is somehow related to our RT tuning.
> > Enabling NAPI threading makes the warning go away, even if NAPI threads
> > are tuned the same way as ksoftirqd.
> NAPI threads? You have RPS enabled by any chance?
> Would commit
>     dad6b97702639 ("net: Allow to use SMP threads for backlog NAPI.")
>     80d2eefcb4c84 ("net: Use backlog-NAPI to clean up the defer_list.")

With NAPI threads I meant the kernel threads driving the NAPI poll
which can be activated by "echo 1 > /sys/class/net/$device/threaded"

RPS is build configuration wise enabled but not configured.

As Felix already reported, backporting the mentioned commits to 6.1
would require some manual work. Simply picking all the dependencies
seems too much for now. Will have a look again...

>=20
> help?
>=20
> > I will have to look into that in more depth.
> >=20
> > Thanks for your input Sebastian.
>=20
> You are welcome.
>=20
> Sebastian

