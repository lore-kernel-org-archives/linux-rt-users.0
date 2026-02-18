Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB42BE04B;
	Wed, 18 Feb 2026 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435731; cv=none; b=LmOL9eDlRlXm10NH6mF9C54qCybkFHJt7DDIm6s82psL+Trs1V64rNL/DCXZMfvtWig7GCBAcQADflpXr2ETtSvlWK1+PZpw4ABK5+4uNPFlRK/6/QJ5IyOhny73JiCOY/kQrYwGWZ5VGaxyzv4nLK6nAjrSva4jj651wf/nASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435731; c=relaxed/simple;
	bh=LlsP6N/lGLgsOsH1VtmlbR4lF8UD2EWa5RykZy0qUKU=;
	h=From:Subject:Date:Message-ID:To; b=ZWbhCNDiIXQndKtgRLvX00wRKMawlASevz2pdEWXnPGJ8WTilM+E6oz9bD+lhOxi5tfB0Qf3bQE2KK3aVqCtCrnwcwViayVbEiM6xCLKnAKD7YsTHF9D4f/yzrOsvgjvLRfgmKcVVt+7v4sDQb2wpmTigtLyr+FfRkHJuSMaipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D15C19424;
	Wed, 18 Feb 2026 17:28:50 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.126-rt68
Date: Wed, 18 Feb 2026 17:27:25 -0000
Message-ID: <177143564561.1081522.4396719876035072241@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.126-rt68 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: eeb88055d1ffcc2d53c6116c7c0a23818d71db25

Or to build 6.6.126-rt68 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.126.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.126-rt68.patch.xz


Enjoy!
Clark
