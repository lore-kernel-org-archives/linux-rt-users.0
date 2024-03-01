Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14316FF2A;
	Fri,  1 Mar 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325109; cv=none; b=sD+8kIE9DkRsq9S4YOSstS6hSEomLlb/VYAl1yQ/lOdrm1VRuQb31rt8u54+ZYun/3pNWSpTdqpiGVs89ZJFV06V/tKMviKuLYvCBgJDg2s9WKCPny9AI7CMOVpts8jApqHYVpJJBH/pjkwU1J/7bOH/RMKUpmWQURhzsSnx+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325109; c=relaxed/simple;
	bh=fTbQzYWExcB5MrhHC/HS7Za3AG5luTabeT9Bkj7Ausg=;
	h=From:Subject:Date:Message-ID:To; b=c0VaaCKk/MboipLFLUPwOedZb0mAa1Vp9KnppHbihuECk1fxc/1KprLwHcIu8nAJem9hNFSyLG7yAX72wDaOwkt84Ff4DtMlyTwHCzfOEqzXN7cGdEow7bDgwWW7XxSQ6t8wSMTP5QYKH0kD45CHdZBCx0i9ig7wob0tM2B//vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D5CC433C7;
	Fri,  1 Mar 2024 20:31:48 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.80-rt26
Date: Fri, 01 Mar 2024 20:30:02 -0000
Message-ID: <170932500241.806639.8699973391121848252@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.80-rt26 stable release. In addition to merging
Greg's v6.1.80 changes, this release contains one commit backported from the
latest PREEMPT_RT uptream tree (v6.8-rc4-rt4):

       0be7a75782f0 arm: Disable FAST_GUP on PREEMPT_RT if HIGHPTE is also enabled.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: ca3cd16f344f3114fdd133946cc58a72c4f36000

Or to build 6.1.80-rt26 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.80.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.80-rt26.patch.xz


Enjoy!
Clark
