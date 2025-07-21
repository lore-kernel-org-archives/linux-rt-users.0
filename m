Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4CAD23;
	Mon, 21 Jul 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134641; cv=none; b=L4eaRH8KLLxYLw0DqdBwTrgZkI4+Qithd1ORFfOW2dRLzGdsxC+6bpQu8v9asoYPvREJo+67HSKZkexw/ai1danV9AWzcnC4+U3T967QgokU0GkJtJoJZ5rxhNBftFljdep0AkOrfSo68FBKIZucOSWINGggarclJ8jRi6qjSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134641; c=relaxed/simple;
	bh=VTufIbNYvP7Qw/T6ARrTALc0fx6eJG4VewkKyeyeJhs=;
	h=From:Subject:Date:Message-ID:To; b=SXJhr7UHwOeL3e8R2E0qun/jNSO+BKll2I4DFyRDF+tQk3koA7nXgA0Pvj8VbDBREg/0yvt8l6ee18mxb5dqSRUsVxWDCeTg+W0GLVOgSE84iv0R3ZDJhFNZRe4jXyRqjCR20MYP209ac2P9mkuUAkrxxj/FhduJ60MR1EEWq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC06DC4CEED;
	Mon, 21 Jul 2025 21:50:40 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.99-rt58
Date: Mon, 21 Jul 2025 21:49:54 -0000
Message-ID: <175313459468.257507.16071887743492103780@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.99-rt58 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 9ce90b76d5069580f8a3657c539be4c1b6ef9b4c

Or to build 6.6.99-rt58 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.99.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.99-rt58.patch.xz


Enjoy!
Clark
