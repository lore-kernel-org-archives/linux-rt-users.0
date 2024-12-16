Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11B84A5E
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364378; cv=none; b=jGVCs9EiW59rNayU2L5UnOqNXEnMC0aors9NhBGCvin0Y4AsIgp9W0yOeOBgQgWaZnskFkKfq1O5tCXjrYcssa9Pd/+AZ+G3gfv0zJXojo/PTL//fp1xQBCoQtmGbiGq2KZ3xzUIz8voKyM6WFyf/pW5eYsSKhAKNQCXv/7TN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364378; c=relaxed/simple;
	bh=oGAvYTUda6zsqAhxih/iNc51wzbk5dR2ZYfn9oKE79U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IveJzAmuM4QuJ8lN08Rwacx7N22yo9d7JnFiVDfqQkeFXADELbJuYOWa8wnCmJ9Pv/+Al9EJTiWcbUymnbx3Ct/JpcrTMV2Yg7UmsuhqjYr8UpogFJgXiaVpSuUrRQvLwzy5cNvlkbu6r2tdN6iJtlXeVDqJxfuKzkd/Ybrjoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+yEyA33; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+yEyA33"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385d851e7c3so196748f8f.3
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734364375; x=1734969175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38FKdhz1VvDhc/ssvKRblfgMS+wpHTOD89YDjFr970E=;
        b=W+yEyA33HKEXGeiMVqnAbUYCpP8PihKlnWR3IwNH3cNh8A2X0gK9n8ROrVfpdt8H5u
         xOdls8umhW1SDnY6Qu8vJdLaoiO4xCNZ/j+BhRqRafPPwLWHzx3xvalCYP3sHT3Q3G8E
         VJDlRPPfbb4bbRObbGcfpyOKG41YjkRr9T9ohOuitd/SL5+qsHqqVrra70hztxzknuLy
         pfshaEHlQZOOv0MDZ9e3OfI8sfHIlxD0VPLK6PkfzWJO8HyAJJuh7HYIO1BiKih7zEkB
         RFRovPtg9P/YjxA55QWZ67oOUgxGM/uF3e2WyoQclZHEVtndT6/BbyuWK9hl8CUNHZe2
         RqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364375; x=1734969175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38FKdhz1VvDhc/ssvKRblfgMS+wpHTOD89YDjFr970E=;
        b=gQRCAEj0N4Ph6GJ8P+OVN7MgaeSaTUr/ziRRJkYtcJCIEkGlbWBn8yqjXsR4zF/SH+
         UIIIsPqCrCQ1sovbMI4Ulz+BluZILUGky4jSh0fBzl1+Qh1oKdDupKtD23Ck/1Cmd9pA
         f9r7dwBfPWnftffZ+2D4S0yW8VUrhz5vMYDh4gDChbd6PHUq66XAdrlGSgkR5balnVM2
         6InT4zILhKDNauUlMHYB81IQwVpXTQvpEOvgXkGIa725vyxbr9AN9dSnlfWrYx10LdjP
         2tHDPSMCaiRoBFH/qDwkSSIOhgEsC5lX3Qzw29n+DvfHjXTc0ofCw8jXNtRkWIID6VbH
         nBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcCbN7ohlC9jHVGufUhYnv6wL5CMys8xqfMFshXfsULa2bBo7YlYjdhi50KhtDnPQ9G+YxVwgYpGujlvFA6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyovvxxpsywRXCKQFdNkx2aXDNLIq9RBLKEpL8x3jaF/iYLaJOo
	16D9fN8LsGOAUEZoYaqJX9PnBmaqlfTYRzIROpacYHC+nCdzRZUANSfH1DC4McE=
X-Gm-Gg: ASbGncvDixC2c9ORTXcBt6lnvGhXQdgZPvISdHw9aQ9cDswMisRxBoJkQBFjtjXGnqj
	wxee4+dnUsNXhXYaYZ6DCl4SuaFqf67yxu0eEnnzAMaSwTlBwqPhsnttu7ihapBIcjHM9Q1hlIV
	lekc6QVgxdvk6UIdk+4pSmkAcSeMeXFMAiyEbYyb1g6moZT0apeIgB/F/7BO9djMCimf2tyNssW
	j71kdbklMJMOu5qyklI+9sdui3EfkijK9vVXHBNhLGIxZhPGaOGMuqrCzPm1T//1X5ixUj6IX/f
	T6/RfVPkyStobNpHphyioCDRjHHSJXjoWOeax0mVWABu5wYRDCvEVe9t3n2wzw==
X-Google-Smtp-Source: AGHT+IERJiZgYVHCfr1v98k+3qwUb/e+s8BAL/XMJ5t/zmC887eRAbHa3krDvJnb+Btr6fWCPTHiqw==
X-Received: by 2002:a05:6000:4b04:b0:385:f0c9:4b73 with SMTP id ffacd0b85a97d-3886c72110bmr4641130f8f.0.1734364374759;
        Mon, 16 Dec 2024 07:52:54 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804d573sm8397658f8f.64.2024.12.16.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:52:54 -0800 (PST)
Date: Mon, 16 Dec 2024 16:52:48 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.13-rc1-rt1
Message-ID: <20241216165248.5cae6311@mordecai.tesarici.cz>
In-Reply-To: <20241206154701.8XBv1qNE@linutronix.de>
References: <20241206154701.8XBv1qNE@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On Fri, 6 Dec 2024 16:47:01 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Dear RT folks!
> 
> I'm pleased to announce the v6.13-rc1-rt1 patch set. 
> 
> Changes since v6.12-rc4-rt6
> 
>   - Update to 6.13-rc1
> 
>   - Down to 24 patches (including three new). The v6.12-rc4-rt6 release
>     had 42.

Great job!

However, I found 26 patches in v6.13-rc1-rt1-patches:

petr@mordecai:~/src/linux>  git ls-tree v6.13-rc1-rt1-patches:patches | grep '\.patch$' | wc -l
26

It turns out, that these two patch files are orphaned (not listed in
series):
- netfilter-nft_counter-Use-u64_stats_t-for-statistic.patch
- riscv-add-PREEMPT_AUTO-support.patch

What is the reason to keep them around? Is it even intentional?

Petr T
