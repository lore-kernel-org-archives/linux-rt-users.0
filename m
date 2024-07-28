Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACD210FF;
	Sun, 28 Jul 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722200135; cv=none; b=bytriDhGulUx6rIMalQyZkuewUZZVP5zkvKE7PFNBbS5SiVh+3dTLLpTMLUY2oDTQWrxXT4ekHWbCUYMZkiPGxFxlAPEvAaCPOO7+6VzP1s3nhVK8lYft+NL1Qg4NzHsAWDjO1sj396iew8pbHkGEvri1Yc5viL7CQZS6rT9NFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722200135; c=relaxed/simple;
	bh=zLZ+M95dVj4dNiEjfw5D8KnQMx79CFYqrSVyAQ4Rfp4=;
	h=From:Subject:Date:Message-ID:To; b=p7LPFT0XM1tuOo4MQUjFU+0hQQoWHESUVlKCY62FHLPX2cS7HWPyg9ONJSM9waALc5qWoX1oOkilLgIsdvnQtndkjf1ym0XNJYZFdDBgu/IWOMSuCKTJN5dhz9K4/wRTadjaHqv5De4h9NQyoGz9kA3Axb1Tut1It8UknOiqT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6733C116B1;
	Sun, 28 Jul 2024 20:55:34 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.43-rt38
Date: Sun, 28 Jul 2024 20:54:51 -0000
Message-ID: <172220009175.319684.8526468036795448618@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.43-rt38 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 3adbcdc26bf4773f6871f705fe440b9c5c4cd7db

Or to build 6.6.43-rt38 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.43.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.43-rt38.patch.xz


Enjoy!
Clark
