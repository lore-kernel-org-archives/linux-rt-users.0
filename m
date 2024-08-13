Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC819DF8D
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Aug 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559701; cv=none; b=OcyjE7uxOpMiCQyTe98/fTRoLjDIwYDmsuqZLEi4+jF/1zxbstXSJqqswsJcQKdxd6X1+zzryFUcwyYBROriDLwk4P8lkHCiL4Qxbb9c21JIbU3oVWHuOCW59jdFr9RCWscQo5OzZPzO04CBy5Z3okt9AU72BBSY0EWhE30EPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559701; c=relaxed/simple;
	bh=FivyjLTHSlB7kiroK4zgEbXBwsCyP2HZ7Y0vqsgeAXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8HhxKN/RyDJ7c7GrKgLI4IUK8JB1be9A/18T1WjW6Ve/sctM6y5X7JoAo0e0CrKO65/UywHdMsGwCNTFoZJs2amq0g6XgGeTWXrcYt+IkEYyc9teIgBvV5YfGVQgX7+9BgkVbORzTmCPkWT4i2bAKHNoWW9D/hapgc7DXD8/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com; spf=fail smtp.mailfrom=sidebranch.com; dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b=fhWTMmr4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b="fhWTMmr4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d1e3381cb1so3092252a91.0
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Aug 2024 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidebranch-com.20230601.gappssmtp.com; s=20230601; t=1723559697; x=1724164497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FivyjLTHSlB7kiroK4zgEbXBwsCyP2HZ7Y0vqsgeAXY=;
        b=fhWTMmr4sSH0i0gge5FB3BCL450N242Dq1bGBvj8TQJQ1tZJ38FFXpyZARiz/Lvyjo
         BITHWpTJMN9x6Xq1S57YYE84JR7479eJvtoYuOOD5sEvA5wR2HDERq7dbNiF2t0xn8iy
         LHKIgtf7UrhkN+yTktdhxVlPFhFl7KYpn2VUsI/z2dd9SAjZ7cMWdC0l9DTvCPCV3yJQ
         yyFqqWgwjjCWDG5KHN9QAhhkUrM31z2Bc/ri95H37+JznabVPLLxESBMrC6oCBLKm3D6
         WrZpOYUs4Swibs191yQsknNgblx6djXN9gnplt1W10kNQ3d87yjVrKwf8g7QrXwKE8+j
         Rf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559697; x=1724164497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FivyjLTHSlB7kiroK4zgEbXBwsCyP2HZ7Y0vqsgeAXY=;
        b=ScJ8SgDzJUCOVKFAGwjEakKKjN53LMpwnGpO748bOHaTpCxJV9yntXfp8unHSZ8CVL
         n3SVCMW/+3uyKOfecWxJnR3HGLpI92Wo58QIci//tFvRiYYL50wS/ZdH2uoxKPJ8AZgl
         5+xLPzc6sO+67eswygisVv1OEWQVvCukmdB8Lr0xQ6/G4evV3YEwrxrLlcbPKMf0RxbV
         44rl0u8uw7R+9CvsuHjVVR1ZESxf/XF3Vq06G26fqZ/ym3xcNHcKctSifVV8ndaAmkOW
         ESDW5lW/VHmEHU3Wg6jUr9FUFa99yuXdTEsfatS1qJbvHsGo8QkhkAjKzc7FUqEIaQ2f
         9opA==
X-Gm-Message-State: AOJu0Yx0O3nPNZRplMdhDLokpkyQ0hgidtbd/xvCd0XqfnWMxJ5XkJfS
	6AG703D7WJ8bpJ9+aa0f0WAWEN7YAazKFYo9HHk0XY6lgpb2B2zgn+Zs5lDTy3kDa3Eb2ojdb0e
	f0drog1QH+D55cT/0sowomt6Hlp6d1XOPsTgzAJZT/7fLe9Mix1w=
X-Google-Smtp-Source: AGHT+IFSrKEwo3HjgisydHL75CTK4lS8BsCy9ntQGpcEbxV+hO/LXJioHOqKkFqzDQYDoM2f+pP047TiQWPnbhTy31k=
X-Received: by 2002:a17:90a:2f61:b0:2c9:6d30:81ee with SMTP id
 98e67ed59e1d1-2d3924d6d9dmr4395484a91.8.1723559696605; Tue, 13 Aug 2024
 07:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
 <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
 <CAMjhiJhZQvr1qEdUm3T2v=JDETO4iWjjo5Lfc=XQgkm4yPwXtg@mail.gmail.com> <CAMjhiJhzwBKGYGKEdsiZjaiPDPE5mz=hazV2dS-THcUKHsDSUA@mail.gmail.com>
In-Reply-To: <CAMjhiJhzwBKGYGKEdsiZjaiPDPE5mz=hazV2dS-THcUKHsDSUA@mail.gmail.com>
From: Leon Woestenberg <leon@sidebranch.com>
Date: Tue, 13 Aug 2024 16:34:44 +0200
Message-ID: <CAMjhiJg579K25DAahfqcpMjbtVqk2uie80-wevnX09CpbcxC0w@mail.gmail.com>
Subject: Re: rcuc/ thread on isolated CPU
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, Jul 24, 2024 at 5:30=E2=80=AFPM Leon Woestenberg <leon@sidebranch.c=
om> wrote:
> On Wed, Jul 24, 2024 at 4:46=E2=80=AFPM Leon Woestenberg <leon@sidebranch=
.com> wrote:
> > On Wed, Jul 24, 2024 at 4:35=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > Le mer. 24 juil. 2024 =C3=A0 16:06, Leon Woestenberg <leon@sidebranch=
.com> a =C3=A9crit :
> > > > CPUs." and also tried with rcutree.nohz_full_patience_delay=3D1000.
> > > Are you sure you have the proper patch applied? It is not yet upstrea=
m:
> > >
> With the patch installed and adding kernel command option
> rcutree.nocb_patience_delay=3D1000 I can still get rcuc to run on the
> isolated #4.
>

Is this issue a specific regression, i.e. is there a kernel version
that does not show the behaviour that this patch tries to resolve?

Regards,

Leon.
