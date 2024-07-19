Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C58282FB
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398205; cv=none; b=b5ViXimpFqvFRObN4aCD2taEDsoB8q7VpfRmh1Ox+By6nQfo6z3mcHsCJ6XLIQJX3coR7fmAItxZYFuJqg/uOPRil73cdpf7yChbnq0UCOWmQXrmczDBDh/8XH/EsJvhViE0erEH3DaPfgbsGi5hli8VzWLF+T4iV2xckMpir+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398205; c=relaxed/simple;
	bh=pU0yYeksF4AHmofj0YRFBkaSbhCdPFFAnXhu2ID16nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp56Z/hGTcYnDuBzs5/xKI7VwBPK8xt75rXX/GikikE4E3SzfNjC33w5ypGlANAMW/lyF6YjZVKOb/g5I8FeFaZpS++3fv+Ga1VuqW2i4a2tV1Ov+S8LK0+nR8q99BfOXO3ISopbVl42ZM2a3iAFvxjCnHRqP1XgpBb4pXJDBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpFEpfUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpFEpfUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721398203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q2O/aVCOGcmka/WfdP1dnwgE71neQZNJ0l1uAH3mE18=;
	b=RpFEpfUZJDhWkst0fWtpcQgJkYMefXcPa0NQs93jskz8xg/ZJoPDlk5T369kTeE8uZXRwR
	PiFZuLASKmp2vq+tOsQgwuQNdi7a0k3Jc4MyRG0bKtHsI4I0t37HNeXNAr5VR+3NZdBTZy
	LpBzzN1L+4/rNudgh7UTBUJaar0tnCg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-pwlX2icJMuC7urGRw1sZfw-1; Fri, 19 Jul 2024 10:10:01 -0400
X-MC-Unique: pwlX2icJMuC7urGRw1sZfw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f684ab3f9cso257037739f.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 07:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721398201; x=1722003001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2O/aVCOGcmka/WfdP1dnwgE71neQZNJ0l1uAH3mE18=;
        b=D6mdRKG5ODX1VUmOlI50RQChNHusNRb6j5KeyTSv1sfEZ6/DlHqSZMyAy3RpC4TXb/
         /jGBrecyEMNSjj9N/skWPX6Q1MXTeRBa7OSVu3ejBpKecMwUh3mRTksScL31j+mYB4kt
         jQr9PlfECvnPaWzr7Ard50gkY4Iki+y6HAIw7pkXsdxh2bVxdmZh5CZNRS4iMOC9w4rB
         3garN/t0+SGWB+cqjd3brDTtbqsCANOPhzdIgSj/umg3KS7cElwYO/lKeyOWhIdeJoZw
         pjY9JfmHYs6AaOJdVknlD40CH+j0Yxg+iJ0S/fy3qCD/Cqdezuvfp8Rb74k6eTjEusk0
         DE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0qg/AlXLscfh9xGZ+ikuiOosmWpYBgLRWJb3X9QAYV82beauWOcXjNWGNbHHFzHMylVH1mlijl0jsWrh3jfCwkkMpTJCqTVhgCSAvjyg=
X-Gm-Message-State: AOJu0YwbZHvf+cojtXftXdNxR0i3nhK+xhaeRHkaQ+/zINn0YwGilSMy
	Wxf1SDZEH0RLCA4wHsIVFUKTIbZ414ZIhQPbqAMWVqR779ZAVoFOS3Qr8+iCfsIpcsdxrHrcJNq
	eHwtHc8EF9Cw72V45nk63YF5ElAmBFYoT3j1dG1rIJYFseh7oYujv3sY+96+7Clzd
X-Received: by 2002:a05:6602:640d:b0:803:6d52:ba7a with SMTP id ca18e2360f4ac-8180d9eb251mr451404339f.5.1721398199680;
        Fri, 19 Jul 2024 07:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+R6qUfnbWjx2RRPqxNumxW1WjehQoPgcCo3UVAMZ+tnFvN/b3z4G4sNAqhOSg0YJRIuw96w==
X-Received: by 2002:a05:6602:640d:b0:803:6d52:ba7a with SMTP id ca18e2360f4ac-8180d9eb251mr451402939f.5.1721398199333;
        Fri, 19 Jul 2024 07:09:59 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819aba10e3bsm49495839f.7.2024.07.19.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:09:58 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:09:56 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, pmladek@suse.com, 
	senozhatsky@chromium.org, debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <q2ph3icjjyg2ca6cj32fdtxo3qaap2cs3s53zp42icluve5pct@hut7qbcpqxxi>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
 <87cyn9lssy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyn9lssy.fsf@jogness.linutronix.de>

On Fri, Jul 19, 2024 at 10:01:25AM GMT, John Ogness wrote:
> On 2024-07-18, Andrew Halaney <ahalaney@redhat.com> wrote:
> > I'll be honest, I only considered this from a printk() point of view
> > so far and pretty much ignored the original splat (as someone else is
> > looking at that). Here's the original splat from a centos kernel, I
> > have yet to look into it other than "we took an exception prior to RCU
> > coming online for this CPU"
> 
> Thanks for posting the splat. This is indeed a printk()
> issue. vprintk_emit() or nbcon_wake_threads() need to be aware of the
> RCU state and act appropriately. I will look into this.
> 
> > and me naively thinking that printk() should work everywhere.
> 
> Your thinking is not naive. It is correct (for PREEMPT_RT). printk()
> stores messages locklessly into its ringbuffer and must work in all
> cases (including NMI and scheduler). And AFAIK it does.
> 
> However, printk() is also responsible for reliably triggering or
> performing console printing. This separate responsibility is tricky. For
> PREEMPT_RT the problem is supposed to be solved. Obviously it still has
> some issues, so thank you for the report.
> 
> For PREEMPT_RT, if you can put a printk() anywhere after the Linux
> banner and cause a problem, the printk-folks need to know about it.

Just to be sure I'm following correctly, when you say PREEMPT_RT above,
are you meaning "the printk/nbcon/console solution in PREEMPT (independent of
the current CONFIG_PREEMPT* setting)"? Or do you mean that + CONFIG_PREEMPT_RT?

Thanks,
Andrew

