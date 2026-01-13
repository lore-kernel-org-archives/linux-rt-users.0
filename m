Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588236B066
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302893; cv=none; b=DHEwdzkULDUv1SoWvpf+G5nXJm8raLC+f9gXu9nXTtPCqxN3XB+qJ5gbJbgBM/8SfcIbSIdBYnIIwK9diJP/ktV8pt8MOwCy0Q85jZFVPUk2jP9MZvcxTje5WgWuiJtqFG/AP3gzqXfzGJpO5pZBQ+/Kux9YTVwdMEpHKqq3ZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302893; c=relaxed/simple;
	bh=z9PQMobsP2niKMvCqnAi8eDmDvJQLGwmjObS2pcGJcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzOHbxV3LIwfBLvDVqzqgYdQRuajq9JOeEM+yKEous+TnaXGfv4UfGuyT6qlJ+3rAlrGgU+Xejceuwh51FXQKUnQ8dOqUncJ7cF1eP/Obt5MKDAhY/HYufy5Y5XVjtdixykSas8UT79io9SU6VjNZwjuFXAktRQx2MfMRfGetes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuwJml6w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nE8QCjh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuwJml6w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nE8QCjh"
Date: Tue, 13 Jan 2026 12:14:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768302890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mXsn1kNiDbOrsi2AXXfvcJiwoiu/B91GZI7M7296r0=;
	b=QuwJml6wl7gz63JpSyY2z7LGeI3u3lidWWPBl7956gGhQ2FeKga98pxDDReFYbw2XaeK7y
	Qi+ljBmvksb7JF/06zHe51Byaz5W1Zb0YsPSZwLBgomsp+hgtnwBDwYLi7eUQ2LMgnEKKu
	p6qXwueGVvjWm00LGamIqq77PIu+ZtjQBPedv0frOovk0muWz7uSAj0dnH84gIgHPr8x0i
	4FDT0PkJpTzuqdyvTfIGtKsqo5XymfcrxjPPx8r1cuc1wMjYatakhUxirNnFG6M5gug/p+
	zeZPlBPvCrrxNvxJyGUVcLsZs8rhUCxGIYJP56l2fYnBtdYU8joVy3lxk5Eekg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768302890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mXsn1kNiDbOrsi2AXXfvcJiwoiu/B91GZI7M7296r0=;
	b=1nE8QCjhaFb6Zn4A+AXddzG/Autzbx+qxH+//IWFNqckG9tmUUfzzUu4bntgARyqJFZ25u
	JRqG/OpmfKc9c1Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from
 long_options
Message-ID: <20260113111449.ULgrZN6N@linutronix.de>
References: <20260110113738.2376456-1-costa.shul@redhat.com>
 <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
 <20260113081300.s3s115wU@linutronix.de>
 <CADDUTFxQHSP1VWqEG1ksL7sOoTOKkjXmz=JP3_HPWajz07GjoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADDUTFxQHSP1VWqEG1ksL7sOoTOKkjXmz=JP3_HPWajz07GjoA@mail.gmail.com>

On 2026-01-13 12:00:29 [+0200], Costa Shulyupin wrote:
> On Tue, 13 Jan 2026 at 10:13, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > GNU ARGP might be easier to parse and maintain in the long run
> > especially if 20 other options are added.
> >         https://www.gnu.org/software/libc/manual/html_node/Argp-Example-4.html
> 
> It looks impossible to port to ARGP without CLI change: cyclictest has
> options with optional arguments (e.g., -a can mean 'use all CPUs' or
> -a 0,2,4 means 'use specific CPUs'). ARGP handles these differently
> than getopt_long.

I see. It looked nice and I assumed it supports the same features. But
if optional arguments to options are not supported then it is probably
not doable.

> Costa
Sebastian
