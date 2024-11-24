Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8E51C4A;
	Sun, 24 Nov 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475394; cv=none; b=AEFaL+s/hg3bsNpk4KiSaJQ4ICFTXSFrPWabcPoKDU1t9f5MadBQikGEVpX/5db6z9vASa0yq80GGOuPxzqrTGdb0qZR67yynisga97xBPFuRm4hwbESxMO0ClIRyhdi6oXH4Nbtq0TqGGvL5WXQi4mkkmi1FFKXDwBbZZzEGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475394; c=relaxed/simple;
	bh=4vuqr2pcYV2BzuFnSVlyzjh46Ed3HO3v3XGw/5XYkus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U01gtib7OyR73QaK3M8B+Kpit70MkCAxrr/2VeU+Onl/qgKV+EkGc1v1Xuj/+guBxJGhmErjsdgYzNyMRdzqjmG7d30WNhtp8lglg8jiQbrTSSV8FqPe7eLcIJbiHhJF7L8jrvYJfXAM1sk04vRewa35oy88Imf0a497F1OWDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=AkGVAzqb; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="AkGVAzqb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7ED1ADAEAA;
	Sun, 24 Nov 2024 20:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1732474948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/a3mDGW44ybqboDdblNJVXV9BC0U8HhxTrsAdRSov+4=;
	b=AkGVAzqbdDqIMogwhiArKIGJuUp4sUrxGftmxB0FMWjogdrYl1HN3UNOIio1UfmGHaU6qi
	wSEXbfE4jC3zIC2ICsXW1zh8lJNGv9GuvDOtD+kOvlnXIalTME0mKgtpJKtRipwwp3lLZv
	ZxVca1YIGWuVfVd+WQMluv6eGNpSuJ/PPSaQPU+FBTOjEsBInxtu82/feHyzlO93PqSXr7
	h25EgabyzgycJE8Bc6jzcCMI86Cd/DsRYGwvGtVvZxRXseHyuu07Xxw1y1SWb6tcEjcZey
	DncIhb/oQ4rFSRdWyjRfvrgN73XSE1a9TM6zq541nVvchjg0r8XkI4ORjCqdxA==
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
Subject: [PATCH RT 0/1] Linux v4.19.324-rt139-rc1
Date: Sun, 24 Nov 2024 20:02:21 +0100
Message-ID: <20241124190222.112239-1-wagi@monom.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.324-rt139-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-12-01.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.322-rt138:


Daniel Wagner (1):
  Linux 4.19.324-rt139

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.0

