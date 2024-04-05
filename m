Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79769174EEC
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355121; cv=none; b=m0B1CfE2exBKMN+c7ZXWQ38U+YuaB6Q5q8i1daCn+nhITwrPAbE5zCT5vb+HNJRAlXjM48XQ003D1GKnpb0mkyPWwCRq27eOQwuh3QWHzfZUgeCq61921C1lwZS/OIySEbJeU5GFkMpPfinx2HG5yoWiPtCxOM6UH4EipIy7AsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355121; c=relaxed/simple;
	bh=+TVe9H/if7DYPRzddLfnBQht+lQDuzkzPU8f1wWClMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d1pqQK0XTjhfivScbyVppfIOV8P74Yg1FHaB8IumSYUeuFN0CF9FbvhsxUn55UBH6sHLUwkCg9EALVpm2M+qUW/S7cG1vSYURzycJ4dR9P6l5k3476//EJlLuLv4NdyXEe68JKrvJTYHsbVZJdPv+bzNJPOIcX/NGiP1EJ6FA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHdiSqfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHdiSqfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712355118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXcYNwl/SiAnIQWH09hNMvyECESiFPg3yb4f3eBoq+4=;
	b=WHdiSqfNM/NMBAmhfa707ysZNslErDqnzmncq/5DjJrtYSuBgSPXd6fwYZBRY5NC1JkSu5
	iraQoOtjg38JnycF1hrxDMOUAxVnCBOVa5JhFm6apvJ02bdBsx8UYHU3DchKA1KymCUqJu
	rNBZw/2FQvkYqYEvsRU5HMyjGvuOsKQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-cfUShoIINGC3s_q1aQb7EA-1; Fri, 05 Apr 2024 18:11:56 -0400
X-MC-Unique: cfUShoIINGC3s_q1aQb7EA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d546cc459so1561085a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2024 15:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712355116; x=1712959916;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXcYNwl/SiAnIQWH09hNMvyECESiFPg3yb4f3eBoq+4=;
        b=sfljnRuBzXI8FRx5BFYp/s8YOX0PdDR24pqK46a70ouShNvcgz7NXAE7O9xwE2O0Ea
         JwsDbsQ9AUJw88n8jna6iECo3xFNCCHzc/uVkKe1pLaXUlKIeQOsCANBfuKINsL1LWip
         tYZxkM4A+M4z1t558mMpdhNs96ieWvJFSWmsi85mRrB0Nu9rZacPvDJ43ELOz024LK1h
         pVhjIf44Rdj1T2Pde4f4WtCvK32HId6VDkds0LvD1zY9c7rmvFWPi5fyf5qnpLoROu5U
         pJt0pk+q8rFr5xfIUcT4UbpL6aoZskRKXIbZz6A/YAbqxtysJqPl3fAHsVE+k8SR9cky
         OsIA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHEn/GBe+ZdW0NV/t5zemg0cyGB/g2WqZMwn0yAym+3IWNTDfSkPJZskiLgu38ZkK4wWK4MiMVLujXcW5SMXLZfFILon5xyjD7DU3Fbw=
X-Gm-Message-State: AOJu0Yx+P+CMRJMEsN029PLQeMm9E06Xx9hJisFTK5jwXDiJTuOH0scG
	at3qPuWFzDiW9rYU9a3aOcCT3vE3hcbtd0k0GgHW4CTcAhONV+fRU6ZTSZbEkhmS2vs/D1NuUFW
	WODX6lxp7OeIYak6syRi/YddkBfRm2zTY24yhf3Ca1GtyJXq5tvWK/v8P8JZXtKsnRpKKfZ6i
X-Received: by 2002:a05:620a:46a6:b0:78d:4f3d:503f with SMTP id bq38-20020a05620a46a600b0078d4f3d503fmr2393209qkb.60.1712355116072;
        Fri, 05 Apr 2024 15:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXZvlgqNhogagIlbOr6pxMsn2N6laGysQdqxgRrTvSP9o7paaSMhZX1/0ztJhGiCc42J8Zg==
X-Received: by 2002:a05:620a:46a6:b0:78d:4f3d:503f with SMTP id bq38-20020a05620a46a600b0078d4f3d503fmr2393193qkb.60.1712355115717;
        Fri, 05 Apr 2024 15:11:55 -0700 (PDT)
Received: from fionn ([184.147.142.166])
        by smtp.gmail.com with ESMTPSA id j11-20020a37ef0b000000b0078d36f1a609sm977050qkk.128.2024.04.05.15.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:11:55 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:11:46 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/5] rteval: kcompile: Skip mrproper, and re-extract if
 clean fails
In-Reply-To: <83e824439dee6fc794851620cdabc374affd8f1a.camel@redhat.com>
Message-ID: <0bb78649-a3b4-9e32-c540-0982ca69b4e8@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com> <20240304211655.20174-4-crwood@redhat.com> <0f21e919-9bab-5abf-8844-d4ff8c84b82d@redhat.com> <83e824439dee6fc794851620cdabc374affd8f1a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463771134-1334105801-1712355115=:44864"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463771134-1334105801-1712355115=:44864
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 3 Apr 2024, Crystal Wood wrote:

> On Tue, 2024-04-02 at 15:07 -0400, John Kacur wrote:
> > 
> > 
> > On Mon, 4 Mar 2024, Crystal Wood wrote:
> > 
> > > We only ever do out-of-tree builds, so the kernel directory should not
> > > be
> > > getting damaged except by incomplete extraction (which mrproper would
> > > probably not fix) or external meddling.  So, skip the mrproper and
> > > instead re-extract if a "make clean" fails.
> > > 
> > > Also, add -j to cleancmd to further speed things up.  Startup speed may
> > > not seem all that important given how long rteval is typically run for,
> > > but this helps make quick tests (e.g. while debugging things, or when
> > > hunting a latency that shows up very quickly) less painful.
> > > 
> > > On my 12-cpu laptop, this patch saves about 15 seconds of startup time.
> > > 
> > > Signed-off-by: Crystal Wood <crwood@redhat.com>
> 
> > You would probably achieve close to the same or better by just using '-j' 
> > with make mrproper
> 
> Perhaps it would be almost as fast, depending on the system you're running
> it on (and how many non-isolated cores it has).  But it really doesn't seem
> necessary.
> 
> As for better, how?  We're going from mrproper *and* clean to just clean. 
> The re-extraction only happens if clean fails.
> 
We already reextract if we're in a state that is broken. Perhaps you're 
right and the mrproper isn't necessary, but perhaps I have a long memory 
of when we just did this by default and a lot of problems went away. 
Maybe I'm just stubborn. It seems like an "if it ain't broke don't fix it" 
problem to me, especially since your other patches already shortened the 
time for very short development runs. If you'd like to send a patch to add 
'-j' to this I would except that, otherwise, let's move on to some more 
interesting problems.

John
---1463771134-1334105801-1712355115=:44864--

