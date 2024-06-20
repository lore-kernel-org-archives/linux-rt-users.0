Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422527D417;
	Thu, 20 Jun 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917264; cv=none; b=fZiBi4O7VqsBdYy0AkwncmTUGHDy70JFPao8vHUIPdEqqKC2zRA8HN6ApWB1hSMFRmx4V9hM7qXnPFNReuC+2XQSLkcLO5aC3tsuDW9moQA4RVV7EwZ/qZTUcStGXeIfPGYrgjfmxByVkGCH5CnLrZ5p2ZXn16PjDgIb8POBxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917264; c=relaxed/simple;
	bh=QaSKRjYjOJVdAqkW6i6FYas3DEAnwc+g5BW992YMdao=;
	h=From:Subject:Date:Message-ID:To; b=pjcoX5Mmx9GKLaOxowFYTiNoj9uFF45w5qWkvRSBRUEhDIRxPwdeBk58NSZxuj3N9VCOjRWZZb1AnhWU7feScAAZnepS5I8EmkNF9jC0TyNwyXfuZsCUMh64KnmHvyCSBjkybPWqXOspXmeYsGObJPMEdLJx6y745rmmShOl30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE297C4AF07;
	Thu, 20 Jun 2024 21:01:03 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.94-rt33
Date: Thu, 20 Jun 2024 21:00:28 -0000
Message-ID: <171891722894.353638.8744756880426565065@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.94-rt33 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: aed73b33b04a789ae0138428e5b83dfc74c99b45

Or to build 6.1.94-rt33 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.94.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.94-rt33.patch.xz


Enjoy!
Clark
