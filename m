Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265894;
	b=w9YvkXhEfDPTnm7ynnp11P9G9MTO84Sflpz1X22TavJOebPpBk4Rp+vKBoDs9eM1hAAi
	 vonxkALgGICV+KkjahThmXloTMD5PG+EoRGUSygsQ0smaPmzldAWzNTVXMgvQ+RH3xeL6
	 4tYD5E5ScPmJGKt/SBYzu9+5psVVHz3aSX3eyArz/E+jbTt5MHBHkxKGJMN6+3VvX9zu9
	 lzoNkFM0D28bhu2MsKSxUUIhXg0Ji8IuFVfmp3FZAv7TKcl4rWqs0aXMZ6uU6mDBRLttE
	 3s0dr6SXNAG1GRYpRKAEalwthkvWuqxZyKECDB1Py8V1jicFFQkc3DY1aX4L13uOBBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265894;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=ZK+lBSFkcCGDbs8Ur/722GMJ2Wd+4b9Rad+c5Jgph+s=;
	b=zh59cYFNmKk2bXXAAG161qxFEvrChCClf1jzMHQe0jjaMOjKIdXyGKFWgqmGSCZwMxl8
	 5jjW8163cIBZy7zwsZz8GHD2ASGE8MhMp5JJdbA1YLHt3tn/s8tgZADD1czyiOTec5lB7
	 dGBZJuCZryi4ueQ7rT6yKEOKTrkKeduO8bBB4CZQ1dqfia0iyOqPFXM/Qsg4wzRKli/Gn
	 kWzLWU/imNI4LIAUwQwR8RPNr1IWQTntWyEFAC58pNkpmx4WubmtnVfQa4Z+1Vd2KjZBS
	 CJ/oYlE/T3efhXvV7vMMiuQoS6YsBwAIUP/k334azJtD6lz0a0FYOz2RPNnfZ9JeMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=4ddMz4Uu;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=GS+gzwvv;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169F606A320;
	Sat, 21 Nov 2026 12:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F169F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=4ddMz4Uu;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=GS+gzwvv
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1795265868; bh=ZK+lBSFkcCGDbs8Ur/722GM
	J2Wd+4b9Rad+c5Jgph+s=; b=4ddMz4Uup/R9CVsknq9Aany1751OgRXHKsoAIgUbyoumYup4DV
	ky0dLzQa813pbPxgZ36y3H+bLS/rBp+UGSCA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1795265868; bh=ZK+lBSFkcCGDbs8Ur/722GM
	J2Wd+4b9Rad+c5Jgph+s=; b=GS+gzwvvoh/uvOGdxw1SSeXQj/gOVfuC74PB2LOle1DzrmZTn/
	OLpTcD2Ty1sTHNclxjf5A70d5HReb6g5mCC433NRcAg+0xgF0Hfq+7Niot5kGbbPQVkUwFr9QML
	t0d3spyMuMJdnxaCuZEziHw8Jc0gb+eJUszUCZzDhAtp5eN7+MH9zHFsR7fwt/L8X4m8jJrFGwB
	SSCgoz0BGbAo0zCMyZICHrGWsaBFheh6eReCiTxqeD468PYRtZU62R07aZSkcAs+fpu1YAjh+6k
	c5wTY/fLOQtYU9Ftgi+PkjSIMMCz6ks4MqpaPyr5CgtUd1sETdw/ZC+SiQwl7yPgLow==;
Date: Sat, 21 Nov 2026 13:57:47 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.118-rt24
Message-ID: <5f522636-3555-4694-ac55-923c981eab3f@kernel.org>
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

I'm pleased to announce the 6.12.118-rt24 stable release.

Changes since 6.12.117-rt23:

  - none

The delta patch against 6.12.117-rt23 is appended below.

You can get this release via the git tree at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v6.12.118-rt24

  branch: v6.12-rt

Or to build 6.12.118-rt24 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.118.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.118-rt24.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

