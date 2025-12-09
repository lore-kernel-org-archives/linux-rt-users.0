Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FE283FDF;
	Tue,  9 Dec 2025 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321034; cv=none; b=E3cw1qWIT4Sj49jlGjwmxaKzvdufll95fIn4fX4ooMmZvzyr0HrgonDhtO1dMkuAi0AhtY+AIfcXBcWYElEDActnVk26rHCxFOIfrUGuIx07tz2idxHu8+dcXb8RqbvdgB3HDZYp3dJEApEgloZF5UMeuyR/NzpmtAnA/+Iklko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321034; c=relaxed/simple;
	bh=yyRahrtlsutwECX6O1ORkGOjjaEOjpdE4ALbb+n6mTA=;
	h=From:Subject:Date:Message-ID:To; b=VHlH3zyMxxmB3CcAKUJjfzZo6zWFnk7/tpLCOr97cPw+8Dtt/NIgxp0AR5G+87NO4zet84cZwpOColplRJYOiVF0XFuQBQmvjlXeevwr696w8NQB5B0K3iJNnKQug3EhPgKHQgaSzLiktXTXfe1GWwC4paAo7wb8zmjmrkgCNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A59C4CEF5;
	Tue,  9 Dec 2025 22:57:12 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.119-rt67
Date: Tue, 09 Dec 2025 22:56:14 -0000
Message-ID: <176532097422.262627.11373248051565726270@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.119-rt67 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 67a5a2ed7ebca42a646433ff04b3559a5beda48a

Or to build 6.6.119-rt67 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.119.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.119-rt67.patch.xz


Enjoy!
Clark
