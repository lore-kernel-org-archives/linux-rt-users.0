Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086021DF970;
	Wed,  2 Apr 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624285; cv=none; b=i0yjvj9EShFTlqOX0W730a5l3CADm0Aw2fDActdmhWNsX5oh5NOGc9YTbDnk+qNaYcJ6/HS7dOAs3M8SFYMfAiyUAcaEVaOdfie369ECumB0WmW6I41lvaLOYN4LCwHnKdT6Q9li4Zw8Hhwtbow4AscxxrZKi1uri1eJhxyZ6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624285; c=relaxed/simple;
	bh=VKd7X/VOhlqaw8qdFqCqwEraPrh+DxFD22rQJxNX1lE=;
	h=From:Subject:Date:Message-ID:To; b=WigqN2xdWM9N8BGLmGilM/Z6LT73YGWR5ibyjRgrxydSnQSGw/N29c7/7VuFelrmI3Po1vEJHY8VNDIglb0dJIcsybJ34pZss4IPPrRNcOrbTEKnQBNBO6ji90S9nOuRFXOaKu6VTw3Jmr1eal76BwsvAbHfdY4F9N7n9eMLthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf4zzrvM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf4zzrvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46CC4CEDD;
	Wed,  2 Apr 2025 20:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743624284;
	bh=VKd7X/VOhlqaw8qdFqCqwEraPrh+DxFD22rQJxNX1lE=;
	h=From:Subject:Date:To:From;
	b=Kf4zzrvMtSuap0LwGMHMHjheiWe5F5mIcAXr3ruHr7wHwv8oqK/SDNvlhGAyS8/nV
	 3Ot5T7QgPYGOpCdL5piOqlD0oO8SwVBOrQAw13hsK/7cxNRofIMvbbp9gw7v9ae0ex
	 7zRNiVZQZ4TbyEua4tleIE2dxvpbJu3RX0zdm3d7kxp5YX1W/x95ELkX27zDxHsKMu
	 ucJvD4nGpnNeNOigkY5PjRgMMG68BklDCIz9m7u0eS3MZAs2sOzh16odR+Tk51l+PT
	 1hnovdiEys1tyCeN6ZmKa9aekD4ZYeWeFUBA4OfqdU4xep9qap13cPfYyrJ4Xdkx95
	 gb4ZYMUDVQU0Q==
From: clrkwllms@kernel.org
Subject: [ANNOUNCE] 6.1.132-rt50
Date: Wed, 02 Apr 2025 20:04:04 -0000
Message-ID: <174362424433.1463119.9423398825773000770@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.132-rt50 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 2039809c11c62af6ada5d057faf00c4c36ccdfc1

Or to build 6.1.132-rt50 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.132.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.132-rt50.patch.xz


Enjoy!
Clark

