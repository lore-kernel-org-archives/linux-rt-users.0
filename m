Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FE384CFD
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699294; cv=none; b=l0B3kJnxmuDegwVfFI0JN/NrUC0pHsatHoo/FQ2YTdu+NVpn9nxCukgZFNoU4i5Em0fXsz5f0ZRP91kVDXq3lyXWvII5TqxAvM6j21DOLSHY75ReYzRB0kJ+wq1/w640Jks8OKccezmw9U/ersd6zV3AJKjzKZTFLTDdpg55t7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699294; c=relaxed/simple;
	bh=5r4Pa0QxyR4IG7q9f+DWCy4twslM4Pd8WTvTt319zwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWW0yeIt7jKh42nMP9oYDI9Gu7q6DVo8EzsiRs1wqW4/1gMeL9qYfS0uSrHtPMD/oe0q5DQy1mxJQ6xkI47BTMNj0BVsUkjIEzDLLGpL8+ugkdmzLSZfVWKOiFENdvg/HomGh81q/u+Zl7pGssEOt+lSDW/vg1xYHoyplk0EtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=b2mgrImW; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="b2mgrImW"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026071016012103a7636255000207e9
        for <linux-rt-users@vger.kernel.org>;
        Fri, 10 Jul 2026 18:01:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5r4Pa0QxyR4IG7q9f+DWCy4twslM4Pd8WTvTt319zwg=;
 b=b2mgrImWtAiC+ILwnGav/2x+yjhpy+MNSscBG8oPq4LWRYF74CK/xfAMIaxgtyyVKgFhMs
 L1vFYrapYS/pHWZOmIwxlhICYikuXQT3G4MCv1/vJlM03TU+m+Xch5scP806KlQzNSj2val4
 0CUwVO1pUuA1HzhYmb2iQMPHRSNpWWpQkvoCB0sCb/z80Bd8eMSIN4n/sbR3r55zhQLOqDRp
 0cN79zXhPjVGjifTOGQ5gZF2/9/+wuK53Pg22BOGWJKol15t8L2agnL3fz+3t8p1nWsaxLe4
 zmiBmozN/khG040Dh7zAXHsYEsrCNL268EVDY08c9TU9hccIneK7jrdQ==;
Message-ID: <ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Clark Williams
 <williams@redhat.com>,  Danilo Krummrich	 <dakr@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner	 <tglx@linutronix.de>, Jan Kiszka
 <jan.kiszka@siemens.com>
Date: Fri, 10 Jul 2026 18:01:20 +0200
In-Reply-To: <20260710115145.32729a7c@gandalf.local.home>
References: <20260709143108.UYeCUUcd@linutronix.de>
		<2026070922-kilowatt-matador-5e1c@gregkh>
		<20260709152214.rH1O_8SM@linutronix.de>
		<748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
	 <20260710115145.32729a7c@gandalf.local.home>
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

On Fri, 2026-07-10 at 11:51 -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2026 09:23:16 +0200
> Florian Bezdeka <florian.bezdeka@siemens.com> wrote:
>=20
> > uname might qualify, yes, but keep in mind that this sysfs based API is
> > already used, so a removal might break applications. Yes, userspace can
> > be fixed / adjusted, but it remains bad style, no?
>=20
> Then at most it will likely just stay in the -rt patch set. As it was nev=
er
> mainlined, it's not breaking any user space that uses only the mainline
> kernel.
>=20

Depends on what you consider a valid update scenario. Updating from 6.1-
rt with sysfs available to something like 6.18 (no sysfs anymore) will
still break - as long as you do not (force) update userspace in
lockstep.

I learned meanwhile that our detection moved to uname meanwhile, so this
is not a problem for us anymore.

Florian
