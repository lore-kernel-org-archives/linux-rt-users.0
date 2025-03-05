Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFE13633F;
	Wed,  5 Mar 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178914; cv=none; b=EDbI6UQB3TO3xHls/l23ZDI0VJYvj1ZEwqLExC6RhpHNWGCb6J8EogzTlRPd+Q+Ziis/+QGVvb0xosNs5fiuO0PS46vTBU8dsL245dTXvPthCuWVDgJoV7Oik9N7ENBP6xQCtFB2OpsexxP6HvCkqNvNKszinzCCASBQ5JARakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178914; c=relaxed/simple;
	bh=gOoonUpRqPNjkNQ4QpxIoYxN7kGTACv6RWczqVQsTyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHTh8qDhmrWUlyd5QH91bILV9HUpoyfrXF56KOuv8Mo7T9C2gNoXoc20O6MG2aQGgxxBix52/OG/lOih14U3BsUkJcPQ+wXTGKxpM8nOu1Db4c0MTvVhjxZNock6H80JL+Y1hCaZsIU1GzKf01nwNQUtSdwE0BdQJi9qx+Nxss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tw78+aD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmJ56wTB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tw78+aD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmJ56wTB"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741178911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOoonUpRqPNjkNQ4QpxIoYxN7kGTACv6RWczqVQsTyA=;
	b=Tw78+aD2h4Q9bJxkPET5ggTa0QOFh7B77Nmks06j5mAbVWcNFNVap3iMchhvravH5Q91wO
	apwsgFcp/8WB1IoHmJRjs+C9AZSgjweHdzptvazFiOEABNKOImRQBgejoMiRr9eQAjg89I
	csJ6iv+lD26eTKcCm5TNs9rBCDsI6UxsGMedLoPiDEr2GKAppOqZOlgz1bBK8YKwENu5LK
	8q6ixkDUbCoRZGmMOcv8obqfEcB+s3Nnx6gzyFm9/JhX4JTWwYDFP3Wo9Q3nZYBhVZhDSl
	ND4dGQQDWXEKfsb3XbTw8AiwGnxLckKAY86xlUcypC0c1mSwmWNm78bDWl7bHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741178911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOoonUpRqPNjkNQ4QpxIoYxN7kGTACv6RWczqVQsTyA=;
	b=fmJ56wTB1MtRovyNVQEoH5tvswtVy3ruIssA+yqjmGNDv4QDUm3QYMDYGjoIwmnB0Uf4Zp
	2Kuaj9lNmt0kEXAQ==
To: Valentin Schneider <vschneid@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Galbraith <efault@gmx.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Collingbourne <pcc@google.com>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Thiago Jung Bauermann
 <thiago.bauermann@linaro.org>, Mark Brown <broonie@kernel.org>, Kristina
 Martsenko <kristina.martsenko@arm.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Petr Tesarik <ptesarik@suse.com>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Juri Lelli <juri.lelli@redhat.com>, Phil Auld
 <pauld@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
In-Reply-To: <20250305104925.189198-2-vschneid@redhat.com>
References: <20250305104925.189198-1-vschneid@redhat.com>
 <20250305104925.189198-2-vschneid@redhat.com>
Date: Wed, 05 Mar 2025 13:48:30 +0100
Message-ID: <87cyev63tt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 05 2025 at 11:49, Valentin Schneider wrote:
> From: Mark Rutland <mark.rutland@arm.com>
>
> For an architecture to enable CONFIG_ARCH_HAS_RESCHED_LAZY, two things are
> required:
> 1) Adding a TIF_NEED_RESCHED_LAZY flag definition
> 2) Checking for TIF_NEED_RESCHED_LAZY in the appropriate locations
>
> 2) is handled in a generic manner by CONFIG_GENERIC_ENTRY, which isn't
> (yet) implemented for arm64. However, outside of core scheduler code,
> TIF_NEED_RESCHED_LAZY only needs to be checked on a kernel exit, meaning:
> o return/entry to userspace.
> o return/entry to guest.
>
> The return/entry to a guest is all handled by xfer_to_guest_mode_handle_work()
> which already does the right thing, so it can be left as-is.
>
> arm64 doesn't use common entry's exit_to_user_mode_prepare(), so update its
> return to user path to check for TIF_NEED_RESCHED_LAZY and call into
> schedule() accordingly.
>
> Link: https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/
> Link: https://lore.kernel.org/all/xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb/
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [testdrive, _TIF_WORK_MASK fixlet and changelog.]
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> [Another round of testing; changelog faff]
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
