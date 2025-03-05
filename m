Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666F24A078
	for <linux-rt-users@vger.kernel.org>; Wed,  5 Mar 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183412; cv=none; b=YEhiQMxtOZxO/Bvc3J1nKPA85J1U5KASo0n5Z7At84ucmkq45SrxpsZQwu77OjXi3Rvz+EUIQqlwy7pTUZNqV05VyAkKoAEk9HczkMGMp6Y3zhE9oh+uuBQmpUXwMabXHeZ06Ft7BGSfVOxdHJoxklOBUUlqF7zTmNxICmzhz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183412; c=relaxed/simple;
	bh=sv6VA9jZbZw6WMtYHKC0o2WYuG3v8NlBMXTC63Ue7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcg8XgzQWzkR3jEpTNOx/nxRDq4Mz83m0y7ToqZ/3BbO/4dg/TyIKpCqzJpg7s/7g5G/b6CIMyF0UhLWL1RuemU78Ee8JhPxwEPOO8PKPAQr8HTOgN34PQUUAJmVjuFjI32R+Euh7nZKZW+JU7xpsajSL9eV/8HnipaFFNE7Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKk5+JGI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKk5+JGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741183409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvisxEEy81f8Soxzl6LcxPAISbi6nfCZztRfmoSPzA4=;
	b=BKk5+JGIg9v2yKcCW/AMq1slNOrZIHvfhtCMJJ1gLMrrrN/eaCaJ1SvcXn1CUoNG1WXMxY
	cV7ssCkyFHKB/BdixtG8XiPRxfjDmdk+hjLyUV4g7u7aU1BhT4nlvDmciRrJp+bv16Wt5t
	XUP81TdlkaS5o/on1xhjyxRY/Iv25ss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-loh_HRQfNGyVhwp5Ef8Ebw-1; Wed,
 05 Mar 2025 09:03:23 -0500
X-MC-Unique: loh_HRQfNGyVhwp5Ef8Ebw-1
X-Mimecast-MFC-AGG-ID: loh_HRQfNGyVhwp5Ef8Ebw_1741183393
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12AE01954226;
	Wed,  5 Mar 2025 14:03:13 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.55])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 686A41954B32;
	Wed,  5 Mar 2025 14:03:08 +0000 (UTC)
Date: Wed, 5 Mar 2025 09:03:05 -0500
From: Phil Auld <pauld@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
	Peter Collingbourne <pcc@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 0/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250305140305.GA51446@pauld.westford.csb>
References: <20250305104925.189198-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305104925.189198-1-vschneid@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Mar 05, 2025 at 11:49:24AM +0100 Valentin Schneider wrote:
> Hey folks,
> 
> This is a resubmission of Mark's patch [1]. I didn't end up changing anything
> other than fluffing up the changelog.
> 
> I ran this under an arm64 VM, added some trace_printk's and checked that
> sched_switch's between runnable hackbench threads would occurr in the right
> conditions:
> o with TIF_NEED_RESCHED_LAZY set
>   o at the tick
>   o at do_notify_resume()
> o with TIF_NEED_RESCHED set  
> 
> [1]: https://lore.kernel.org/linux-rt-users/Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com/
>

Thanks!  I was looking for this the other day :) 


Cheers,
Phil

> Cheers,
> Valentin
> 
> Mark Rutland (1):
>   arm64: enable PREEMPT_LAZY
> 
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/thread_info.h | 16 +++++++++-------
>  arch/arm64/kernel/entry-common.c     |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> --
> 2.43.0
> 

-- 

