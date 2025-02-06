Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE161A5B9B
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854592; cv=none; b=SOcB/FptK03Ie8gT98W4nI9JB+1mjbUuIZ23X00tTu8xTSYYZ81u8pzwC7XE1s1rQ7VdlUBbaLrQI7rE+QR+ceFHmHiqyxaR4uSBODniFvXxQPgN2SA7BW8G7tN6QMyVW2SYBTfhHYUriUN1OuPfG+esccjMaxLrGGuQI11Tv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854592; c=relaxed/simple;
	bh=EejfCkVkeeCcbh+PhP21ab3P9tWxyv3EbSmAysnIoow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW9A3zEpzArhaofqobdG5PnhAaXCAKmJw/wN4fH6hWCMn+dRDEvMFjuwVorrpKN3uuvpaXLQY+lINZMcjb5QH5HEKUEDdTpwfGSLR2Jn5tTzPv8qm6FYcZPe8dMWiyHh/JS1JDD6/QnFsOHcRlUZk+zSltYeAObbxiT85aeJHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMjWx4b5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLI1JlEi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMjWx4b5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLI1JlEi"
Date: Thu, 6 Feb 2025 16:09:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738854589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkFaycUjWhuAG6zZ7CBCI3dvxdGHyKItFLDQeYWT/dE=;
	b=LMjWx4b5H8xzkUzWXlVivkDJDTnUHAT+bBUo5N+7OW6VORQcC6n7bksQogzIdr3LNsCCw9
	wh0OnAhEjM7RT6ZreVXljHmVbTQHIBozWAEOphVRRPd/vtsDTyVd9iTjST72DUtYLbNXbk
	731q2HB8HfLHcjd/3w0/SZYmkQIz4q40MbkqmczgVq2FvDOeC/se0pytMR8L3JD0KWAWUe
	bA94d6r5sisfOPc8totz5WF3FgzJ4AlrhFlG1FKdCDJXLb1kNjFfZUm85GgYn25lIEvgWD
	tgeMSGge6+cYHMyRKfjqXdp6EN3ulVvpL2xCR0cYI/gpgL4okNQ/4cyta4U3DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738854589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkFaycUjWhuAG6zZ7CBCI3dvxdGHyKItFLDQeYWT/dE=;
	b=fLI1JlEigWdF3eGf3f68t/hvUSQb4hmfw+I7EzC87RKYT9EFHPtWoC6l+kHMYZ75NIAp9w
	xmymsjjw+oqvHKBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rafael Folco <rfolco@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] Change min/max to float numbers
Message-ID: <20250206150947.GYesymE5@linutronix.de>
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
 <20250206120056.oE88fgG6@linutronix.de>
 <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>

On 2025-02-06 12:02:49 [-0300], Rafael Folco wrote:
> On 06/02/25 09:00, Sebastian Andrzej Siewior wrote:
> > On 2025-02-06 06:16:22 [-0300], Rafael Folco wrote:
> >> Make min/max consistent with avg by recording the latency samples
> >> as float numbers instead of integers.
> > 
> > Why?
> 
> - More precise numbers of Max/Min for extreme low latency cases
> - Distinguish zero latency in bucket 001 (us)
> - Distinguish values from upper/lower boundaries in a bucket
> - Clarify confusion on average (round up) vs maximum in the next bucket (casting)
> 
> Instead of:
>         Core:    3 4 5
> Counter Freq:    2100 2100 2100 (MHz)
>     001 (us):    14880514 14880447 14880442
>     002 (us):    0 0 0
>     003 (us):    0 0 0
>     004 (us):    0 0 0
>     005 (us):    0 0 0 (including overflows)
>      Minimum:    0 0 0 (us)
>      Average:    1.000 1.000 1.000 (us)
>      Maximum:    0 0 0 (us)
>      Max-Min:    0 0 0 (us)
> 
> We'd see:
>         Core:    3 4 5
> Counter Freq:    2100 2100 2100 (MHz)
>     001 (us):    12578842 12491108 12578752
>     002 (us):    0 0 0
>     003 (us):    0 0 0
>     004 (us):    0 0 0
>     005 (us):    0 0 0 (including overflows)
>      Minimum:    0.033 0.035 0.035 (us)
>      Average:    1.000 1.000 1.000 (us)
>      Maximum:    0.129 0.153 0.134 (us)
>      Max-Min:    0.095 0.118 0.099 (us)

so core 3 has min 33ns and max 129ns while 1us on average?

Sebastian
