Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0A1E0E1A
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498068; cv=none; b=tvioRCZQ4UCfVqEMbsrXMbK1xTKweOmuWLyhT+SvPq1dbB+pVUk26UufdSpJLyn9lnQHDSxs/94aYVcJWDxsziuTbzKa9TltLGD+NgyY9Ur8EcdzKdRCt6tSKd5XF7EFCX9cgi73GOgmSaZyWfGqDwsvPZLvd0QeyQ8bDhgvc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498068; c=relaxed/simple;
	bh=HJebxIOWqulUILVGjqu27KiDCEaeGOn0LLtKW/bGf5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8C5t+d/SxpVx3jx5Um8rTsj5F0v4ruFwfFZmPkz2iZgDJOzdLvy73+bsGU3VnseU7AD47WcNdaFFb/ALvjYLJTQs6vX5l7GLu7k6laVQiXCxXE8HbzEwZKpmmbe8AauKGh0RpRAqzU++Wozz85uHIYL/LVw8q40ic4QAOCejTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qA9wFFF8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/3gSDqW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qA9wFFF8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/3gSDqW"
Date: Mon, 14 Jul 2025 15:01:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752498065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJebxIOWqulUILVGjqu27KiDCEaeGOn0LLtKW/bGf5U=;
	b=qA9wFFF8dAH/S7bSSJ4er7vSeCC0vgZArI30GANbmvYJyiD/FSTXVC4ppqg3SysJH4/QPs
	D9Mp7sbC72y1KgfRt1XQlnMxOojQDdbFf1cWHssvG9F80QYr2aUbX4QoUiJkgi7aGiJ+gC
	l8o/hKnDkCj2aTHE1i+UXH5XvYBw/mEocyFYrZTsZf4G17T8BNXFLQVaK5z34iNXuDCcL/
	4l/pyFj3V8yyFcOAC6O2qVeTCPSoL6U26zbNTeiHfBfQzfaScrng1NOYg2sCR1LwC+TeBE
	4oXtyNAp6mGx4b2vtJ4hdxjNju5rhc59a0G5J28gEYjVEisnPNqjd76YpTVWwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752498065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJebxIOWqulUILVGjqu27KiDCEaeGOn0LLtKW/bGf5U=;
	b=m/3gSDqWhbMGN8GpvZdJ2BdBj1A3oWU9ZJJxanQKBLXSEX3cWX5b59WRK2KFL6+tzBFga5
	2TMjJ4F24ufOFdBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 00/28] rt-tests: Rework cyclictest manpage
Message-ID: <20250714130104.29nUrEeQ@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>

On 2025-07-04 15:26:53 [+0200], Ahmed S. Darwish wrote:
> Hi,
Hi,

> This series provides much needed bugfixes, cleanups, and updates to the
> cyclictest(1) manpage.

I would merge the "remove $X" flag patches. It is a few times the same
thing.
Then you have update troff syntax, re-grouping options and then you
extend a few/ update them.

Given how difficult it seems to be to write these things I would suggest
to either switch to asciidoc or pandoc and let one of the tools
generate the man page and/or html from it.

perf uses asciidoc while rtla uses rst2man. I don't care which one of
these is used but after I saw the cleanup I think it is easier for
maintenance to use one of these simple tools.

Therefore I would suggest to write a new page for cyclictest based on
what we have after content wise after #28, let rt-tests generate the
man-page from it, remove the current man-page.

John, Ahmed ?

Sebastian
