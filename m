Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8420E03B;
	Thu, 12 Dec 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996189; cv=none; b=DXLqJXdINYYor7UOrcPaq8mem760jQvymyEzYoTlUZ4znbYl4JDiKU5hhzsPh82QGBwJx8SMGWryrmccXsT5//k11hMD2JfEiXngDcn5VW87Fh8gE9vGPfZwOtIujW7yOABd9EXi84QxhvNY9UUGTS6YCOeSC8ojEfB+0SiM6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996189; c=relaxed/simple;
	bh=x10mCF8YqQYTqr/vaCFAAXcMIo8oZRLZ8knGozTlz00=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mX6AZWfhqrFDJCt3JdnLuKlanxmMPt/WpAvyjKHq00m81grkt34iCfTO/fIB7dqJAK6Z5Y5I/ECfjlUayGA0+jz7g+cQC2fp4Anv0LATBd48EItBBsXgFFUKZOWxJsCYaZfu6ag9DgOJLdfNt6YqvlMuc5owtUnMGa/Mx5gphAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=rdl/bDVn; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="rdl/bDVn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10241DB05B;
	Thu, 12 Dec 2024 10:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1733996178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=8Dq9Hpv1+bWSUozbV47rfOqv2sonz5XxWigsrCsHGws=;
	b=rdl/bDVnst6iB9QqI1BzhPT66N+5p2YSjoboxaQENMmOt7XFPGl/RPOpksyhqKq1wZxmNy
	8iSuDvNchZJmsIt+dRpuprg4K1eEtUBzoaf2N1sJnBZZA3k8xWGxjn2FE2JrTvt968ZTZN
	KE81ni+1+Qt+mBNdNnLUiqemlRGD53puL3VccbG37eFLI73dJMK1SgVk/GAvl3onBqE79x
	3HTlHVbLTPhMQ0s4prR3RkLFHxDSwCRf4jLF9CjwXKGkEFxCVDqSPHL3VkQypKfgZHcxO7
	E5tqVn+rsx4XBzdGMGYOjoAgkM3GO3QDSbTdP02NaCGxFdV8KtqX+eZG7MRCgg==
Date: Thu, 12 Dec 2024 10:25:55 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] EOL 4.19.325-rt140
Message-ID: <173399498510.8065.17411485631021071013@beryllium.lan>
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

I'm pleased to announce the 4.19.325-rt140 stable release. This
just an update to the last release of the v4.19 stable tree. No
RT specific changes.

The v4.19 stable branch reached the end of life, thus this is also
the last update for v4.19-rt.

Users are encouraged to migrate to more recent RT-supported LTS
kernels, like v5.10-rt or newer, to stay on the cutting edge of
real-time performance and security.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 98415c457494b14020ce3ae70f98edf997fac181

Or to build 4.19.325-rt140 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.325.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.325-rt140.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.324-rt139:
---

Daniel Wagner (1):
      Linux 4.19.325-rt140
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index e0b93414dc30..e27678f73d17 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt139
+-rt140
