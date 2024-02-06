Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3531C298;
	Tue,  6 Feb 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259951; cv=none; b=sWhhsFF6cA4H4lAKHLNcPngLwmNWvNkO87yQBFyHsL6vtVza7aDvL6FWZn2zykiEnhL5Lfz4kRPxZtb8ZRofpHT8nGomxVraR8BlDGCs6I0+YqBazcrX3JJuIDHm8UlzRY8nKOWXEDNmF4+nWjY0xUGIFf03qqWoS3l65Z6p06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259951; c=relaxed/simple;
	bh=CDmzxGk0QjVfBm+F8M5NouTEtB9+n0fQwKVbt6u5aMc=;
	h=From:Subject:Date:Message-ID:To; b=o2s9HAjV3Fr6BtJX2PhgmO+YbvMNTdsJZJ+zTPswf96Hk7oRJAU2oRIn7WRSiRtCSjVvgs/UOEX3GsmdqCBdahjlG3emlmO8xOLN2kKK+egSvLCPOAVhltmQAB2t9r2tYSTnayjKIfY0oSlZM9WfmZcKo+vKQF+lQVzOGHB5fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FA6C433F1;
	Tue,  6 Feb 2024 22:52:30 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.15-rt22
Date: Tue, 06 Feb 2024 22:49:17 -0000
Message-ID: <170725975740.2355528.14726436717875387253@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.15-rt22 stable release.

Note that in addition to merging the 6.6.15 update, there are two changes to
the RT code:

8c86209f8669 Revert "preempt: Put preempt_enable() within an instrumentation*() section."
be85fc2324f5 arch/riscv:  check_unaligned_access() don't alloc page for check

Both of these were suggested by Sebastian Siewior, one to get rid of a commit that was
fixed in the stable release and the other to fix a small memory leak in the RISC-V kernel.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: fc772fe6d5e769514713819dd43c49c4092b2bf8

Or to build 6.6.15-rt22 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.15.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.15-rt22.patch.xz


Enjoy!
Clark

