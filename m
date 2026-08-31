Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B88372663
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194602; cv=none; b=WSpL1Wgz5w+WFOaOYdJHTwXfqomtmG6GZynCiKnAy58rSdSH6xowQfo7S1wCyanL//ElDJvKj0Fj+z3G3vgnWVJFnbN0ewr0m/EwdXj36CfR7o0BiTNIhYRkg23g337t5xgdW98SxC7yilNCVUiEKA05HSy3zQ1K/X66LajCi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194602; c=relaxed/simple;
	bh=Mz0czvFy1Sr6/hxE0ONrYntgHrcUM5k8l6IjSeRAPl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bj/Kcpli0ePtim28CmihbyxRgw1zxn+6rnToeZMOkm5kyQ/G0h2MqtzQL9jcwXYtC+TAx9LSuCzrnqlqTv90RkB4Ml0zUt4t0+6WltYSH0InoV0QKZbCKynAlLg3t99YF2S+F0h88KxI+w+fG1qNnb8A6VpncxTBu6+t7obkyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npiO0OZN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npiO0OZN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90cca401c89so38190646d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194600; x=1788799400; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyopxOEcrsQjI4d7hEIU1w5aau/2cGuPL37eCKrJykE=;
        b=npiO0OZNgkq65hyCAur3X8sfxLCTUuadNc0G4lmKC0VNFg7s57SNy8yOPp/JJ+A/iV
         IGkg0T47c4NUkNFUKu6o3C3qa534ouInljC3n+QRX/MaAdbT6qi8mRZSIV6h96SFrCgs
         Dt2zSnSMMUwmvWoQoZXyoWwtt9wHJNIGvorU1gzqIkLfkyR2rsch3TK+th4r+r+AU8wo
         S/eYjiEvnrZfupdNi2GsdCIOMyFrFIDB/nCprY1w3mgWS1aG/VmTQOp/w2pkxIvZtYAe
         wnSpwPCECTZIZoXDOoA6DDKRnDXG0bouWUcDydXNQ96KkXI1oQeVmm2EpJDXekCT38F0
         OEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194600; x=1788799400;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SyopxOEcrsQjI4d7hEIU1w5aau/2cGuPL37eCKrJykE=;
        b=IYxoJchKka7zecIDFqnNvA5XJM2cUza/b5NEPO06Qh6icQ40JwDxIM5NwCpeVyh0hQ
         o7VmWn4CnGR98DzOsDe1Ti7/Eke9/NGQg4EQmIOYyr01GjqTB1fHeSOIAOYRlMLoCy2t
         vGl+ByaYkn0ugjqeG0my++u6dkWe2s0VWziZWupGW4vDS05c909QSYUTowoS+3SJyr6m
         d7sv5KoGBCutRmBqPUZ5JZ6P6udKymYAc4mjOBdx2XY8ser3JjAqXYgQLZvBZltRcLTO
         0MEM7tuOR6gqqPc1HYXsnz3XMXgclIAI8l6gjr9eavIqbbYjzgkwttnk7K77H8TLnSaZ
         K6EA==
X-Gm-Message-State: AFuF++nOWAJw7UX9YJgKIy4r2M6ChRn4YofVMs7YZ473Oy1InS0ZtDsx
	Sd5zxeX5zXOIBSuXwjXIdFjGhXW3rJV4o2ioRTFF061voC08yacaBuwMPiCaJQ==
X-Gm-Gg: AR+sD11juYEz17HbppCPtg6mOb3ha5+aeLg37zHOUEef5x0sZDg0Ccd057GHyicMU4j
	vIhtlO2vww61/1ujDwFcSIKpp2h2Afzj2fVhmCVUGbS2H73smAi1d0xMEKeAOLgCGIm6r+UWj2N
	fSyOn0+lY+cSbtar0mOmncwV9Ai9r3Q/srGoJXbKx8Ezb/s9ixwU1mcoEkM4pnEfg4bmvujUUdg
	bJKlGJt/Jbd/gNxuEGiHHJm2ICd8pClTVN/ws9EFe/j3GJlXhFEu/TuVhEaM4FiY96062HFr+6h
	w0/NOW466eTC2m+Hns3W06IMzrkk8IEzukDgvD9BcdjO7tZFCZiERn6qrILFIks+wW1QCu0q+qR
	2/oSg+oHPLkP69VOvt9z7udOfEki5hmozXkx/HHTDC480rLwinxt7EFCg/EeSWcRZZ0wBEsR/st
	odr8GsAxN083rioOls4/VRLv6Yn3dDvFxD51L8cYBTKt/fDjlxfJzMn79W0rDvy/78EYQ9TihYP
	Cxz5kXU05k619Lhp2dZYjqritLeZsm9DiOv
X-Received: by 2002:ad4:594d:0:b0:907:c025:e4 with SMTP id 6a1803df08f44-90ce0e7d878mr326707766d6.13.1788194599551;
        Mon, 31 Aug 2026 09:43:19 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4460e56sm89396216d6.14.2026.08.31.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:43:18 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:43:15 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 4/5] cyclictest: Make trigger_lock a PI lock
In-Reply-To: <20260826132153.2476006-5-bigeasy@linutronix.de>
Message-ID: <61ec370c-4c03-9cd3-e974-3ecf84775923@gmail.com>
References: <20260826132153.2476006-1-bigeasy@linutronix.de> <20260826132153.2476006-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 26 Aug 2026, Sebastian Andrzej Siewior wrote:

> trigger_lock is acquired by the timer thread. Given its usage it
> probably makes no difference if it is PI or not but having it as PI will
> keep the RV-monitor quiet so let's do it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
[snip]
