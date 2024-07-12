Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA317741;
	Fri, 12 Jul 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771575; cv=none; b=o7oVMKajQpd1mI8dhcAoZGJUfiaLDLCbZWdPRFp/UAppd2/4Jy8SfGjrg8Yp8xMHvbs8Kz7dQYksVQWsxbr8hbDwwUGD2L6aEyh+Yz8XMBUVkxtCyH+4YXuGwg8iu+cqqbp6p0854UAHpGBlSErIcH/ZYl1l6SxnRGDP5JkntkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771575; c=relaxed/simple;
	bh=7KQJ/rSORgjYXReXBIPA5wk8qlvF92namALIkf9OGVg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VNX0z6vBQdDi7jtiUmveLcCyTW3CbxpdXofSSg6Xmf8qYQcG0E+Gl9Zw1u7Q09vA6HuDFYx3RQ8jNv3qA2bUWdoSTbApHGJO7Z9rzsuQ66GYmZ6gMlehy9eMYWi1brniwIodNDnbC0OZJJDf8pemfwfEi76pEFMhKVNYGUcnGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=K31cVLW5; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="K31cVLW5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7D99DACD3;
	Fri, 12 Jul 2024 10:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1720771563; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=TvF5r8A7Vug3T/T54B+epLrboJRNbq0U5RG0fUJgFGs=;
	b=K31cVLW5lEAt46WtS1G6zNBb0CLvm2GhWiw78YLGKfoFYTOi7tnp6Ep1nZYyCjeVCmSaQV
	I0Z7l2+9Cn5EJrARjhRG9LDV1b2yHX5lzxAb17YXiRdr0AE8Oq/pHJw5hwHukCuYEkDmCc
	rw4s54XLVUC/J4rdlYSznFHv8sEh+ZbneWqC+VRGWEG2X0DwCl9OrbNjccQhJ02FjxPDub
	P135uSExWJXyweVWvIaV+ghdB8a1d02ZVdFv2KJtYCQ9n3LPRpE/OoAh4CwEkQe1zXr2E7
	hanDEoe3yh9MlnZY7CUKbECViWi/2Iy8ZpkJ6ORaQeoFa61w3YLOadiwea/6tg==
Date: Fri, 12 Jul 2024 10:06:00 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.317-rt137
Message-ID: <172077140772.5488.7194965584849299600@beryllium.lan>
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

I'm pleased to announce the 4.19.317-rt137 stable release.

This just updates this series to the latest stable upstream
release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: cd63b6227c26a73d4626bdab9811f685f0e3fd7c

Or to build 4.19.317-rt137 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.317.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.317-rt137.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.316-rt136:
---

Daniel Wagner (1):
      Linux 4.19.317-rt137
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index f824f53c19ea..41b444e910ef 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt136
+-rt137
