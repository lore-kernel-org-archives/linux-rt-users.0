Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577D4688;
	Wed, 17 Jul 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252150; cv=none; b=mvKqHb4Rw+ykN++JSULQXrCQRipDOx+/P6Ypw1wVRMYXNr9XtFPdbi35cg024fPxxw0U1jijaDTYIdrmIEllOq/85kFTt/RiGvzHQAugP5HdxgP+x3VgT06sYP2mBPLJfSBZYYbxUWfmb7mmz65oSO5WXI0vxtknv29uJNIzC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252150; c=relaxed/simple;
	bh=lnsTA+sflusDZMwU+mbd68qOfEBJau/DgLDFu4VqLQQ=;
	h=From:Subject:Date:Message-ID:To; b=p9ZVkCD1YoAkTpIxDX/OlBTAVp+nsQScaORUyHi4UXvp5Gg8wniLHvzT5T1GqEmicexd3ovsKTsiKmxS2a4TJFMcZJt4aGc3POwrnefPVuB5lE/sAxfxMF9fhu4sneaZOzi/DYk2KC7Nx/65cRlto8uxTZc3tOEuB1zvF6DUWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC81AC2BD10;
	Wed, 17 Jul 2024 21:35:49 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.99-rt36
Date: Wed, 17 Jul 2024 21:35:16 -0000
Message-ID: <172125211690.1344796.4012268210816662616@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.99-rt36 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 060a330ee7d83d4c39b6a9c773b6e9986948886e

Or to build 6.1.99-rt36 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.99.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.99-rt36.patch.xz


Enjoy!
Clark
