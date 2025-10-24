Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7132E695;
	Fri, 24 Oct 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321042; cv=none; b=kNwbyde9V+pFII1+7Y3Y59pb5EsWap4UYVdLUJP1k8AV4gQQZOgiSbAN+HSdyexL6+54pTvQMW0oLfEx0KU4jhnqXDSQlGKMjG/mDDnY5JE7ZSfblgq5rm2wBKIRw4DW6ikq26/Mlc4gMlFqO5b5mXDMC5CM3YBkDENTPuy1ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321042; c=relaxed/simple;
	bh=jIQ3PmquF8IGksBf8g5ns6HEqLB7enlaDoX953Wv11U=;
	h=From:Subject:Date:Message-ID:To; b=jIIriTy80m+Q8KdrOFyLqbJJWMDXjJMSEh15BGpV10I0kid20zeQ4Cft1SVlMvsbC5Bt+VCyEhpAnafhvnsMjALX4mRAurgbrKnuLfNnlDYwrfUarLRejHiUlcKBlnc44GkXreXnGMQEmBBB3Sr2OfpowHq/Szp0TPeE2Ka+Z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD76C4CEFF;
	Fri, 24 Oct 2025 15:50:42 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.157-rt57
Date: Fri, 24 Oct 2025 15:49:54 -0000
Message-ID: <176132099496.2233461.13982532598284511514@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.157-rt57 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 0c44acb11352a8f409ba3aa8544f8bc6d0c5f9c2

Or to build 6.1.157-rt57 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.157.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.157-rt57.patch.xz


Enjoy!
Clark
