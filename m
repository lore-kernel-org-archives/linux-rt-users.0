Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523492DFA5B;
	Fri, 18 Jul 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852844; cv=none; b=uyDx60x/s6u3pfoHiyf5PZw4nVoELoiFcVVOT03hEwfj3p5d+z4o9ieeOkh7ZJaqFBt6IbhVTm06VKp3OVHvfi3PechDwb7E7nn24EzTUBqHTTu076MdNMTTDEnJ8PvDQCQOqEK4nPgU4rVuIPVlYyTOc0cfuXzkMh1SFxNCmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852844; c=relaxed/simple;
	bh=bMAYp832eJRbFhvQyNN9lKM9IWpAlp4UHAZ5J01nJso=;
	h=From:Subject:Date:Message-ID:To; b=SbjrItJnE9LzoGBtNfJ4xrVlPMiIMzwZFWBT6aegwnrgIBxusQhdNdRQuquoesKXnHczq0wtC2f93vzcwcPhcMLhqT0YZS+ryjfEPXAAnwsH0gmslIYdJlOhmfYpfatloe68YvYforEPtv3Qf0+SzTeuXoJV0ptQ8uJRkZQ5puQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33C3C4CEEB;
	Fri, 18 Jul 2025 15:34:03 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.189-rt87
Date: Fri, 18 Jul 2025 15:33:18 -0000
Message-ID: <175285279834.432835.7598065816181540951@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.189-rt87 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: c3e1fdf3f5e8407ab50b9dc1ac0d346dcd1a5ed9

Or to build 5.15.189-rt87 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.189.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.189-rt87.patch.xz


Enjoy!
Joseph Salisbury
