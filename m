Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFF524C;
	Sun, 22 Sep 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727033761; cv=none; b=pjC14yyGvq41pAUUD99B0O2Na6ebyZVdOvMNQTLnD9r6nG2I8M5OXWrkaUVVrcM8ke+IA9j/c8IqpO9ZURqfIczA/v0azMSSB+qhCcXpx0ahay1p03N3wbUY9RnlPxCWReml1Ve6/aNIQW6fgwFJbNzH0AZPmB1ufQw+ZWLw0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727033761; c=relaxed/simple;
	bh=QmcWLdrMmDkAjKQMeKe37sxMPXXa0nGl3lGzDcX6i/U=;
	h=From:Subject:Date:Message-ID:To; b=C0PCEIUWnSGCJSDtF87PHCFfAf/BWL/O6TmOVvzqAA5+2jiyVap20wlXvCddShbnKWPNnCGVKrYkQl/E1oBsXzsfh+geMIYJIgQbkaOwIS1mARUAXKfby/xZXRW3BRaCJr6+C+F5ofW1b2837AwP1zCd+lrSzapODDN+JPnjgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5EDC4CEC3;
	Sun, 22 Sep 2024 19:36:01 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.52-rt43
Date: Sun, 22 Sep 2024 19:35:25 -0000
Message-ID: <172703372530.2576862.6341667937000998147@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.52-rt43 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: afe962c4098bf23ce16b31c01a0307e3e61e59d3

Or to build 6.6.52-rt43 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.52.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.52-rt43.patch.xz


Enjoy!
Clark
