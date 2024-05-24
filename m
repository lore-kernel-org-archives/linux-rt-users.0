Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206731802B;
	Fri, 24 May 2024 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564515; cv=none; b=q/0bsLa9vYXvXkUbK9oSgivvp7V/PqTKMg77zx4RVyVMyAhOocOzCLMGB/6INaVJ/0Z3z0RtJnJj6uSw57Ifg/SNTvffHrnHqUDhU1hrw4iUxa+cMkKM/mongjlPmSH674bD6qrl9SXNlM7KijSLDOGArW26D355FRq5sYCNzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564515; c=relaxed/simple;
	bh=nsN849zUWtX9u1SWvqtVGrQcDuWgg+cOsUVsz9gYzYU=;
	h=From:Subject:Date:Message-ID:To; b=oVNQjPFJxS7PRJxVivtd47ArRe9riPJSLOtpv5k2KndLYXmvYueVsz2FIEHXIQ+uvnQT/KsxB2KmBEDgSZIfDRwhsbEE9rQmVAuZjHFhR1RzfAqr/fMW/YO4BkbmHhNInxmvNvEtBjjz3EubNu9bTkbhPV7KJg+H5yztMcRcjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36DEC2BBFC;
	Fri, 24 May 2024 15:28:34 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.31-rt31
Date: Fri, 24 May 2024 15:27:45 -0000
Message-ID: <171656446568.1023533.2923770961482380735@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.31-rt31 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: e83b8bf458ff2f429aa2e6e51f15648ba3d28b7e

Or to build 6.6.31-rt31 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.31.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.31-rt31.patch.xz


Enjoy!
Clark
