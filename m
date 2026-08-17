Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BA3DB314;
	Mon, 17 Aug 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003983; cv=none; b=Wl0OMPgN1OevodAswVEs7XHrWRVI0opSpp7xdFvBnFwx+ITH9KYulgzuZVzWAJ1A2XuWJ1f+Gc5Wmy3HQjNdKbBuWmqakVABdNlOeOgeNlmu1F7WsThUCTVEvnG2UDm02t0RfLJSE0XHli4BvtaKWK8ubq836wDGcuacWteIQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003983; c=relaxed/simple;
	bh=UYh6rTRAk2wGNGBAOKHuPMvEoKHF0DK6OHrrcQlNOLs=;
	h=From:Subject:Date:Message-ID:To; b=msvdzgNbhO63NV1xJr7ZpKEsxin91TtdjOvvBXsJ3uaaASKlxotWIuPDSG47p8MJWmEs7BwHu0gbTci1zEWYu73AY9ScOPWsLrapeOo1t0jChfqchbbhHy/THbAOSjIzFjQ6rVmloxbqhw5zsQ25lCUspXJMvOtWbvTdowStY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD621F000E9;
	Mon, 17 Aug 2026 21:59:41 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.182-rt67
Date: Mon, 17 Aug 2026 21:58:41 -0000
Message-ID: <178700392130.2882177.634708096835019334@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.182-rt67 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 5473e5cc35dfb930c7c50fdd61e63458f975dff9

Or to build 6.1.182-rt67 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.182-rt67.patch.xz


Enjoy!
Clark
