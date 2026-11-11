Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418121;
	b=sbhTK24dx1C3CIXc3+UoiEE8iwQjAOlvgKOH2mDWzucwIqqzmS6d/h7SBt5+rDu6Y7Xc
	 RoVmVwL0NUAuOE2fisKf80Gv3E2pisqUfWB7SuLUdu3B6zI/rYhXChaJ/k8FktxXT+0/M
	 SYRP3vGKyx/xgOzzhra0OqJTTpoKgkvx/nRUemFSuUIoIvj0TmljJUJzxmCOKvqoo+EuG
	 m+BNa4mgt4nNa8JMVAZWcpYVZYBVfdU7rhvn70eu5y0xdT1ECHr2j+DwyrmqBpbNrec+p
	 6D4LVBb7Ro8BnZxtdMNaWRI4EM+0bQ6lNSGZ3ur6HC3zZYbb3ED33QQF7/GH71YjuXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418121;
	h=Received:From:Subject:Date:Message-ID:To;
	bh=IjqD5K3uKMlDPF/16EXUnzfOyRHRw5oOnP9CdTkiENc=;
	b=SILb54XL3VKljLWG4vd/yAQFCy0wzIj3XUiylHqH+mM2tj5JLB7qQ9vRQj37JB7m5gdY
	 Kx6kLMo0rkAMUyUtrhDsNEpiOCNW0M1q2Ok2gfFOChWzAFMMVU7CXLXoTkxR/eiitldX6
	 VPED7AmK0DvZE4GK1E8x5lM1PBJAOE4xuwx22c2oVXFnCZA4OKxctLMbLDUOknlAwMf/G
	 ImcuSoK8XTaSp24UxJJ1D8l6jxQXVgTZLIaINvG/1+6RJ2lbtsIbb6YLJxyznM/Qa/4Wi
	 gerY3VgkgAglQfdTcEo0v0BU7M1hsiwJ7jny0xLNMOoy/Ex4AN0okPKbyg3ZQh5ysRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272A606A321;
	Wed, 11 Nov 2026 17:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101161F00A05;
	Wed, 11 Nov 2026 17:28:40 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.191-rt71
Date: Wed, 11 Nov 2026 17:27:37 -0000
Message-ID: <179441805726.977873.7038833321219970245@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list

Hello RT-list!

I'm pleased to announce the 6.1.191-rt71 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 98644838bc8fa6255238b1a3812668d592bb86ab

Or to build 6.1.191-rt71 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.191.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.191-rt71.patch.xz


Enjoy!
Clark
