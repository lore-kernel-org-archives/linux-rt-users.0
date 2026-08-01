Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E43093A6;
	Sat,  1 Aug 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594598; cv=none; b=un5fvYS7byo5MO1tNivQhUHVz4xvTRgmDEz57Bd2UJ8ToRwO9ttQ30M9T6aqoG6dF+2mGsOCDR7tXTjzTjnd+WjyjbHf9RbCalsux3+kEpbjCxaS5e/OCeOy1dPP1b0FlfPZuRQ3nvilxpxQjGxQ8jfWe4slLbplgVwHzybqyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594598; c=relaxed/simple;
	bh=nXxqn5RG1tKajcPa7ODInOV//sWKjaiNYcz/3YHz304=;
	h=From:Subject:Date:Message-ID:To; b=t9H+I2jGmkhWixU364Crsyn0y7vzTAX4deGD+XRdc1MyujmEeiPriXAywIrClIgkHDy5p8cHMaBFH8ZGzIVirgHDACcsliv8VQeqfnuTi74W9gk9XlHGWXVB0Ma7ljJ+ZXvtqxYc5KOnhetmvPVJiGTISR6G1a7mBYwHOIHy834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF451F00ACA;
	Sat,  1 Aug 2026 14:29:57 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.180-rt66
Date: Sat, 01 Aug 2026 14:29:15 -0000
Message-ID: <178559455514.1486727.10111494374215802799@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.180-rt66 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: f7b1782a0360b04e8e305d23aae56b4299f051cf

Or to build 6.1.180-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.180.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.180-rt66.patch.xz


Enjoy!
Clark
