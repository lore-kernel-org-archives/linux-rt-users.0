Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264A2ECE91;
	Fri,  5 Jun 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684449; cv=none; b=R4YaZ3rOzIP3uXx6RVLAYz7kZl4v+BoacaAkoWcHH/nLln63Qi2OBMoxN1ijsN3xD1DFBtF6cfAPFMQIfu3oNrQBEUTHbNHNSzjiZsDqSe2czP3CxjTVHM6LVQ0R0/pL6SDXk+uX26mJCK2bYsl6YfkLSlbDsHxq7U05vXIVvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684449; c=relaxed/simple;
	bh=4S8eat4O4NQ+d4Mx/jksKTwrJTdxYl0LpieNmcy1LHk=;
	h=From:Subject:Date:Message-ID:To; b=RHG/2FDIRxx8vmBXCF8wyUJDOysGhV7I/NfPvjmSphBs+brNJLLoi6TKueflyY+rpMA0bafhZKyInyTjCSrXOkRxLdkUoma/Tq1ZIFq/P/0uwHqSVMVSAfDY5F5+b2aU9LW5GkJP6zo852F0XxKFrS0ncEh9rvvs+gT1R7ywkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA8A1F00893;
	Fri,  5 Jun 2026 18:34:08 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.209-rt96
Date: Fri, 05 Jun 2026 18:33:52 -0000
Message-ID: <178068443215.1705331.827203549713429278@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.209-rt96 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: d702e418cdbc3f44f3eab266dc22d522cb6c473f

Or to build 5.15.209-rt96 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.209.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.209-rt96.patch.xz


Enjoy!
Joseph Salisbury
