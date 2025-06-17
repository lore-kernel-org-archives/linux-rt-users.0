Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0B2BEFF6;
	Tue, 17 Jun 2025 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134690; cv=none; b=qpfxi6Sj5/tAmNOuvN88MLe7rKpDIEPMdm1pYKBAD2xajjiCCtxrI82wpCE2CWrDa+vgieD8pol4zP6Ttl6Z6lx9FVN1hZc+oeWH0e2d85rjhtkI5FEKglnNYdIONcCpGEhoV7bsoxbtKvGVh4vu7gYzNpwPIlahpbcuM5JTChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134690; c=relaxed/simple;
	bh=7E5ER48TU6DCWs2N1IsaKbNB5hKTbWfcKTDUAyoHeKg=;
	h=From:Subject:Date:Message-ID:To; b=RD8i4S66AJBIYRwlBXNUEs/6ZjIUsaAGWIamqLCbhzTN1A/ViGZEPCic8FjcGzV2VvhQDY7dTmignCk84uzBSkYyYH6RA6M7Q4nRnseffT6HKsYAfjuG+CHzXD37HgRfh8n2XoVcYO49beREO68ZZxFBTniuG7FxHnHwQ1GwY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49112C4CEE3;
	Tue, 17 Jun 2025 04:31:29 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.141-rt52
Date: Tue, 17 Jun 2025 04:30:47 -0000
Message-ID: <175013464702.446896.2245695937420545361@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.141-rt52 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 000fdc8871801d17d55757a4e20b5cb71ec2a7fa

Or to build 6.1.141-rt52 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.141.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.141-rt52.patch.xz


Enjoy!
Clark
