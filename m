Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A11E32D3;
	Mon, 21 Jul 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122166; cv=none; b=E8+yFdjaC38N4v+N/u6wxQiUBaDCFrEcE8sekMsm/d7UMLdfP/HD2s5duvS8elfySgT7m606n9eHF+JLAAb6/JYRhpjeUcsqKW/Qf64X3ARL+hS7k3Q9+C1LUu+zNidJhGb6Z8oPS1HycfTiluy51rentYAq27LonPDVafuDNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122166; c=relaxed/simple;
	bh=v0JnckTKa9Wzk2b8bnJecoMDCfc+d/+mvsfcwwI9uCE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ruEi9/t0dafwJ9P9VDhT2i0It9HxmvcijpxKY2LbctnRb3ZyAGCXe+CwB5/m9UJ5epXeBVX+mHvZDWFc0HpO/vReFUEIcMB4Y8DZC10QILxjUra6kPV+J7pv8ZKcXGt49Nm8qfzKS2LeZ8Sczi8aUgiCF8c9wMqJvfavvZAI1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=b2+taER/; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="b2+taER/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6ED2DE37A;
	Mon, 21 Jul 2025 20:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1753121761; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=fceeiNxSrGcA0LQkHYYLM6vTS6LX9M+BjUXdE/4Ejac=;
	b=b2+taER/nFELQpNV3QNJZSQP/HVVYf/tGA+tV9mXtgr7BnFaJ7CPKgPzE2c2QJDnIc+3aD
	fFq2e4UznK4fU9LPLs1eNXztgYBKbVN/mRpitSlEHpC8wK3OjbhxTLqpY6yMK7XjlG0I1C
	CtjKFoXQgRGNbyfNEhCzGisZs0bXN9ajSS3D/FG1cUiGMX1GCeNSYmISWzEESo8eQ4//Vr
	+8RuD3ZEnwOWPS3YRseOawrI/qOIyX7yyJFvAoLnhe5C/eLTAQeJ0qQ+3V1y4TNY2TJfR6
	B++eeDCYsNs0DjtWHiJwcTGkJaJvHuwbkPUofrSfv4OrRPCUZgOLjD/lm62C8Q==
Date: Mon, 21 Jul 2025 20:15:53 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.12.39-rt11
Message-ID: <175312127913.526655.11942829521744876779@nitrogen>
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

I'm pleased to announce the 6.12.39-rt11 stable release. This is just
an update to the latest stable release. No RT specific changes.

I've taken over the maintenance of the v6.12-rt branch from Sebastian. With
this, I've also changed the workflow to follow the devel-rt workflow. That is,
the source is the quilt tree (-patches). I've started to add support to the
existing stable-rt-tool. It works, but it's still a bit rough. The tooling will
get better over time.

That being said, this shouldn't really matter for this release artifact. If
there is something off, please let me know.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt
  Head SHA1: ae9a9818f45c14db5eccf65ae7da725d8e578e72

Or to build 6.12.39-rt11 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.39.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.39-rt11.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v6.12.28-rt10:
---

Daniel Wagner (1):
      v6.12.39-rt11
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaa..05c35cb58077 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
