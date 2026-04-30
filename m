Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159739B4A0
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547722; cv=pass; b=jR+pDktOtiErRaJS+XHR+NS9+pU7iKps0BkuPTmBmRerQIq5bIYt8Prsav1pIVdLqjE3+2cze8V4noC4yX/fmU1EWkyvpDefCo44A3fL8uATFxoaCSoJZrvETrY2miNt3c0swRh84KIbBVzaOm4gvvoyQWY4hb+3ic6GDy5lhOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547722; c=relaxed/simple;
	bh=ZCIWkSoTWQGQG1FIWtqFQV0Jg8QF8Tft9DPFnwsJIKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jlugl3w9IIGjeKMWJFzNaK3x0a8/MgnDCj2MZlM5on2hXat/gU0R3Oy0/KH417Pf3hXD+6DTmzvgGpz1kDpNahRihfUz458c3AQPpJI7KiqU/QCC8woRQbCXm9SwsxgJRK9V3t1i4Ui22SkCQtmRe3CpmTD7lk4nVpEuEQ+agw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Klpvvnky; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Klpvvnky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777547720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCIWkSoTWQGQG1FIWtqFQV0Jg8QF8Tft9DPFnwsJIKU=;
	b=KlpvvnkyhYERmA7S7M8wMxo/D8O5SYD3/l7Xq5IdqnKCD1wmpfyY6QhCH6U+9dFtr03ueq
	CFutHkg7b+MRs9j1voU2+auab8SP064bmrI+PkUfm/EzsQLJwMP0NV4O2+6IVuCqFKfl2A
	jlEO62hye6iwrhj1B9aUe8+0dwKG/UY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-x7vnvNTNN2K05BFaZCXkVg-1; Thu, 30 Apr 2026 07:15:19 -0400
X-MC-Unique: x7vnvNTNN2K05BFaZCXkVg-1
X-Mimecast-MFC-AGG-ID: x7vnvNTNN2K05BFaZCXkVg_1777547718
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5a1154f41fdso313418e87.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 04:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777547717; cv=none;
        d=google.com; s=arc-20240605;
        b=fiCCWzinDBKTcFrSFORnzqtTDQsfe2+W8F+pIok1lZu2CD7Jj1NxOSZ3RQ4hZWinoA
         qS9DH3ZY6XLDw75O4UuZWdrZy1ml8m44jaHuVNbPeOA426wNYkKl9T5nJKNjyEiTrL/A
         oBgeNitzKot2SnlnxjA2mIXUjC2FkzYSFqH7SbhkWdupsoZz8ssSvWjy95DXLp1O31dW
         jX8bQ8n4YWF4srrZtMoLbQDqplK0zegZmF+Ocl4Fdk3LyT/ySlUV3cGmim4QM7YfJhYB
         IcBd50frEfWdEx2eGD1xMiySilSTZJT0CqTqiGrcTQAYWZ4AiyiOhg1PqUAxkRMlBvsC
         CwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ZCIWkSoTWQGQG1FIWtqFQV0Jg8QF8Tft9DPFnwsJIKU=;
        fh=X5UV63ec2IdraKD0DRRh/9MV3JfSlSu55PoYZ9mSlHQ=;
        b=EdzOaO/dFDA6APuNodd+vxMGpsH8HDbjAFlk3JJ2H0BvDM5I2gNJHnsSryp7dx1CSV
         O9/EaHj+huiJqPz3cSt4SPa9qSsa9Jh3cpSWl66FQqIYFsQUu+ABowQU5Dla8ElcYCdx
         AyACyKztIvxHvsqInSfLvkr2hq3BuBnN1+ofpHqPQwvbW3ATzwoTeTZpDHddpNHBIzEW
         yjd0nebveTYZRRnfXvJGsUFIIU80mddi56Jh7a8pq6uzzSD3l3LRAm39GcTJqdlR/5Co
         Z0x8x9fh384YZEP+TgdkRtnP1tjlFW5RznnlNCeCiEBXTM4bA6HXNuHLzPjdV0nw6YpA
         Ub3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777547717; x=1778152517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCIWkSoTWQGQG1FIWtqFQV0Jg8QF8Tft9DPFnwsJIKU=;
        b=G/7ymJxnVgVdNBjTrtIVn7347fGrEFXMcdOj35qa+PempW3uYZisPeANPz/VsS1MCz
         /z9a7l3d6FJRz4pAtFf/R0fd9q22t2trK1zUou6WRXO2+1MjLtkRRHeEXy3IZYBeQaXS
         Hr5dD3D72e3tpYOZHueTUJM4zoT/lHpMb18wL+oLcHB9Tgy5su6xPxAQXNoxCquT/Ewv
         nHhNhaaa3ew2F+jyGXDL7jLiYKQjZL4nVB+ZLc1QbVk8CgYsDSYmdQLZiwPqLuUCyh/L
         zH/V6o6s4nOeC2FvFun942UnDQzRBS0Uz8uoNYzUNt5LfZE8yEy3Iq5/RbDQ2Q7cHDTd
         YUvw==
