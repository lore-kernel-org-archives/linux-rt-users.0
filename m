Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41417C7BF;
	Tue, 25 Jun 2024 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353484; cv=none; b=jS14HwLE3X1Ju3cpDaL3xKCj2CA2IkW491FCq/iyuVnxiMFDAGgsqtF/Su8N1wHxVtsur0xvALTDK22R4QSQQ3IrFv9TAsIMyV1dkK9TguwudxlZh9tmlI5C2qvZi59Hwa6xMpi1SM5LSBQ/cFnZ0CnOQQNfAn6kfZjaPPFDwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353484; c=relaxed/simple;
	bh=n1nlo2KQS0UOjtRczDrfYS45Plla/pgmuts6/ltJ8p0=;
	h=From:Subject:Date:Message-ID:To; b=pleon74hZHq8E0CDKxHMnQQG/rb3CmApneosce96epbVO0s0/xRdmLX2Il3H02gVMS+8WR+MsX376Zu1IjiQCHFe9vxtf+ENk0u/4auFn8mslicVcxh/TZi1HwaiN1nUo+cKOgyEWfbqYPiCKo6jGqcXGEWWoCprsM62ZqaST3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83282C32781;
	Tue, 25 Jun 2024 22:11:23 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.35-rt34
Date: Tue, 25 Jun 2024 22:10:28 -0000
Message-ID: <171935342800.749835.13365997826807649617@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.35-rt34 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: bca099ca6243687f67b23f4d32a80aa453c4d5d2

Or to build 6.6.35-rt34 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.35.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.35-rt34.patch.xz


Enjoy!
Clark
