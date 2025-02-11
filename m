Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD32641E8;
	Tue, 11 Feb 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307798; cv=none; b=Npv1sO/TXjIytb7JbvEql7j+zLdJcT/UEjXJj8aOLDTLxcIF9itfgSDH7i7gZvwnodzezt67GF1h5pXFx+R+Awd1BDJ+cvUb++nFnBm5UKVSeO3o/RqUwEBMJaZlLfp+TgZILYnoqBuQmkNXC12yQ2qc5dIs800JUuRMBQffv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307798; c=relaxed/simple;
	bh=ZiV5UnlNgo5LJJYX67PTNH3d6OqRRAgbTbxt2mTmD0w=;
	h=From:Subject:Date:Message-ID:To; b=AHD1VKMRRl5EGIuRGFq/ye7KnZynez9EodzyFgP4sq4qm1Ig0TMJPoJqLeU6rVqr5M6oNKpAG+ctKbC2HaXVvH86ZvAxZ0YdKsc4R+z+EekqD+SAzDYYRgWbkFUxfvxazTuISi6RejWdggYj3oSrsESM/hXTgssd1I0WfDFiyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462B6C4CEDD;
	Tue, 11 Feb 2025 21:03:18 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.128-rt49
Date: Tue, 11 Feb 2025 21:02:32 -0000
Message-ID: <173930775249.796803.15441220010102177762@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.128-rt49 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 7faf422b9217de411f016245ab3f2f5e03c9899c

Or to build 6.1.128-rt49 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.128.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.128-rt49.patch.xz


Enjoy!
Clark
