Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88B2701C4;
	Fri, 20 Feb 2026 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771556269; cv=none; b=rZ2BjlMOlyJqk0r0cysrmYrBOAOnnMTw3rCNipiMYuf47wvT7OR6yY2uQHCN3ZX0CjYSzgcurt8MgH5NP8UCNhbr2LnxcKsvGsJXwxVSWQOSJJGvIt294GGbQ6N+v18fQvYdzsUKx5/LJFj5FDFAR/DaRQO04XaupZHQKf/UiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771556269; c=relaxed/simple;
	bh=KBjfq/xFi+gsUEkTyGUyG+wYBX/hLoZtomPOkVuj5Wg=;
	h=From:Subject:Date:Message-ID:To; b=gQAfb8iV4qypP7yfhQLrV9UqkOLvcOJzAHu+W4+yrJytBg6716vv/7lw3XJvkMkDhsEUD2JPQKkHusGyCAc1L7NLgP0aXmJ7EdrXEP3m0NKNA89a0WHOAYkaDG4R3IQKAYyltDNDKb6gKZu1txXUv9FdduEHNJDnMc5vgCdWce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC11C4CEF7;
	Fri, 20 Feb 2026 02:57:49 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.127-rt69
Date: Fri, 20 Feb 2026 02:55:03 -0000
Message-ID: <177155610384.1493530.10533644309502862975@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.127-rt69 stable release.

Note that in addition to the 6.6.127 stable update, this
release includes an RT only backport of the upstream commit 1adaea51c61b:

bc80e0ea516a ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 543b9df171270370337c53964ed88b85578a16f8

Or to build 6.6.127-rt69 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.127.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.127-rt69.patch.xz


Enjoy!
Clark
