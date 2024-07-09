Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2812CD96;
	Tue,  9 Jul 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513330; cv=none; b=S22NfY6HarH+SJGD6RLsZtZRa2lU3sknXfhu9axm20QZonx6/wS5vFmrGLwVb4a+KKrYwF/aJ4QNfN40LaLRd5ekAoQY0kMRjQJoKOprHkvBFFF12P6H0Ek0LYr7KSQ1KPl2Gj6pDSN0cCGhTBj7yremqJke6ENU4tau3SmibMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513330; c=relaxed/simple;
	bh=JgEr5U+fLS4WUxNs5ikEAi/tUDBDyjhkkFSQQmq2Rt8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E7cA+WTILsQoP7MADkT7UQYmw+mkU+mVxfXObTg835kr9s+BT1ghmJb8yTiwYjhDxwJPMvWnORwOa2OzDkuNKjmwJvoriujQgPHZZVdx1tKV42wpz2JTXdIMmbXHJ4sRIxCIa1KHX4yKypyOHO+Y8bCSl9lM/bfM4SspXGZRX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=BlNCmKFr; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="BlNCmKFr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8183DACA4;
	Tue,  9 Jul 2024 10:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1720513318; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=RqXXP3P3dOyPEGLpGTGXZPEtE5YZun6RO19b1IvkPP0=;
	b=BlNCmKFr5vOLGPAzsXC5U0+IoiQMidTGXx81eHSW6vFHsoa+1TReAuHj6xSO5vIng5CIFs
	cq3+Fe34Ue04JoLn1xTW+hE2+y3r4ODtplCcAej6Q6pLeqyQqal6aKOiAlX7HeI8xdJevY
	gg+TnH1ccEUfupRGVKz9E5sSHfNR4kZEjZgz2q+zoOrHFNoY12/Hl8yi7aKQwCLjuITy0S
	DPgZFet2ula7+SuNJJ+PQqHwP6mnzG3NYUjLOQY8dY7iUirtuRBDJLfNVaT3cx6JCh/jmp
	pq7LKkGZSCidOBPVCdiLxP1HM5DNm4bIiUI+ga9GxKs7wDSu1MQMrdndFaodWw==
Date: Tue, 9 Jul 2024 10:21:53 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.316-rt136
Message-ID: <172051324712.24919.12388891662776955702@beryllium.lan>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 4.19.316-rt136 stable release. This
is just an update to the v4.19.316 stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 346ca37165de5ea5ce47dfa9a27d4bf22c77fcd5

Or to build 4.19.316-rt136 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.316.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.316-rt136.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.315-rt135:
---

Daniel Wagner (1):
      Linux 4.19.316-rt136
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index e3026053f01e..f824f53c19ea 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt135
+-rt136
