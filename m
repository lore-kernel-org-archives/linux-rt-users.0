Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C61849EF;
	Wed, 26 Jun 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415644; cv=none; b=ASMy9MSfYIm9lSmdd+M5GxxXNul4w4st6hOqGaUi9LT1xrtWyZy1u0QPaYwAsxf9y0XELTC+BgauOQeuEybOLt9mkUc32aG2LB6EJicuLvVHcnaOPzlfkg5xfaxPAr+w7i2424HfGJnfDFr4xakDqa9vPvSb7/ekb186UbMLBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415644; c=relaxed/simple;
	bh=Cf6Aq0GIT61hAysWPDmDul0zzTNax78gdwqK/zSprmo=;
	h=From:Subject:Date:Message-ID:To; b=MLUVtuEwWeIS3G4K0vGz2Nm5QGTlzsvMRZ+eT2u8DP9RCndzPcg8zUJFRyIri2o4E/ewdRKbiJbAhrTQJRgKJ5tVzBBlfs8GQZRBDlFe4cAQMZQK7Q9POWiRs7V+CzsVM1Ni2n6C5eDFmJljaibjgwyCfVoAlRu5y8ys0oAw65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4870BC116B1;
	Wed, 26 Jun 2024 15:27:24 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.95-rt34
Date: Wed, 26 Jun 2024 15:26:51 -0000
Message-ID: <171941561177.926605.3862045277512469322@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.95-rt34 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 7d6bbd3e0ef06ebcc2bb1df60d0496dec615aaed

Or to build 6.1.95-rt34 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.95.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.95-rt34.patch.xz


Enjoy!
Clark
