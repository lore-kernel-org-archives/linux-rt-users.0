Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483903DC4DC;
	Wed, 25 Mar 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447093; cv=none; b=MG9j5dii/vvvRTr+2xAvSv3cIMyRwG/gPay2DeOHGcrXesWal+Y64Is2QBCgvBkIxfgDD9C5qvBZAe8cJrc6pnBEljWf+SBPA13vHYYkHhFCEA6nUxbZnkk163/ZB6iEeYlGtK2ue5UjSxeQQLDqOxHLDWoPPBFzUQRZmQJdMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447093; c=relaxed/simple;
	bh=ExBPXcEQz+pcNYpqYhrE6f0/t1xzagNIF66oP/GTxEM=;
	h=From:Subject:Date:Message-ID:To; b=ad+P9wFOlG51KK5wvGT7XRNtq7JU6w5jLzT/MU6ifEDKumAqYN6JWE8hVHn0Adv2d+tr73QpWwwRxl3XuDUR01PJfMBm1ovAAg4ciXvx3Qtkl4EjbwAWv0kyTuan+hBqO3xsHD3mrr1MQOPP3pD3+zwAL4NCWi7ObvxItSrI5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF37C19423;
	Wed, 25 Mar 2026 13:58:12 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.130-rt71
Date: Wed, 25 Mar 2026 13:57:14 -0000
Message-ID: <177444703495.902281.17583706899682935588@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.130-rt71 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: e18e0b6a2391b8351f345b3d7d34babf50080dea

Or to build 6.6.130-rt71 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.130.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.130-rt71.patch.xz


Enjoy!
Clark

