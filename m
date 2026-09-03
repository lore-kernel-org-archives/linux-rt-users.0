Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28A3876B3
	for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460766; cv=none; b=Vzpc0qqEJV5g2xNymrUB+lrbot3R7zxcQBr23S4FZfQrJHZJLvUp5UJJVJOhTQqJQ3/Uw/yBglIAgBIX+VT7AaubaE1iaxKKHn20vnDn22f5Y1314khMm8ceqVYmnGuE8D87O+IhF0hSquL9QQKpB1Eozv3vHeZX9+t1BTcfTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460766; c=relaxed/simple;
	bh=NAlN974APS9sXACArxoyGloAdPYkQNsHIIuNOASfGQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mgl+oQcHSFXsbpnfTBFDyiNx1+TjUzrvh0bt9bG1lUGCLnjUjaXICyJcz1Yr1PtmrOdh6dT8lB8xQy8EnAlUrJqy5qLFDBBTTl8gWbeFIwUhftRCUJDGIM+6JcM+KluDIuptUxI6b7r0DBb3R3rzcJmVS38cyCKRwiCUhGnucxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mblrg0u0; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mblrg0u0"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-930f618435cso13042385a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2026 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788460763; x=1789065563; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lheFe8REypwSxcxjEVLGMPn0Mo16Idvxg1PEOiBUEo0=;
        b=mblrg0u0joCQtJiAvpjxf+j+zYTq3YkBhPBP5oar3w43FcmEBOcKmQnhBJj8fxxCaz
         W0bjdHcOpWZjLCgdTwcvX+aj0oB0ys9LacS0DYtWhYLTawvnvhTj1Gx+rlYiVY0PpLi+
         y+7s5qVy6evFEhIv9EHX/3j/+Jj7Fi6wEL4ERtMW0CHIUaB7iQCfh7Hwtfvi03h9PIVk
         bKT2onf9ZrNnqzKksyFDrwbZ58bLfQ7HBeDSR6mv0/LN9MreBoclF0yN6z4nshiC00z/
         ICO2mYTDnFBm6vndg7YqyfIjqT7NrLJiZU1yEMaeq/LOzkbE6eKJz0TACgFkXMBadIuZ
         873A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460763; x=1789065563;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lheFe8REypwSxcxjEVLGMPn0Mo16Idvxg1PEOiBUEo0=;
        b=QIulO0jhDErAZ7S3hOTr1BclVZ+VAflafA27izYRWkdSKI3qAV58yCAOj6ca1eqAED
         QaZpaTH/L2F/KpZLhUVymENc7jEz8suWivqPR+wdrqLFzgzfhFcBpmKc4fLZh8GhoLmq
         lyp6YYtT6JDaaJPKSHwoxI9m12DINSwuKjl9J+iM+HAr2SUzo82JCFcBnmfsp8x7aDhA
         m1A6DgNUZvhTcygG0PJrpB6OsDnKCrrmEXgvBYV9ayJ1Vj5KDQjWShZVr5tfgL3lmegj
         S9qjr4OQPc+W3bxrFSvVketEjSEtCzUiIix6Y9c061rdu6S8eVZCvJ8T8cWMYN26uvOZ
         XwYg==
X-Gm-Message-State: AFuF++lU0tiO4y9R1XklOOzdMe2ZyirWeKmOn66KSOLMs66uNFn5G+Gl
	8SAlhZqZ1VNV2D3PYVsQZAEUjFd901LOFm+0zctS1nELxqHnTmr47ZWX
X-Gm-Gg: AYBFou1+yg1/2bdlJLEcubfWDBClCuOTFAfrtBCR7ULHHy/Rwuf+1kyvRtboi0wjXRs
	4dAXBzxRiYHiAuqEQ9BcN+7bhfxZ2jfJxDPjlq1YOPF9f0EXD7WttL9FCObxxUMr1PCcH5k8lq3
	sv0gumA+G25OcrCgbuvSc5jsp9xmN0QSINwqBzXyG4/weneP68ENiR4RZFiY3UwpxYV9Az3NCk2
	Uz5LqnPqCIuWqvcxNJRaPvx55z/AW1xyYuiGzPSliTbqypISpjbx2gTIQEbFPNHCKwiU9I40Wd7
	mYtIdcDHfMevy+008xCONX9JeA4y7TvgB41A2zvH/jk1VF1ZQQuP6DF7IA5FejiColfS8eYEdVw
	Rq5Er6TzuA+Rx/x06EQpYTByrfgFo3LfzbyDTpc6I2OF8XF55CCi3cYj/VE+mgZMJi4BVU4N9If
	aBPUqO793ZMzXH4QAbb36GuvF+ofkeLfEFkl322RRoMpD1zpPSGLVD+KbWYSut1O5bONR5s+CpG
	BY5/FXMFbucr8DGFzfnKJosQr95Os6skgdy4GII2lAhsrY=
X-Received: by 2002:a05:620a:690a:b0:936:dc16:206b with SMTP id af79cd13be357-9398043f64fmr57011785a.26.1788460763132;
        Thu, 03 Sep 2026 11:39:23 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397faf927bsm28162585a.8.2026.09.03.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:39:21 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:39:09 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Suneeth D <Suneeth.D@amd.com>
cc: linux-rt-users@vger.kernel.org, williams@redhat.com, jkacur@redhat.com, 
    bigeasy@linutronix.de
Subject: Re: [PATCH v2] cyclictest: Fix BUILD failure for GCC_VER < 14
In-Reply-To: <20260902095807.3531-1-Suneeth.D@amd.com>
Message-ID: <946c45dc-8ac6-407c-97f1-c88b21168221@gmail.com>
References: <20260902095807.3531-1-Suneeth.D@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 2 Sep 2026, Suneeth D wrote:

> timerthread() uses bool, true, and false. Those are keywords in C23,
> which became GCC's default in GCC 15 (-std=gnu23), so the file compiles
> there without stdbool.h. With the earlier versions of GCC the default is gnu17,
> where they are provided by <stdbool.h>, and the build fails without it.
> 
> Fixes: 98fcd661ac59 (cyclictest: Acquire a lock before invoking pthread_cond_signal())
> Closes: https://lore.kernel.org/linux-rt-users/4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com/
> Signed-off-by: Suneeth D <Suneeth.D@amd.com>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: John Kacur <jkacur@redhat.com>
