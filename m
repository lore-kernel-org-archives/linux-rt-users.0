Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6934CE691;
	Fri, 16 Oct 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163302; cv=none; b=K3ZmXuoUkwbwgcAw3g/ZS1dfsSCGnpjFlH00teaz/PP4WzJqFeNTeM6XKk/gi2Ll+AlzzTfcOvcn4o9atm8O6c2r9cjOzBN6lkkatTZBn9hTegk+sM6//+QDjaPsQUXoshwgsMlID29ACnlDFbwTbkzmdOaCohQyATpW+CbU9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163302; c=relaxed/simple;
	bh=hJ6zzNPWgJJgArlrVtajt0XJz+YPMYnJvidHjQrlJQU=;
	h=From:Subject:Date:Message-ID:To; b=KshIVWSHLs55Jwc+2MWWmZn4Qu7PjsQfmnwwho03jbX+qgiTuk0Hv9J/SH6d3xI27d+Ix3kCitBQL1aEbFMoZC2J87nqvZnfYt0KOTdfhDegSlysYxmWAOI6aGL8llFZeqonNB+vYxANlC7HZF9hLRZ6RuOo37bk93fTcD6EVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A31F000C5;
	Fri, 16 Oct 2026 15:08:20 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.190-rt70
Date: Fri, 16 Oct 2026 15:07:33 -0000
Message-ID: <179216325380.754447.11525819491474303706@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.190-rt70 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 9816d2d72ba5223bc81e3388869ef03c3f770e29

Or to build 6.1.190-rt70 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.190.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.190-rt70.patch.xz


Enjoy!
Clark
