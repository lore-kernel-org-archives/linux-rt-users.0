Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CA52FE2A
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063588; cv=none; b=UF86NvhHa0kru6gNSfx4HNe9WPc5W1BLh8ZtYw3wWoADSe+bSjgoQTcbfm6xJSx+7E+PGHoYVFLzMVpA7J9QWIwg9cJyoQiUm8j/591QIE1gLfwyA8lhPB/Hk5kXi18l4PlArhMOfLvFvgAFuc1/ifWlzeMmUZhK2fqzDHIDWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063588; c=relaxed/simple;
	bh=KkS2Y2C4yMLZUjgNozN9cZFnlKLkdyu2J0a9HplB07g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k6xPcBTN+/89XkWeLlW1jA8RAV+06kKTTIj2LeyRiH+O8wk854iUKoBJZrzUT/33nYx6VFHgRgNWDxvgjYRbWtIRI6A/Jaw50+cWr3srd49S4K2gwkki1DHR82jOj51co9gM6uUDIPMHBFozp6KWIr8cMjYFuWarSZZYfcUqbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wck1Yvgk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wck1Yvgk"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-857ff9fef54so73948217b3.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063586; x=1789668386; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+RHJOyEtY/MqNFmxnLODNW4ggVnAfzPCh4gwxLx0sSM=;
        b=Wck1Yvgk7e/w3Aq7ll+6nH60/iQNQyHKUB9ozInZk4jg4Rx+wgE+EI9pPEu3AB1yuv
         Q9GPWfoKLwLNoBWK8kqrjqthD2riGTRH00Cbk6BVKHDJGu3JBZnSYuUNWAN54VmpRd9S
         YAcf8okaFdshp+jDYQ/wS4M2d3UOc1NQSYXBXuCEoLvlE7bNUTik72TeoQBGGGRT1uv0
         Vt0hUYsi3eTDpTl3TKL6IX60woR4SlQ9OVBj/CzO186HTojhKwfK3ubwwwleLNQRnsTS
         Lb0Tr2L1qPYpDML+Dr59I99dhHSV/YqBeHD1/j0ALwSFeZdsg/+K/VBrYpiXBezoEu8r
         PhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063586; x=1789668386;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+RHJOyEtY/MqNFmxnLODNW4ggVnAfzPCh4gwxLx0sSM=;
        b=BTf3QZwqUeinopiwYAQEwckcPlLBk4rIuVql4tLbDi9822UJ0orteDFWV7c59RkjwB
         yW8A8pLcjQDDAqNHdthhuVTMFjimaGxTOxA0vDK4UIgQPm1WWfRmgYw7Ez4zwok7BanO
         I2ldcDgAIXHrEa2V44CXPmd9ynJRvZSr9I6mEJxPuohOv3Ls1ierEyRumctZ0jnzZvVZ
         Ga2xOD9sHbM6oZYBT+1rjhDeq6dgbYRgnXWTmVmGaFy2cFZdGwD/mbqXj9BCfgpW7iW0
         BlRZXHwsqsSknUKfoENFIzRN1wMiLIfNBWck3UiwDW3uQb9aNTSZYNmf1UPiYOsM6uhf
         Lz1Q==
X-Gm-Message-State: AFuF++kQIgJuPC6+rpEB3iLkwS1Ny/9U2r3B4empUnyfyYqb9t/iuMkT
	qeVRxQ4wB/AAFNIdWd1XgJ74MCGbjjdH1WMhm8AIadHJ8YbsQWrBjSHv
X-Gm-Gg: AYBFou1iN9D4rsxuvKQj85ipvSBP6kU6iBowfIZda8vacgfV2YHtxFa3cN9giRbj4LS
	SeLNaA0e5iN3kZ9RigqYK5+YEJPet9+3vXQoC2kIlEr6D5oV3O/ZscQe/EogXECMmHFdA2W+wNQ
	MN9bnnscVayViDaGzQEaAFmsy26qtb2BKFLGRlYybi7BNQkYpdtk+p/nfeym0a/v6DaYRktx7cX
	8H0we+H7PDIBBmI/MpyPWJ3NSHuDOsOflWo+HHbvviPBCFmjuFIQeRPS88dd5vuzsy95B5mIoLG
	N0mAvnYhZFxEvYKSLfMrOZGCZRMrrSayziEyXAuXbWkvDcKbKNcL9S7yOxmSH+6PRLOm6AXDDJz
	TT+d4uaBTiQKtMcPtzEI0JSqvKM0uV7z+VPF5IkWQL+WdMzc066t/H1WhGh/9qYxtkqHBwE2TRi
	THttmeBV8zGNWzWRwsaQkMi0UHZ+4QvXloioryNr48J4Z+ijpfe+qu8RYlufRnbCf2h8Halvdpr
	UjxUA6xpgwvhfT6RGojNX9dVlmJQVSSr7cZqTIKutbXNBU=
X-Received: by 2002:a05:690c:dd4:b0:873:5bb2:6c01 with SMTP id 00721157ae682-884b5d8d01amr2237007b3.43.1789063586367;
        Thu, 10 Sep 2026 11:06:26 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80f8142sm40761585a.43.2026.09.10.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:06:25 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:06:14 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Suneeth D <Suneeth.D@amd.com>
cc: linux-rt-users@vger.kernel.org, williams@redhat.com, jkacur@redhat.com, 
    bigeasy@linutronix.de
Subject: Re: [PATCH v2] cyclictest: Fix BUILD failure for GCC_VER < 14
In-Reply-To: <20260902095807.3531-1-Suneeth.D@amd.com>
Message-ID: <f9fdfd51-d18f-dfd9-a6cf-08a3e530c921@gmail.com>
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
> ---
> 
> Changes since v1 ---> v2:
> 
>  * Modify commit message to include Tomas Glozar's note on default
>    changes happened since GCC 15.
> 
[snip]
Signed-off-by: John Kacur <jkacur@redhat.com>
