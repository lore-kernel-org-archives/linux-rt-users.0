Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592813F43B;
	Sun, 13 Oct 2024 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728855834; cv=none; b=R5VxlieDAMfID+/6QP2UGo9+DDNbH9rA6UIuP2dvzmd71BYOOTtPA23uH9QN65ZFv+bSMbUpgak+EZT03vKXjkpPhS80+JAaJKihSnnT3CwyjI7H3wiWeK2N9KjEpsFzm04lbDUzGumXovWxPuqaiAvzyOyUbwQ10c9aN0T0KUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728855834; c=relaxed/simple;
	bh=4KWwks5hJtUkNjztUBdvSs1Q5pRZx3IQerW+lKAbYas=;
	h=From:Subject:Date:Message-ID:To; b=IDAcc8q6M4HQkS7aNL53OFfMyfBm9GKbMsPTz6iLgamI5nnQmMI4c3OEeavem5i/LmDlPZaMl1TSGQhFyBwse8uw+67uBHJGlpbrAfccwzujUqjXv1nkt11shklnHL/jkxP7ILh2dCeN7rhBpyVdXm3dovZKKiSxcG4DwNn4TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BF8C4CEC5;
	Sun, 13 Oct 2024 21:43:53 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.53-rt44
Date: Sun, 13 Oct 2024 21:43:17 -0000
Message-ID: <172885579773.1079975.12506499268013224109@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.53-rt44 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: ba97699fad0ef69b00686a2786cd173c9582e3e9

Or to build 6.6.53-rt44 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.53.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.53-rt44.patch.xz


Enjoy!
Clark

