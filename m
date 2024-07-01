Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984F16C844;
	Mon,  1 Jul 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859397; cv=none; b=d7gCwolm/cJ1XmsFYjpSrjBmZ9CuJ5K/RFWwwtw1sBTaXLgezoQ0u4cwvlx4Rvpw6fBA/6APrn4rBOBaQBq2PEOpK1c9PvazervVyVWpMFMFpScuBy4a//FQRRWT2ryMZ8vlXJAw+CfMmqL5+k76tb+WdibhvOvTzx6ZBzcWRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859397; c=relaxed/simple;
	bh=uq8cv4P8tTN128BUGe/MtMj9i96KXMbQOCFYWpYrgIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNtdx2hnzdeG8Hu7zDpL/RdZube1I/DpEAN8oGozFs9yv/9nEcnAKWZlRk+sIrM78eMOrVKDaAwB9h0+AVzAwRQK34PXMM7pGBC7UvXisVxKeFbDZU7f2EUwL4aU44HGmIoxX1rGTbEQztIcnyIFTG/+L2XowtZAO6bB9IogKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=Kvkh3HTM; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="Kvkh3HTM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D109ADACCB;
	Mon,  1 Jul 2024 20:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1719858923; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ZcwORZ3OTWfDspy3wgPTEJMK4905Zu2w2DL3goIe2ZM=;
	b=Kvkh3HTMT98ERvVxnbnVNVdX/ykuwUctcodjOga/dIWwJbvUj9EPR7faxsef5OQh+96WM5
	KXAhIwYdHsS2DOvDEggXLDAvdDC9Tpv2dsW66LOpA/t8xVWkQSFK7NvqD2N6VaYiNhj0sj
	DhmFDnpIgA8rc25kh6sK08Z6nk76ntl9OhkRnPZoVRDzG2iHWlD8HvCfGXfFGR5lhih/Zy
	/GcNG2ySp7z3rMQTb3l2044BqxOh/eRIoLAj97Oi0NH5/dXKEXJ/JRRrUTMPLdp1qyTHRP
	Mak8qRXJQBJmTOHkgXmvC9iO+e0zgvKr1AzpvubNkhXmBkCuDPTWOlLabOFUCA==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.316-rt136-rc1
Date: Mon,  1 Jul 2024 20:35:17 +0200
Message-ID: <20240701183518.26751-1-wagi@monom.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.316-rt136-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-07-08.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.315-rt135:


Daniel Wagner (1):
  Linux 4.19.316-rt136

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2

