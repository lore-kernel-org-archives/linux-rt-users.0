Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5876C61
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331288; cv=none; b=aA9s1lr4ttOTqMJBP+vacmpxJW/TQDlF8bRgeC5RWg3DJIKOvuIMxqzZ3BXFRp5B0bTPXiqFv/1lDuVhy68gmVMqzhl7MACUBS1/pD/EO2LNcrHcFJykP6zQNBEoPq/1Gcec8ig4upRIXSn9fU03F4F0cdgJYYtn3t7vqI7fsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331288; c=relaxed/simple;
	bh=UU5MbHj5nw0SWds5QDIOm8apmv1itbwOP7570RR0NZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5G2cW/DPfQixZb6L0DH4alwEOiSUYZkcxYQ/9mar7m8R1vmb89M46X7Z9a+8khnTgdXZP4muq21PPGOWJQWHMEU3PdDMQgQpp6cQPe74toFLetAZDSyGH1WHrPpcU5Z28YuvUx+col2MeG0ezQ825lEKJiqQsSSJhYzrANEQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2AsydnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2AsydnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWgl9Wd4pO+irXbkMV4gb6EA1zHFx6Jv3l8FTlv6JHA=;
	b=M2AsydnZ7v5KR+X/VZUjUQymxfgtD2UhLyHN+R+ULrCuoWC1+TyoM1VoiwbI8HRML75rRt
	TozfX33axk6YWXgsAnloXmT0sJC/oDhJfi/YqGo0ayADIKuyGzXjiYoowdvbU+HkiVq+z8
	PBdA4OtJmj5cy1sHyxQOE/oEtTe0hUA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-1hCaag3zMK-TZQnrdlr0yw-1; Thu, 18 Jul 2024 15:34:44 -0400
X-MC-Unique: 1hCaag3zMK-TZQnrdlr0yw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44f2e97d2c7so9630931cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 12:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331284; x=1721936084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWgl9Wd4pO+irXbkMV4gb6EA1zHFx6Jv3l8FTlv6JHA=;
        b=LGiRYpVdsycxMHyBzaPgC/b0N9Ipih0Tumgytom3t7qXglTQiY/ZoFcKvn6De8UBgk
         IarPFXjVrqAgZUL2S4LpOq/e0WIIxIZ8zjcwe6G4Wo2kyfy1I+Ak4k7nZcGHVAb+VIMC
         EJGcp1p4BVspbmeo5MqNHcfaiP4wHaCZby+EFnUZNAucf1O9zjwXlmzrXqfcxy1y+Qxd
         Wc7xpeBzaqxqFdXpYUNk1fO9XwaPlS0tfWzBEKfUuklZWmtRCzBV/kR/vmDCBZ/ZkqLr
         TC6Adk3BMxnSerLzIfEfhHxMLh7QAQbTroKkdJ1iBwL+jQ/j+7ATWsHj8NzEvB1TKv6/
         dGag==
X-Forwarded-Encrypted: i=1; AJvYcCXkvjSsesjefgR3n/ae/GFe4Z2wEIpS2TcjkWOdINE45n72mbpb4tvsqQ7JWiXkKvypWZJbqFW4dVSElAt3vYKPIyNqtcV0zWfiAiJrG9E=
X-Gm-Message-State: AOJu0Yzu9KHzd2o0J8v1coaTucvhpRSRACGPDQ2urRuRCBOa+xIGD3qb
	cqm1yO1O8QSjeuzlAAQfdN0Umcts2qM6Ood6GGQmIP96IqHz3laVuULBhFxxZseM/watzlDcWom
	Np9R7H+aw2eWIlA+0LTApS455y8JvRaFCRaattda4KsCnUunejPyVQzKHQBmfN8r0
X-Received: by 2002:a05:622a:1486:b0:447:f0de:db5e with SMTP id d75a77b69052e-44f96b6dedamr21113191cf.61.1721331284028;
        Thu, 18 Jul 2024 12:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEgQ8R5sNcDoW40RXc9yCOtxYGv8UU/dJi+hrBUZoo9pdWOx2wHlbJLV+G+g9ao2pQ6vydQ==
