Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5352914
	for <linux-rt-users@vger.kernel.org>; Thu, 22 May 2025 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747886531; cv=none; b=HZC4Nm//+sH3gxZvau17/NcChoVQUFCoRGD/FkoSFS27WQHQ4dKYXqLrRoxQxhZJYYU1sKgJOUnI1WSlPQTbdDLK+aczEI3D7zmbWpivA1Uf9pjEJrrU78qUnYpcKR1IpEAGuQMyXAQ6cJXabAyqGDGSXL0Iqie/MWNB3NW6qz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747886531; c=relaxed/simple;
	bh=/6W/X3PgI3CVIDFoqbeWNszrtttj9mPmf1yDZahlocU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvF2R9U0iVNRId565zZ3xSLHJMxsAwyGfuUUa5gXTyX3geTuWDLluL1xBHEFhy4rTAuJAm7iTUwP2jDh1xgWEuZjKl3EaWftPwvypN/1C0/yvN+iG+p3bt5HSQNrjPK5bzZNsbOld6r6FJ566zN3FvyzEbkgPPJe5augi4SnCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czlQ11/n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czlQ11/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747886528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo6dAu6YkOv6HrRPNr8vHU8MB5g0A7hyfPgpTE3Qoys=;
	b=czlQ11/nMo2e+XYFvbFi33nPFmsKfv5RoDvHWmy3dyvdnqKiVwmihoKwVXtg64ceTsZzXL
	4vDMslrVn73bA5uLq83HYydLDa9vGf+A+JluBd4hxGfqlIZ5bP+LmDFwM2gb8Iq+CMxhM6
	MgrQok+6utq6YG3CPRS2CujhRqqJekU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-ljv8oJBoMySm7cugEmALIA-1; Thu, 22 May 2025 00:02:06 -0400
X-MC-Unique: ljv8oJBoMySm7cugEmALIA-1
X-Mimecast-MFC-AGG-ID: ljv8oJBoMySm7cugEmALIA_1747886526
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70cd03e8c01so63288957b3.2
        for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2025 21:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747886526; x=1748491326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo6dAu6YkOv6HrRPNr8vHU8MB5g0A7hyfPgpTE3Qoys=;
        b=IYfvF8GvYxvKq5DXefaZILwgKBcrMAAqBQoRRn4CXKErF5XRo3BNbWnxqUVyvqlZ/h
         nh3sj6uJSSm9KlxgEsFYl8m0fNHxmDfLJnN4iv1yWJEjXrsJW1JDZ8uIuasHYmnUmg+N
         oOnrktm1827kzEtXPkJKVKMu8R0lxiO0EG6tt++MQz3BgCyzuGuYjSSTQcyc4Jci0Dcq
         rvemYj3Aj2RkfHpRsALwn22Qbk6Wf0E45ZT9cnV4RoZWU66gllIpwKZTZujkcm7jbYeg
         C59mnQTSJ6daU0r7UGs8zZo0NNcXizWN5TPF+3KJIKoSJKv0XPMMs1wtRUc2SLxwEw++
         i+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVlfrD6UW+7NpKkEccPXNcZ37MVyyTJM7JBwE5lRiqlbZ9BOzOBjKOprFXzFBJOPXjqnvFO7Qiem8+9YhvuwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyFVvvtfSryVe4XtAZg+OnmWO4ixBhaHm+L6k692MwiXo6oH2
	Ek69xrjWtydHt7ujEGZPfWuw7X8NGlssgRMq7D4NIXWErnbOOueSQZvxHQEp9uKOQA/NwxUHFGZ
	AIB/XR+/C9Hdy5hVELyYw+m53rEuNnoMs8hSwDZ2av4kU2WrnJ2meuWbRUtOVeG9TjN5ZTIwER3
	q29sxL1cwaXgvvu+hLKCV3NlCAjF5ybyU+CzC+F5uYa0Y=
X-Gm-Gg: ASbGncuxKDeHMbECiiGCrEjDVmR0rssLrYuRLWj+YONJydLzvHb+xnHXJEZ66dzK+GC
	A2IaTXskgXCgemyvSoTAbC8x6xUW7fp0/bTC27SsvtOoxKnVZSj9cY4NEK0/p5oQ0jkNgjJJO/+
	oXCRjvnZaF8vDHbwRuqJVY7tRm
