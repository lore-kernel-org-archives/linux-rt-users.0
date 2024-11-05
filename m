Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABC29CE8;
	Tue,  5 Nov 2024 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838873; cv=none; b=Ou4dMQEdpVmT9XYPou1XHUTvu6/RNHYrqduPBCuD0KXIq7z3CnGi1g124eDOE0DCDt0gs5hXxRVB2MR+EkSd7P7O/zWLd7rqK0cTCCSxic3630r6CBu8jNv25Y06FwqLIWopi/f1fo0Em8xkbxcYThOYvFWtQfjJ485t5FcHpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838873; c=relaxed/simple;
	bh=5oGlmXIECbQ93Lq1NESvyNJUA67pBUvJc9Xt5LWWJdQ=;
	h=From:Subject:Date:Message-ID:To; b=UvdvSl3cgUpk+k/XvcTFfwm1ToNla7smvPRNiRO5nRuyGR3U3a+YJbiwf1nljcmEKlNhsJbUtp4wG66KMidxkhx+ePDAgEk7bOVj+AwekcJMwfJmHsEWHF6Zl43XENG6Whryyu3VZTvxhotLd1xnCLBXmhOPgOvFy+MwWSqD348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1BDC4CECF;
	Tue,  5 Nov 2024 20:34:32 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.170-rt81
Date: Tue, 05 Nov 2024 20:26:53 -0000
Message-ID: <173083841317.3068608.16605335356855199499@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.170-rt81 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 67017c496f78e15598f48bb3115e3641a82ae507

Or to build 5.15.170-rt81 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.170.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.170-rt81.patch.xz


Enjoy!
Joseph Salisbury
