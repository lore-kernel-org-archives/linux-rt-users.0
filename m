Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715C22B642
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800769; cv=none; b=jYGuUMPuVM76qkaGeqac6SoQPfu3iO6T22JB1i4RBOIM8dtLPPvFkCJaf43xkOIpm01ek83uAh/mHe7Xv65wvMZzDxLC6+Jt9RBFSTk9LW9mbiFlwQEX+e9VEHfdYyFwqcVqDn/UmTltXI6DFAqoHsVLvJ7h6pVuY6cIGeVFqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800769; c=relaxed/simple;
	bh=Pd4ZZV2hIh78nXUX2qp0zLWSAPT2RFAX92sVCX/6+xQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccmGwOqLElda7SfgpFMzOE7QikWpz2yoqfgUxgytkMa3wgnjKmjZ3OXjn9laAzn6RoGWGcoUQOsschGJ9dQ1CrYZvZlJh0YtMRTERDTLoAeUfhrWtWye0e6HYk3tIXOM32cddvN6g4zK/22NV1uMIFzs7Z7h+06lNmhnaGD3YoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkFI1MQT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkFI1MQT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729800765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJVwY4eaw7IpG3I4I6AKAZZ+pZNoP853lppSFu3kI00=;
	b=bkFI1MQTtfmNEHiez71D6XFKCZaaWGiuhuXK8DyPuDJyAXoOelaMmtquCqKnauGlo7jbsA
	9eDYDYstYcWduaCnUODx6y8ywlLwmGWXdjX+hFKfdIj6vLGcnjlXakhmZZLMtHw3xAPxQI
	qb0SYdFmq1lKwksPcokq1M7T5aKXuRU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-fFCdE1wvNZiTf3u7ME3jnA-1; Thu, 24 Oct 2024 16:12:42 -0400
X-MC-Unique: fFCdE1wvNZiTf3u7ME3jnA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbeca2b235so16010536d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 13:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800762; x=1730405562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJVwY4eaw7IpG3I4I6AKAZZ+pZNoP853lppSFu3kI00=;
        b=PWNwSBcC5akJb5kiLu5NVwDn/Ifthta8ja/yISYbIHBQZt3BP9FBpX5uxxv/de86Az
         CzhzWivq9TkfgggEfXAX5clIwxGVN8rUrBoJMI2Al/MvdtyS1xQ71mA/m0H05UjaKvdn
         H7CdmPNGnmapg0lR6eYRf4joCqlGoV5kXs5klwcnlC6rCqYsFArPZci7AS9QnmClqGse
         Vr8n/Ozj+ndh/YnD3ThrtZ18d0YU8BvzzHWsFpAQBm+L/et7KIp5fx9LlZOJbCCMU7rM
         6318omdzTbXeYfNGM/csQkyq2Yt6M1cHqXit1k7M94165gwmDvTicD5ppCaRxqKzlOnQ
         TiJQ==
X-Gm-Message-State: AOJu0YwVgUJqeqvpKDpiQyRBtw5RowtAz2N/uU/p3xi5TlQ7jTCh2z82
	s6qdpuatAcVFiFxl8Jb9RbqZ5Xm87grKwSoUctUeRucOBdXKa9dVnYGw80zKMKc//eq82VJObJD
	VPTiqYewJRuoOWMO9furoALIdRM2Y2jBs0q8U3WjyNFm5YeInTzA5tMCInMYOBsQ3
X-Received: by 2002:a05:6214:398c:b0:6ce:1011:60c1 with SMTP id 6a1803df08f44-6ce3428494emr78172866d6.35.1729800762240;
        Thu, 24 Oct 2024 13:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEhfUICT91fsxaY1ynP66GIgeYhv/v/HPv7elqHPPhWPYTlFXnYjuFbl3U4kxRI7thFDE2Gg==
X-Received: by 2002:a05:6214:398c:b0:6ce:1011:60c1 with SMTP id 6a1803df08f44-6ce3428494emr78172696d6.35.1729800761966;
        Thu, 24 Oct 2024 13:12:41 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999f3bsm53031656d6.91.2024.10.24.13.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:12:41 -0700 (PDT)
Message-ID: <278bea37ceff6f67dd1b29707d1403c07590b6dd.camel@redhat.com>
Subject: Re: [PATCH] pi_stress: Add memory barrier to resolve crash
From: Crystal Wood <crwood@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Clark Williams
 <williams@redhat.com>,  John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, kernel-rts-sst
 <kernel-rts-sst@redhat.com>,  "John B. Wyatt IV" <sageofredondo@gmail.com>
Date: Thu, 24 Oct 2024 15:12:40 -0500
In-Reply-To: <20241024162620.349934-1-jwyatt@redhat.com>
References: <20241024162620.349934-1-jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 12:26 -0400, John B. Wyatt IV wrote:
> @@ -952,12 +953,31 @@ void *high_priority(void *arg)
> =C2=A0			=C2=A0=C2=A0=C2=A0 ("high_priority[%d]:
> pthread_barrier_wait(finish): %x", p->id, status);
> =C2=A0			return NULL;
> =C2=A0		}
> +
> +
> +		/**
> +		 * The pthread_barrier_wait should guarantee that
> only one
> +		 * thread at a time interacts with the variables
> below that
> +		 * if block.

How is that guaranteed?

> +		 *
> +		 * GCC -O2 rearranges the two increments above the
> wait
> +		 * function calls causing a race issue if you run
> this
> +		 * near full cores with one core (2 threads) free
> for
> +		 * housekeeping. This causes a crash at around 2
> hour of
> +		 * running. You can prove this by commenting out the
> barrier
> +		 * and compiling with `-O0`. The crash does not show
> with
> +		 * -O0.
> +		 *
> +		 * Add a memory barrier to force GCC to increment
> the variables
> +		 * below the pthread calls. This funcion depends on
> C11.
> +		 **/
> +		atomic_thread_fence(memory_order_seq_cst);

That's kind of nuts that pthread_barrier_wait() doesn't even act as a
compile barrier (which a simple external function call should do), much
less a proper memory barrier.  In fact I'd go beyond that to call it a
bug, just as if there were a mutex implementation that required users
to do this.

And POSIX agrees:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#ta=
g_04_12

Is it possible that something else is going on here, and it's just
being hidden by changing the timing?  What exactly is the race you're
seeing?  It looks like there should be only one high priority thread
per group, so is it racing with a reader, or watchdog_clear(),
or...?How does the crash happen?  What is the helgrind output?

-Crystal

