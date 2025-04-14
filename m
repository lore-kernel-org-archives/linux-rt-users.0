Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202C1FAC34;
	Mon, 14 Apr 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673251; cv=none; b=uXU5/OTLULKZPLDW9sTIV4rCikmFVaFYvIPrY+vh90fLfz/GWR9S+WZPHF43irSNtjvRD3cFCubUWQEv4dtQAu58Afa1nzqGZZ0ibIk3XssFgWqv5l7yRtbrZirzfgVw3zE9N3faUE2geED7VMoPnhiQgjL37HyfZjwXL0Wa0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673251; c=relaxed/simple;
	bh=p6g6ziSaBXs3EAxpznhL41fI8ZYQJJnvHNbBzgVUSak=;
	h=From:Subject:Date:Message-ID:To; b=sFrTMV7qbF2Ho3ra6qX96UNbrs4n/4chkFNjFn7CD/CocAn1pDm3T4pRZGKUyqtcp7yIBIewzy08o/lSANPDXA7PV6ZBjmqqGvWkSFV37cFkgrnV7j5phAJiV6BjBftGvLCxCQ/HuNzFJfgQLFhEOFSRzWnI6J4jVyDe98z7reE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A3C4CEE9;
	Mon, 14 Apr 2025 23:27:30 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.87-rt54
Date: Mon, 14 Apr 2025 23:26:01 -0000
Message-ID: <174467316163.556215.3409258210392642159@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.87-rt54 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: a4080334e237c0ecb0ac4b3ecdc5ec2d8d6dbe31

Or to build 6.6.87-rt54 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.87.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.87-rt54.patch.xz


Enjoy!
Clark
