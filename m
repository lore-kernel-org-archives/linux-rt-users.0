Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C6C2FD;
	Mon,  9 Mar 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069133; cv=none; b=Nt9GdAm/+Za4tgDRlDEPJY1sc2VOhyrBDM5Zr7Is4/E+d85sW4zOyjm0X8z3DuRtQxexz8NfWcXXZDFbAO191S4fQsnFbOIzV8f+0jAmxxCzWYcno0CCk4dswxUFlFVetMl8UFJZ6ZmnMqSRjdzTDadGTTxpMXZi+PVXOWXfsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069133; c=relaxed/simple;
	bh=L8Faxj6Qm/xItc7+s5rQuleoy8EpmBoHxuPRkKU5vZQ=;
	h=From:Subject:Date:Message-ID:To; b=ZtuqEpNJDO48FrkAqw0amOODTmynmpS7Y9RVvz81vYtvZUIKXj0tnNQQTM/InrFdhtQBaKkEHm1Gfg9GxnmHLU9WdTTMk/BoDIXqPqtvsoMz3V7mwxXFCcsrUOIiVJM7L79vwD7L82YUfXD692Ws0uIu/yxKIJ7XfbjyX3vWAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30104C4CEF7;
	Mon,  9 Mar 2026 15:12:13 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.166-rt61
Date: Mon, 09 Mar 2026 15:11:33 -0000
Message-ID: <177306909305.1567095.14233897080610592126@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.166-rt61 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 11d6f81e07259e160d5c9b91159582a96c48a133

Or to build 6.1.166-rt61 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.166.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.166-rt61.patch.xz


Enjoy!
Clark

