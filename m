Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8013A41F;
	Mon, 24 Mar 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831949; cv=none; b=kQvn4kx0DkUT+QBKzUnshSNnUNJ9ZsdP4OU8DvyuJoseiivwc1r1583wFPDKNU3U7cqoglM7fuTMJPHquqKIn/SvndjKGHcn290aAlCTHMvRyT2oh0aa/h66kuPUWpM04jbgE3WDW/THy0682FQfc5g7owjNBsX5ALkkEOyO0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831949; c=relaxed/simple;
	bh=G56A8jOTTK1WscGk7rHGhLpb5HQM2DV8gKU8mM1+wJ8=;
	h=From:Subject:Date:Message-ID:To; b=MPvl5rP3O6VG2DnSdhFYS3MO0ZFjfGMRhkJMUsTNAGBtnLt6XaDEgLFhvs09xjhwOoKpVgHnT2Hh+nMjRbzTWN97ffYuWSL4KJSNNsngzCawWedJXtolY5DZrawvGedFt74Ft48SLAhA78uHpb1zpUR8eQfeZnGBXpNXQBwIY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97209C4CEDD;
	Mon, 24 Mar 2025 15:59:08 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.84-rt52
Date: Mon, 24 Mar 2025 15:56:49 -0000
Message-ID: <174283180972.621163.577540576622356859@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.84-rt52 stable release.

In addition to merging the v6.6.84 changes this port contains one
backport from Sebastian:

d423d4a3e63 netfilter: nft_counter: Use u64_stats_t for statistic.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 025ecd0d058156e3ea73b0862c23258bb9cc9149

Or to build 6.6.84-rt52 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.84.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.84-rt52.patch.xz


Enjoy!
Clark
