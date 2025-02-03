Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EE2040B5
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Feb 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588957; cv=none; b=etiHiDLgeeROKmTIl4S90J+J69nLPTUn34xWXwxhTNzOETf6LnTPCQvbMMMIaSlOMQDNShQtYP41aRp1pjU/S6+TktOAq4nqgJHQ6egDc48ODAPVuwdTgSsbmDQQVKC352XzQtKLzSaziJ/3AEpLXXo4aYQBPxz+frrpfBzzUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588957; c=relaxed/simple;
	bh=rxNHpkpijV++bwhmdk1EdqJS1SUZ2KpkUZbX/slEBQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y29QsXNyRLM2aKl3vQUcVkpahD6F5ykNMYzRGBgEDfSFhC1unXauD9A0Y2UiPn8C9gYPtG4V3ztn/T3se42ne5x4XYVnKzQRruzv/3VNFo1vZLh46RNsRIxU5JOsVuGV2a0YPTiTXECm0E++CiihANhG2+mXInZwEJ0MF0+SI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNRPX6Wf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvv3tIpZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNRPX6Wf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvv3tIpZ"
Date: Mon, 3 Feb 2025 14:22:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738588954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqKFOIcs99K7gmszyCiupumTsscMRyUSiWHW0l3tNKU=;
	b=sNRPX6WfM5qYZI5Opah+fsUKgaYRFnjZ8ENyBLhvKW8vAtL2SyoJ+xrvHtujjIzw33qc4V
	TjuaEQId5CyDkMahVdqrh2SGI8bI6Gpu9M4wJ5GvzmqYuTF5ha542mzD9mxzbtlLEvEq+a
	06e2Vt+FkeDdntgVnY9q8lUhOu2o47q9xyIEfXt6EmJbJrHZBwqkbKCkvGsYlPBmTSIXww
	jyb/Fnf/edib5c0RFGkrJ8MT8uH89O34mNgkWlNUbJh0AJAbyIERgWDvE7MUshWjfbnpPv
	9pEeWsNTtp/GM7vxYS8pBz9AufJlNy2NMgAQ3dJa4Bgvtm1tSnFHLfSHKnVbPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738588954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqKFOIcs99K7gmszyCiupumTsscMRyUSiWHW0l3tNKU=;
	b=gvv3tIpZI4iLUaz6Sa3O29ETGWUfH0kgAfFoyLvjz6+TZgBzkZLTQARS8xUrlcPmxymdeV
	1+b9Wb12h8QrbQBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Jillian Donahue <jilliandonahue58@gmail.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petesarik@suse.de>,
	linux-rt-users@vger.kernel.org
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
Message-ID: <20250203132232.ZLq9fj5q@linutronix.de>
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz>
 <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de>
 <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
 <20250130075026.RVen6mGf@linutronix.de>
 <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
 <Z6C6ZHQh3jc_iJLk@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6C6ZHQh3jc_iJLk@uudg.org>

On 2025-02-03 09:45:24 [-0300], Luis Claudio R. Goncalves wrote:
> On Fri, Jan 31, 2025 at 12:08:01PM -0700, Jillian Donahue wrote:
> > Thanks again for your time. Here is the request patch:
> 
> Sebastian, do you envision this as a patch to be carried by v5.10-rt or a
> patch to stable v5.10?
> 
> In any case, Jillian, would you mind adding a description to your patch? No
> matter who will take the patch (Greg or myself), a description is required.
> One or two paragraphs summarizing the problem and/or the solution.

Jillian, could you please follow
	https://docs.kernel.org/process/submitting-patches.html

The Fixes tag should be
   Fixes:  d5daf49b58661 ("USB: gadget: midi: add midi function driver")

I suggest that this is posted upstream and applied there, backported as
a fix via the official stable tree. As I mentioned this is not
PREEMPT_RT specific.

> Thanks in advance!
> Luis

Sebastian
