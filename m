Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4220C499;
	Wed,  5 Mar 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172818; cv=none; b=Xa4wFtfa1npeOhbElFJEp56pMk3ne0C2A0Glqjk5UL6bJwYeaacxXhSbFVK6Quhpgj+C3M9ygvKGD+XRnXt62+10nqUKBS3oDeoPNtGVYIeMyZLY7FEd9zWxYQC0hnN2KYO2oqsyhvwKn9HT1MHUew6DbdgGejsGuCrzF2hlFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172818; c=relaxed/simple;
	bh=JKE1Po9EYSj06r8hdyzALVX80J+1kWHUeRpZ5TugQow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHFTDwagCqFiYsnz+rDmB3fXhiRrg8YPCNN9gTgLR76WaC17NgINe47DZ3uTW3kxx0fKPuFGAHo3bfFSTV/76f9w9W4DsS7dn2hNMzdlzOnpUHGkeCl7xhbYCWCtuhEEYtUgxgMFvnHs2kJg2A3dDlsS53S6ZICiBU6ca+K3Hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOrDYa7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DIlPIwOm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOrDYa7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DIlPIwOm"
Date: Wed, 5 Mar 2025 12:06:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741172813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRDDORjE6c+3nRL9vKLH4Ti8p7Y+SPyMQXlyJKMzRy0=;
	b=FOrDYa7eQN2jlxC7ytKE6bZhjfO/OBUqgLqGbkrFA5fvTVCt2scQkvIpVo8XEzaGPVUqIW
	ImijYvC//gJbvhgeN8kvEURLP/h/uOk5Dcp9Gx6cM7bfuRHTzaIB9hTgux+SDY9NeKWtXi
	sBUHAtMZ1RiufG8mqzdHHmd1wm6G9xn1AiBdj0W5JrgmKjqvcCv92hRxrWBrXm5VLB/15m
	+1mmCCJyIzlEgIwDdwmP3IlYcfUckjEV4+3yeAcQXWXuFzfA89Rp/HvLYn/ax/sLtQ/jtK
	QQcZXkoLtUwTX9yl95joOSLvJfl/eEUc2gSpLu330aRnwkyFAIfa3VGdZPGz3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741172813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRDDORjE6c+3nRL9vKLH4Ti8p7Y+SPyMQXlyJKMzRy0=;
	b=DIlPIwOmLWYvROvTLasNI3rDu4PycI1v0bprCTpjbEZIK4uMe5rJo/G29nDf/j3Fa05igb
	QUSO4Nm56ZoZU9DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Mike Galbraith <efault@gmx.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250305110651.6dpe0xQU@linutronix.de>
References: <20250305104925.189198-1-vschneid@redhat.com>
 <20250305104925.189198-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305104925.189198-2-vschneid@redhat.com>

On 2025-03-05 11:49:25 [+0100], Valentin Schneider wrote:
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

I somehow assumed it was already merged. For what it is worth, this
looks like patch Mike posted in
	https://lore.kernel.org/a198a7dd9076f97b89d8882bb249b3bf303564ef.camel@gmx.de

and tested 

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
