Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D1270EDE;
	Wed, 24 Sep 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744163; cv=none; b=cvNerx1hqOHtBHKu9c6NFHHptQUKIj33B/Jh6AkNv/6W+eARCt30dsduyEaDmU7QL4xEmlB2l0dWqiY+17p+JfIk/L5bBTnHB1y7X6YKbl/cQKvxHch3TErXKOOR4AoQ69TD4n5lKd/M+TRbQtNZN6aUBrYAhuZoZP5Nsmu6Of4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744163; c=relaxed/simple;
	bh=U/lAKfKw2bE/Mc7j9gXhadp6j+cASLObtoUeJaH2XeY=;
	h=From:Subject:Date:Message-ID:To; b=dZ4unXn7O5x7p+jbxGQyRB+nBd/+9abjifaV4cTlgqIYDp2AgFCvqDS2efP6nUPC+1jy2i2CNxBYRgfxVT6Hw3dFtw1oxEc94+BqTwj5Tor7+0Vpow7AgMkGgzCG41s3MEV1QkBZC2VKZHXUlqnvhR3mUFQ09fpOGoIqdOjSzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32E1C4CEE7;
	Wed, 24 Sep 2025 20:02:42 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.193-rt89
Date: Wed, 24 Sep 2025 20:02:24 -0000
Message-ID: <175874414478.875350.15994441507914392117@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.193-rt89 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 300b644acd7a7bf1bfd2e6a41ac360ee8d031862

Or to build 5.15.193-rt89 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.193.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.193-rt89.patch.xz


Enjoy!
Joseph Salisbury
