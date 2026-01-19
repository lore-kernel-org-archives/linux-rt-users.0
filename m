Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CD50096D;
	Mon, 19 Jan 2026 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856506; cv=none; b=C+HONk2a4SvE1bBbvPaMgPFOSgi/T8DNzjdY9ewd7XLBYbceEMlN0NhnTYDAzGBNXmrVXtJ/FSD/ZQG4OaXOAP5Z1LAFVeWk+9APPeDnF0JjgCkIvRuCWcL2lmpKSjuvCIeXboI408AnG0UHrEOXfjXBXgL05CI+gCIINHWBUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856506; c=relaxed/simple;
	bh=PT9nrrPVAbmQq6E72CivuujG6a9b8hCmZ6oLhNnQUBE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AbyUqVsAsVMBjclAn7zhpoSi3qW2ZvfKGJkkQjZfWRvEM5y8GMyaMcprVoFjOz7CPpqzSe9eWl3/bZ6EsnqWZqQYMfr2awIwJygHr+YzHwFtbhC+UO9y6x9a1jHCrFZ+9MxomIGAl1Ca8FoFRvKZRQeIR1N1U6FKhIhFKApFzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=lNt6dKs3; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="lNt6dKs3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB89DE4116;
	Mon, 19 Jan 2026 21:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1768855919; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=sPjrPsCW0SWV51AZ+nux2paE0SVATagsky7N1T6E0is=;
	b=lNt6dKs3URULuPO5Xwh21UVhRR9di1JwHkQj8Ml9c5Zb97wblH1ySiDEnh+T3XlZEvRwJU
	88s4+C773SGSp8lH0pxIj0JIUPzSzQENzF+XIVpxyhDwC2fTltqnkz80jnX5rJ42XHkSRV
	MKAaqZ5ZLMSuarDdyUASU6BzH8vT/p24yhqhwH8Rni0pbOUai5ZOXpUsBjUH2jiuFpjSIc
	W6s/3H4/cBYBK5fydFWpbzsChYGKvwFF/g3aFelRO4kg18tc5WsTsi2+fJLsG/HDfQW+65
	Tsn2br9GB/wKKUr+jC27bdU7S31m7NPcYb8T1WlaJOqa1gxR+34E9UB/NEae+g==
Date: Mon, 19 Jan 2026 21:51:55 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.12.66-rt15
Message-ID: <176881761224.25763.16646224135751002623@nitrogen>
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

I'm pleased to announce the 6.12.66-rt15 stable release. This is
just an update to the latest stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt
  Head SHA1: 682cc16c05c6cec473f4277c9b807dcd5cacd0c8

Or to build 6.12.66-rt15 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.66.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.66-rt15.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v6.12.57-rt14:
---

Daniel Wagner (1):
      v6.12.66-rt15
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841ad..18777ec0c27d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
