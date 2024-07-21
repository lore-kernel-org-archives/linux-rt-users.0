Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696F29AF;
	Sun, 21 Jul 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721591146; cv=none; b=oMH1V/6iY4+xXN51JwfbiekFwkzSzgVtw2MxF7wEIh1nZC+sHBNnFP1r7LBOSWR9tSBDP4TzbVi7z70XG8ORXhiFfUARnLPIswoG1mDIKYRpJXSjrkg+w8q8FAxwrvCjdEOIPajGtyKrI8a6FgZXDsVFMro9zWfao9OGrFTu+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721591146; c=relaxed/simple;
	bh=S+L/sFOfavGHe99Lf/RfapQmkeJ5nToIGUfJbIziYbg=;
	h=From:Subject:Date:Message-ID:To; b=ZG1rzTKbpG9AS1ZuJKKinIzbm0dswSjyddII2RGvHJl0ft4sYsocXGcR75QECFmy3bmBSLWLUhyyrlKdiCV+Cgmq1gTjTxKfjXdV4jbP7YxCUTKOZfE/XEkEMT8gzwiQA0L7xW8rWE2QOC2B8fquIfclRfx0VMeaUlE2mWgqoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FB5C116B1;
	Sun, 21 Jul 2024 19:45:45 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.41-rt37
Date: Sun, 21 Jul 2024 19:44:57 -0000
Message-ID: <172159109793.1568564.11575270718064448055@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.41-rt37 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: a2e7693916f864091dac63b4498f1bf1799fd4f6

Or to build 6.6.41-rt37 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.41.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.41-rt37.patch.xz


Enjoy!
Clark
