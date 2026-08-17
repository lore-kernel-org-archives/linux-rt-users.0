Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FB126ED4F;
	Mon, 17 Aug 2026 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003422; cv=none; b=MIR31eXRxsW4/ee9Jgs0nDRhKftCXweSDMLs89mCwObNEtc9Gj/7Ryxp0Jck7ymK6ThSnYMF91DFqMkTyBB/SskPqm5QJf2t7baNu74HkoUlvhfvJ6mJoBBYGUi1M/llneBTR4mVmI54GvchOEOc0ts0yAQBGI4YzEAYY3WYdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003422; c=relaxed/simple;
	bh=0mXWQlG+Du8SDPCCu4YW0TPUx2SLz8bLlu0aPikbDQQ=;
	h=From:Subject:Date:Message-ID:To; b=WrlKsn2JWm8MJmhw1LEEIQDKq1BpxtjMLHvpNko2Boq27XCc22MjNKDE2VWqm0WEwVKqQqAc09b/42doyG1yVnzdc4MH9KL9OZEkoYwq28Y6o34fDofrPgMsD1UVbjXRAmMCGCZIefQ7py2C2HYjwfsSZ/Kk0BTLtG2cCG3+kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C091F000E9;
	Mon, 17 Aug 2026 21:50:21 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.151-rt78
Date: Mon, 17 Aug 2026 21:49:06 -0000
Message-ID: <178700334643.2788043.16527030850355039192@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.151-rt78 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 84925bb144f49eb0d5f4c5c29f690b4bbf84903b

Or to build 6.6.151-rt78 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.151.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.151-rt78.patch.xz


Enjoy!
Clark
