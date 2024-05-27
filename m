Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C110E4;
	Mon, 27 May 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716776329; cv=none; b=lKqKeUhNtWazJj40BkyYU4aKBB/irX8kD3IzfCnorQZHSB04gmUC8CEt4Hg4J7a9O2VlrNu08EJ6AISP7W1Faj6yAsIjCsClXNluOJ1yRKUMV/2F5S4O4UstYM8CZQ6AaMCsFIi3gPoeSyZtgOKNUV2v02FaV+6lTbsmCTwsHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716776329; c=relaxed/simple;
	bh=h714SLTwEMfeoYfSobqGSbvbn0dh46Ou/drFzdzYbXU=;
	h=From:Subject:Date:Message-ID:To; b=EsppsZUCCFxHKKCwK2JwUYusp4v9Yhg8L4BnWjFP+Ye0Tzz3mHnT/4ncZ961sBN6+vQfVMPp7mNOc0sGU9WYnPicEB4vy4qpoHH98BI4XOLMEdapA7cB0Iag0/POc8Mc+qjROmUNn2Wd9+QH0W0dTgA3WKIK7nd0CB18jPQdrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4FEC2BD10;
	Mon, 27 May 2024 02:18:48 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.92-rt32
Date: Mon, 27 May 2024 02:18:16 -0000
Message-ID: <171677629682.1563516.14642351149648872540@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.92-rt32 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: b5e9492f0754bee991234b10ace058b275a2d8b4

Or to build 6.1.92-rt32 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.92.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.92-rt32.patch.xz


Enjoy!
Clark
