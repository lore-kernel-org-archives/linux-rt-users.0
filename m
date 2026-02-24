Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EC21A459;
	Tue, 24 Feb 2026 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902037; cv=none; b=bsWY0s8PuJzWBoCff8o5mawLChXYka+o3Lry1jz66HsR4MlmBUgUt2F5JsF8KYyL9kQJvmAkIOT9rnzHXneahog7OWqvKShrC+Jgi7kWotVIJnRAZB+a9nLNgc03UF5vpxj1Y7dywH2TF7jV9v1jn9ucYbAgy8noRMaNTYuNr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902037; c=relaxed/simple;
	bh=oUk/PmkNLVzNOHSjmOTeKxehXWu5y9ahUft0qRhhid0=;
	h=From:Subject:Date:Message-ID:To; b=emq3Qar1qXqOhLB1ZSXoUYoNHQpjecyDu0hUeRWLBiITP6D0h6pv8yYe+u7fMVLgq3pgFulxTZEaPd3aA88eXHFi+mcjkew8GWZKm5QffYOB7bHeKcl3tWKToqmIEwTbovzCLKU5Mt61BMVnokYhub+o3PreF24UAsvrC2izTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F45DC116C6;
	Tue, 24 Feb 2026 03:00:36 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.164-rt60
Date: Tue, 24 Feb 2026 02:57:42 -0000
Message-ID: <177190186269.2528149.3228838763588890477@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.164-rt60 stable release.

In addition to the 6.1.164 stable tree update, this release also contains
an RT specific commit, which is the backport of upstream commit 1adaea51c61b:

589da30efe30 ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 9902c2a1896084e3271f396b3ccb361fc4054331

Or to build 6.1.164-rt60 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.164.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.164-rt60.patch.xz


Enjoy!
Clark
