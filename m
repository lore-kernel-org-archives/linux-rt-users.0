Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60246AEDF;
	Tue, 14 Jul 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036339; cv=none; b=LgKb8Nk8XIXeEJ07wjVzuLLERWtxv6ePdNFvFiMWCgObWFZ3AoPZSPyaLCdalNnj3QrTx1cK9zrRNSriOe73lB0U3jDnExQXUSE+/5e4e3ZkzwaZOo/sqLCNJ+23ac1bHclf3UkhgdSRWBhu4OHymjvECspfQlhnWXi3j+Lm56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036339; c=relaxed/simple;
	bh=iCVr/wKzKS9hUTZisb/4Q+bqzi06gn1CceWoVLWJKGc=;
	h=From:Subject:Date:Message-ID:To; b=cbsDnBB9fkElUMgHP3FrDwrM2PFas0sVw0jLzT4oglIdRcKwgDlMe6MTHsvJUCGkMC8rDCL8oqGo73pHSQ4YKBMH9QBnWpO8GrwMRzF3HYcyHvTp8FW34ev6W1SgaJs+JvgMfIVtyQJsdJhnhowSdVSFosiNk4ehHVTHP2fPDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212E1F000E9;
	Tue, 14 Jul 2026 13:38:57 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.144-rt76
Date: Tue, 14 Jul 2026 13:37:59 -0000
Message-ID: <178403627961.2542645.1740723237887139811@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.144-rt76 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: a53df22569c0ad66b668d767aa956343688d05a8

Or to build 6.6.144-rt76 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.144.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.144-rt76.patch.xz


Enjoy!
Clark
