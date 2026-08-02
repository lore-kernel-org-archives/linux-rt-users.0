Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54943C1D53;
	Sun,  2 Aug 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689342; cv=none; b=Sjl0xzH7glTKzor1QZ+GEKstCKS5631JtUeJj+7pIrvCIcaryGirVsun9W6Qx/TmKUSAoigk7BS4L7C42+25oNmyR4YlVlqPtq9Rdk1QFMFWilfZ+OyI6BpFp1gfAuhqhjmr8NrX8iuchZUztZd2einSgT3oYaJ6pPRSUKteCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689342; c=relaxed/simple;
	bh=5xgk0KckABKzMjxwpQI8ual4/56iR98p1JTr60BNsNA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GQUQYjSySvXNbcCdJ7UdfBcWizWs/MrC8KkdmhUNRipOdSDtNbdp3yHwR1tlPxFKodMYMqrqP61vhfn8nwgKqsE9tnVZ1KfX85EKP2HOGAl1USMeHEOnVCWKhWbcOBvIAkVQgt0hnxmcEv3djyzrLDehn9qt7rAVPGdPkzGdsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=permerror (0-bit key) header.d=monom.org header.i=@monom.org header.b=+XxgmrIV; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=GtoWKURp; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=monom.org header.i=@monom.org header.b="+XxgmrIV";
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="GtoWKURp"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1785689185; bh=Icn5XPbJCZ72P1bsEqOJQMJ
	9gGnJqfdfWhWwWhc5dkU=; b=+XxgmrIV5WYv+Eo2p8fnbwmxngndMT5rknydnMRncQaq0G4DJk
	WVFQJuBOwnJCz7iALp6eNzZ7qYhnMnMguPAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1785689185; bh=Icn5XPbJCZ72P1bsEqOJQMJ
	9gGnJqfdfWhWwWhc5dkU=; b=GtoWKURphR+TQs/vFLgEnFRHDiS1Y8GO64FE/DnwbrGk52450w
	W4XpQo90ryIzZe2Nr9aIxAVsytmlHu+Uv6d59NxlVd3+HqzdyHzkWXPELp0kRvUocEi1F3OGKjg
	mMUii4jB/Gy1lRJx/JSNzJP9o0KoIsN7CZXsEf4qFRvp4ocRn+e3LWs6YTAPJ33gTq6OHcLtqRh
	Aq3QELZjaPf75YICF0wkhS+hrttH0KFFl/Oi+FlgM2Byfyeo5wpbbkriodSk5oIEqlGf76umbHR
	JPvMXXXu2gPofjGK/mlUK9VTYzQBEX2eyLdx2+lbc6dIh3qQabEgcG27Yd5dbl+qgbw==;
Date: Sun, 2 Aug 2026 18:46:25 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.100-rt20
Message-ID: <197aa5e0-801a-4974-a0b8-ef74a5d9d593@nitrogen.local>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 6.12.100-rt20 stable release. This is just
an update to the latest stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt-patches
  Head SHA1: 26d5b688d8049e409f8cf849f6a019534259392e

Or to build 6.12.100-rt20 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.100.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.100-rt20.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

