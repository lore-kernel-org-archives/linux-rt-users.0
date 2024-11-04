Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0D469D
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731852; cv=none; b=gKTnMydLiEB678Bhlo2Ty6xuL3WHOiHwhihNsC8+P3Jmr87chpX3EBkpSpzx863BzgRQzGuoec7MRtNZ+yc6BPinYGJwAQBxuf1l/6gi8ubUDyK2vIC9euWLRVPqRLwx2ya5GlKsjAVcWCAHqLs4nC31Y92ulT4UEYSpliR9ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731852; c=relaxed/simple;
	bh=gariBgLGgx/vmgnWGiDP0J0oLXRj/uqKo2VsDnSOSL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRrQwQGyE2b2VTZPRN7UoOwjLYtKZatzggEPrej9989K6Py5Hf1kJNkmEmqC7XVFDW+IU9s28005T+GDXKbtZYVTCT1w+/HA8HnCv/2n1D0EfUK8FB4qhObHmsSbLHJhBuAO3cp2gbgqDjDddvN4Qn/DK843u16L0mbvKB504Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnkXGUAp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnkXGUAp"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea07d119b7so35480527b3.0
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Nov 2024 06:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730731850; x=1731336650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcs2cBnEoJVlcir7kvkf90VxNRN71SjM+qZmGOn4M4o=;
        b=VnkXGUApaSizqLclRckrwwdw+RsKCTleP81CrfhelhcHLtmwWoUnhBuFklG4FnrGPf
         IM06hh5OwtReEG4mdHJpINT8YYweDiJBCjTgTCbaJE8BnZ+i664wV2BvhVyDhFXTflsI
         4HpAmX58y3Q2i8IvkPteoDqGcgCzB8c5OfdSt+VUQXckz8MTA86jzYHGv4DbSrENL2Nb
         Ah7s2gzZmm2ZOFZmwMeYab7UiGSBPiF33TV9g/9QcfH4HhYORma2S/i1NRGUnECMee4k
         0LpCrD8Essj16NHgGv7o40An6kjFClvmDUa8PTGMITrojCf+DNRvLny9SXt1GAVxA0bb
         sHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730731850; x=1731336650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lcs2cBnEoJVlcir7kvkf90VxNRN71SjM+qZmGOn4M4o=;
        b=IY3Ezav7+M63faJDf3KwJdHhLwRlEWvhgZ7ksor2bX1jfoM2KORGEJ2ty5FuEl6i5l
         6mTLEsuEe5FfAkQeLo70rObCMhkNe6n812qEFpAVKVqTkPRHyZstPjgZkVh7/N3tKSN+
         3sVJAx9andNLPV2fYaiaend7DTGfjVmqEJSWHHeqlmWQl/oE8JpCnGEUznDy31BTpt5E
         Ebjr0ZHWhecCFD9RscGwtR5pMudN2koizVuxgZlzqmPJHMEnd4LXAM4JtqxdrFqiVf4O
         klDqpyJsY5/LKIhyEde8lMmYHWLFnnR7xG6BIw1fvt28YE25cr/Rk9xXVY5Ur0bypaWO
         QzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUatSFdvp4xMdqavT0tGm6svwLZX+MIW+aOqbjaquSMAnhSZPXA/P1WkRGd6sEzo7Z/8irRI0CSDek0+4bGRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPHsy+hQRoZlgdBEUd6qdQFfpsOWdcE4NrtcpA2rUKQRiK2Qj
	36JamvyOgZnR/q8S79tE6HfNFGuTG586DmdOUotoOmnC52drSFZf
X-Google-Smtp-Source: AGHT+IGTwspGblBJu6ScZAyTeyuTgog71fQIkHDB2OSgTLmWtl69KzDe3d9w3Gr4Rqsed08s+zONOw==
X-Received: by 2002:a05:690c:8082:b0:6e3:d6ff:2db5 with SMTP id 00721157ae682-6ea3b9830f3mr135729637b3.40.1730731850033;
        Mon, 04 Nov 2024 06:50:50 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7c9cbf98sm10389027b3.87.2024.11.04.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:50:49 -0800 (PST)
Date: Mon, 4 Nov 2024 08:50:47 -0600
From: Andrew Halaney <ajhalaney@gmail.com>
To: Derek Barbosa <debarbos@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
	bigeasy@linutronix.de, john.ogness@linutronix.de
Subject: Re: [PATCH v3] printk: nbcon: Fix illegal RCU usage on thread wakeup
Message-ID: <wrj552wplbprzdqnracug4z2dbtgwcot3kmjkk6xnfzophqmpy@cicbhbb7mzky>
References: <ZyjaTu8ktE119iwW@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyjaTu8ktE119iwW@debarbos-thinkpadt14sgen2i.remote.csb>

On Mon, Nov 04, 2024 at 09:29:34AM -0500, Derek Barbosa wrote:
> In debug kernels, printk'ing during the SMP startup of a secondary CPU
> results in a splat on boot that details illegal RCU usage from
> offline CPUs.
> 
> This patch aligns rcuwait_has_sleeper() with what currently exists in
> Torvalds' tree, at commit 76f258bf3f2aa, and will avoid the
> aforementioned splat.
> 
> Furthermore, this patch makes it so that we avoid the use of hacky
> rcu_derefrencing through the waiter's task struct,and instead leverages
> the correct RCU API with the rcuwait_active() function.
> 
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Closes: https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>

Thanks for pushing this!

Reviewed-by: Andrew Halaney <ajhalaney@gmail.com>