X-Received: by 2002:a05:622a:1486:b0:447:f0de:db5e with SMTP id d75a77b69052e-44f96b6dedamr21113011cf.61.1721331283642;
        Thu, 18 Jul 2024 12:34:43 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f96a0c138sm5723341cf.49.2024.07.18.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:34:43 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:34:41 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org, 
	debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <qhv54n4limuh335borcwdnailiuecez3jlie35zoo7vgerix4q@cqtetxuc6a3b>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
 <20240718152447.42244f98@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718152447.42244f98@rorschach.local.home>

On Thu, Jul 18, 2024 at 03:24:47PM GMT, Steven Rostedt wrote:
> On Thu, 18 Jul 2024 13:13:02 -0500
> Andrew Halaney <ahalaney@redhat.com> wrote:
> 
> 
> > I'll be honest, I only considered this from a printk() point of view so
> > far and pretty much ignored the original splat (as someone else is
> > looking at that). Here's the original splat from a centos kernel, I have
> > yet to look into it other than "we took an exception prior to RCU coming
> > online for this CPU" and me naively thinking that printk() should work
> > everywhere. I'll post the splat here for now before considering it more,
> > but it sounds like my expectation is wrong and that if something goes
> > awry and needs to printk prior to the CPU coming online, then this RCU
> > warning is sort of expected?:
> 
> Note, printk() is most definitely not safe in all contexts. It can
> cause issues if done in NMI, or even called while holding an scheduler
> rq lock. And now we are trying to make sure all tracing/printk is done
> while RCU is watching.
> 
> > 
> >     [ 13.643007] smp: Bringing up secondary CPUs ...
> >     [ 13.644422] smpboot: x86: Booting SMP configuration:
> >     [ 13.644431] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34
> >     [ 13.680691] Callback from call_rcu_tasks_rude() invoked.
> >     [ 13.684308] #35 #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47 #48 #49 #50 #51 #52 #53 #54 #55
> >     [ 13.720218] .... node #1, CPUs: #56 #57 #58 #59 #60 #61 #62 #63 #64 #65 #66 #67 #68 #69 #70 #71 #72 #73 #74 #75 #76 #77 #78 #79 #80 #81 #82 #83 #84 #85 #86 #87 #88 #89 #90 #91 #92 #93 #94 #95 #96 #97 #98 #99
> >     [ 13.783247] Callback from call_rcu_tasks() invoked.
> >     [ 13.785941] #100 #101 #102 #103 #104 #105 #106 #107 #108 #109 #110 #111
> >     [ 5.061942] x2apic lock mismatch between BSP and AP.
> 
> >     [ 5.061942] =============================
> >     [ 5.061942] WARNING: suspicious RCU usage
> >     [ 5.061942] 5.14.0-467.el9.x86_64+debug #1 Not tainted
> >     [ 5.061942] -----------------------------
> >     [ 5.061942] kernel/printk/nbcon.c:1118 suspicious rcu_dereference_check() usage!
> 
> You said this was a centos kernel. Well that explains why the above
> says 5.14 and has a reference to kernel/printk/nbcon.c, which doesn't
> exist in 5.14.
> 
> Looks like a bad backport.
> 

Heh, exactly why I made a "reproducer" for the printk/RCU side of the
splat with linux-rt-devel before reporting.

So my takeaway is that printk is not considered safe to use in all
contexts, including during SMP bringup (because RCU's at play and not
yet ready to be used on those CPUs). So if we do printk for reasons we
can't control (say some firmware problem causing an exception) and try
to print you could get the RCU warning about printk/nbcon usage in
addition to the actual error, and that's just something to accept.

Ideally though we don't printk() in those situations... so if its badly
behaving code calling printk() that's a different story.

Let me know if you think that recap is bogus.

Thanks,
Andrew

