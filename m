Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC584A40
	for <linux-rt-users@vger.kernel.org>; Fri,  3 May 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771489; cv=none; b=NxQG6acb8oQQuKdXRuuzByljuoUt3qQ+3IccYsIrkGab7GYGeZKlGqfB99oYND7R5T3o5qEbBoxaev6xm/MG+QmlTfPv/1m7Bo35ploqAVLtG5cimHmBxUug3WUlkK6SqLFwDxnHf1cdNjNVZjUj3+om43tt1Fb/8Vv7HZNsARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771489; c=relaxed/simple;
	bh=+ooVK/AumgxK/5446WmCtFMmxrP/Zl1qnwgHQdxyRHA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sTAgIq5p33p6e/FJ7MpIhi1wEQto06xP94PL6Tq0oME7O8oG5k34AYRfB8Q6CoTul1ECnE9hXQWnSP2YI0lXbDbk3TPvkiQgqTpEi4xsB2Lf0cwN6hPOcbeyqsxVVNXYz+gmeNjhiOLWYDkJM4E5sM0qYYG4ZvWjfthBfRbtHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/ltFB5k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/ltFB5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714771485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M1/T5A+JsNL4c/hegk7O854x264+NXh9sMpQ9LpNoIs=;
	b=S/ltFB5kzQ4H1eZZxy17hQfpwXp7MYpVTKjFM+9HI3bHYo8sPQp6bRbuTw2T2XHR3P86WU
	bCQpUThhLZkwAWt0GP+UYbtc6S7TdVR9ySAhhwggxd9XXmUuyZfp35ZU/xzbHPip11OLh5
	hJewMsEUD/mq4j8uBBiqSrOeZvumbcI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-rWwcPhUEMXmCBEFEfXc3Ew-1; Fri, 03 May 2024 17:24:43 -0400
X-MC-Unique: rWwcPhUEMXmCBEFEfXc3Ew-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-790ef197695so9713985a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 03 May 2024 14:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771483; x=1715376283;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1/T5A+JsNL4c/hegk7O854x264+NXh9sMpQ9LpNoIs=;
        b=XQBXZQA9+3bYz/miTjTpCi3RzaHAHFUs0DjqihQ54ksUPBSom2tkQ1HBq1muD4BGi4
         N2AsTd4XPd+wofOyx6PbbylgqK1sJdZMRfxjEbgehbBa4z2XkXD/NxjXL/egRKemGdtH
         40GiN/EDsU2t5dw/pKCx28IkKjxWvv4ky5rVWIWZPEMdi7ZMyBS9BerCJer3bULRK7x8
         HBssD+1+9UNY5Ducb/FLCL8/conO9SBdec9GrqIH9/CRNokEFBu7wq/rTHGTKBepAZ2p
         uA9/zQouuh27r6luLIcQF0IfD+DaABi/Kmt85npU2zJjsILTOaHmkjZZIIm1or/px4q2
         HP6A==
X-Forwarded-Encrypted: i=1; AJvYcCU4vjfTWJ2muuD4p5bRcjHl3FyuQmm8L4qWr5gj45t80se5euE7L5o+R/jPJuIvmS4vWydLgZ5oyULdLsLQxlu/89qnBK1qaHqdjCulIW0=
X-Gm-Message-State: AOJu0YxHDsGeLMGg4pZdZ/MjAM18mm6CIMgWM//A8wsPghxwHw1aXvUr
	QjuF53QQ/if856gIs0IXTLQBh6ceScVAawgZ8pcZkYtkP1TOwlPE5MJ8nHhE8AhAqhol22xT8Fv
	yfGe8u5oU2hieesZ3qXEu2qbFSdcdjKj4IHiiT+Jw8ZZWUPlcEG+ui6/eqPykLvhZ
X-Received: by 2002:a05:620a:1923:b0:78d:6e6f:9004 with SMTP id bj35-20020a05620a192300b0078d6e6f9004mr5091705qkb.59.1714771483250;
        Fri, 03 May 2024 14:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExbKqUF8bLn2f60xIdGXmbb9uYy6No99Out8pmSclIKmCDp+f3MwBZ+GobQV3g0/ZoSXu1vA==
X-Received: by 2002:a05:620a:1923:b0:78d:6e6f:9004 with SMTP id bj35-20020a05620a192300b0078d6e6f9004mr5091682qkb.59.1714771482793;
        Fri, 03 May 2024 14:24:42 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-16-74-12-5-183.dsl.bell.ca. [74.12.5.183])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a098e00b0078d3b9139edsm1551010qkx.97.2024.05.03.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:24:42 -0700 (PDT)
Date: Fri, 3 May 2024 17:24:41 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: cyclics: Omit empty histogram buckets
In-Reply-To: <da44edf2d10659ccfea2b8a646f8431cd3dcd168.camel@redhat.com>
Message-ID: <9ed003b3-66dc-fd4a-b6b2-531ba49657da@redhat.com>
References: <20240501204944.228386-1-crwood@redhat.com> <974cd5d9-f027-5e51-e6ba-fd50e4759d4b@redhat.com> <da44edf2d10659ccfea2b8a646f8431cd3dcd168.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463771134-1147017012-1714771482=:68633"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463771134-1147017012-1714771482=:68633
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 2 May 2024, Crystal Wood wrote:

> On Thu, 2024-05-02 at 15:13 -0400, John Kacur wrote:
> > 
> > 
> > On Wed, 1 May 2024, Crystal Wood wrote:
> > 
> > > This makes the output more palatable for human readers, at the expense
> > > of requiring other consumers of the data to be able to handle the
> > > missing
> > > lines.
> > > 
> > > Signed-off-by: Crystal Wood <crwood@redhat.com>
> > > ---
> > > Don't apply until the below patch has been merged in rteval:
> > > https://lore.kernel.org/linux-rt-users/20240501200922.226347-1-crwood@redhat.com/
> > > ---
> > >  src/cyclictest/cyclictest.c         |  6 +++---
> > >  src/include/histogram.h             |  4 ++--
> > >  src/lib/histogram.c                 | 15 ++++++++++++---
> > >  src/sched_deadline/cyclicdeadline.c |  7 +++----
> > >  4 files changed, 20 insertions(+), 12 deletions(-)
> > > 
> > >  
> > Fixed title to say: rt-tests: cyclictest: Omit empty histogram buckets
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > 
> 
> How is that a fix?  I said "cyclics" because it's both cyclictest and
> cyclicdeadline.
> 
> -Crystal

That's kind of funny. You ARE making up words there, I jut assumed it was 
a typo. I've already pushed it upstream though, so we will have to let it 
be.
---1463771134-1147017012-1714771482=:68633--

