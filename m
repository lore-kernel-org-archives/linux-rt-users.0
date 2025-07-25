Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09701CF5C6
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431192; cv=none; b=jjt1VALPBC+jn/dzMwz9+D8cKqmbLeu5ftnqL4MVfRmZgbEJAIoWUcw1cTBnsf3n+v5oNdm4RCBegq0jXf2SAU6RwEaTIrOxacczuylTj6NjH+P2pS0XvXogj8wsjmQpZCwWLednDYdevWFkx+BZI2ag+yJHkvxmyBgaEjQ4kw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431192; c=relaxed/simple;
	bh=b6U9YilnCRvzmiC8uiHSBL0gWdKxOwv0ai85eGsnOT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2rwXNkPmpB0UMdlGY1fjg8RQlgMjNBjS5FXdekWdbAtIyHfiIXj2c32KuUzNhzlkBX+Oatfvk9kEWWOlgyMUvGv2S5mOwcHEGoai5G8n2Aa3ubOtcibamSNTYuBz6UEhrxD6AdOPuIsYAmjRD/iayhnZcosgVTdNLNtfvoblJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G9zV2lsk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G9zV2lsk"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so298965a12.0
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753431188; x=1754035988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yEsN6/n68YrGOTTP7Iee3Rit6H5gs/0pe0JPH2a01k=;
        b=G9zV2lskAKE9v0jh14IAR3KmnJgG9hFE/nBT5kLQsn+N9uNu/q0nbkjQouz6ymlpUV
         EQn73+0d7yE8bq8NXrtqk5QGCgffJUZBNh+U7WyJWGeUkUpnCUn/FDDPs/nMLMKEFqxT
         Xax598TKHxjdrlWPC18zUg8NsCzFOyCewmI+T5l9DQFC9x0vAOAyvHp1Btg48AZcf2ww
         7vuHkGSJTn8uTF65wbBcDSfU2yDWH2vSgyJMCTdeH8xhBtrweMgfzfiE9htU7fsFPpe+
         RQsNjQ1VD0H+qxS4gcYNJICRMlkynb3ec+akgFlJh+y4arTWqobbToijdKHAnluEbwls
         Hh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431188; x=1754035988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yEsN6/n68YrGOTTP7Iee3Rit6H5gs/0pe0JPH2a01k=;
        b=tmcRj20qAteY+IGSh933S9BEpmC2KOBP25ud5SBoReIjlGSQn/US+F67IgvNdT7X2K
         JF0K5eL2jdsZd6tzkOhlQOcCGpBrkjqa8ffK5cpNlOLIISpe7f5jXxdZDT69OR2CRQuY
         Lm8LCvYIKiGv+zVkYsRe4Jyfu4fvVsp/L/Ycmb4Lj3s/YWzVnIhYNARCZF5EO30ndaLE
         kSHUG2pJ4qa0TiHHnVpsLYbhXNcQlOLESkExpTynVcDoVAqvqCcQnbPt2qAC1DOZjysO
         WnfINV14++NvzuCrqNq0XEpm5r62SgB/fkWLlABE2UgrINVr+5pXJa5HSDfGP6+EuN1D
         iNZQ==
X-Gm-Message-State: AOJu0YwWLPxVWlziVGbwM832eddButhka3+zVTREXYRnxsbi16b24tHk
	AODSuDZ2VC3wDd5QRPK0UIU4yafP5nVM2GhS9v/UnPTU7SwIQWikSC+x07nvT98DcLA=
X-Gm-Gg: ASbGncti/1sKN7ERO5PIbZl2SA5QPU/oa9SLNwQ50sQvUXE1coQqg2QGa3AQmr3bPiB
	FkdmSd16Lg0gtN2846SThdm3oMQBrIZdbUiHyetkjbqn+mmyesa2IZFrvw/3DCI5wunZMsFebE+
	YiXayd3lwfT4LTNdkJ0naUVdG3abcdrKCPqbPfxHIYz51Rlo0W+0haKJrlp/iYCR9uxL3YxpchU
	CNYXcyvVwMAM6/p8uRYS4Gj6S184FhzNzRPAciv8uxVo9sqIS7ZpVxC2YaUr2RV5if9j3PSZDSB
	TGbGGCoi2gYcXyeHKSy+B5ouD4/p//F4R1ZgJOJjCdxFKiaaGkXfWDXTlR1eneGl+wG15SCpwpT
	cJpRfHshufgg+dho625CX9jNKRYOhIHG1VJxohf7XtWXWFpZh2F/ARTwiF+deXWIe45facKE6eD
	Ps1KNWAeGJMORR9AFyu/ACYCtsUaevTT6YtKABsQ==
X-Google-Smtp-Source: AGHT+IHIvix4/9UCDYWzYXxg7KjS9FP+8INyCwtAphaOg5wYHpjnWCFSjQmSBYD80X1pXd2D/v4k2Q==
X-Received: by 2002:a05:6402:4406:b0:612:bd30:d32f with SMTP id 4fb4d7f45d1cf-614f1bd664emr360570a12.1.1753431187122;
        Fri, 25 Jul 2025 01:13:07 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0f730fsm1789123a12.22.2025.07.25.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:13:06 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:13:02 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 07/28] cyclictest.8: Remove left-over comments
Message-ID: <20250725101302.74611025@mordecai.tesarici.cz>
In-Reply-To: <20250704132721.13325-8-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
	<20250704132721.13325-8-darwi@linutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Jul 2025 15:27:00 +0200
"Ahmed S. Darwish" <darwi@linutronix.de> wrote:

> Simplify the cyclictest manpage source by removing all obsolete comments.
> 
> Per commit 79ad2eca9abe ("COPYING file and cyclictest's man page added"),
> most of such comments are random leftovers from the original template the
> cyclictest's manpage was based on.  Namely:
> 
> (a) Remove emacs markers; modern emacsen do not need them.
> 
> (b) Remove the roff macros description table; they're all already
>     documented at man(7).
> 
> (c) Reference groff_man_style(7).  Per man(7): "man page authors and
>     maintainers who are not already experienced groff users should
>     consult groff_man_style(7)."
> 
> (d) Remove legacy, commented-out, earlier cyclictest descriptions.
> 
> (e) Remove a reference to info pages; cyclictest does not have any.
> 
> (f) Remove an obscure joke about the manpage being written by "The Rise
>     and Fall of a Fooish Bar."

FTR this was not even an obscure joke, it was another invalid left-over
from the template the manpage was based on. You can find references to
Fooish Bar in many other projects that forgot to remove it.

Glad it's gone, nonetheless. Thank you!

Petr T