X-Forwarded-Encrypted: i=1; AFNElJ+exatCJZQ1xodIoWSowJPM9bm8yIYoNKfmLB6z+yOp2+ztIntpQStjjstKNbJOkJHm4qW8aNQo/aWIrs1inw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YvJrotEdeZeG9Q/RzRCLP0WNMMc/BZqFlpYfSPbSnRJk4FWH
	OYitORTVyQnA4k64cITuyVqN4Nwmy/eM3IwFWouVGbo81oQX+9Tk0kqcim5bHYNS1MZmmrbYwFn
	2ksLwXp8EUa5rCsREC802KwDFmXtiqDE4vFqnCzkIc5T433QUxqXI8Aaqz8VHMkmaloFE6zpUpZ
	boqlMB/uvNsbOOwIZBHJtzZjYliu38sgk/w/WtykBCo7k=
X-Gm-Gg: AeBDietm3fCaJAAgTgOy1ImItURl47DiS9Ql7aN/lrxDP+9xFLGqHJfuBfSx8h7cu6I
	EqhFyUaqkqJqONP9nRPEaTcc9EPlQaaZLfF129wMLfB/pPqjbdnpZvPcaNUzCSn6PLAbHzCJzoV
	pxLCVoodo1w3TW+w804yEZpGXCRWyqURJDNI4brSDFuXPR2zj/LW4JbSiFLytNoywh/cJD6KLk+
	NRQ7/9KO7cfFP4ibQnr+mBv0+aZNxj9LW7rRGZpqcpMBK2WDwTky4V9CxMpnmkvpDik42ykk1gO
	q4M=
X-Received: by 2002:a05:6512:6ca:b0:5a4:18f7:a744 with SMTP id 2adb3069b0e04-5a8522d9be4mr777633e87.31.1777547717550;
        Thu, 30 Apr 2026 04:15:17 -0700 (PDT)
X-Received: by 2002:a05:6512:6ca:b0:5a4:18f7:a744 with SMTP id
 2adb3069b0e04-5a8522d9be4mr777620e87.31.1777547717035; Thu, 30 Apr 2026
 04:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_0EDB0AAF6CE44F6D1B6C8EC2@qq.com>
In-Reply-To: <tencent_0EDB0AAF6CE44F6D1B6C8EC2@qq.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 30 Apr 2026 08:15:05 -0300
X-Gm-Features: AVHnY4Le5WAlZvqYsuc6EkzoyyOhg_uTjOYJOGbSBLYWXhf0OPta3BI0zmbpWH4
Message-ID: <CAAq0SUmrKdoHBvwCY_RaRPT6udvA7aODofiw6ucOLk1mjhvZtg@mail.gmail.com>
Subject: Re: [Internet][PATCH] stalld: make syslog logging opt-in by default
To: =?UTF-8?B?bHVmZnlsdW8o572X5pil55SfKQ==?= <luffyluo@tencent.com>
Cc: williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	davidlt <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 12:00=E2=80=AFAM luffyluo(=E7=BD=97=E6=98=A5=E7=94=
=9F) <luffyluo@tencent.com> wrote:
>
> Feel free to ignore: now that config_log_syslog defaults to 0
> (disabled), the # Test 3: Syslog (-s, default) comment is a bit
> stale. Might be worth dropping "default".
>

Good catch. Just sent v2.

