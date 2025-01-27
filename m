Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECB18FC7B;
	Mon, 27 Jan 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017677; cv=none; b=ItyOS1Xr16ZNMcpfdIqxjVEC6or18LxSNdtuhO6ipNLRGP4rU6v7cVljE6UTo/kZttMJiUXpI+5NK0ZDLF06YuXkAw2WS5ItK+gA6pQmPCUckS9nPbuSZ9svTT72zdfpqSQMnytnOx4ESCnCpQMy4GXu/EKTlSV/PqE1yXjNAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017677; c=relaxed/simple;
	bh=k1KLVAkWgjyj9Xx+vG4CSan+x1rOrFG9wP5dNCOsWxE=;
	h=From:Subject:Date:Message-ID:To; b=TSt2oh1GaAET7kJ6U5q3S5pXxvYhX/4kXjbjHaP2wU4G8aGwQEQeBh1qL6dtVXXxjrDP+PVW0qAhjKhBTUq0vm8YYWWh6Fvn4qBLcbyy7X3ZZrG1S2eeaz2rKnrbPRxOcCHKZ6FBrmqnEZNLEpoI7U3v6rZweNEfiRPOv4BhgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5F4C4CED2;
	Mon, 27 Jan 2025 22:41:16 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.74-rt48
Date: Mon, 27 Jan 2025 22:33:08 -0000
Message-ID: <173801718834.626715.17380345011046003719@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.74-rt48 stable release. This was a long
one due to the conflict between the v6.6-rt PREEMPT_LAZY code and the
upstream stable changes from PeterZ in kernel/sched/fair.c. Thankfully
Sebastian bailed me out and gave me a quilt queue, which I used to resolve
merge/rebase conflicts. He also found that I was missing a couple of patch
hunks, one in drivers/gpu/drm/i915/gt/intel_breadcrumbs.c and the other in
drivers/tty/serial/sc16is7xx.c, which I've corrected.

Finally you'll see three reverts of an out of tree set of changes that
I used to handle some changes in the way openssl was packaged. Hopefully
that was only an issue on Fedora and my fault due to not realizing I needed
openssh-engine-devel :(.

Please check this release and let me know if you find any problems.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: b8c892b7816074585ff45397712c6310ba5ae26b

Or to build 6.6.74-rt48 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.74.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.74-rt48.patch.xz


Enjoy!
Clark
