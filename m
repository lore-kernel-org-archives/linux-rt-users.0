Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3F74C14;
	Sun,  2 Nov 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111156; cv=none; b=d+k0hLMd49Qifm8dtofrOzqMzLlOtSUtlKWIQGvU2g6Aj/Wt8JJsIJGGht4XbvmfiM0FOkBWkt1P9gHHBBN5oGi4U/tT1gosOQ6GcEHJKtkuEl8rUihxBbsOmlEDIFCgsqyrMzBUWZEdvh/1boqKDt6HRaqgkHIZcQ1KZ35dfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111156; c=relaxed/simple;
	bh=XLk2Ubn0X3Mq+svGI/FMiBCcXW3Q+78IWCLc0zoOmdQ=;
	h=From:Subject:Date:Message-ID:To; b=Bcqk6ktAcOIGmGsv9fSdi1cfwgK+acW2kEEjY6UZgyifuFrQNRfVGD3vozkcPHBJcWNvvl5EkmdKDGEQnNm6VkfLZCSB1lgyJVHyWFusgaO4SerCeubLpPp8V3QImxLDvCNQjWqYEC6oY9BIftn1uoXDEASxmKURfAD7WXGJpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2100C4CEF7;
	Sun,  2 Nov 2025 19:19:15 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.116-rt66
Date: Sun, 02 Nov 2025 19:18:24 -0000
Message-ID: <176211110436.3177369.3476597062115119817@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.116-rt66 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 313a4080dc9299b2cc50f5b84ef0ccacd4b3b24a

Or to build 6.6.116-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.116.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.116-rt66.patch.xz


Enjoy!
Clark
