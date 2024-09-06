Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED801D6C78;
	Fri,  6 Sep 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654424; cv=none; b=h3UFh+jW7w6zw3l0Y3TwRxYV0u2D/oLGiP6/M43yKKiPnhqycMYKZV/KnOUpJ3QqYFbWZGZPS6MLvxfW+qbLiuYIlJicwll5+5aOLheCKdIzlwnF5mNXdAnbpauEGJr+/948cX2J2YYnt94rWFYAtYjO4J08sRZgCXPMYao+n4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654424; c=relaxed/simple;
	bh=+kc9ilAfAsMrwxjA+1bVMYFyssXdiqC4ZvTIj8SuCxY=;
	h=From:Subject:Date:Message-ID:To; b=PNde9CMYBWiMAjv9Ra+x/ayAKrEbvEHJi24+alV3W3HDNTFURUYWfodYVN+2LX5eIqFjIiT+iQbPDtnP8+ZS0dSKkowsTr7jgvySfuL9d36iweK4wL5GiCHQdjdpbOliolAGZm792hTG8txc9jXK/teeGZ30ElbLU6nhhGTTbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9744FC4CEC4;
	Fri,  6 Sep 2024 20:27:03 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.49-rt41
Date: Fri, 06 Sep 2024 20:26:30 -0000
Message-ID: <172565439020.1613628.6233872510979430293@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.49-rt41 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 3b5a2cfdf74df250aebd37c35fff7377fa93c4bd

Or to build 6.6.49-rt41 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.49.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.49-rt41.patch.xz


Enjoy!
Clark
