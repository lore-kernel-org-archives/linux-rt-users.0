Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400613D531
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519683; cv=none; b=sHxM3pnHMWp4zaDm7PQ0ThhpjswB1iBmiq0r1s01zoFFG0h6ivlHJc2fajUmeVjf2Ml1Rtlp4HeHfLeZAKpJWcE91hGV4+IMB6xoVz5ksyx/ISn3vOD3zkP7yzP4gmtQm5KFl3fUXRcoLhEdIVoRz6VeyiNOOAPM9xylmGNA190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519683; c=relaxed/simple;
	bh=vt6pn4j3s7r0dQGKAga8P1DLaxzYPEZbgFLF84+JBt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq6BpLM+Boh37LcEy2lgSACN8QjwsWB0T/0vLPg65v54NP1Su2Ikd+BU0829Che9qDE8/28stqLDwU+nuiYC0yEIP6u5CJUbHPiiKKXR93Naco9qcQIx4WggRkF3bJtClxTMZe24vgA2Zyd/XJar6BUbAkGHjiA21XL1Y3YGSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDlgNlDx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4gtDOKXf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDlgNlDx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4gtDOKXf"
Date: Mon, 14 Jul 2025 21:01:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752519680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYnFerd+0kEq6UzDv64Fqx6FyOKl/Heljfd5f2Wc/wE=;
	b=QDlgNlDxJc92cVNTrlNPCctE7SLo7L2n+DuVAeb3LbhEWqsslZEtvw+7PgbpT7KB9WDfEA
	qMTCF8yIhQvR5C8NIjUJvsoRAAbWo5c8q7estE1WEviDsuDr8XKioTY0ngp0HlCRaEWyz/
	rdcM13y2siNQRD7iyI27uwdbxs7NFP5ucIuk3epWqlqhexoibMZAgcJJGJPKu8hgBG313L
	u89PC9VPY3nuejpv41t6wGuZopU+HLZuvgE1PWartaEG+dg3lLA2OIK0PlQ7f2vLyE4Mo6
	cgaSnUtj2laFEbn0Ph2EnfrJxtCJ2KO2GnGcS+b4gDKaVvlW7X6BYMxmdZiwFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752519680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYnFerd+0kEq6UzDv64Fqx6FyOKl/Heljfd5f2Wc/wE=;
	b=4gtDOKXf1CVOKW74s+rh052iv3E/ldFEhtr7Ej8pCE8WF0x34NoERvBcUAoK8z7Q2F1KiN
	+OnHF32pBOXV4JAw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 00/28] rt-tests: Rework cyclictest manpage
Message-ID: <aHVT_g1VIj-GxfSp@lx-t490>
References: <20250704132721.13325-1-darwi@linutronix.de>
 <20250714130104.29nUrEeQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130104.29nUrEeQ@linutronix.de>

Hi,

On Mon, 14 Jul 2025, Sebastian Andrzej Siewior wrote:
>
> I would merge the "remove $X" flag patches. It is a few times the same
> thing.
>

Each "remove -$X" patch references the rt-tests commit that removed the
cyclictest option in question.  I felt it's valuable to reference such
option removal commits on a one-by-one basis.

> Therefore I would suggest to write a new page for cyclictest based on
> what we have after content wise after #28, let rt-tests generate the
> man-page from it, remove the current man-page.

Perfect is the enemy of the good.

I have another patch series on top of this one which further expands upon
most of the parameters' description.

So, I would suggest that we first:

  (a) review/merge this series

  (b) review/merge the next one

  (c) I send a third patch queue that transforms most of the project's
      manpages to rst2man.

The rt-tests project already has 19 groff manpages:

      rt-tests (main)$ find src/ -name '*.8'

      src/sigwaittest/sigwaittest.8
      src/hackbench/hackbench.8
      src/oslat/oslat.8
      src/pi_tests/pi_stress.8
      src/pi_tests/pip_stress.8
      src/svsematest/svsematest.8
      src/backfire/sendme.8
      src/hwlatdetect/hwlatdetect.8
      src/pmqtest/pmqtest.8
      src/queuelat/queuelat.8
      src/queuelat/determine_maximum_mpps.8
      src/signaltest/signaltest.8
      src/ptsematest/ptsematest.8
      src/rt-migrate-test/rt-migrate-test.8
      src/cyclictest/get_cyclictest_snapshot.8
      src/cyclictest/cyclictest.8
      src/ssdd/ssdd.8
      src/sched_deadline/cyclicdeadline.8
      src/sched_deadline/deadline_test.8

So IMHO there's a weak ground for requesting the format transformation
beforehand; i.e., the (a)-(b)-(c) development order above is the most
sensible.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
