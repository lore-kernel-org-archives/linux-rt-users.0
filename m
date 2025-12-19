Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBA34B43F;
	Fri, 19 Dec 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166220; cv=none; b=IEmMU8nog8InlYx9s+3H2blCPNobLjE8cShiMiUQm0eN+R5C1YBgxoACZ2X1OngaahIYAfpIViCZ5s2c7Iv++d0xnFrKBSIkACo8ZioGT0DKgjfrdilRtbWGDEdzEnkAVn7FsJxw4VF0aTr6sfgGfEgKY/JJm4aA/HR4+wnkB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166220; c=relaxed/simple;
	bh=fwd/tqETodo3afMGctU4d/J7V0Ok7ilCtN9P7bCcD7E=;
	h=From:Subject:Date:Message-ID:To; b=fPBe19dEsVEtnw7Y0ApAf9NN7J9sG617l8zRAaZTa2YdpTHqtCx0L48uEPoYaCw9nIJKrzlA/HtpIxGE2z73Xg5jhId0IXNGIxgjy9tIRktPucbNxhsJZk8ppPKu5yZsLii55X4s5dkZu0QMsZI288V+a8geuENdIAuKhYRotrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D57C4CEF1;
	Fri, 19 Dec 2025 17:43:39 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.197-rt91
Date: Fri, 19 Dec 2025 17:41:05 -0000
Message-ID: <176616606584.421435.6191205719984305919@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.197-rt91 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 94a9ad5947db4768a0b706fc48bfe011e75a7150

Or to build 5.15.197-rt91 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.197.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.197-rt91.patch.xz


Enjoy!
Joseph Salisbury
