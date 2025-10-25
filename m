Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B82FE07E;
	Sat, 25 Oct 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761421281; cv=none; b=Q+N6AQynF+K3axAWL2ZOnrob1/popZtc5goLMYM+1HD9jsxDXDLAdSHfzotsANbnK9hdpXQz9TeUJJt+iFkoIavG/XrdaKOOjdOs9JAYPeuRTFET2WDWsCPyZt4Vxx5UtEZ8b9omLnwuSWIFC/tl3IDfcB22OtqVMNQ2UWdJ2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761421281; c=relaxed/simple;
	bh=NzaZ3CiiIeAU1eb/XFt80wUeJdtaS7tpvIIGtpHvaSg=;
	h=From:Subject:Date:Message-ID:To; b=Bjngtjkr1nrFRdqmbbRhlrxuImF2qCeXH2Kf7Vq15dcKbdWwwFbbQPeHyP8purXykJwp/wn1wfCgOvqpNqJ1Hr/p5NjKGfsGq0VcSW/02dtGFTWZI+DnW3AuaFM+JaLSR4FGwnx9+2l7gInR7G/1oxW/7Cxg/PYMyOyP/5fOaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D953C4CEF5;
	Sat, 25 Oct 2025 19:41:21 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.114-rt65
Date: Sat, 25 Oct 2025 19:40:35 -0000
Message-ID: <176142123504.2391680.9403530720672072172@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.114-rt65 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 8730bff5e3fb6244ff05722adeb890c928444cca

Or to build 6.6.114-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.114.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.114-rt65.patch.xz


Enjoy!
Clark
