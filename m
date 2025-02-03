Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A11CF96
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Feb 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586734; cv=none; b=mPrKImST+yREtdQqefaeSPs5m5ozE6xHLbmQU15aTj/Tma4EqCM9YoSiGnizty6SG5jm4OUxp3FmMmk1WSsWm0YimHJbjTGyFDdYhbno/yLf8ugnuCS+ZoiOtOMJVPTvU8xugaC/RPJBZ6pPQIvQHRa1q1RoId16YnUXLcqIKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586734; c=relaxed/simple;
	bh=npMAz3hzkgpVuNsSlfu0sfVKFUaJbTCjTNI/uX9CAXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUkkMB6eVS7mULSaqZodk8Pt5BHasU6VN2myACP+qduzsmjmC4rWCUSnUd01mxSDKODAIhJfD5B6NxJLvchyqqtSE+ZaT8mrH/94HbSXRHUBWlMsoEXoctrjogBi2hGnuer/PCWivPnKH4zyGOKXRQi3pbOV7D4eaWT2Beedmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBUtQNFH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBUtQNFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738586731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FARIptggJl/qn7W8mnhkO3irAZV3EqHnn7woU1S9zOQ=;
	b=DBUtQNFHstt7ArvKY3f1OzvsvQwI1CnJGAjMuBNeCqfTjTn+Y9hI8HxMkC4ycKzRIbkvu3
	dyMC1hdUytvBG/0ws24/H8ak/9WkLt0TjD1zoIaixQ4WNCoUMt2RN2jZZzo0ScLtFq9inD
	XY3sTzxifMdiElGoVouqHK7hY2ffXok=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-bNLccipRMk6X3Ol3UBvDqA-1; Mon,
 03 Feb 2025 07:45:27 -0500
X-MC-Unique: bNLccipRMk6X3Ol3UBvDqA-1
X-Mimecast-MFC-AGG-ID: bNLccipRMk6X3Ol3UBvDqA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 928C11801F19;
	Mon,  3 Feb 2025 12:45:26 +0000 (UTC)
Received: from localhost (unknown [10.22.88.128])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F423019560AD;
	Mon,  3 Feb 2025 12:45:25 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:45:24 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jillian Donahue <jilliandonahue58@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petesarik@suse.de>,
	linux-rt-users@vger.kernel.org
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
Message-ID: <Z6C6ZHQh3jc_iJLk@uudg.org>
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz>
 <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de>
 <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
 <20250130075026.RVen6mGf@linutronix.de>
 <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jan 31, 2025 at 12:08:01PM -0700, Jillian Donahue wrote:
> Thanks again for your time. Here is the request patch:

Sebastian, do you envision this as a patch to be carried by v5.10-rt or a
patch to stable v5.10?

In any case, Jillian, would you mind adding a description to your patch? No
matter who will take the patch (Greg or myself), a description is required.
One or two paragraphs summarizing the problem and/or the solution.

Thanks in advance!
Luis
 
> From 1577bf36766218a1902ac92377dbc51798f2e4a0 Mon Sep 17 00:00:00 2001
> From: Jill Donahue <jilliandonahue58@gmail.com>
> Date: Fri, 31 Jan 2025 11:39:57 -0700
> Subject: [PATCH] f_midi_complete to call tasklet_hi_schedule
> 
> ---
>  drivers/usb/gadget/function/f_midi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c
> b/drivers/usb/gadget/function/f_midi.c
> index 837fcdfa3..37d438e5d 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
>                         /* Our transmit completed. See if there's more to go.
>                          * f_midi_transmit eats req, don't queue it again. */
>                         req->length = 0;
> -                       f_midi_transmit(midi);
> +                       tasklet_hi_schedule(&midi->tasklet);
>                         return;
>                 }
>                 break;
> -- 
> 2.25.1
> 
> Jill
> 
> On Thu, Jan 30, 2025 at 12:50 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2025-01-29 14:59:19 [-0700], Jillian Donahue wrote:
> > > > So a simple "tasklet_hi_schedule(&midi->tasklet);" instead of "f_midi_transmit(midi)" in f_midi_complete() might do the trick.
> > >
> > > This fixes the problem - do you have any insight to how this worked in
> > > the first place? Trying to understand the change.
> >
> > There are possibilities. The problem is that you send a packet and it
> > completes the same moment and the completion callback is invoked which
> > deadlocks.
> >
> > Now:
> > - PREEMPT_RT may have moved the timing a bit (makes it behave a bit
> >   different or simply make a UP device behave like a SMP one) to the
> >   point that it sees the completion of the request where it did not
> >   before. So does it occur without PREEMPT_RT?
> >
> > - It never did work in this combination even without PREEMPT_RT. The
> >   driver (f_midi) was never tested with the USB device controller you
> >   have and the one it was tested with behaves differently so the
> >   recursion never occurred.
> >
> > - It is an old driver (f_midi). It was never tested on SMP or with
> >   enabled lock testing. On UP spinlocks end up almost as NOPs so a
> >   deadlock (as in this case) will not be observed.
> >
> > Either way I would blame f_midi here.
> > Once you have the pieces together, mind sending a patch?
> >
> > Sebastian
> 
---end quoted text---

