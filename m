Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF315B0EF;
	Sun, 13 Jul 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430916; cv=none; b=JCkLrbyq5IPG4qlfpo8OPFAmck6PitIS0M0Z9iqHwzQhRYS0/TDH4hp36W4LjTnNcxzgtWq2lGTPyBkvcYUYvr7AXn8+XKLFRfXD8mKHGY7JRzF2AZ9ynrr8NhzL1k4Ds7mmoLgIGbS+rQH9AUfpw3xt9Er9Myrhk+1Lz7tbnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430916; c=relaxed/simple;
	bh=0z4tBetC1XzgynJx07RVrSZfqezQIZ9FMUsD+ce9VWE=;
	h=From:Subject:Date:Message-ID:To; b=HTVjygbB2FsxBvbFjCKfQmWDNHs+sI3ra+Nrw2oViMx74fd5JKYDK9WH1K+eEEL6uK1WVpfGi5X/4OLQJCBKPqHWbbvJrz1RjqPcXa31YOu8PRiOFkJ7WO8sIad3ty6sSQvL1/lX9gSEEjqQ85hwzjFXI3Xf0iAsdUT8vZ34Roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5864AC4CEE3;
	Sun, 13 Jul 2025 18:21:55 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.97-rt57
Date: Sun, 13 Jul 2025 18:21:26 -0000
Message-ID: <175243088672.156964.5270040877373409435@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.97-rt57 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 60afa5684fff981a86d2a55f600767cb4cd353dc

Or to build 6.6.97-rt57 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.97.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.97-rt57.patch.xz


Enjoy!
Clark
