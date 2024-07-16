Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945D25779;
	Tue, 16 Jul 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721168181; cv=none; b=UdFarF49q4/yywMcZ0VRz7AXx1DnqbnZ08M873fZCKF5pgGTN3QofzC2SGGgfS3CM6dk7ubZI8vRwtA4EE5vmsGxVXIE7dpYg/l5pzFPX1QTXES1Ne50CX1NH5u1u5v5dU4bRepD6ARPFX+q5tIu6uqfxnuPdm+SJtVWi/Nw99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721168181; c=relaxed/simple;
	bh=D42LkJfOrdEi2kwCm3TAAA1+GSEpxn3v7GPePmI1tdQ=;
	h=From:Subject:Date:Message-ID:To; b=MN5WaHjeNK6BMk895jw1m2e+Du7/19+jdeqFuPLXWoU6pWMl02XOC53+9ThdkGoVN5gzeXSLvWIFwkHW9IugPm4YdyYcbuO0FbyEMfj0fDSaCIetc9cB2j15FTSJRwuAPsRjj5oDqc0T8PSk3dmcARcKT5ipVNmFKIQ6vRT47G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3030C116B1;
	Tue, 16 Jul 2024 22:16:20 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.40-rt36
Date: Tue, 16 Jul 2024 22:14:31 -0000
Message-ID: <172116807109.767360.14072998960531182095@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.40-rt36 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 61073b0ac69c36f9c318276b6c5c5785e4b3978c

Or to build 6.6.40-rt36 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.40.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.40-rt36.patch.xz


Enjoy!
Clark
