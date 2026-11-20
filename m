Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215814;
	b=qMRYN7KWjqsHzxhrCUKG5LpnE80eWRt+/no7utFVx+bsYzCGOyCrsOiiu9ZntFFBuUOx
	 z4rDurhQRe3whMwyKzHdeQWijdrT4p72nKkmlEGRtw6cKdRzPHIbCY8oOKEZ1uRs5DseD
	 gBttYNhuCUevuo/8hT/0MEe5SFGUOQffZj/xCGTqZxb5YyBHZnXRfpKvM7QivYNlAo/lb
	 Offi4BFlw2AF1CyQQIcj5A4JX9Uf/NAIRKdBSmqIWgyNsGDTKsZDxU9dJUirUyPMoNbqK
	 M1QGr72d4DaZSsz8zAt/gi5S4Gc+sIxudZVJU4txO/QcsJK+u6XHx6qnx1oRKhdvT4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215814;
	h=Received:From:Subject:Date:Message-ID:To;
	bh=bj1wB54GHvrjLSDWTbRU0oCMv++0+BIgjqVwbUwGITE=;
	b=v0tPBkPGWTR7sO/toMll5kAxpnd1rm5K9/fi6rBJL2ePVYa+LYrv0VisnodtNdP7RFIN
	 YaqwipLHCNpsyX+G7iFCdoWwULn5LM2GpjLWMgfKWVQtkQ3fQIIbdCxSoq5YnR0n5tc8E
	 udJXT08lFhhK9KQ0UcL2Yxm51mD3h90W66R+wTIXBuYlLIGBwrvzCz7c3WRRE4DHszEh0
	 A7DkA+tK30gEYHtlsMDAp1fX5Yvtd0mbCAGH8YHUecHA/jW8C/J5FrN1rjAUNGLyV1RfT
	 f93FeQnuq9qwjA2oafNgy7+TXqsHA6Srewx6tREYIENiB1C11cs5+Wr9bgn/fwzTjfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0C606A686;
	Fri, 20 Nov 2026 23:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA171F000D4;
	Fri, 20 Nov 2026 23:03:33 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.192-rt72
Date: Fri, 20 Nov 2026 23:02:51 -0000
Message-ID: <179521577180.495482.5442704973337841591@demetrius>
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

I'm pleased to announce the 6.1.192-rt72 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 86c3661438d7e131004963e154862f35ee530764

Or to build 6.1.192-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.192.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.192-rt72.patch.xz


Enjoy!
Clark
