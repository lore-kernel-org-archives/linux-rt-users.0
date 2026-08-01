Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC78309F1B;
	Sat,  1 Aug 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593453; cv=none; b=BnADbDy9h2byIHrZtYrx8D+x5TDG/qwiF17Ug+5SpO//qe3SIpFiSals7zkQ5j5Qrdb6VssoJ6uy1N+McbV24/W18WxZl2umF5BMGzBTQtmXeCf/Lv4Dyu+dWY5GlWX3AjLqrhECaANCEuoDjk+ffF/jzTdDLkBCvNN5XOll6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593453; c=relaxed/simple;
	bh=wPOagMRMCmIK/y0y3QANZXtX0W5Ikz6plJuNbFw521M=;
	h=From:Subject:Date:Message-ID:To; b=KuFHSmfvMoL0neJck5j8jt3VnNLao58EeInyIBVoGLzZv2nAP5pJKWVK+lOAWZEnRTIDFaR3s0+7aQrlK2UnygdnF1LWaz+1JPLksHkgv3bj7t5FXp6l66fhsfdwjNwaQLcoLXoT8ThIt2nvAyMHqvwIUU7FutuiV9+4m7Pt5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A291F00AC4;
	Sat,  1 Aug 2026 14:10:51 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.147-rt77
Date: Sat, 01 Aug 2026 14:10:04 -0000
Message-ID: <178559340415.1480029.9654109287291974800@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.147-rt77 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 0ac31d6bf34e04c708e93c3b04738217abdb6c36

Or to build 6.6.147-rt77 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.147.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.147-rt77.patch.xz


Enjoy!
Clark
