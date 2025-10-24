Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F52153D3;
	Fri, 24 Oct 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315924; cv=none; b=hr5YcODzZ9qMS/eqxTmPU5zkVSQaitJ+n8+XsELazluE9WSJdl5Y4JqyyK34Jadaa+rzSKRfdbPFz31l+GWUQWOp34ZqUVbrh7JXA5HQJLBnxOQ+X47Oa0kT0IQ8J9fVuj1iygQlpwvE9netA7mUhxkCl/H3S8FI+w4Iktk4QbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315924; c=relaxed/simple;
	bh=Dp2tMX7zMN7M2u0nEysiM+LRLHt/4c33JDnqsbwNJqA=;
	h=From:Subject:Date:Message-ID:To; b=lf4iy2r7saBBg/KEpYByzlnOFcxLFopLvTerk8tXTYyuPdGOnP1PnNGGRA8jxe5/sIqukqTHmnWd3wk1ssYCF2VLQ5bV4OjUingGpkbvYQ6opHFAsxUsWFaMqwNb6xYlYo1+oDv3XRZW6k6ZXAfYMVCY8SGWQ4z3Ny4Zd0KkDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAF3C4CEF1;
	Fri, 24 Oct 2025 14:25:23 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.113-rt64
Date: Fri, 24 Oct 2025 14:24:33 -0000
Message-ID: <176131587397.2087940.9909280471524573596@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.113-rt64 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 5da32bb3192889530bd76fc4f0adb75c54044cfe

Or to build 6.6.113-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.113.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.113-rt64.patch.xz


Enjoy!
Clark
