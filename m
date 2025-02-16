Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55879748D;
	Sun, 16 Feb 2025 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739688850; cv=none; b=eAm1n0LMvkLFSDGprYd32X8D9VrXS812J53nlWtV8QVL/BFXWv+VNzgH7sREZ2KEjSlDcf2YLcvnw42ZSxSdxLh3Kw6m9ylsr/I1zo9ij31IQNj+OyUvVFRtFaI3u4scLukKdMF9sjBXRdmNzR9VLETavAY3gmm/v3tBdfAof8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739688850; c=relaxed/simple;
	bh=xQ7DRn3VQEJsPD7gb7Ua0UZdcYPqmk7aTZEHQp4kAmA=;
	h=From:Subject:Date:Message-ID:To; b=X75LfxPOoWr1Jate11idvJ/eBVMG4kyOmIMq01zqlup6XNyTuUyvM6RITpxVXeTMhOovTrjUys2Bw9KRES/+MJ1Y/AGyYFzQFh+3GDx4cPKjqH4dWDsEiydH1RlN0WHumwyshVD8n3OlCQAA2yTUOy9cQsB96xSPxeXqXH0QbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29C7C4CEDD;
	Sun, 16 Feb 2025 06:54:09 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.77-rt50
Date: Sun, 16 Feb 2025 06:53:37 -0000
Message-ID: <173968881796.265269.4992139552085083465@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.77-rt50 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 90e0048f6ba56b29e19506a9a213790cc953fdf6

Or to build 6.6.77-rt50 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.77.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.77-rt50.patch.xz


Enjoy!
Clark
