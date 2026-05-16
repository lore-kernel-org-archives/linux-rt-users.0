Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958263EF645;
	Sat, 16 May 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778952834; cv=none; b=KMQyXp7tgdGkTiQUMKyQBj1Ykp3J4Oi6hKbmHzSYGFAHMj0eOmy+IOBO3lqF1MEE8VFVjPbZ9OaQexHOWTwNjScZJIkiC5vaLbUzJuJtClohFhsXUbK8PhOChtl98DxCMFXpce0/aHpu+TsqoNI1IbEKrMT06/c4GoUZMUlk4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778952834; c=relaxed/simple;
	bh=MeC6PwUaWt0snh3bnK73jH3POxLx9VwtUlv8MURhJuQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nB70MI1dcfPpzyacJXvBqBiu3Br+Mb2pLZc4QtRFDjnluQxONQ1tf3marCPU7+JySgxwErceL9srJM3yP5p3PORVnoOTGugjhtnNG6Xi3KTeLJTU8EYyW8tGYAcA7Up9XIDVy9lWqAXmPd4dU2cAFI/1jlf/lKd3FOB4VvLexjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=I0ejauVN; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="I0ejauVN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 569CADAE51;
	Sat, 16 May 2026 18:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1778950701; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=GLJGJU5ntftvcQFPJea9newq+S9EHZ0aVl1xdGalbWA=;
	b=I0ejauVN0VKdXj0D80OTw6/38tynB6q59D/yasmufZ6dnebdSPvknoPT5Qhqe/xR1a6+SN
	2MeNXFOLcGNBZOFXykSR8XHFncS4OCm4uIB7RBsRhVOivM8rtyLNGUoekvtL5SpWcFEgoL
	4Mp7Q4lMShq07bjJE9DxOSVbLfv39z/pz9lMWmPj0aonmkH15wYe1JqVyMOfiRhCWXX/qu
	ZxbfbsO9HIo1tQB1VNnDbl4fnB3YXNT03em0EVaaLbNcvpW6IruCNkCU5sPQVQevJdb1bW
	uerFZaRBT1alJ9aBFY2MJiivzLiUx+g25mbONhvgxj+wPimsPTZ7B9qvY+qnfA==
Date: Sat, 16 May 2026 18:58:10 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.89-rt18
Message-ID: <fe181873-9a38-4b4b-aa9a-3a45b28dd769@nitrogen.local>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 6.12.89-rt18 stable release. This is just an
update to the latest stable release. No RT specific changes.

During my testing, I saw some spikes on my x86 box, but so far I haven't
been able to identify the issue. I recently updated the entire lab, so
it could simply be a misconfiguration or something similar. Since there
were a number of high-profile CVE fixes in the stable release, I didn't
want to hold off this release, especially since there are no RT changes
at all that could cause a regression.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt-patches
  Head SHA1: da81d744fde93759451b625bdcaf1c4eb7a3b18f

Or to build 6.12.89-rt18 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.89.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.89-rt18.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
