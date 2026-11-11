Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409732;
	b=F/p+WzvCvs2ZTtQ3RubD4r43mRTtyBGLJCCsysxsVtugH3paDWVCN476Yi/vuTRPr4Su
	 X4aSVmp7lQNz+Se9A7goLPYOyRDNN6UEui9UV0FZd8yHSRAYzUr4CPfxE0W0rlTdQnoi3
	 VwYapSMYLOCYj0t9Z59WYn/OgXz9uQpRi+Pc2dBRcVHRjQCj9eeZxq2UL0RxGU9oD93ii
	 AJme7NbNtze+oS0aFF22gf1vm3vsf/kW5OxP6tqRwGmFY2KJOj6qLzUX2CTWuDGhVFgZ0
	 9O7rqhERQVLj8YdMtyapmFnzSL/SLHNcF0muQ/1bgv0oYaSHqAGB2mt6lhIZ6N2EQOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409732;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=ELTxZM4v6gc7R0aU2+sQ0qw56N1NuJTUDnzP6eyAL/s=;
	b=2IWAaKGTZqQYvEKwnVBEHDmbXppm7Jxdsgj1GSNMd+ap9ZGYjhXy6pRv8m5M1MABFqGH
	 Z1rqkONKtzKDh59xPcRLZ2jlhnTt8RtBT7PSz4fa/UZaJJSK2bHdfLH9H5SC5zooB0Pgs
	 pMIzFV3wKbYY6qIsQu2z2Rg/2W5gKD7H4KrF9ActfSiLAGS8KPt2oyKG3u0dAS3ROxpFq
	 +A5LxLsngEGpnoSMVUeo8UNPFyWG3RZwHhXtvIB3VAVPfcNqdihxAALzZrkv+IlVFHkk9
	 NmjTeR89gEWxtI1CrKKXXTvGUUY/Yo6z3bp5h7BZ76NzYFcY7uG/umEVgidSdNlOA2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=3sPGwwTv;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=IWPVOsyg;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1485606A881;
	Wed, 11 Nov 2026 15:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1485606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=3sPGwwTv;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=IWPVOsyg
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794409702; bh=ELTxZM4v6gc7R0aU2+sQ0qw
	56N1NuJTUDnzP6eyAL/s=; b=3sPGwwTvCKPSQrVl8jn+5wZlstg6tfS6/CkGO59wPx3jlMdPSV
	XZMQ5/hP9y97AaA5Xl2jczxg5VTfztgvEeAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794409702; bh=ELTxZM4v6gc7R0aU2+sQ0qw
	56N1NuJTUDnzP6eyAL/s=; b=IWPVOsygifquVmBgauWuEpsPqP2SM23a0CtiD/vFEUOczY0fmB
	2Ntq1fgb8xNt429Ut7dRyPgoPp2Pyiuz+a+burzI0+QRh/0WLbl2HVAcijkjKeOBXAMs9jprT3N
	1NSiB9S8Jrq+lwSmwp/AhxJ/3IeuGhGcjCzUYDHFnFxlRQDBzzmBDKrvL9i42U9YbaRXCfp1qu/
	bIjerYoBdl2DirbfMauawc2mLv5xW85Sm1GwvcSbF8FkbbhankhtjTagXIogKBMalefwoecm4XW
	NVsmPDdbhAiqnzvjC87LGtwb2c2VHe+gfcHl5zlggoZhRCiGrqZb3AuXG6iFp8bHF8w==;
Date: Wed, 11 Nov 2026 16:08:21 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.117-rt23
Message-ID: <a69d4e0a-c93a-4b14-af47-c876a6c06298@monom.org>
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

I'm pleased to announce the 6.12.117-rt23 stable release.

Changes since 6.12.116-rt22:

  - none

The delta patch against 6.12.116-rt22 is appended below.

You can get this release via the git tree at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v6.12.117-rt23

  branch: v6.12-rt

Or to build 6.12.117-rt23 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.117.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.117-rt23.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

