Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E6188CCA
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Oct 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462995; cv=none; b=EH4nnxSD9M6V3xhiV7nAz49iTBExHznByEPGlE1kCkorQojeZmKRgimCjOaZg1WG1U566aqs/QL2KaWYC6Rm27SSS3Sg+lY0rdpyqfNH+19fJrzNdSLFsYX8Nlt6cIcUuDY/JD6il+Qzgg77HM+8AoNzcNoPxeuTtSYqMa1Vsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462995; c=relaxed/simple;
	bh=fkyLFJKEtI+14XmToXjsY4VfDrjFVgjWejQFfNCvgLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm7ZOQ0zsOrgG6DrjBNHK1bfrQiYnF+2tVuDgXv//Syt/IoEgzMImJTansP3tcz4tcRJ7A/rfkZCUH0xXO3KSTak6oQ9Ju1EEGf0Z8qHrpxetRV5OzgJO2FNATopcDJqkoM1EEB3PmVGoulugLRVwBW3tYqE0YRHh5vXDtw2icE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHauVRC0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHauVRC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ovshM/hJzDxSzL6UkhkOlKKt98Q7bAUp8qN21jtpiQ=;
	b=eHauVRC0dSjsOuCK33PsbflysUbXPAuPBKdB9W7F752rp0Xmk5EiKd0KaybUTQ9gnSsKKN
	+WxqbiQEHntJyb0sOwjlo53U4ojLn+5xq0Nz77pxVbwZw2UdDcErPOerM/M8GMt42n/w2n
	kfZ9ARQwBgnyQtXD0Wdd20qvx2KyhcA=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-1z3tOCgmN5exPlksFtJbxQ-1; Wed, 09 Oct 2024 04:36:31 -0400
X-MC-Unique: 1z3tOCgmN5exPlksFtJbxQ-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50c7cbc2485so1268284e0c.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Oct 2024 01:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462991; x=1729067791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ovshM/hJzDxSzL6UkhkOlKKt98Q7bAUp8qN21jtpiQ=;
        b=NPnQeMFH26zFxXgKvKh+CcrkR/Eed6ogrZ+Sa48ZwZowhFlujeuCtDUDWxDVUefIZM
         nhDOabE546Q/mm6OSY4S8jMp4j03AAMQbYWQfYs0zAqjOMlmQ+toySqaOmovaz/+Gn5f
         hSn6Lscg9XENHJx6GbVWmWEHsUYmVg5SzUdPzbauCsfsxsgCa8GfpBoIK46mrLG050e8
         JoY60rcKwiYtGG5jrk4Zqhi/JVUfmUX5Ix19Vlguxm2YGTlJT4YIKRdMap1gzyrrzaPB
         6k68SvNN5Q2jRLvHRKFpiNLvUSMaTnf9/q/8TEriy3F8s8uK0IJ54zfNleMBcRqK1DcI
         51TA==
X-Forwarded-Encrypted: i=1; AJvYcCU3BZPmzmehTKy+9MBqw5SkuWOFOsyQlcY0WnGiu07zxlffjz/HAWKxNg2mXVxdtBtmShREcVdT3Inoyxn5Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHqFcszFx4fmBx3Y8I2staWOzkuKFtockkRGCiVF8+HEUQvPG
	K32aP29D5rLI35/S4VDYdwQWUZMLxKZM2tDkXlRG6siKJHJRE7BscOUwwA4uggu5iOaFQsZqWDd
	mAWewcrrwPD9FYJy4Acd4hWQz5Yvnx2NbkP80yTXyUeEvvcd5mKCMGJ6Bpts3Depv
X-Received: by 2002:a05:6122:1793:b0:4f5:c90:2556 with SMTP id 71dfb90a1353d-50cf09a3735mr1596459e0c.4.1728462991198;
        Wed, 09 Oct 2024 01:36:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDnQZf02HtilonLUcCdsQxmwcIcoPCQcDwb/5gCqqDyQ7h7T1QFgDMmTnwQ3ZsgdTa7moN1Q==
X-Received: by 2002:a05:6122:1793:b0:4f5:c90:2556 with SMTP id 71dfb90a1353d-50cf09a3735mr1596440e0c.4.1728462990825;
        Wed, 09 Oct 2024 01:36:30 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae756611c1sm435790285a.72.2024.10.09.01.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:36:29 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:36:25 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <ZwZAicOokVUn2h8h@jlelli-thinkpadt14gen4.remote.csb>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>
 <20241008155129.z7ZZVzW3@linutronix.de>
 <46c259c2-5503-4a63-94ae-96660e5ce0eb@igalia.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46c259c2-5503-4a63-94ae-96660e5ce0eb@igalia.com>

Hi André and Sebastian,

Thank you so much for your quick replies and for providing context that
I was missing!

On 08/10/24 12:59, André Almeida wrote:
> Em 08/10/2024 12:51, Sebastian Andrzej Siewior escreveu:
> > On 2024-10-08 12:38:11 [-0300], André Almeida wrote:
> > > Em 08/10/2024 12:22, Juri Lelli escreveu:
> > > 
> > > [...]
> > > 
> > > > Now, of course by making the latency sensitive application tasks use a
> > > > higher priority than anything on housekeeping CPUs we could avoid the
> > > > issue, but the fact that an implicit in-kernel link between otherwise
> > > > unrelated tasks might cause priority inversion is probably not ideal?
> > > > Thus this email.
> > > > 
> > > > Does this report make any sense? If it does, has this issue ever been
> > > > reported and possibly discussed? I guess it’s kind of a corner case, but
> > > > I wonder if anybody has suggestions already on how to possibly try to
> > > > tackle it from a kernel perspective.
> > > > 
> > > 
> > > That's right, unrelated apps can share the same futex bucket, causing those
> > > side effects. The bucket is determined by futex_hash() and then tasks get
> > > the hash bucket lock at futex_q_lock(), and none of those functions have
> > > awareness of priorities.
> > 
> > almost. Since Juri mentioned PREEMPT_RT the hb locks are aware of
> > priorities. So in his case there was a PI boost, the task with the
> > higher priority can grab the hb lock before others may however since the
> > owner is blocked by the NIC thread, it can't make progress.
> > Lifting the priority over the NIC-thread would bring the owner on the
> > CPU in order to drop the hb lock.
> > 
> 
> Oh that's right, thanks for pointing it out!
> 
> > > There's this work from Thomas that aims to solve corner cases like this, by
> > > giving apps the option to instead of using the global hash table, to have
> > > their own allocated wait queue:
> > > https://lore.kernel.org/lkml/20160402095108.894519835@linutronix.de/
> > > 
> > > "Collisions on that hash can lead to performance degradation
> > > and on real-time enabled kernels to unbound priority inversions."
> > 
> > This is correct. The problem is also that the hb lock is hashed on
> > several things so if you restart/ reboot you may no longer share the hb
> > lock with the "bad" application.
> > 
> > Now that I think about it, of all things we never tried a per-process
> > (shared by threads) hb-lock which could also be hashed. This would avoid
> > blocking on other applications, your would have to blame your own threads.
> > 

Would this be somewhat similar to what Linus (and Ingo IIUC) were
inclined to suggesting from the thread above (edited)?

---
So automatically using a local hashtable according to some heuristic is
definitely the way to go. And yes, the heuristic may be well be - at
least to start - "this is a preempt-RT system" (for people who clearly
care about having predictable latencies) or "this is actually a
multi-node NUMA system, and I have heaps of memory"
---

So, make it per-process local by default on PREEMPT_RT and NUMA?

Thanks,
Juri

