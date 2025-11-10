Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246112F657F;
	Mon, 10 Nov 2025 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816057; cv=none; b=uEXlt/Kf6yuCWR6B35/2iDCPRUccuvUib9ZMYUnRWMg1rNroWLxkVxsnOrMCdZlN+y4N0xT65eZUcnkzDVdFarj8NoEYqnX52V+AyekGrTUtiVcIs8mvBqU7NTS2fr+ygXDafC+q1OyApb4fkVKv3fodTy2+i8kcDcUzy8UNZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816057; c=relaxed/simple;
	bh=F4RtX9NIUHeK91wJx6rcDdmNWSMKqC2dtdzRh71/w/U=;
	h=From:Subject:Date:Message-ID:To; b=Mk0/bZaciLc2PjI6kJdNGpHYwUMGdL6d+q06P+8E8djUMMLmb+oltYP1S4Vi4qDp0ggALD7w9jUoowx33sVcJtjzL3kw1n3DipWfHiOK+Iz9bMhOGUC9AZt/8fPjj3/bMLrC6Jlm2n0Sd2UvA9KJAPdwCELHRi2ZvubXaG4v5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E7EC19424;
	Mon, 10 Nov 2025 23:07:36 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.158-rt58
Date: Mon, 10 Nov 2025 23:07:02 -0000
Message-ID: <176281602239.304272.17205819242969938414@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.158-rt58 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 7f90be9bd646f3b3ba239d08fdfe6d90744cae07

Or to build 6.1.158-rt58 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.158.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.158-rt58.patch.xz


Enjoy!
Clark
