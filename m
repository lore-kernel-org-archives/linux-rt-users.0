Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5136165F;
	Mon, 12 Jan 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233179; cv=none; b=KNi3b8bFM379fS9wacKYar8GZEzbX1B/IPbvuZtOl2UOZnbri+Xsj9HaLqnTTNzPreKVb5iRX9ysC81UMBHb68H01l/Uglq+oRyI2G52504QQfrHLRGdvwIAyMSjoWyHwzqRwGDZvuTOY+P2GzOZ4HiaXviByBpSfD0hWddSIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233179; c=relaxed/simple;
	bh=Ho7KHXzb7E6ybZjiRxvINuVsOzkJ93vp85ztYVFy2OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anl2/7hFg/F7VwKIdStcc4+pwxuBXm0ItQenzoOwq4V2M99TVqYBBuq5rBRM0V8mVbheNevd4wriVH9AOkD/HPyliSTufY0iJJ3TUGrd1B/yWBdo69P/NHQZW+KHoLQ9gdHwRFIF9cKR2TC3qgRoM5RanMzCwQ/yCb3WUOUhOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zrv6I0vm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3K+aBvu9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zrv6I0vm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3K+aBvu9"
Date: Mon, 12 Jan 2026 16:52:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768233176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0whIEjQ36BYOJiilgz9fG6i2v5OA3oYCLKr6a32UybI=;
	b=zrv6I0vmmrvUBhRUjbFEY41sjrqU7FEYqBBO7EkHvkBJQ2l3FNeyA84sgygVdP76rTyEkX
	Ho3lHXt3gKvFvZf3EXSs1JzfuyKQHdYuQRaSLcvWLlxykzE2xNgjfXVWpMDgICqzRVNjOx
	WIlAC8GU6FrzuCh7FWnzf098C2lp/Yk3faVcib6ItIUIxqnBCKHx6UX2/YU6hM8JuGYqHl
	dxkPQP+oCsoQiGWDwbx2nqoGfyUXDXMVSPcNUFs/AZ29NiJEwqbjSgsOXpRdzQnqPS8Pj9
	e8hCEVe1xTSiNp8YzzsXznQ8zoP14MLyYEzVJ6RnwWhjORW2V58/UUKFBONLFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768233176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0whIEjQ36BYOJiilgz9fG6i2v5OA3oYCLKr6a32UybI=;
	b=3K+aBvu9ioH0Q8Jxb/y7z2XUF/pKEXGbFt75RwLGVRiBj0ICSWZVZFTvF1phep0VO8ntAO
	AVQq3YDp/F2vBhCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tom Zanussi <zanussi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Daniel Wagner <wagi@monom.org>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: Re: [ANNOUNCE] 5.4.302-rt104 (EOL)
Message-ID: <20260112155255.hF_ym_Eh@linutronix.de>
References: <6c6f82df4569575b1da86c29504c5840d2c63ec5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c6f82df4569575b1da86c29504c5840d2c63ec5.camel@kernel.org>

On 2025-12-19 16:41:50 [-0600], Tom Zanussi wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 5.4.302-rt104 stable release.
> 
> This release is just an update to the new stable 5.4.302
> version and no RT specific changes have been made.
> 
> NOTE: This is the final 5.4 stable-rt kernel. Because the upstream 5.4
> stable kernel has reached end-of-life, so now has the 5.4 stable-rt
> kernel, as expected.

I updated the wiki. Thank you for work.

Sebastian
