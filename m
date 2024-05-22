Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496627EF1F;
	Wed, 22 May 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380255; cv=none; b=ItcMM+A7X5FVMGKN9vWyWH+FNo3hJ4w1jzPu6dodsrjfRYbMB5A0BnpIw5SXtJxHpIsKrM4cy9xp480HWfVSmBLEjFnncmobNs+etac65BkNNs1xcsw+Cc2MrNgQ5j+j95GmxOSLDt0CnTcKfz0EmrA1lfR0hEu86U60sMTROBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380255; c=relaxed/simple;
	bh=5XqgxJ4s4obLjU3RH1Hcac8iajNl61h552vrzAtJlLo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=clKrt7HQIBH2i3PopCYzQJ6Pe7tcEyfuL9nYc/2VXtZVe026asFBmdsktu/u7pWtdGhVJBX2Y6d9N9enM10FeR/H2sZyW9HVVZ+prNcMB0MIYwbVX9Tr6Qua9Ic162/VFe35M7QHmfa/SM5mtXrZv/vY4lRCXmbyIaNhkwh7vC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=ckFXKomN; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="ckFXKomN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5A25DB440;
	Wed, 22 May 2024 14:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1716379804; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=I99HSrXGOWc4gQITzBBfFSgceACHwqV/lEW4REQuRGY=;
	b=ckFXKomNanJ1UCvpfwEMFId+iGHzd3jWn1EiT8VWS8ErrBJLBOBnMq2O6g3A0yAgL3mSxc
	lDdA4TAA/gLtsAOeJjexCpLDx15Mprp+fPqyRHXQj4Xa1pFmxcdCyVJLSvZd3b8e+A89MM
	K0GDI3rbQQjaX/apuTg66Zs3xYpmV82tOjvU7AD4Xvr6XDJ0K12BaEF7rxaPGTxJR8/Co+
	RhTUDtqg+HxYKk8bjZG+lgQgUx6fXGjhZxKgSiOe7+GSr1HHczuS37jrknjs2E/a+K4KwS
	mFqZpEnTUXli9BQAlTv1ayyaMC0FsVdexV7NHXkNfDEveW/ZvT4Ql/u3T8PEfw==
Date: Wed, 22 May 2024 14:09:55 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.312-rt134
Message-ID: <171637952997.5572.1871863446768796282@beryllium.lan>
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

I'm pleased to announce the 4.19.312-rt134 stable release.

This updates the rt-stable branch to the upstream stable v4.19.312
release. This took a bit longer because there were some more complex
merge conflict . Stable backported one of the preempt-rt preparation
patches which v4.19-rt already shipped. Sebastian helped out to get this
merge correct, thanks a lot!

Cheers,
Daniel

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 1c3b7281e2711af8488ce40c9202ad19f3eeb557

Or to build 4.19.312-rt134 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.312.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.312-rt134.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.307-rt133:
---

Daniel Wagner (1):
      Linux 4.19.312-rt134
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index c2c7e0fb6685..6067da4c8c99 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt133
+-rt134
