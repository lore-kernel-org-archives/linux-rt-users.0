Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1517E9;
	Fri, 31 May 2024 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138971; cv=none; b=DuTfzidxijfAZKVCtOaakqdl3qAzOqx07/smgOoRRsEkEKyRGTpIdoE4hBftJLOtzPoAhkTZDrJJqdbt1TKjuDvHYPvDnwZAFu1ioRdnKE+C556xaz9ACQNmA7VWw2O7A4lR6Nc8dOedyr3hy76nNMmWWHhsCOQyiqMnJ+VGbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138971; c=relaxed/simple;
	bh=e2RvwCRHl4GX1kG7Nh6RBjRI/S4ovW6oenUsZihDIGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/T4PkKT8K8JCj83NaTV0RE0I334pcaHj8X/gW4lwJgr80D+eu5OBlgZh9oE2M/ES3i3FBEQzlE6wHq8N/zr5aaGMu1Ze1whVJ0uBP5SKZLau9KCIRDsGjM6yXaeZaLhn1Vr6RMBd/KM55M2MzoMKa8VXCkEXddcff68qHh2JjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=GLl5Fui5; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="GLl5Fui5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11EA1DB443;
	Fri, 31 May 2024 08:57:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1717138637; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=otNz7CvTivnwC3/a202OFaijRwix1c06Gyv3iiaPrKY=;
	b=GLl5Fui505TSUq7sB9KDl/19kGs9kyFuKW+WQA94xThCPArtL/GkM84z1Rx51cBnv4VYQU
	/kWYdjIVkuSZ4+Z3o+po7b3hvIJHkdUS5xfpWLkf87VupCI76hIpx+CKAAumP0a555h+e3
	phyuEfQc5DYnQGYiPvKy6cYp35Ibqa3ItNM/VYxPmV1luue4x2Iz00Gt4ZJ+JvOWE7E9uP
	e3HG41PM98UEzQ0brs67mPZFbpSwtLD+fP0F0k+NV0hiQwOHDcI+H2Zlq69Ze2NhedGoq2
	TDU7kxTQFybezFbRguuxQsOphdlUmw2Ih15XhXj84uTIvPcd9BL80fNZmO0l6g==
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
Subject: [PATCH RT 0/1] Linux v4.19.315-rt135-rc1
Date: Fri, 31 May 2024 08:57:10 +0200
Message-ID: <20240531065711.32484-1-wagi@monom.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.315-rt135-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-06-07.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.312-rt134:


Daniel Wagner (1):
  Linux 4.19.315-rt135

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.1

