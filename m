Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618E346FA4;
	Wed,  8 Apr 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664755; cv=none; b=LLGFgJZXq49ShwjEuWD+pygcGVay0Vm/BaU9UxNzsZ9l+Z372VzHrkawmlTA66P6hcFdshew00uBKJdnQiI7hqxXHDwoyymadEadmR6MQ1nZjQmgLj+UtsGpmbdv5xaOY/PYDWLujE9Q3oUM//YxwmqzpGa42QaB+TcRbOXaRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664755; c=relaxed/simple;
	bh=9UbnuE/m6yVQFpJMGfQPUekeFshiJcJvvHJUUBWERXI=;
	h=From:Subject:Date:Message-ID:To; b=pptiX/T3zYxOOdtFKlvMRozbj9pQUiKz3FWuhdkA7KIXiaiP7RS+uT5fO3B58M6u9cBW4h0zzkZSVYZS3b95P6eYcfDPE+qWT9YNkHBZhZlT6n7DhB+da1X02HxxJkd5qxaIojg+/W86MIbnfahdDU0T+SNChzoAQBvl/rC93vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4440C19421;
	Wed,  8 Apr 2026 16:12:34 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.133-rt73
Date: Wed, 08 Apr 2026 16:11:39 -0000
Message-ID: <177566469997.2276766.7272140223601844796@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.133-rt73 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 1ff2ba37e98caec0e995d5060bd4739688d8dd60

Or to build 6.6.133-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.133.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.133-rt73.patch.xz


Enjoy!
Clark
