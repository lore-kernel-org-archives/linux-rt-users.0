Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D518635;
	Mon,  1 Jul 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866289; cv=none; b=r+jtJiQNxIpuxoCPWvwzjmOIr1Ol7w1RqNhl+0f5uN/yrqHkjFidpnCkaViwZOqWFAtOe2j8Ayh4CQFR1jhMWqs1RVv/nQLjXvNv7LEZQegokyLEmtyfwQz5CDzVJlgGuzv7m/Q76Tuub8/iQGYTo6unecWndSgGG51ODABF9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866289; c=relaxed/simple;
	bh=GtzHsfmxTwlD8fkBydhACIzOTugc3g87sx9jSrQdjYI=;
	h=From:Subject:Date:Message-ID:To; b=odW4UlG5BBdfdMQyGNmQU3ig4ojPmwF1ipLflq+Qi3bsYQGOBQTLF7zagTNMZaTWVUt/fQJITqXjHOjciyeXssna593BtCVs2CZJjyslw3vf8y845/RQDkjiVaLnWZl3Afn4fWHC0VgV5MTxzJPobGJvHydnguhUePJJXFfgEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E123CC116B1;
	Mon,  1 Jul 2024 20:38:08 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.36-rt35
Date: Mon, 01 Jul 2024 20:33:56 -0000
Message-ID: <171986603692.1363512.2827523700380457269@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>,Derek Barbosa <debarbos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.36-rt35 stable release.

This release is the merge of the v6.6.36 stable tree and the addition of one commit:

     2cd745fc0bec prinkt/nbcon: Add a scheduling point to nbcon_kthread_func().

The commit addresses a live-lock in the printk/nbcon code when running a kernel from
a tree with the RT code applied but compiled without PREEMPT_RT. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: de1f6214d67ede05aa223fcb7e6e48474bee628b

Or to build 6.6.36-rt35 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.36.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.36-rt35.patch.xz


Enjoy!
Clark
