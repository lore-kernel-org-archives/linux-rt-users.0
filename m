Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9B1D5AB8;
	Tue, 26 Nov 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632305; cv=none; b=A6TFj6NnN3VSxmGTkDnxSKiMEBndxYFcqczlo07oYW09D7+LGAQdbWIDw7uiWQA2ba5wIu8TvWp8bjgpvAYm33KCJ0+kbD+Kpde5TW8kEWXsFN86AiteEjvfP/MaRZ2CpMR9dgEUZ+wmJ3dlkgYYiAGVoBBwcQ2NEKcU8OkF+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632305; c=relaxed/simple;
	bh=oNBKxNfPBj/LAJuGUxOPZZeUekU2BrgP0b/jhAPbGmc=;
	h=From:Subject:Date:Message-ID:To; b=mA47HTJ2ZxUSUKlPBekQxRpYqKPc2t6M3b7IaBljoMMBjV5P/+I4Xg12eNPmVEfRcykpL/C4lFOnI2ew85f6P0rBcYR+3xCEXXbx/jAKqKFZgmE7q6FEuRWYiiGCJkH4y+A3GFDpLOip7FHpEmMTs8X7JMR5s0RNFx31eD2Eosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABA5C4CECF;
	Tue, 26 Nov 2024 14:45:05 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.63-rt46
Date: Tue, 26 Nov 2024 14:41:38 -0000
Message-ID: <173263209886.175309.15864566220800003543@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.63-rt46 stable release.

Note that in addition to GregKH's 6.6.63 changes, I had to pull in
Jan Stancek three commits to deal with openssl compilation issues with
file signing and cert handling. Please let me know if you run into any
compilation issues here. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 9ca618d07190e9f502b2c0cdcecdf14b118c6856

Or to build 6.6.63-rt46 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.63.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.63-rt46.patch.xz


Enjoy!
Clark

