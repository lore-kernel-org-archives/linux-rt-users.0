Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E027E1DC;
	Wed,  7 Oct 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412003; cv=none; b=J7iojZ4lbHxeFsCrswXIZfGIv6AvlW1MARrLb2N3t7/NUUhmypvXNtMEolU+cvKBUXTYrUJ5S0UBieCU7bL7ZKBkmA/tUyUzSzkBBbuOmfxFKR/YcpWU39SkFsYkOaWYuBuKz3h8IVnc7KQr6naXhbprSxhKEnlpHF1W0SdSN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412003; c=relaxed/simple;
	bh=7OSWxRATwdu1oG4KyE7qUzfWqjgIl+/cEOeHexlacU0=;
	h=From:Subject:Date:Message-ID:To; b=V1/+6HeOYlm2ovaBTv5mK3WqbQMzOBZRuObIQ+kAlo/Dhkaky7Xw7CMSr9n6+Xd9DNyKgvkDYAriEFOY8XzqBmlwfDU/4ZihhJIgBApyIvoe/IIUmneojOwl5A66E88qiajaRz+yjTq++cbD0KIBIFyGsyXYQFNJZbZ7PMnoMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258DE1F000FF;
	Wed,  7 Oct 2026 22:26:42 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.189-rt69
Date: Wed, 07 Oct 2026 22:24:55 -0000
Message-ID: <179141189555.4093771.7537869033124980852@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.189-rt69 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: d44cc6ee62ead2ba9c78eedc75be6b15807fb079

Or to build 6.1.189-rt69 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.189.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.189-rt69.patch.xz


Enjoy!
Clark
