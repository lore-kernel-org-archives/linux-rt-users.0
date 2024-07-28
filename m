Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBD6EB73;
	Sun, 28 Jul 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722203553; cv=none; b=LqFMcRL/GbDdlIUZSs9L8Nmr5ckwKlYxDAipjLo5sfefide1JVfBRY4fvEElB6U1tliacbHAdZ99ad554Zfp4VxZWYt2Iss/7rQU0ZKrAj+roLI8f5lx1iZxQimj9v6kDhQPW/TJdqQy9aYC8Y864eBbsQKAFfIVDr1qPWTcozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722203553; c=relaxed/simple;
	bh=UMjI/7/mY+XGqlQXKoouh4/RSas0W0L1qX+Oj4IAN4g=;
	h=From:Subject:Date:Message-ID:To; b=ozVoHVNkocJ374+Dz3+E/P7dBFxwXiH2gZ5F+J+3rrL6RzTxFBJEFDs4b7nqNHDMK4BhR6hTQicSwQ1/+ZOb23s9F8c4c8ZW2MHdWqcLWGABVLj++ESkFHYsewTZRJcmYu9RLdQm+dCMP5iPbRguIeLm4K0dQziwGOtQuaLgclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2A7C116B1;
	Sun, 28 Jul 2024 21:52:32 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.102-rt37
Date: Sun, 28 Jul 2024 21:51:55 -0000
Message-ID: <172220351589.461289.17369104226037682162@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.102-rt37 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 53d8a462f3228a72b0b29df7aee1fedff786a4d0

Or to build 6.1.102-rt37 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.102.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.102-rt37.patch.xz


Enjoy!
Clark

