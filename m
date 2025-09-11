Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13839345734;
	Thu, 11 Sep 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604383; cv=none; b=W4AszkX7E7ccXCda3CGtGoMhCEDrxHr9XqskrFducL05F/1hm8DkuqKAI00M3BC20IuXCQKxUryTjBl9lA48gIXp9IwkW306CvQY7sNaIAaPKCvbaVz2P4Y6kXocSuuAcMUX6jvQnrc88y91ayjyPowDlJrj9BLunilfw0W2g/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604383; c=relaxed/simple;
	bh=8SzV7B9yyrbdND8lFkkZM/JqLWrM+K7s443mEFV5ueY=;
	h=From:Subject:Date:Message-ID:To; b=JofXV5wynAUtbmiCMl69VZoUyRvBYUL8+Kit+TRmTqklphhAhRxz5b2ega9dbzmdut8uBs4Q2pMPrCvuIFocl0eAmvhnUeKkBH83EOGNYsfv2uZovwrzTzVoMDesDOvu+whl+VLubI7kxT7Uz7PhCcX7otQeBB5PCnZ0XpIpE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B30EC4CEF0;
	Thu, 11 Sep 2025 15:26:21 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.151-rt54
Date: Thu, 11 Sep 2025 15:25:38 -0000
Message-ID: <175760433897.500323.2599535254728272709@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.151-rt54 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: dd86f367e4a7ccb1fe498813405de21a13258539

Or to build 6.1.151-rt54 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.151.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.151-rt54.patch.xz


Enjoy!
Clark
