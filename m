Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB684171A5;
	Thu, 20 Jun 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913970; cv=none; b=OavOKN9eQ+7jefAC0b4MJT7GGHZLC+yfYuDJM3JJD7bctUlwOdMO5+1aQNUtdFvvtAiD0VZJFK5Zlvud0SY+B7eGH7rLzYcMHuXxBEItizGwBlW35XrzNWr/FlEFM/3ycjuVotMnD0A4wo4Zm0YyE5+xR+wVhWuuO3kiKnJSzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913970; c=relaxed/simple;
	bh=5Yady2NQRaeVLT4Z80IR3uCTqK+DNdYVwaubYSMtmtk=;
	h=From:Subject:Date:Message-ID:To; b=QIRfZ6P/tPPKQRXXUL4SdDxGiHuY/inot5yeYQ0o+eTIJs5T6RnidU0KFjBFO+X9naJTRtD3HxgfaOVnLznxUphzMmMjdUKVGZZ4Pdt+7QCVHOplE6IgV7ja0dZjxNx6VRLU78LaFjPVujTBbhJGT5Ky6T0sclgIyFjtufA6ccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C85C2BD10;
	Thu, 20 Jun 2024 20:06:09 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.34-rt33
Date: Thu, 20 Jun 2024 20:05:06 -0000
Message-ID: <171891390611.209712.13284847548995423479@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.34-rt33 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 97aa56ace89411b363eb21b307e988626b989743

Or to build 6.6.34-rt33 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.34.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.34-rt33.patch.xz


Enjoy!
Clark
