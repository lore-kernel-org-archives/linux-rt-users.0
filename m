Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DC175D4C
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Oct 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462416; cv=none; b=TMIGtjjpdulBe2kzNUezVi8OdcINGtaFN5iL+ANwoldr/+ohFngKe6/2xHtKMfrJL/cAsjs+IZCvlmcB4P65nvu1npCisd3rTxjnRzdbR7fLxUYh2d3Rhy44CBNhktTOLiIPry7EtwI7WGfZ5mgPpmkmjs4iMVZNx4WHNQkLd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462416; c=relaxed/simple;
	bh=obXngFnmMN/LZAb7R2o+/YAqXsiJoWW3fvcJSOyXWBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9uhaGpSXMi4YfHi1401HZ7XxOgI97EN4vvDhLQsgZBJW9H6sW893ydyF9B0v1HYiERSvD34swEiznwNTfE2x4N66AJOPVL1dL69+wDtXw8L/6z/bG8TyPJgEfD/7zA68fcAMad/BhAPIv6+Mc53qLHcGjf122cAC475mddMgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ai3OAyPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai3OAyPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIFHNk7sZNxShh3bVR5zotS0Iveno/DHrmVz7gVszT8=;
	b=Ai3OAyPy4qf35KtSns2p0l7uTEEd2/wUyN8Yp8fV88zIsOIHqetDzGQCLKSXHcuRhh/VPp
	RQgO/3Kzz3plTF/3ML2ARwayoNKW1s7Y0N9ZvXoWGLVSVWrYXOvQabFh/7wXtCsR9fFB94
	UmvAwiY3S1BWsnzcUaqIbdsyhP2Yi7I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-TLe9-Bo-M3Om2gF2QY_bQA-1; Wed, 09 Oct 2024 04:26:52 -0400
X-MC-Unique: TLe9-Bo-M3Om2gF2QY_bQA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c513582b05so117140236d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Oct 2024 01:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462411; x=1729067211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIFHNk7sZNxShh3bVR5zotS0Iveno/DHrmVz7gVszT8=;
        b=oMa1tuDXrDQs90+ekf+GZHEi2al0/rZyREf8wTB7e0v46FadyhWljQIe+m3k3kDDlb
         KnO4A9xZiC+EEvr+IJLCf58s1ZAJBDg+/0IUyrD3MIYvcDTcR1lG0Llbdrp+zKfyQd6X
         pff36Xgi6I4ESJkUVuvuGNufTxgYS2lmMu97IbL0Kyqa1J8lkfKIaoQ5YLUHrNKRb6rw
         iFhRYFy2fSXxLotzp0GwJy6rN+axSVksKyhhxdI3sVWb6rbNKR+ezmPaeoWJbKms7Q3X
         AmkJUaER+kDG/n3QtqTjknBPc1D6hSHUQSVJEwyERgbuj+PvVwFh0T0Br4Ytw3pOpCxS
         CDgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4NgRTixrx/27okihgudkQV0wAffyouIDpzyPSv84v8P1bvp1eBn2HdJESKo/8R9onSzz86gxVKym/Xm/TKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHsktrs/zioRpPQG8fOKcIsUa5GNDE0YNDK3Uapnw4INZz7ek
	+Y0hpOrmrEROv2InyjOrxqX5UONVIPc/jHZqd40ySJ9jmhl+nJ9FsqJ2Vawtwc3M7S2O8Dexymw
	puDJY3D3SbNbPv9BSKinlkkqedsMAUfmCnaPhbJIfFb7b/tqWHuNC43Zoz9xDkte6
X-Received: by 2002:a05:6214:4a8c:b0:6cb:9bc9:e24b with SMTP id 6a1803df08f44-6cbc95801c9mr25654636d6.43.1728462411402;
        Wed, 09 Oct 2024 01:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlYycaHbhuzGbICFJjwxzEB8gUP2gOuEMOI5StZwaakXq3gML2hlgDxFr6JTHiGWZ9wt2kSg==
X-Received: by 2002:a05:6214:4a8c:b0:6cb:9bc9:e24b with SMTP id 6a1803df08f44-6cbc95801c9mr25654486d6.43.1728462411081;
        Wed, 09 Oct 2024 01:26:51 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4752828sm43626336d6.95.2024.10.09.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:26:50 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:26:45 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <ZwY-RZ51-1fD_9mr@jlelli-thinkpadt14gen4.remote.csb>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <20241008173859.GE17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008173859.GE17263@noisy.programming.kicks-ass.net>

Hi Peter,

On 08/10/24 19:38, Peter Zijlstra wrote:
> On Tue, Oct 08, 2024 at 04:22:26PM +0100, Juri Lelli wrote:
> > Does this report make any sense? If it does, has this issue ever been
> > reported and possibly discussed? I guess it’s kind of a corner case, but
> > I wonder if anybody has suggestions already on how to possibly try to
> > tackle it from a kernel perspective.
> 
> Any shared lock can cause such havoc. Futex hash buckets is just one of
> a number of very popular ones that's relatively easy to hit.

Ah yes indeed. Just thought that if we have ideas on how to possibly
make this better it might still be worthwhile, even if it won't fix all
issues.

> I do have some futex-numa patches still pending, but they won't
> magically sure this either. Userspace needs help at the very least.

Thanks!
Juri

