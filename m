Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BA28000B;
	Sat, 11 Oct 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760202748; cv=none; b=j37EyRGHQSPilepAIalNyWHwc1ZAVvy8iTYxSrRK2krWafFH+SP84vwwpynBiOQSBiR/kXAQcC6wo+w/zrXem51m8Zm5KVb9ZxCfqlUNJIwUg23QLmr3mNUTL1h/UP5i7G8j25QgyutgqymkoXXuKliSZb7SmYR0OQ0SB+pXHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760202748; c=relaxed/simple;
	bh=/XLH+hFVi5xd3MXwLTdrEPg6NSTlVEGe+L22sQfzi0A=;
	h=From:Subject:Date:Message-ID:To; b=EwUV3Dy4/IkGAWwD0AjteLdQ7p61uMpVzmj+7nOc2Qq5nLJBZaJmmLbHl/79pY0tTYFJcJ3doWBcX37JNud+brS9Kv7FsfuJWxY/8CBPsmcELECG7fy4+AvgCnF4GPjNCn/JXKw3FeicwmX2XItFvhVeqjXQFt6MjiAIq95SBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBF9C4CEF9;
	Sat, 11 Oct 2025 17:12:27 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.155-rt55
Date: Sat, 11 Oct 2025 17:11:16 -0000
Message-ID: <176020267649.453116.15297751024720699594@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.155-rt55 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: ad53f4218ed6e11333ad5e603dc0c902116380fe

Or to build 6.1.155-rt55 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.155.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.155-rt55.patch.xz


Enjoy!
Clark
