Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C7210F45
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Apr 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002300; cv=none; b=eG9hR2YIof6uo4UNQBxlEbEJ1ErMgR9ahMyYhhLAs58G2xQT9n45o50e224Y39Yud4hVTwTLGIB2xsS0pkwd+vCrXBOJIQqx4UQmEWlz1sqpeDD3OLcTg8ZtfwpoPus19wTluAxgdswQzWzAyK4Faxe0LdcGA++FhdwcyZJ5/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002300; c=relaxed/simple;
	bh=8zi5cyFcVckW9t2pCIiEBn2bNjtZCSk84A1Zm7fViRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWdpy28AcxYI2szV+GGdC8Vr8ZjWvKR2WbnHxlUiFOE22VDxRgtP/WKdu/CVu7DeCfuOS7ycv84wrFEtFxxsGWo0cFLj02EEBAQuqGyDvXswkR/yJrAgnG3TX1jKqoc7N6KBMwpHcxMmqB0f6UgQU2e70y3YiGHBsvWTogOErx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G9UnLdK8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G9UnLdK8"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac339f58631so85404466b.3
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Apr 2025 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746002297; x=1746607097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw1h6CkpVzZ1WBfBkzfAYu3EbWwU7nqNOd7qFsicdoU=;
        b=G9UnLdK8r+iN0eWelzoAzIFW/A5vA/6jDVRooAJxg7oy9txOWJctSCcKbuIjhmBjx5
         fpzWJyE/bIsmQQu1ccKDlzrOw11yvEfMqgg4qRJ6khzy9rh3z70s7AhyDRrpPUVbKN9N
         5SalCSsxP5rK7zT5aQ/oZqGhzB53Ztees6nOH3B4n+NU8V+t/MUiH9q3zLUyyXWfbZmz
         3HTG7N3TCErlC2RhVkSrANZc1XSqeIWLjsXLLSvSkdQYJIPp7ilveimM0QUj4UGp/u3X
         /xzV7W9BIU19RyIapleKUPK0KWiJ3farSMxP8i50nme8umAC8TjKunK1XI48BFBVn3Bs
         /tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002297; x=1746607097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw1h6CkpVzZ1WBfBkzfAYu3EbWwU7nqNOd7qFsicdoU=;
        b=sC1o5KZTaCMnpzXbJ8FcDL3nSaQKkdQCNa0LxWreDx7sBOxiAn/qGnjCntDVD8Hifr
         6PdcJzuaKXCqP3oVSnIHxMcluittCRyPkGd7SMJvhzudwCae8ahiQ67qEd4EQQPUIStk
         gEDoVz8E8EEfud/oYdP6IS5RlD2xHAll0TH0VWexsK3jNxw5R2TBPxCAi/BpvUaM6kvU
         Wchk7ByLUNLV8Bx9b/zLV2IfgOmwJC4OggnbhWqdh/JlMcRcsV2ANMl2Q7toFtjIvL3S
         +W9a9OcKENvSXOUaK+MYJmT9NTAnlbHqDJdpH+U1flTSynau9zBgG1SBrmzfISaoOWUq
         QWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS9EnXZPj6dyo2qeZ7NGILWXz+xRbdd/0+I8SsFOrMtMX1xe2raJALohN0UYuaPItEZQgPxlTcB2yYqG7Pdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnrS3u0zUhexA9566NhFfgMrd5HfVubc+uQhX0Du6uR1E1NHc
	m0njbO0wl4837leqrxJL+aCKQPLigvowJ5f+A8QdnZPh22x2q2WFYpCZU8syv8o=
X-Gm-Gg: ASbGncvPMWTQ2pPs9qqH9TX27eY3MQ2fL9NGuROFgs6YhXtX/BUXaFBHVtc479gwbzj
	C1HWE+qvVCT69uFsfEVmmrXLgxvG6SAzj3RSTp7pvMbZze9uyqTGGSAEMVcz2S4rXANJJsmOVlB
	O5bdKo0t6MyqJIOSGoMZUwfkNznfQa8Y5oY7klA7miM20E4LT23npsk4jS/Tv/1T5L7BCnUwnc6
	DsSm8LF8onObTzUtlLtJK1pPzb0EDNrZnO/Tu2SXjSdfUsmjhek63SgbTAv4W9lVpbuyDBqZ+nT
	3AusR5Z/HJcQrf4+EGqj3TdvVODfWds/l3jjYFv3bZv5U/ics5fS/8woFL0w/mwxGoFG9d2OGSC
	Fg+d1WDGp2KI9IaevPXjxHpkgXo8N3A==
X-Google-Smtp-Source: AGHT+IFqkJthPFAOd6c/6owM9CGgAK4lDSph/qo6ciNRRRzE4a0sKhq9+GnkkHtvadbY0MtJiZLKgw==
X-Received: by 2002:a17:907:f497:b0:ac7:9237:60a8 with SMTP id a640c23a62f3a-acedc610398mr81783766b.9.1746002296958;
        Wed, 30 Apr 2025 01:38:16 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec668dd9csm245517466b.96.2025.04.30.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:38:16 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:38:13 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 catalin.marinas@arm.com, kernel-team@android.com, Mike Galbraith
 <efault@gmx.de>, Peter Collingbourne <pcc@google.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Thiago Jung Bauermann
 <thiago.bauermann@linaro.org>, Mark Brown <broonie@kernel.org>, Kristina
 Martsenko <kristina.martsenko@arm.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>, Juri Lelli
 <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 0/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250430103813.5bea9f4a@mordecai>
In-Reply-To: <174593068821.431779.9112946165910138990.b4-ty@kernel.org>
References: <20250305104925.189198-1-vschneid@redhat.com>
	<174593068821.431779.9112946165910138990.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 21:27:52 +0100
Will Deacon <will@kernel.org> wrote:

> On Wed, 05 Mar 2025 11:49:24 +0100, Valentin Schneider wrote:
> > Hey folks,
> > 
> > This is a resubmission of Mark's patch [1]. I didn't end up changing anything
> > other than fluffing up the changelog.
> > 
> > I ran this under an arm64 VM, added some trace_printk's and checked that
> > sched_switch's between runnable hackbench threads would occurr in the right
> > conditions:
> > o with TIF_NEED_RESCHED_LAZY set
> >   o at the tick
> >   o at do_notify_resume()
> > o with TIF_NEED_RESCHED set
> > 
> > [...]  
> 
> Applied to arm64 (for-next/entry), thanks!
> 
> [1/1] arm64: enable PREEMPT_LAZY
>       https://git.kernel.org/arm64/c/c8597e2dd8b6

Great news. Thank you!

Petr T
