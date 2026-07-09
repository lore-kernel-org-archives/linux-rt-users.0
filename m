Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01623EA8A;
	Thu,  9 Jul 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617576; cv=none; b=SVA0oQL3ItV85HIuM+fM0iiFmOfK2zkrwan7UzdvhEORRMsp4teRCs89FTATqI1EAXPxDuHBWzc1tfxHUIohzTUa1WY3gRwuhraoFzQCiY0tFoShKmc5TorHBtgL2KyWxZvKWvaejEk6+3+PcBM1VedshwwLtzj9oFctZzphklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617576; c=relaxed/simple;
	bh=9+p5gj9D05FD2MJ4Ds7Np9D1An9hv9dwsABvPxXK8ds=;
	h=From:Subject:Date:Message-ID:To; b=u3eV6DUbKJQdgfOY8iJKPQ0XBgDlpN7yYPRFbFUZef96O2TXyiWXXoxNt0JFiuGUftJjSbPjUt/MaVw4ICqZ3y+ttQMaQTNvfCNokRzi/5hCOMMip9R+d/puVyBk1wa1idIeHljCdDIFXmcgyskUzDCQvOYnTiJKTwn3y95AcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0473B1F000E9;
	Thu,  9 Jul 2026 17:19:34 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.211-rt97
Date: Thu, 09 Jul 2026 17:19:06 -0000
Message-ID: <178361754692.1593222.7540927403951901828@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.211-rt97 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: fcaa4db0c83ad8985e3c1f3e30fd522b1bfe75a9

Or to build 5.15.211-rt97 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.211.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.211-rt97.patch.xz


Enjoy!
Joseph Salisbury
