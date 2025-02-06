Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334361FECBD
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843261; cv=none; b=Napb098hfRRhyJ2lGJPX7a/0j73O0mMbesqrrV93iz68hLucxc4QimEFu3LXUAODMesmc8ario1Eut22BA4IwMUaCn6XO5cPME4fdMuV2oxNJyJANpsv1RCjDqlIKjBEHvUGmqEUvL7haXPtMxg44ZcjriIYrguTWEp6JbbTglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843261; c=relaxed/simple;
	bh=FXFz0x/x1XWCl7vNv7G6TvbUmRlTQSPGQAnh06BDw4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzCXHl8q2GP1ctRUJizXMDMXAwt94JNJJvgO9UZHl7hOnfv/0YGrquB4U4IdYck4QzFREbV/E8fGJ2Flwt+MtAdLjBSGH87vul4PlN+sFKQqB25K5a2uYxesOQw5cHsbydyhhLZEvHy1f1SrJ83HtbDnr4omsu2ZLj13lFAKtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XPqfqbu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CyFwCF1q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XPqfqbu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CyFwCF1q"
Date: Thu, 6 Feb 2025 13:00:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738843258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFz0x/x1XWCl7vNv7G6TvbUmRlTQSPGQAnh06BDw4c=;
	b=3XPqfqbuzqBeecRmgHhXyiep1wvqUMsxLdkhfBeSQjdI7QWWgWrXo20O+jkpAuEHVhkJQA
	ERnZp8h/lnkG2etfCYbu0Ehi5t6VbczUG2GiIkMxWmp2iNja7eww8/4434EFY9/paVwNoR
	Lu5ESeo0/NNut69gW9EAfBQiG5mvJi5epS9ostgp27+7OW0k6Q6TDPElcsVsK0Ac47HTHh
	/T8T3joM2XWYwtdd5KGvgMhbpJHzzX5pbNNHrbgLp2gp9AibIOyAaKnOcqyI6ZyZixsXVZ
	Ytx6pHUxXPFS3+Q5nNQRHcXBEKPBJ/rHgYsM7yV5hOBGJwgpc8uwhBju49/cwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738843258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFz0x/x1XWCl7vNv7G6TvbUmRlTQSPGQAnh06BDw4c=;
	b=CyFwCF1qUi8ZnfxZfQHJL5/mwhrxOuYPgdOhirrTLtXHBDK8JsfuC5RVrG4CtoPEI2dRAu
	Fjsh7IJqANsE/6AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rafael Folco <rfolco@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] Change min/max to float numbers
Message-ID: <20250206120056.oE88fgG6@linutronix.de>
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>

On 2025-02-06 06:16:22 [-0300], Rafael Folco wrote:
> Make min/max consistent with avg by recording the latency samples
> as float numbers instead of integers.

Why?

> Signed-off-by: Rafael Folco <rfolco@redhat.com>

Sebastian
