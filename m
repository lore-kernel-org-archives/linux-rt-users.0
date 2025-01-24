Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BF1D47AD;
	Fri, 24 Jan 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744077; cv=none; b=HS8Ed554psFr0zPnBNmcd1ou6V/Q1VX9wCavn/HL+YR5qvtupW+DxfjDKdBvUQjafDP4TahjbniP/WLh25EBY4FG+dhu8k37a4J3Vmd/HFLB+1lYOr0g6yO5eOjORklWn9gMivllzbP3/HG7f4Fe00QwpyzS8rxjklj4IabtVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744077; c=relaxed/simple;
	bh=lKcswiwvpAj63G+tH7lPm5LxH9wUwzFh0cctCVxuA40=;
	h=From:Subject:Date:Message-ID:To; b=khvlLRK8i+EF3Y1V3+QgJW2/lnTQRT6Snvm3XLI4DlJSCO8Sx7JqlhXIOqg7ro0cOQP2um7gOJXw1sNY+H0sYN337uVmqtu3jC04hy2m45yNX+gfO3i1nWWrneYderv1y5tJSTyPL8/x5E/ieRzZfXc8IT6nmAmfyDlJ+MrIuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E012C4CED2;
	Fri, 24 Jan 2025 18:41:16 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.177-rt83
Date: Fri, 24 Jan 2025 18:27:24 -0000
Message-ID: <173774324469.3874349.8494019457396117741@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.177-rt83 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 322fcbc51c5afc26e44a4c57fb6d5b3a80b598c0

Or to build 5.15.177-rt83 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.177.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.177-rt83.patch.xz


Enjoy!
Joseph Salisbury
