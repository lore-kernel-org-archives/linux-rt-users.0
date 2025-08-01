Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77794A04
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Aug 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076452; cv=none; b=eK65fevUQSCszIZA7MLIaXAgctIDxjILwklDuPyIi+yT2YqcreR+HlEF8r81UeAcMuSo8r3dEZWd1eZzAChKIYbve4KvZKXBHflKWod35L/HM0Gnt+cMS5xUXxTGcGplDwZfFXnwHMjWT3dRN477c2MhbGa5uoS1UY3Yt2MoIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076452; c=relaxed/simple;
	bh=OuqlSGEDv2/oUjW9t2xqDFH7oylxKewbkhA3My1Z5nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtQtZu7RitCDPMHB9Lfjqe3KaU1WNZW55FgYrgb5Yc2+qrMKdfTrca9h+G9tduKplOUoi/eKtUO9wP4CvRZDbFi0xCwlX5DlRK/Tq5G4uTc2gwY52xIY3n5S8jt6KXMLKj8D3qt4wD6NBT2b5V/F4ISHycdSgCyNyQka6nntb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiDDRW02; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiDDRW02"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso71001cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Aug 2025 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754076449; x=1754681249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuqlSGEDv2/oUjW9t2xqDFH7oylxKewbkhA3My1Z5nI=;
        b=TiDDRW02IFd+8sdc9xodPaR6BDQ69dJSus5tCOqN5TI50hrserPYyo8hn2ZMwXdOpa
         tEhMmOxgmH/u+Rc6QX5E947NzRGp2R0AuGxxaUmyx0GddJpe3w3Bg4n5kxCU9hc9YSRu
         RzYHXFYxMYpYZDJsAmc5LADEtdKU6nJmXr98mnUNZytCG9w0H5RnK0TD6R/9r9eejz9J
         t+WxJavkO4x4GWvq1O9Hry1xX8+xUZlFIBsMna+0r2sN3sSdOHLGM4dW8sA3W/155Fbk
         DSr4T4dtXOTsjdxDUPIGPpE0wP7/NGp+X+roIFrgaQeVg7DytAafqiGAU6VIyJAwvJxL
         QgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076449; x=1754681249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuqlSGEDv2/oUjW9t2xqDFH7oylxKewbkhA3My1Z5nI=;
        b=FphPKo7w1jj4Nj0ZRci5W/c/pl4GCNeMizdQsF5bMAgvUupjFTjmqkpqdui+TkiNrW
         2CP9jHjlPpX6k8E6XmK02nS3INjWc7MH8Sq4UUZ25jTy5UBcCM0xcv/VYX5Frur5722x
         q+Z5u+U1HwFB26CAyehZi99hoDWy8I3Xy4q4BIGKytIXA/UBjqyZwHRymGPlRkAKz1BH
         VTwExAHPk7O0C9loX9g2lf3vGc/Bdwr18J08Z7jVQHPLTRTmYtQVIeAeCAwxZTQCpJWG
         /u//k3HXvVegztk2z8eKKzMOsyzHn1+aUmTsxHZTF6XC+keq7dP1gK8xV/DBX9YN9FB/
         9m9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5sJv0ieKLstUXqMVEXeqJ5TZaqdM2IKR0yJp5Nrev1ChxDJq7MULrgg7kq14B6EKWCTb8ZRRtUZM4ohkz8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMK4/3SZorrsn92GPGF4Bu5j95zhxHka55TawUy8Q1rb2KaGU
	62TqIN8/ozwsDOO04kd0fQwmyYaQxowdV4asnezwxXTDjVGr9E86hcyFD4XYo0lCfpkNj5/avbo
	EHvYrBOkosoGhZypQVFPdE9Sx27fmfZ7KKhni3i2x
