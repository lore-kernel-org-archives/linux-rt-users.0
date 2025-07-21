Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8F1F8690
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119753; cv=none; b=cJ4GVpTDlNVBXI8yTqby7tM/B/nVhVW4DwgJwOgJbF9ewT2rNik7ZUHC5wsHTcw7rquBUegpjv0wSoCoUzX7z/vPWfdUncopnqGIVYEdsWjwhfGEsVZNpZeqFg2rouTOY9lauU14hvaso3g+2JilGsGUE1IMMfVeUenw2+Uu4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119753; c=relaxed/simple;
	bh=HwaaoQ9x6IkC65OazTXaietVG+4Cb//QRTAkntD+9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaQS0h4pZe4GQLrwdbOO+4TqBCOV9wLUE5hthDNpSLoh+W0p/FiMt6ltBFwJg9/USy/83A2gE95qPeO/Cv3ujCo6U46MECl6IpbUuETv61IO33WEtVlk9V3cnzAsWBqV9pROb5m+Q1v9ZVGNxXd1Rol3rNbjb+y4bkw92FmyjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXdwvofI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fc9yxuEw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXdwvofI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fc9yxuEw"
Date: Mon, 21 Jul 2025 19:42:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753119750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwaaoQ9x6IkC65OazTXaietVG+4Cb//QRTAkntD+9Wk=;
	b=AXdwvofIXlo1WzRPHLqMWp9Y4yUbuWwjI3gg6rXkceNnf97XYs07nlizpgDeqPgalmXvPS
	avnGnJJPb+rs5i2jFPUwL+hJy2GnCSRCEANIvNSLnrI4uZL7kc1fIVcSST+su9ZMKe04el
	wXUfOQ+IQoO2RHEZeBaLnSN4vhFmMFo7ImfkRlBn8HpEFHuN/oXD0M19YMxLwl8OSSNiVw
	9UDmj4yFboYhAawWfWfdB58ziwZWo1qq4KKgag06q/MnTGVfHgDhyeeTqLpTpFtgDl3YfH
	ofJD/9cPmaINHh2blE8SJNTQ2Jpbi4v0H9PpeuZ1JZGrA55geWqQu96mkSn5Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753119750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwaaoQ9x6IkC65OazTXaietVG+4Cb//QRTAkntD+9Wk=;
	b=Fc9yxuEwWZZdhyig/vR/GOSPI4DcFshiB/HPd6PN2zmrl2Qawn6chEZvH+giljibyYWSBe
	Wqf9JUEym92GtTBA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 02/28] cyclictest.8: Synopsis: Remove -U
Message-ID: <aH58BNMiXZj8rqFh@lx-t490>
References: <20250704132721.13325-1-darwi@linutronix.de>
 <20250704132721.13325-3-darwi@linutronix.de>
 <08edd7fc-a9d4-87cc-9c3e-7aa135c8d15a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08edd7fc-a9d4-87cc-9c3e-7aa135c8d15a@redhat.com>

On Mon, 21 Jul 2025, John Kacur wrote:
>
> On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:
>
> > Commit 7ea837b01d7e ("rt-tests: cyclictest: Remove numa from help")
> > removed --numa from the manpage but forgot to remove its shorthand, -U.
> >
> > Remove it.
...
> > -[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
> > +[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ]"
>
> But don't remove -S
>

Correct; will do.

Thanks,
Ahmed