X-Received: by 2002:a05:690c:3681:b0:70d:f47a:7e3f with SMTP id 00721157ae682-70df47a8395mr76564167b3.20.1747886526247;
        Wed, 21 May 2025 21:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSKwy93prBQ1ZrF/hNak+lQR8NFuD9N39a/BrvBWJuLn/t6/6CdNwEQHyJJP9DiXFJ6g5GjrRtWaWuGJFMl3A=
X-Received: by 2002:a05:690c:3681:b0:70d:f47a:7e3f with SMTP id
 00721157ae682-70df47a8395mr76563897b3.20.1747886525918; Wed, 21 May 2025
 21:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520035641.533706-1-leobras@redhat.com> <84msb7g2sr.fsf@jogness.linutronix.de>
 <CAJ6HWG7d-1SqOh=H62Ycrx_owziO_CzEvPKMNgsqeWC5b139Bg@mail.gmail.com> <84v7pu9x1b.fsf@jogness.linutronix.de>
In-Reply-To: <84v7pu9x1b.fsf@jogness.linutronix.de>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Thu, 22 May 2025 01:01:54 -0300
X-Gm-Features: AX0GCFtT4PULrYijI75qOgA02YaZRP6jW7v7ncRs_pcCaYiJoGy5LUBy1Q5gPe4
Message-ID: <CAJ6HWG6h_t33ts4aH_tKg9HDKuCCtq0e8hxKgfVXs1Pa+FT=Pg@mail.gmail.com>
Subject: Re: [RFC PATCH] cyclictest: Add skip_sec option
To: John Ogness <john.ogness@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	rt-users <linux-rt-users@vger.kernel.org>, Sana Sharma <sansshar@redhat.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:40=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> Hi Leo,
>
> On 2025-05-20, Leonardo Bras Soares Passos <leobras@redhat.com> wrote:
> > On Tue, May 20, 2025 at 4:35=E2=80=AFAM John Ogness <john.ogness@linutr=
onix.de> wrote:
> >>
> >> On 2025-05-20, Leonardo Bras <leobras@redhat.com> wrote:
> >> > When running cyclictest with break trace (-b) option, wait for skip_=
sec
> >> > seconds before issuing the break.
> >> >
> >> > Cyclictest may present high latency on the initial cycles, which can=
 be
> >> > caused by initial resource allocations, and may not represent the
> >> > expected latency for the running workload.
> >>
> >> If cyclictest is programmed correctly, this will not happen. Can you
> >> provide a technical explanation for high latencies on initial cycles?
> >
> > We are currently investigating the source of this latency, but I heard
> > from other team members it's also happening on Intel Secure VMs as
> > well.
> >
> > Scenario:
> > Host: ARM64, kernel-rt, 120 out of 128 cpu isolated, hugepages for gues=
t
> > KVM Guest: kernel-rt, 120 vcpus pinned on above isolated cpus, 116
> > vcpus isolated on guest
> >
> > Cyclictest runs with trace-cmd attaching to a guest agent:
> >
> > trace-cmd record --poll -m 1000 -e csd -e sched/sched_switch -e timer
> > -e irq_handler_entry -e irq_handler_exit -e tick_stop -e
> > ipi_send_cpumask -e ipi_send_cpu -A 3 -e csd -e sched/sched_switch -e
> > timer -e irq_handler_entry -e irq_handler_exit -e tick_stop -e
> > ipi_send_cpumask -e ipi_send_cpu bash -c "ssh $my_guest 'cyclictest -m
> > -q -p95 --policy=3Dfifo -D 2h -i 200 -h60 -t 116 -a 4-119 -b 50
> > --mainaffinity 0,1,2,3 --tracemark'"
> >
> > What we see is a peak of >50us in the first couple cycles, and then a
> > max peak of 15 in our tests.
>
> I wonder if this related to cache misses and/or memory bandwidth. If you
> keep this patch but you increase the interval, do you see >50us during
> your tests? For example:
>
>     -i 10000
>
> If so, your "max peak" of 15us is only valid when cache hot.
>

That's a smart move, we will run this test as suggested and bring the resul=
ts.

> IMHO whatever situation is happening for the "first couple cycles" could
> happen later. In that case, the patch is just sweeping some of the bad
> numbers under the rug. It is really important to understand exactly what
> the problem is before changing cyclictest to ignore such problems.

That's a valid point.
We are currently investigating it, and I will bring the results when
we have some.

I have a v2 ready, but I think it makes sense to send it once we find
the above investigation if it makes sense to proceed with the
suggestion.

Thanks!
Leo

