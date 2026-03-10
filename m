Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4F3BBA0D
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159504; cv=none; b=QeD9IcsvqPYEmmFphNcxN/xhxAH4bFj2DuvjFuVAP1ZVVv5xHX9fbmNCmMuxPeVqO0n2Kbcbu7qk7KVvVBFdhnnTXFFS+7ZS/3FY8uSNXjxFYVGeLdR1tW5AD+UBNo8i+fgUs6jkNnA7B2Bdl9h+6OlXuvfP4qRhIrHB7jdJs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159504; c=relaxed/simple;
	bh=pZVrHPxnVbcth//BHF8GlV7PJ6LvsfJ/5qJnblU3T4w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hL714wo8rltzCJxGNGk4HptVC5Ca8MRfd+2NCgE4Zjgbl/Gl3S174fdr3YrhMXJQtfRWwiGJQV+b04yFsyRQkzh6Cw/lyB3LWd4V1LIm/4sQwSwflTiuAnvLBG8wBdEpMXa9FbOdXj8nNyANZPUsuwwdJo2asCQsJaEZ2jv3Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7EA2oiI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7EA2oiI"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899ee87355dso126279096d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773159502; x=1773764302; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZng8F35CGblcxDa7SGlbV/lvIAOGdyytAvXH22wLwg=;
        b=a7EA2oiI77r+yUXjTlEsBNGarndKr2Qk2haT/3hjrOzxZniTz+PNryZkGbhYBlkdfF
         Ixb6oQ0RD4O4Ff9XuKks0GgycA6yYEsQVamPjTbUIgDQQdmUVEt744nkM4HrRSIPlN9n
         Hf/rfAl50Bi/uTZ+Rmyl5V5GYvcgmgECw+uyh7gr5rKpUID5NeJi6p5DVsodeCU+EMGp
         Vp1+HbNI9fV2DfPDOIKT4ZkI3lV+01etxXWkAj4wGFRBjk+UiK5LJ9P17cu0QMcmR0Nw
         fmd1m9wptYmjWWKM+NBhTUIdZ8u2I180uA0SGPZyXLslR7reiGztgxD3Odl+bleURFT2
         EyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773159502; x=1773764302;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZng8F35CGblcxDa7SGlbV/lvIAOGdyytAvXH22wLwg=;
        b=OF5wYzitX84bS2Dt5ORm44LhpTPcGlRkO+hE7FWlY5GZpDRmEwUQ3Dro4JV8MiR3F4
         a9xz9xzIKnnqPHpGQm5C52hm4qgEZXi+y4BarWLfKMWWd8o1NM4JYrti+f1hk3yAwdf7
         eoDh+eIU9HtsHkxpaNllBIOGRutX/8x3RBZmKHsepW18LlD5l0cl71JlIFrfhFNgMZdR
         9oGZSCGMLj9Br2Wf1Yy6C2cyhhuQ3g2sEqqCT6jRh8WlVjjM5tI3ll66q9e+xGb/TZc8
         lf1heev0qwa52PVM4tUdSlHOM9vKuh7oXWx5Y7+Q/bzrzic8cu9svITUV+mSy8eanUlK
         ZF/g==
X-Forwarded-Encrypted: i=1; AJvYcCVNctxB2wzNJ5kyGXl8RWD8kHFMcJChkrjmWvGC5LVrQq/V24VGtzTqZM7FU02c2e3zduzKKDeRJfFqf9F7Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IKYk9XJ1SR/HD6zcrDo9rEMh9I025/CjxaKr5XINWbFz+Z6B
	SS+NToJfzEMI9iA0MybPNJV07plqN31poy2M087HZ51PlhdPSzn9rEGa
X-Gm-Gg: ATEYQzwoKE34A34j0bhA6Ip9FMgg8fSAQvLKdVMJyttONanglN0bUIxkfUiaPvhLYDK
	+6HncxTGXCbxcHg1QPjnnXwmhqy7qfIVCNDlp6ZGiFFuP95FPMtJbmuGSDE0tTKRtL8IEZyyL1C
	swDEGJ4wSpDyEtE9HEEyXTvLCsyD18WGWkMT3tqy3NNyIMseyYelaepUZBcyH46pOcopFq/PQlk
	bJlbumUtkhaf9hAlSvofmBWW1bMrDxAgFJpbEdZlfeB3K4o0dze9hVoPq+R5ATDEghq5uojxo8n
	6nNHVo58GDgSPWYKP8Keg6MLvmAsGRZY5seGhhKZTl2ozX3n/k/QARb48p9fy880vYgLZquzVAw
	Nt6p3kVRxd+uVKCD/TBqqP2zSTww4J48V+8ytaRrCzgCjs6NkPzmf5Cw2ivmqTVzuxVHPY4TeWH
	WkNB4YHlHzMO8y4yEsmcDmM348csMKwiRSpJZa/k9VQUcuv1tYHoyjYj8DdtYu3vGjacs7i9rO9
	Q==
X-Received: by 2002:a05:6214:518a:b0:899:f0af:4f51 with SMTP id 6a1803df08f44-89a30a34904mr195252046d6.20.1773159501797;
        Tue, 10 Mar 2026 09:18:21 -0700 (PDT)
Received: from Cumhall ([70.50.116.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a3a9a2sm22463626d6.15.2026.03.10.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:18:21 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:18:09 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Crystal Wood <crwood@redhat.com>
cc: Lukas Beckmann <lbckmnn@mailbox.org>, John Kacur <jkacur@redhat.com>, 
    rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] cyclictest: simplify rstat_setup
In-Reply-To: <9ff2d632fbbc58fda5509a26f0dee26d6c3aefcd.camel@redhat.com>
Message-ID: <85147e31-053f-1b0f-e200-5d49c1b8b123@gmail.com>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org> <20260301212407.3146506-3-lbckmnn@mailbox.org> <f504e9c5-95c9-79e4-0274-f639a4829af9@gmail.com> <9ff2d632fbbc58fda5509a26f0dee26d6c3aefcd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 10 Mar 2026, Crystal Wood wrote:

> On Mon, 2026-03-09 at 18:55 -0400, John Kacur wrote:
> > 
> > On Sun, 1 Mar 2026, Lukas Beckmann wrote:
> > > +static void rstat_setup(void)
> > > +{
> > > +	int fd;
> > > +	pid_t pid;
> > >  
> > > -	if (mptr == (void*)-1)
> > > -		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
> > > +	pid = getpid();
> > >  
> > > -	return mptr;
> > > -}
> > > +	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
> > >  
> > > -static int rstat_mlock(void *mptr)
> > > -{
> > > -	int err;
> > 
> > errno = 0 before the call to shm_unlink for good defensive programming
> > other than that the patch looks good, I will do a little more testing
> 
> Defensive against the library returning -1 without setting errno?  Seems
> a bit paranoid and cluttery... all for the payoff of an "ERROR:
> shm_unlink Success" message if it ever does happen *and* the old errno
> happened to be ENOENT.
> 
> And the current code uses it even in places that print the message
> regardless.
> 
> -Crystal
> 
> 

Isn't that what defensive programming is? Guarding against something that 
is unlikely? It's one line of code that I requested in a patch that gets 
rid of many lines of code, is that really worth arguing over?

John Kacur
