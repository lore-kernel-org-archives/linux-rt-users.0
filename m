Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508372;
	b=KS4sZmw026utXicFMqb3tPJo9TaQb9lzJ/gLWwFNiBeobIWEG2pA0L2Db4nphN8ZAGKl
	 na/fDid9TS/wc4eKmXY5h8Wy+Rr+inh5YGN80d/mgapLAQ5zgqHO+z3aV/WlK0dyAfyV8
	 RZZq6I0J7igmJ4SEdYDhYJC82xGzXoPpeZLlJo/Hc1TEuR/ncPC4JSb6r8rx3CHGqTYKy
	 Y9p5ujOeZpyz3wCXyUm6p+d49DzC/+yfyJrBxkKSTAHgz93ku3VL97AkkBTWkRaj/B5cf
	 tJZOGwoHpyhrPdVlgF6JusbT3tVHGQZ2fqDKNzwbAiXefZ4FznGxZqJR+ZE/PIc+MXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508372;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=rPFOY6K5fvmdSfx1DV+pv7rqJLwshdq7CxLNidfCxHU=;
	b=ybffrk2DsiyI5C5yJstzT+tzsJH+NdeR+SyJYXVMv9rYqGV6hSbgY9dmR+XclXx6gQRl
	 GaD/JZHhkBiwIxnUgEgz9yNvDbWzqWLKJT8lF0rcieOk10fTtE82rz4Jz82XsorGxTG6R
	 RFOntBYXuiqidIG2ueXn4wHC3dmW6bpWV9RXj2bItcFcozLcLIzMiwV0Tb6blLxFtWm4s
	 svp8bCcYSfKqwV5aBRl4315cDx2rfkoLZqdv6Vbym3LJZjo74IC8LgVK4zrGAglOFg9iu
	 uw7TzII1fawBa88nxoyMdzeEeIld9TzoS2/lA0isZY13/ZneQgNmUBhWtNjwKeSR0GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=mXJc3H8X;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b="IC8UGQ/D";
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135D606A32A;
	Tue, 24 Nov 2026 08:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9135D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=mXJc3H8X;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=IC8UGQ/D
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1795508360; bh=rPFOY6K5fvmdSfx1DV+pv7r
	qJLwshdq7CxLNidfCxHU=; b=mXJc3H8XR8XNt4mbezro5jl8ehq3sIn7E1z+StWnBHCAcQ6iJ/
	PEQ6V3erIplw07ud1EtCoKGa495mkdpAhnCQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1795508360; bh=rPFOY6K5fvmdSfx1DV+pv7r
	qJLwshdq7CxLNidfCxHU=; b=IC8UGQ/DAXrP8Tg+hyS9kIyC9h9J0mXfl054EcbUCQgG02DK6V
	Em7VQNs5ZexnnRNV4VCaL4e2HtFM8w2Ts2Fm19mAgEGJSnXe+zT9k05PEhCRWOZu+qrsjcZUkDk
	QqrDbr7PfCPjL9ZC1ltZ8+MpSoWoxh6E6wK5nLqGgfeQg4XnN+Oyc+YxiSat627Q3fPdXMlDvB5
	nJ88Vt3HxTHX9MZKGuJFewueyPEgXxASCzweap+/3cIEppmne+fNGVCmA3obaeK8JtHFmCOU7vr
	m7HCRiMjPvGTJloRAniDzk92UOL0WuG/54nY9HTqXH3ZsV+Fd1Cz5kb92oSEXsMCydQ==;
Date: Tue, 24 Nov 2026 09:19:19 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.12.119-rt25
Message-ID: <0bb98f88-7036-4508-a58f-e4a967993a79@kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 6.12.119-rt25 stable release.

Changes since 6.12.118-rt24:

  - none

The delta patch against 6.12.118-rt24 is appended below.

You can get this release via the git tree at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v6.12.119-rt25

  branch: v6.12-rt

Or to build 6.12.119-rt25 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.119.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.119-rt25.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v6.12.118-rt24:
---
Daniel Wagner (2):
      Merge tag 'v6.12.119' into v6.12-rt
      v6.12.119-rt25
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index b2111a212663..c5b71f9a229d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt24
+-rt25
