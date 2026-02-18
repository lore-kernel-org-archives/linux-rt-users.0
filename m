Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88A343D74;
	Wed, 18 Feb 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435751; cv=none; b=giDJ03LN84J8kPI9maMX2mygqxv14E6vFqsKtxla2APpjpm9pqFulu0LY3ZiFrKSSi1Cew+P5yqFj6HXfwLD3WEALRmz+tV+CEd9fyKtj0tjq8d7ZjjQXXk7Vy1V46c3jT1Kv7GIMBLLIshQ68KXatPOiQceVC9kNGFRUvRHzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435751; c=relaxed/simple;
	bh=cXNu6HCk0o3Fl+dZ8EjS3kd7cXjOUOt257XCWA+yQ5k=;
	h=From:Subject:Date:Message-ID:To; b=LqNJlraZntTrRIShG+viCd9pJwBdb01ANsnWGhtrcGIURGvL7HcM6sMTBMh+FZxKWmkLPVZRY5348orCMG0mmyHjI+Pxlh2R1MkhW77GoLWty5GOxWIm8DqKYtRReLEE068XfjJcKNvU9l87RqE2QJ6FBFq1N2kPIXAShapnj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B628C116D0;
	Wed, 18 Feb 2026 17:29:11 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.163-rt59
Date: Wed, 18 Feb 2026 17:24:33 -0000
Message-ID: <177143547371.1081343.5061241048573762473@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.163-rt59 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 185783012be6a4348ee398a8af0857894d930ceb

Or to build 6.1.163-rt59 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.163.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.163-rt59.patch.xz


Enjoy!
Clark
