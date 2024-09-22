Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF15B64A;
	Sun, 22 Sep 2024 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727035259; cv=none; b=KtGOkAPEd8SD+0ixELgCa47CP9N9LcpcPBkLsjd5DzJyvPPMRJxlZXtZ5ZJM3b8mcxRuPCyCvv2PW6kxeHIvV8I3Pj5DfUQLuQevOiMT0mnoLGnqg/qkGEO2a5RN4s5K3DMtIo4mJC6iDIptoMO367yLU5NRkkwUn4MfHEkrpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727035259; c=relaxed/simple;
	bh=PW73CFLoy1NujT1AOoNJA5nr+mK6Zvt6HHl6bir/aZ8=;
	h=From:Subject:Date:Message-ID:To; b=EdYlo36qXKRwTMphA5fJ3RnDEFk1EAkfF7j9kJtvr5oQAUHsW7r1yWac6OMU92fjooEx5DEuaqxVX6CyeirOyoaZeGLiu+hfpR/Nlr2KrEIz9sYcN45wwT4OhLMecoNUSy502Ox8Er12e6bQ6HgnXlRtRVzbJfvQ6a/T8WkYwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA25C4CEC3;
	Sun, 22 Sep 2024 20:00:59 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.111-rt42
Date: Sun, 22 Sep 2024 20:00:24 -0000
Message-ID: <172703522458.2716474.12619418194249809374@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.111-rt42 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: ae643a2f60520f03fb176d684febadb445b51095

Or to build 6.1.111-rt42 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.111.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.111-rt42.patch.xz


Enjoy!
Clark
