Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954631;
	b=cyOQoJjLU5HuX6LPKxBoLuB3cxIzyLSDMh9rwd9qBYXRAz1i/vIruDQt5VpVuCEoEwLc
	 71vDPdRApfnAaTHF3XYWpRyxgE1tYify2srNaIDT7MK5IJSZtLpNNrNJLD82+bcBCjGBr
	 TxIJuRBKkcPnVKpQ6yEiP4/fDLeMY49jX0Ympg8ZGfdFxl2d0BwbzcwyAwxQmUHX7ceyh
	 rb6GPSOSyuS/3fzB6qePfd8otHOGtOoikvZq2g57bMyGU72U8yPbhKlTd2Sv/s9zc2wKU
	 frMT2uXp9hy+K2+t/xFoqSrXeOLx4K1ZvBrVyzpFX+UmPZEhORYk9idscKyQrO4wNKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954631;
	h=Received:From:Subject:Date:Message-ID:To;
	bh=rbqXvq8mQGnXqVjP+07546QcX3XgRz3Vx/9AtBauWts=;
	b=J0lyT+u6cmid/HzxN4ojlQ7ykJJA5HjibzYRufg2niHauWPAQzYbedkttRgt7F7o1cHx
	 5UbdzeWppstPH4x1mdPQxWn+t23vA1INO28puZiCTnC4SwTMLg7XV3r+GfI3pBv0p3w8C
	 kf9nFSLRe3Akbiw5MtDcmG4v2zTxXi5jNIcfvPxF8WjdgB06NvrYQhMMfzQw1lpprutjT
	 9X0hTRIyIKv0wehjDM/s28ivAc6n+6lMGZGSNvuNhqpXgKuXFL3oWFuDturpDTKsCQR1S
	 yQjlQvP3stUGq261kUW8GS02Hfc75hd/xpK2zEqYFWY1xYGrFktl6/+gXvA+wslXqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92556606A31A;
	Sun, 25 Oct 2026 18:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D701F01825;
	Sun, 25 Oct 2026 18:57:10 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.159-rt82
Date: Sun, 25 Oct 2026 18:50:47 -0000
Message-ID: <179295424780.1488364.7778089586315659031@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list

Hello RT-list!

I'm pleased to announce the 6.6.159-rt82 stable release.

This is Wen Yang's backport of Sebastian Andrzej Siewior's
changes to the backlog-NAPI smpboot thread mechanism from upstream
to v6.6-rt. This is actually a backport in preparation of a larger
series going back into v6.1-rt, mainly to keep parity between these
two branches in terms of RT specific changes. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 7fe2a2de958636b5d9bb9f9fe8894613ec014a32

Or to build 6.6.159-rt82 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.159.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.159-rt82.patch.xz


Enjoy!
Clark

Changes from v6.6.159-rt81:
---

Clark Williams (1):
      Linux 6.6.159-rt82

Sebastian Andrzej Siewior (4):
      net: Remove conditional threaded-NAPI wakeup based on task state.
      net: Allow to use SMP threads for backlog NAPI.
      net: Use backlog-NAPI to clean up the defer_list.
      net: Rename rps_lock to backlog_lock.

Wen Yang (1):
      Revert "net: Avoid the IPI to free the"
---
include/linux/netdevice.h |   5 +-
 localversion-rt           |   2 +-
 net/core/dev.c            | 252 +++++++++++++++++++++++++++++-----------------
 net/core/skbuff.c         |   9 +-
 4 files changed, 162 insertions(+), 106 deletions(-)
