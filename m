Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A815B10F
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Aug 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801473; cv=none; b=iTpydLjFKNqD0D11T/i12FN4e9Pw/XJkw0L+OOOmJO5zU8hwJuDJtJClqOqkAXsp/35SMJyxWEHftkJLQD0IqeV0b+omF5XtfnmxU6k7mCG9/CCyrg2DClOFCb2dLVsm0NV5ZtWcDrBKa8QxAg+HiJr+6At/YdQ2TFzjyTIIQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801473; c=relaxed/simple;
	bh=hjbUNrLnd5vQRd8aCRV371SPrUbF8JZ6o3tHat1Haz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y54wXpFFqweluczui7C6bkUuRowRTtKeSfi7oHOP+8TgVvFGcvC7do5/UvBTzvuoe99NYGFFlRDrg522Pa0zZ5ZPMVSEGdJ3yVtHKthnOGTsAhiDWrR94nJXE+/D+S559h9bSiXFWy7NrvCuYghxCbS4kdtgrXA5u5KP3gRmR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnW6I7uE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnW6I7uE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723801471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zf6bZ6YOr3Fi5nSGy+L5xdOXCxmwUrt+Bd86dMWpelk=;
	b=WnW6I7uE+VkKlCcRjGb4YbFMgBQQiYAvy0tk1KLFiaiOinI61MeOXHn0SgQ6MGBic7pCDE
	OJprjsVTcHQkEluSf/4/6HNd8hqgngT/KZjF9n8nYzOm5lcnc70RXjjA6RN6S0n3zegVON
	nrcjz61NHW3fRCohLy1waTyyI+o0Riw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-vJtIwotaPiynDUTcXXrgOg-1; Fri,
 16 Aug 2024 05:44:26 -0400
X-MC-Unique: vJtIwotaPiynDUTcXXrgOg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308D31955D55;
	Fri, 16 Aug 2024 09:44:24 +0000 (UTC)
Received: from localhost (unknown [10.22.8.106])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C59219560A3;
	Fri, 16 Aug 2024 09:44:22 +0000 (UTC)
Date: Fri, 16 Aug 2024 06:44:21 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [PATCH v5.10-rt] rt: dma: fix build issue in at_hdmac
Message-ID: <Zr8fddZYw5iYufd-@uudg.org>
References: <Zr6gH7SNsAD0LHWV@uudg.org>
 <20240816064625.J6zQVz6r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816064625.J6zQVz6r@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 16, 2024 at 08:46:25AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-08-15 21:41:03 [-0300], Luis Claudio R. Goncalves wrote:
> > The functions atc_advance_work() and atc_issue_pending() both have a
> > similar statement
> > 
> >     return spin_unlock_irqrestore(&atchan->lock, flags);
> > 
> > That results in the following errors during the build:
> > 
> >     drivers/dma/at_hdmac.c: In function ‘atc_advance_work’:
> >     ./include/linux/spinlock_rt.h:115:9: error: expected expression before ‘do’
> >       115 |         do {                                            \
> >           |         ^~
> >     drivers/dma/at_hdmac.c:487:24: note: in expansion of macro ‘spin_unlock_irqrestore’
> >       487 |                 return spin_unlock_irqrestore(&atchan->lock, flags);
> >           |                        ^~~~~~~~~~~~~~~~~~~~~~
> >     ./include/linux/spinlock_rt.h:115:9: error: ‘return’ with a value, in function returning void [-Werror=return-type]
> >       115 |         do {                                            \
> >           |         ^~
> >     drivers/dma/at_hdmac.c:487:24: note: in expansion of macro ‘spin_unlock_irqrestore’
> >       487 |                 return spin_unlock_irqrestore(&atchan->lock, flags);
> >           |                        ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fix this by splitting the spin_unlock_irqrestore() call and the return
> > statement in both functions.
> 
> If I see this right, then this code has been replaced by commit
>   ac803b56860f6 ("dmaengine: at_hdmac: Convert driver to use virt-dma")
> 
> which has been merged in v6.2-rc1. This has been introduced in commits
>   fcd37565efdaf ("dmaengine: at_hdmac: Fix premature completion of desc in issue_pending")
>      v6.1-rc5
>   c6babed879fbe ("dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()")
>      v6.1-rc5
> 
> This means v6.1 is affected and the earlier version got it via the
> stable queue.
> This compiles here with and without RT on v6.1 with gcc version 14.2.0.
> The question would, while it is bad in your case and I don't see. Also
> if this is visible in your RT queue, it should be visible in the stable
> queue without -RT, too. And then once all details known I would like a
> patch that goes upstream and fixes the breakage at its root.

Sebastian, I do believe this problem is unique to v5.10-rt. My bad for not
stating that clearly on the description. Also, specific to aarch64 AT91-based
boards as AT_HDMAC requires ARCH_AT91 to build.

The definition of spin_unlock_irqrestore() at include/linux/spinlock_rt.h
is slightly different between v5.10-rt and v5.15-rt:

$ git diff origin/v5.10-rt origin/v5.15-rt include/linux/spinlock_rt.h
...
 
-#define spin_unlock_irqrestore(lock, flags)		\
-	do {						\
-		typecheck(unsigned long, flags);	\
-		(void) flags;				\
-		spin_unlock(lock);			\
-	} while (0)
+static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
+						   unsigned long flags)
+{
+	rt_spin_unlock(lock);
+}
 
...

And that seems to be why the problem pops up v5.10 and not on newer RT
versions.

I see that there was a revamp of the rtmutex code between v5.10-rt and
v5.15-rt, but given the advanced stage of v5.10-rt in its lifetime it
sounded more reasonable to simply fix the symptom.

Do you have any suggestion on how to proceed?

Thanks in advance,
Luis

> I don't see anything in v6.1.104. Unlike the recent RiscV fallout, this
> is not RT specific.
> 
> Sebastian
> 
---end quoted text---

