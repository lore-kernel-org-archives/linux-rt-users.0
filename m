Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E93993D
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Oct 2023 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SjNNokDU"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CCE1A7;
	Thu, 26 Oct 2023 12:02:55 -0700 (PDT)
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 884023F6E0;
	Thu, 26 Oct 2023 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698346973;
	bh=fUkBmWq4wA/eIEycew3uxMqHBfInhbpPfWSHXGaMzwA=;
	h=From:Subject:Date:Message-ID:To;
	b=SjNNokDUmqn8OlTfwmfjWd6CqOElSn6uh6PEfyOBq3JL2Ci2tfslNp+oHrsJSxFH2
	 sxh4qObp4vbwmwtsWKggO4BI1ljwP7eOQnXo7kl55dCGScupngmGLSr9Gp4+Iq9Gwa
	 TfCVfTndME/QpYlwz/XNrZHqnlvRuvXDS4d4G5xg60aQh1FrXQwvULaGXYvUpKM1fa
	 0gJyOuwQBbkEZvN7eH6PNVBed4Ap9NVWztHsZ8EpKT3lTvgU55Z/yB2wuXloT2gZfk
	 MQSmuzANTUT9+RCTjZimiXzS90LEnYwQU7+2KNC1D7gPP6qA7FVFuRw9gRYtMJ46JV
	 ylFlL94A3Db9g==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.137-rt71
Date: Thu, 26 Oct 2023 18:08:16 -0000
Message-ID: <169834369657.1117366.14997152396106606866@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com> Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.137-rt71 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 0508c80fa70d1a93c210a4e2482f6bdbd753cb11

Or to build 5.15.137-rt71 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.137.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.137-rt71.patch.xz


Enjoy!
Joseph Salisbury