X-Gm-Gg: ASbGncssFQQIgJRsCy6QgVaw+nOVNKSPvrbmLkC8aoxzXFF/RZEeivEFpiqRtkkXpVv
	cSjTM15MtZ+NqYKUqvJ70Ua9inWLgUfaBFqwmBwF61vx1l/Sx7c5Mi81I+Q9zH9/i1Zxb1IjXaQ
	4qogQ6luQA4Vjz8Ge3ffBgvax5+wc5syhQ/FliiGIUwF25kbNR3hSqlkCAXmxrOlOlVKEkxl2LW
	xlM
X-Google-Smtp-Source: AGHT+IH0VEOEQAyWFcQ0xV2ZT7OrVMuc1+AZpJfbGSvNuR66hHX5BBVvrOqBcWVb23iUeJDFLxG5aetjHtJi2Hi8vUQ=
X-Received: by 2002:a05:622a:180d:b0:4ae:d2d4:21cc with SMTP id
 d75a77b69052e-4af13172de5mr492761cf.3.1754076449265; Fri, 01 Aug 2025
 12:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
 <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com>
 <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz> <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
 <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
In-Reply-To: <25ba0d77-eb61-4efc-b2fc-73878cbd85c1@suse.cz>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 1 Aug 2025 12:27:18 -0700
X-Gm-Features: Ac12FXzjGpgSr_bPfFHhHKJ5h36qLMtXo5c-DKT7XqzqeuIg36gVpgqLIjB0Aq8
Message-ID: <CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com>
Subject: Re: Realtime threads delayed due to kcompactd0
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Galbraith <efault@gmx.de>, Alexander Krabler <Alexander.Krabler@kuka.com>, 
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Dennis Schimmel <Dennis.Schimmel@kuka.com>, Daniel Braunwarth <Daniel.Braunwarth@kuka.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/1/25 04:46, Mike Galbraith wrote:
> > On Thu, 2025-07-31 at 20:41 +0200, Vlastimil Babka wrote:
> >> On 7/31/25 20:34, Frank van der Linden wrote:
> >> > Not sure what the right thing to do would be. Either explicitly boos=
t
> >> > the priority of a thread temporarily during migrate_pages_batch, or
> >> > mitigate the issue by dealing with 'busy' pages more quickly in
> >> > migrate_pages_batch.
> >>
> >> There's a workaround for realtime tasks. If you mlock[all]() their mem=
ory,
> >> setting sysctl vm.compact_unevictable_allowed to 0 should exclude thes=
e
> >> pages from migration by compaction.
> >
> > Hm, per documentation that's done automatically for PREEMPT_RT...
>
> Oh I see.
>
> > On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fa=
ult, due
> > to compaction, which would block the task from becoming active until th=
e fault
> > is resolved.
>
> So it's probably the mlock() part missing since that should otherwise app=
ly
> to kcompactd.
>
> > ...but rummaging, seems other stuff can step on it (contiguous alloc?).
>
> Yeah, there was time CMA was just something for mobile phone hardware. As
> usage increases beyond that maybe we'll have to tackle it. Ideally by not
> having mlock'd pages in CMA areas at all. And if contiguous alloc is
> attempted outside of CMA areas, respect the sysctl there too.
>
> There are also things like mbind() migrating pages for NUMA locality but =
I
> assume people just wouldn't try to do that with realtime workloads.
>

Another idea is to minimize the time that a migration PTE is in place
for an mlocked page, Hugh (cc-ed) mentioned this in an offline
discussion. E.g. skip any mlocked pages in the first pass, and just
add them to a list. Then, do that list separately, but do them one by
one. There is somewhat similar logic in migrate_pages_sync for pages
that might need extra work / locking.

Not sure if avoiding mlocked pages in CMA would work out. I mean, it's
not hard to implement, as it would be pretty much the same as for
pin_user_pages: just move them out of CMA on mlock. I'm just a bit
worried of scenarios where the kernel might run out of space for
unmovable allocations if you have a larger amount of CMA, which would
be made worse by moving more allocations out of CMA. Then again, the
amount of mlocked memory is probably generally small.

- Frank
