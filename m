Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413B443D
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404868; cv=none; b=V4zymm4h4xlZqfx4npPDTt6HMa14CjyYGf7e/03yvd5/NHzucEkJfEsgECCx1BcIHi+/zvrS32czh7Db/fbQwdMX7B+ItW7mrQgPWEY7EXixdzXBV8WLLNhQSqXWk5d+LvBwzAjqCgzWQI0etwEEn7JDyrNpsDFgUS3rIOGl2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404868; c=relaxed/simple;
	bh=/4aNz0J1/sLZKj2Ntw+DwXaSqJfNSyIxKB88ba4ext0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEzReqr9y6VR71vwQH1YZASv0k0GkxO64omMW4JGB9tQHIU1K4giC9laex+Q8pePeXWjCSmZWj/RcQ5mv9OH+F83jibbGuzTmO0H912wzGm9si0VN4vY7QfF3to9+vb+mkPeFvq1djkBWct63TfbnPfFwDV6DlCGCQDUeYI0wnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7k+YI2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7k+YI2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721404865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCgJCrLa1IckGVbnCYyHlLbtLXcuA+Iveo3PPClp3pA=;
	b=d7k+YI2LJA9c/Cr+JyKN761G1uEyotGHIAEn0KBYEgQ5e3huU23bBiXELqy1goJlt0a1SU
	zL8XKzoRA3qJLBTzTnON3OLFmAQ5z7a1NE5kV4AmW1e6vkertl4L9vjb6OPa3Qet1se8Pg
	hE0HAZiXFI9vY1I09Y7sXt+FYkyZSdk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-WYUtZPBJMAWrL0WKTGQn8w-1; Fri, 19 Jul 2024 12:01:04 -0400
X-MC-Unique: WYUtZPBJMAWrL0WKTGQn8w-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37613924eefso33414375ab.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 09:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721404863; x=1722009663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCgJCrLa1IckGVbnCYyHlLbtLXcuA+Iveo3PPClp3pA=;
        b=wzz1SKYIbkf+IE8JUmHO42Owrs8C8P85jAtS6/FbAvHD9nrW/KyfKRNY8HnBN/QAdC
         HM1Gg5/AAgHQ/Vi38bxmU65R+TEYbQlH1q6NOM+7dvcyArK8jwAEytEaqw909NOEDuUN
         cLLMHRyVSnxDQMPTKBViqtAokNs6oS3WxlwJpD5RLTN1nnMFEXU989nJBD/Qv8l3+pL3
         zjxImjXh9q9TBlRJtMPn4FYQ/HR22ikZbWdsqiHPf44CIFRlHL+xtzDscSWpyQiECaX+
         tTmoc3EhTxM4dvXXj3mtjUNq/DevTwIAPLQkkQIfmsV7VQEmNilIRvlx4dZ8vrOtdnk/
         oiiA==
X-Forwarded-Encrypted: i=1; AJvYcCXc6hoM2Nq27yvK1obMGJ3QAPykPTnSa0orpmJRJLlL8m1uIFdKMORvGRR+X6HLi6UGMHM8KXEoUurPbF//POweczI8TshmTNCXB9fbdCw=
X-Gm-Message-State: AOJu0YxFF3tHy82q/9PNCa3KGCSc66CawShfeTSreJS1Xqy9fERODt59
	CoDDU+1VSTIZGiSRPXSHKo6GicDnk9SwKFH2ILwhkr2xNFFJFiPZdXo4a6/NYrqbl1OwubX7H65
	P+be7Vf+Rx/5R+gje+6gCQHzfoRJXMeCxeK9MVKqV8yUeEmVhvXoeOK0ulMu/5TZX
X-Received: by 2002:a05:6e02:1d8a:b0:396:d1c5:e70 with SMTP id e9e14a558f8ab-396d1c5106emr57168405ab.3.1721404863300;
        Fri, 19 Jul 2024 09:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUx1pdGDS/1bRm+QxZ/tUP/wC5vKwjXe6lNbslKXNBqgkoY1pdqMyj5QXrImntYNFEqjb41w==
X-Received: by 2002:a05:6e02:1d8a:b0:396:d1c5:e70 with SMTP id e9e14a558f8ab-396d1c5106emr57167715ab.3.1721404862788;
        Fri, 19 Jul 2024 09:01:02 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-397f7efabebsm5039425ab.75.2024.07.19.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:01:02 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:01:00 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, pmladek@suse.com, 
	senozhatsky@chromium.org, debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <ufafd6kilc3b6k3oq6uqeulc23fznwmyukjzn3zzvvb6ityciv@7wqvfghb3aym>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
 <87a5idlrd3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5idlrd3.fsf@jogness.linutronix.de>

On Fri, Jul 19, 2024 at 10:32:32AM GMT, John Ogness wrote:
> On 2024-07-18, Andrew Halaney <ahalaney@redhat.com> wrote:
> >     [ 5.061942] =============================
> >     [ 5.061942] WARNING: suspicious RCU usage
> >     [ 5.061942] 5.14.0-467.el9.x86_64+debug #1 Not tainted
> >     [ 5.061942] -----------------------------
> >     [ 5.061942] kernel/printk/nbcon.c:1118 suspicious rcu_dereference_check() usage!
> 
> In Petr Mladek's review of my latest printk-threading series, he pointed
> out [0] that I was using the wrong RCU API in rcuwait_has_sleeper().
> 
> The patch below was his suggestion, which I was already folding into the
> next version of my series.
> 
> John Ogness
> 
> [0] https://lore.kernel.org/lkml/ZmsLcu2tHmCfLiu0@pathway.suse.cz
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 0951c2c7fb1b..da462661876c 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1181,9 +1181,6 @@ static void nbcon_irq_work(struct irq_work *irq_work)
>  
>  static inline bool rcuwait_has_sleeper(struct rcuwait *w)
>  {
> -	bool has_sleeper;
> -
> -	rcu_read_lock();
>  	/*
>  	 * Guarantee any new records can be seen by tasks preparing to wait
>  	 * before this context checks if the rcuwait is empty.
> @@ -1196,10 +1193,7 @@ static inline bool rcuwait_has_sleeper(struct rcuwait *w)
>  	 * This pairs with nbcon_kthread_func:A.
>  	 */
>  	smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
> -	has_sleeper = !!rcu_dereference(w->task);
> -	rcu_read_unlock();
> -
> -	return has_sleeper;
> +	return rcuwait_active(w);
>  }
>  
>  /**
> 

Nice, TIL about that. That seems like a good change to me, and
prevents the RCU splat from nbcon.

Thanks,
Andrew

