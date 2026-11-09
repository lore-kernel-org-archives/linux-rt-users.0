Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243871;
	b=f3WoJdtOOGjzhUarlK3w//+9rdv5cJMAn28wkPUrjCh4vlwYuu60dZrYANkAzQrfBwPe
	 Z2uw/0FFcuObZRKir5v7E0s/2Og6Ji9KSw5Qt01MIaSHTKoGuPoxRIOnVVGIpmdYPUA+s
	 bMWTqNoGlJGDAPWBqhZQftHG59vy9oHbEb/YfdR6s0ew9SMFnQ2oF4T9yntyYVudFuEjl
	 9LQw/YnWlBpCyZVAQrERAs+CpKtltTKyiFA3kcou9xCRzc3UlfU59PCEz4hMtAkdngLwL
	 5nxTnVUnB7dnVO2uOHjYVC89ws3d3gfir301pLhqlHlrsQ6T9Me/oMG6rmxLmA4SqIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243871;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=BjzF+OV9KrwDhT+7SIROb6R2QHteuy74+xxIjAz9HGk=;
	b=Y2SwAGR4vCl+SUWOkmNCEwrL7o41cuicFMIrt9yDa7RkZuGKi2v4g4J5j4sy3Ix1HwKc
	 d0ysuoWjuF5/EOLb9kWFfCbO0PCInvs70Id3Y9LmVc2aUq0jeL9XY8Yyoq8HOR8/qNztC
	 wEKxS/s0pNATKpUwatlZuAuPEvz6OEPi+vXEFmsO8ScirAHvgzhDOxuSBnTeqE2byvYTY
	 pxkeDakPAlzH9u/Ytwb1/4X5X3l2qQuTphLDt7dF343L2SONhKHqi4HfJB4xrqLweOH0T
	 wWFDkWYxXwiMboiAxSdUcEGwvdHgzLZk2EdzreIxQ398gKI/NJ2TwsNMF4gZqokxgOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=z8s1Vhjg;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=ksUeWPGp;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3333606EE96;
	Mon,  9 Nov 2026 17:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3333606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=z8s1Vhjg;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=ksUeWPGp
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794243843; bh=BjzF+OV9KrwDhT+7SIROb6R
	2QHteuy74+xxIjAz9HGk=; b=z8s1VhjgdNEhZ5qkc6yeJkIGI3Fvg9+MesP3I2Q5syeproFxj5
	nXf0l6FlVFEYE6qDLuLyZ7Y7fIxl+HZcgqBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794243843; bh=BjzF+OV9KrwDhT+7SIROb6R
	2QHteuy74+xxIjAz9HGk=; b=ksUeWPGp4q3yMzvKba5jrV4xK8O7Czs+0lk/9q+k0S/CYHX+L1
	BpHxSsQaQARg+R4O31Ae0OlCMIviB+b/qCt6QKF2ELINNY2yXgb5l3P7x8wwg6FKakcVnrlE9e+
	qeh6UROZngf2owYIfgzGbXkVrNWiXBJgPfM+vlfnO2Z0AI1U5x2J0TeqfUGh9to1EiKx6oTKsmJ
	yowA+Aw0mtoz97dvpTVV07zu7A/vhiH+XDcWqvcqWWOZ0NwFSPLeoih9TorXrnMi+0MrsRby8+b
	EHnpnAL4vpBKLATzR06XxYgcAPtmtDCG+WSA0wc+mIonVcxKZVwdvcI8j5XsElVE9bg==;
Date: Mon, 9 Nov 2026 18:04:03 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.116-rt22
Message-ID: <62f9ba32-b008-4014-aa5e-061595654505@monom.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 6.12.116-rt22 stable release.

Changes since 6.12.111-rt21:

  - none

In the last release, I reported seeing some very high cyclictest maximum
latency numbers.

After some debugging, it turned out that the SMI watchdog was not being
handled correctly, the iTCO_wdt driver was missing, and a few other
tunings (such as fixing the clock frequencies) were needed.

Everything looks good again in my lab.

You can get this release via the git tree at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v6.12.116-rt22

  branch: v6.12-rt

Or to build 6.12.116-rt22 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.116.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.116-rt22.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
