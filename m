Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E32F6596;
	Mon, 11 May 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524572; cv=none; b=tqnqhXAR4XsG9NoIwTt4gaiRvwmXIVa0bDvPbSu2V8F7i5yxkWTnL3aO4tTqQe85s4KVKvgprYZPVrKM2GXyuG73PCYgO8NPaiTzaDaciM6IFxo4yMCqH/TrRh/PoQiSTugpKyvOBuK0A30Lt96o0fng9T2UQ2Oj6tUuH7PKglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524572; c=relaxed/simple;
	bh=gjZwab6huL9/yT03aQJFNxjFeG4nSel+tSE1SHFZT90=;
	h=From:Subject:Date:Message-ID:To; b=f7S5G9ON/e8TWezUxlzSVgPL5+hsuIU0lIqGuzmLxdVmQXc9BMOFRBHQnhc9S8UJ0B704RJb5P0ONdx+hypu+3GCKV1wYcRq7DhWDzUEMXi2+lbY0g60tscYZYoV9MrUJJgBMPnU8zeBZwXujWDJTB7gk61lhDKCEUNWUt4IZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59897C2BCB0;
	Mon, 11 May 2026 18:36:12 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.206-rt95
Date: Mon, 11 May 2026 18:35:23 -0000
Message-ID: <177852452341.515229.4260524482550495050@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.206-rt95 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: cefb594a38e93756a3e44ec8ccd74f326b5a608e

Or to build 5.15.206-rt95 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.206.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.206-rt95.patch.xz


Enjoy!
Joseph Salisbury
