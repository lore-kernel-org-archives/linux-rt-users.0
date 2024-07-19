Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D4B660
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401383; cv=none; b=I5QCn4+h4hZ7d1D6d7my8fK1M9Asmf4vg+2Hy8PiJzfOKETpQtnS78jLqMRv47QTj+iKNzUDJojISFfflZjjD9zaHBebW+N8ndxRP54LVTL57Il8pKtOCGHcAP/ltltYWiUxUdgUsjMf2iAYgFMhx3jmIZOquVM5Bs6nmE4dP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401383; c=relaxed/simple;
	bh=0T9bCpruc845YzoLU8pYfkUierPHhH67+lK2oACtoGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv6YYg0cBJAeWe3vuaC50UfOVWmVfWMgd31io1ooggL4G5Js73lHfT4Wz25m3/BfT3hx7xtoushyrZp+64v3TfjXhXt4b127LDJjzEwVqw9ZOPthu3A5jqF969rwkFB90rTDuK5VB57chfp3Bwv2tNBCGHUDNLcIKEq3ade6/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqKPl2p/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqKPl2p/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721401381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JBPDbH2lHY022PmTwro5U/3+aoXoapLShQ09wW7ykU=;
	b=hqKPl2p/9suUrPZ9Bj6wLDgkLOCmgQ4fCuh3XOwzgaBsudlw2Nizu8rmgo2EnEFLS+VgR0
	3sGf8k+knm+2M1b3BLE3y8wMlUwMVuUw/rp+mzZQL7Oiv8PdYpmxjfDz0R7fmN7qHj0HkA
	Y8c7QZL+RVsYPWxvT2cuYFaB+DCchkY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-jzV7DhhwM-msl0Yi-83DrQ-1; Fri, 19 Jul 2024 11:02:58 -0400
X-MC-Unique: jzV7DhhwM-msl0Yi-83DrQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so321660139f.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 08:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401377; x=1722006177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JBPDbH2lHY022PmTwro5U/3+aoXoapLShQ09wW7ykU=;
        b=go1nxWdh9EV/sF2VkpuOKOpP4LSr+LJjX7KS6I+O7gD25t3VhxrUGb8vm3YWrePhcE
         bcV+FWnK6EpQq+U/8a2VcS7uETnAzHhyYHYikNN6zfz7ZAd5h+VCDnYeHfg7KE5QGeaN
         8ZDKpck/ZJhcgrnPngkzd/NUPn5u2arfXKyamaQ7+uNEI16Fy29r1Rz6VoUFL6wHEwUX
         lz31CCIV6/gYreeNoPBpmwQi1dWckklEH3I5hbr+X9+7FNhEagwQMGIaylP7vmZ0Kp6b
         BbdbzdfEGTouz19VmFKKplJIPaVM79gN45bRiD8LAOzFA8g01MKcv09GSR2JkF6GEVjq
         dtrg==
X-Forwarded-Encrypted: i=1; AJvYcCVb1jK4vsXe7C8ycM8Ouxji8e1CHIVsxjDt3XMDLj2aaMj/vAyqmj9Q6m7IkTBbjIPc1FRgIZxi5HRmCkMOvWCcRM1iBz5ji4za9DUNZ8E=
X-Gm-Message-State: AOJu0YxrWjYvDMblb632ifYYoDKYljwEgSRxDdKsOw/HXYgSObC6iY7v
	M/BBi/qE9/qHIlm70BK9eKprpyCsr032V9BEX19Z9ILaLiC4/6JIo+YjMhHRFE9c41JGoe1uEeU
	y2o/euQQhfjCXx8ESB7ykTE8UBqd/DmdWGY31jm78791GwqYbDApHT2gy4e3xmjqn
X-Received: by 2002:a05:6602:3411:b0:7f6:4c4d:5dd4 with SMTP id ca18e2360f4ac-81aa70757b6mr18846139f.14.1721401377300;
        Fri, 19 Jul 2024 08:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPo+b+sGHh4ToxVzkWEEUBmWGAMEIF3HfRalsVn15QMzFZ3FkRpRiZbAFt2nmCVJxi9Q3AUA==
X-Received: by 2002:a05:6602:3411:b0:7f6:4c4d:5dd4 with SMTP id ca18e2360f4ac-81aa70757b6mr18840439f.14.1721401376678;
        Fri, 19 Jul 2024 08:02:56 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819ac1cb571sm50326239f.19.2024.07.19.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:02:56 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:02:54 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, pmladek@suse.com, 
	senozhatsky@chromium.org, debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <4bvtpkekh6rrg6sbkbcqgz7kfhnjond6hupq4irodaucrh5ygx@bsq4mdqjsbw2>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
 <87cyn9lssy.fsf@jogness.linutronix.de>
 <q2ph3icjjyg2ca6cj32fdtxo3qaap2cs3s53zp42icluve5pct@hut7qbcpqxxi>
 <874j8ll9dd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j8ll9dd.fsf@jogness.linutronix.de>

On Fri, Jul 19, 2024 at 05:01:10PM GMT, John Ogness wrote:
> On 2024-07-19, Andrew Halaney <ahalaney@redhat.com> wrote:
> >> Your thinking is not naive. It is correct (for PREEMPT_RT). printk()
> >> stores messages locklessly into its ringbuffer and must work in all
> >> cases (including NMI and scheduler). And AFAIK it does.
> >> 
> >> However, printk() is also responsible for reliably triggering or
> >> performing console printing. This separate responsibility is tricky. For
> >> PREEMPT_RT the problem is supposed to be solved. Obviously it still has
> >> some issues, so thank you for the report.
> >> 
> >> For PREEMPT_RT, if you can put a printk() anywhere after the Linux
> >> banner and cause a problem, the printk-folks need to know about it.
> >
> > Just to be sure I'm following correctly, when you say PREEMPT_RT above,
> > are you meaning "the printk/nbcon/console solution in PREEMPT (independent of

s/PREEMPT/PREEMPT_RT patches/

bad spot for a typo on my part...

> > the current CONFIG_PREEMPT* setting)"? Or do you mean that + CONFIG_PREEMPT_RT?
> 
> First, the _complete_ printk/nbcon/console solution must be present in
> the kernel (most likely by simply applying the PREEMPT_RT patchset).
> 
> Then, either
> 
>   1. Enabling CONFIG_PREEMPT_RT
> 
> or
> 
>   2. Enabling some other preemption model but only using nbcon consoles
>      (which currently is only the 8250 uart driver)
> 
> For !CONFIG_PREEMPT_RT using legacy consoles the
> non-interference/reliability properties of the console printing is not
> changed from current mainline. This is on purpose.

Thanks for clarifying!

