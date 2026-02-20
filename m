Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3119C546;
	Fri, 20 Feb 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608498; cv=none; b=pGvZkI3rB/VXhrbaQOqzmOr+CgoIg22DBYAnbFLRDTnj1uYTe7ndHCTXs6Li6XSO1rTmQvKnT4jMGn9c/P7u/ck+xczt1UxtOvkSltnX4ikk3hBALfTe3X4IG2kQZMYgf93B6907hyW6VoYoPjf/37vMBE/r2s2a2FoCD0cpnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608498; c=relaxed/simple;
	bh=vCxdjlRIGsEtML+6IaEvm03lrpgPrO1OEmaLd8s8meg=;
	h=From:Subject:Date:Message-ID:To; b=dnrt5nRE8FgbaHcxsMwZ0j97w696M53EkzgwZUOQxOYoBNa5l+9HDoyUjq1DYaATfROhCuHCPVmYUj1U8u/X544tOYsmd0y53MPIE8uCLwBXlL9hIrCp4fdWSX4hwup83BVW5gO7q9vr9MY+ScqBlplOjlhWiV5dVJLIh6kKCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1C2C116C6;
	Fri, 20 Feb 2026 17:28:17 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.201-rt92
Date: Fri, 20 Feb 2026 17:27:56 -0000
Message-ID: <177160847644.1189209.5731442191995523959@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.201-rt92 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: c6993ee90e2e3a76e3a0483ecbbe88f7cd12671d

Or to build 5.15.201-rt92 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.201.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.201-rt92.patch.xz


Enjoy!
Joseph Salisbury
