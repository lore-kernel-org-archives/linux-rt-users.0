Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124557494;
	Fri, 24 May 2024 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586420; cv=none; b=UrkONGMvsTORmby8Xhq+Mpibi7Ve0uOiUZUAe/ShNnlBhYsF8HEw2HvM53rl+4Tj1I9OOIN49cU8cCQ0lmumHsp95+D61lWOI5IlciWPzkAqPDZCvCP26D1XBQY07IEFhkB7iuaXGh3UtKvsHXx2I6Ap9XyvjhW6GvzDwSF42ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586420; c=relaxed/simple;
	bh=Nc7YRy65amH6wa6wNgL5hwPsEo+HK8NdejJVIjIRP5E=;
	h=From:Subject:Date:Message-ID:To; b=tNtCnVRAZ53jtsx318qMU7BJBNl1r1N40UtDhd3QDSGymGwPFyl8svc5ts3AdgUioLdTkXrFo5Gb43vs8rXm+XBzQUX64B+cHGYgl0iYZIi0ybuD21WqaH+7Xz9aB6MrMhOTs2n7hihyIBvaAYto6h3wSDnrtAPFHAEMYIw+TXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEFEC2BBFC;
	Fri, 24 May 2024 21:33:39 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.91-rt31
Date: Fri, 24 May 2024 21:33:08 -0000
Message-ID: <171658638860.1185853.13143898240950390426@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.91-rt31 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: b0c3e235fef675b79346d114a15592f0dbaf4bd0

Or to build 6.1.91-rt31 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.91.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.91-rt31.patch.xz


Enjoy!
Clark
