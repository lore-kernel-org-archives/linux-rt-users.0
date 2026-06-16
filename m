Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D871A6803;
	Tue, 16 Jun 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573884; cv=none; b=XSYm5xbrc7Sgwz8jTK2Viamd/SoRz8mpihlbY76gSiGTJTp8DUDauyFywPP4TFPcYXDoMsKDVyUoOR2Yf6fuQK0HflmTUnsQADCOaOuXsnJPltyIpzHotq6JFMcC51e8FGBTZ/o08dhMVAL0EX7OsXHAW3Z5N3S4oLaYpR8tg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573884; c=relaxed/simple;
	bh=gB3sOd7luu6XRq61yKFesMz86TpB1EoZFaep7FSkB0g=;
	h=From:Subject:Date:Message-ID:To; b=neyqvyOab+VHbR25EOciWIe67PFaUcnz0rBnGCizpcu7jtdfLlT0nuZTzmj8eaiLmtMV97Rt2XK2iz5Ci6ZF90UqQGuwcZFaG/TpJGlmu3hQp7Nbnotz9CiCceEgQVZKeT8QHlzkeOpXoZHjJmAAMhN42nhiMkUlpCjhDteq+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AA21F000E9;
	Tue, 16 Jun 2026 01:38:03 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.175-rt63
Date: Tue, 16 Jun 2026 01:34:39 -0000
Message-ID: <178157367917.3851513.17741063665559040253@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.175-rt63 stable release.

Note that gcc version 16 had some issues with the tree and I added two commits
to deal with warnings treated as errors:

a381a46f641a kvm/vmx: guard regparm(0) on vmread_error_trampoline for x86_32 only
1fab82e55444 tools/lib/bpf: fix const-qualifier discard in resolve_full_path

I've sent the patches to the stable list so after they're pulled into linux-6.1.y
they'll override the RT patches for the following RT release. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: c232ef803846171236bc0feca33652b9fe681794

Or to build 6.1.175-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.175.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.175-rt63.patch.xz


Enjoy!
Clark

