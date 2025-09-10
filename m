Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B643FFD;
	Wed, 10 Sep 2025 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473191; cv=none; b=IeDpdO37t6KKAz0/nOoMo62dYMfJD0KiP4wbbeJXKDFFcEmH5XQgBtAjINYvPq1005RrJr2+vLjurY6INA0sZmpH0uMjnsWDgRq7nJWNEMa9Bs6HmA19iNxdYnu3Z8lujxaz5GbR4vydlavBKloCVvgxHFWcql9ihoJIHfVH6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473191; c=relaxed/simple;
	bh=25KunPdPXfDEEIBQjn0AcbOn4sL5mLO6w9YSVPKhAX4=;
	h=From:Subject:Date:Message-ID:To; b=p4afJCZ7TPr0EAC94GzL5BtgId450eqiLzhHCnIBQbvJRBjKU+AETgqjQJf/1fXIRY8GzlGACKipj2VVIohxQFtClJT3dr4m1WZO+Pvwzn8eUrm7jdcoHMsp9sjke2RQJhN7lyaaLF9CNgKwRBWUQkZTx4JjsVW1JW0+yAf7mBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE73CC4CEF4;
	Wed, 10 Sep 2025 02:59:50 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.104-rt60
Date: Wed, 10 Sep 2025 02:59:08 -0000
Message-ID: <175747314890.276872.7526958893499689787@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.104-rt60 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 00961b6f076cd59450c033b0c71fb479913ac384

Or to build 6.6.104-rt60 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.104.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.104-rt60.patch.xz


Enjoy!
Clark

