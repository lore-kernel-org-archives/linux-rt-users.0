Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD13803DE
	for <linux-rt-users@vger.kernel.org>; Fri, 15 May 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875146; cv=none; b=G9vumR6f22rUgV76m3+478dNkoCb72MBW0AHZXpPxjj2H2uBWZmZ82stDJJMlwb9ZAYSp9UMPrO/zK0W1HwovzYIQXkJ4fvVkP3gibiFApOApm8R0kHBPTCMZvQl2wjdPyLuK1kQHu/9JnKTnSDIgdEuOrN/VdAeGxBxnO0yOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875146; c=relaxed/simple;
	bh=mhcoEhkzFlFKM6iSzA7jYDdOhqq/SQYkgzHst2MApGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZAuKFINJuQg0sXaCovw4sBpkjGKBZnJSppFKaSYdBIPxqX5m8WqVwIkeT4NwM/lfZuC62FtLBQuUnkw4WcOm/Wrh94qkb1Twv1TYkmUUZhHuMz++p+8YjvV65UGuCrdCCb4tz8uzMxQliP6ZZFj70RboMqOiAd/VLp9a4he0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6PgsMHw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnhPNUL2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6PgsMHw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnhPNUL2"
Date: Fri, 15 May 2026 21:59:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778875141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/66UjcIJ0oO3+VeNYdlBAUDsEzaCYJVEmMbEvGhwOw=;
	b=y6PgsMHwYMBjL1D354O6qhneWmgSHvbO5OOvjX9pPr8sKVRnFaZbt+q1EqyGOUDMwQ+/fX
	8sXWZrFZDRuacre5R1lIex1cLcB6MmTDy+IMpkl3DuANVTRSRVM29B8rA/Sm/gfCcI6A3r
	MBGLpRncP88De5H+d/PRkj6m3a7hvA5r/u+xGF3BFYV3NfyA0Uo/gezwoTcNgib9VB4J+O
	jkdnBdk3H7sMCU8bSQOOlEzT4O+ZyyGqLAWL0Q7+Z/vgKBDD2ULGzrM5uRonP9Z1XPLnij
	K6srO8QR+Q4X/Ov3m5nKhbnUItN+oxlE+b2RF2X6BtsNxv89WljvZEhV+XBqBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778875141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/66UjcIJ0oO3+VeNYdlBAUDsEzaCYJVEmMbEvGhwOw=;
	b=jnhPNUL2bh1E4JtApjtVMX0+8G9kKoXmR30vlvKJ0OzViI+QgsBBRxWLktIF4Qu0bPjHUn
	V0UpRu15UTVKQwBQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ahmet Cevdet =?iso-8859-1?Q?=C7elik?= <ahmetcevdet006@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: VIS, a small Linux/x86_64 tool for CPU jitter, SMI evidence, and
 runtime placement reports
Message-ID: <agd7BPZKZN8c8gud@lx-t490>
References: <77cb843a-d5fc-4a35-b0d7-2b0c7f2f24d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77cb843a-d5fc-4a35-b0d7-2b0c7f2f24d3@gmail.com>

On Thu, 14 May 2026, Ahmet Cevdet Çelik wrote:
>
> I would appreciate technical feedback from the Linux RT community,
> especially on these questions:
>
> 1. Is this kind of evidence/reporting layer useful next to existing
>    tools such as cyclictest, hwlatdetect, rtla, ftrace, and perf?
...
> 3. Should VIS try to import or align with rtla/hwlat/perf data rather
>    than implementing more sensors itself?
>
> 4. What would be the most useful next step for making this relevant to
>    real-time Linux users? For example:
>    - better integration with rtla/hwlat,
...
>  I am not looking to make exaggerated claims. The project is early, and
>  I would rather get criticism now than build in the wrong direction.
>

I would personally recommend that you add the missing bits to the existing
official tools instead: rtla, ftrace, perf, etc.

By submitting your new additions there, you will also get feedback from the
experts on each topic.

Random personal GitHub projects really die off after a while.

All the best,
Ahmed
