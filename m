Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C862446052;
	Tue, 25 Aug 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661902; cv=none; b=S6Iv0arBZM/U/WG0BLk7rEKNsb7xBf7eq/TfCR/zUIVoJPu4DSaMrLhGNRd6cQ5UCMoW2AabsGNW3rEOihX/TLWCxRfcPsR0YJ5J+igPwX3d3dRYfuN4PIHsM2S1K2R2DrLkPWUcbBHb9BXjKb95B0ZrEzRsAsoA9N/uIFxYWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661902; c=relaxed/simple;
	bh=2WBa5yL+7vSgKX+cxpFmOw86WRi1VKisk1YblekmpM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHPffxXe9xLPpwyPEKFKQMHWDaesgXBU7kqk9BCx/oJB8sIubLC19eXMuxiLY02KyFPSqZSDol34R76ZxgH+0gZFTwD8ozQ7EtVZzC4hJbhmIblTmQCKXmnC41mCOPLuuNsC2Vb5cwfjaOMb4EOKAvw/KvyUr1U+ajN5tqOxtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqyaP5H5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Q+SsUnk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqyaP5H5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Q+SsUnk"
Date: Tue, 25 Aug 2026 14:44:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787661894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hL0wB/AdivBKbKIpjc5ZJrroaiZ2UbAuMgPZt+oESDg=;
	b=TqyaP5H5MiRq5LvtqGxqBP2Dy6EKxCnx+uGxoHY2PZ4NBLuTm2nA7bEbVRhOK3mpxK8gLg
	JJDMDJiRiUeOpJ6gwWba/e2CdoHYbNYuq5Lvj0oWp1SdB/CPqMHb2G9C1EJ1dag6KBSPnL
	xrTG+Q90KrgHyC4yNcp8gmiHlmmftIk560UvNPPxQ+25EsliTFBB2zM0L5tfnT4wE0Yi7H
	n+JO9w2556IAEtUvp7fnP5K+NuIWy4Bg+aPGK/gt20tl2rqyQzcWXpITO1TDLci06Bg2nE
	WZ7IAG77gRgRxiAjA7aTuFDikj1BzUG6CSnWig68/ZUaBxn6OKeEk5f44+K+WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787661894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hL0wB/AdivBKbKIpjc5ZJrroaiZ2UbAuMgPZt+oESDg=;
	b=/Q+SsUnk/JXO93T3zPJW1z6hTQdhNB3qPad/8fQnH8sJ653ch9QCk+dhWy01lrrsacDyBW
	0VHUWw4Hv4XmKcDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	Mike Schanne <mschanne@kns.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Message-ID: <20260825124453.INbPSgYf@linutronix.de>
References: <TY0PR0101MB48672132B8525B7B39565EE4D2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>
 <20260819150611.xWELTqJ-@linutronix.de>
 <5943e7e5-9578-42a1-b693-d79f9eef88f0@alliedtelesis.co.nz>
 <20260820141222.gPkfKLpT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820141222.gPkfKLpT@linutronix.de>

On 2026-08-20 16:12:22 [+0200], To Chris Packham wrote:
> 
> If so, you realize that uio_interrupt_handler() isn't called at all?

Mike could you please post a patch which reverts f8a27dfa4b82d ("uio:
use threaded interrupts") because

- it breaks the threadirqs case including PREEMPT_RT 
- I doubt that it solved the reported problem because it does not invoke
  the primary handler of UIO at all because it gets overwritten to
  irq_nested_primary_handler().

As for the Chris case, I would suggest to check the IRQ for
irq_settings_is_nested_thread() and then use request_threaded_irq().

Sebastian
