Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F023314C;
	Tue, 15 Apr 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749268; cv=none; b=ZVKXAhh0CHzqAdxABAWMi0LqBeWNOftJAjNXtmSddrH+dLFZmFTe7fAck7kORzm2CwQ9dd2LD02vU7AzWN/Kl2Qj0OQoq7iQWCXqkgrtfFYqUtDQdNrgCFdB3UTsgKboX+4SEYMKxbOgzWmlRyf/nh89zdd5eZnmiSHDlhMm1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749268; c=relaxed/simple;
	bh=MIasZrF3UtR3+z1lYM3oDtx/o5hENb/zfMI07Pi9DG8=;
	h=From:Subject:Date:Message-ID:To; b=hmS5vNkarscbjQsy1Ea3GFs6avcL4qQjsg1tg93/qUT8rHsh8+DaUGUMtZ6J/6AsyjKNYvEsYM9jv+FXSIwWwYeZJhqs9SYcA6mVE8b3jww0Bfgm/12j5AniRwSHHMfs9W7TYcXoii4p4BP2qf7BzVybV1/IwbDLfE4tCtolokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F4C4CEE7;
	Tue, 15 Apr 2025 20:34:27 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.134-rt51
Date: Tue, 15 Apr 2025 20:33:36 -0000
Message-ID: <174474921610.752411.17029418176777381996@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.134-rt51 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: cb9238b4ed330e15dda26ac38ac933ec2394bd67

Or to build 6.1.134-rt51 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.134.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.134-rt51.patch.xz


Enjoy!
Clark
