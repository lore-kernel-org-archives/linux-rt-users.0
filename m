Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AD39AF6
	for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738746; cv=none; b=C5XA0Dzdg8ImPcxQeNLBkJh0lj5sdEG6hSIB7BIZf0syjooydEuA6c4uarS01E11346XgPwNebQ5RHzkp0Gh6xBd/jTDSqMpkC+ZEC8Sa8F61XmKMEcV+oXkMIWYgB8kmwVJ97Tjer8fmJ8+Cu6eJ5vjMxea1zTuS6HasY9GSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738746; c=relaxed/simple;
	bh=Xe/0kiadnVIHnMVwtx5LfhWjTwSFMImzsrO5KgpupuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/2/vDP3zrIZmwinZD27S9osFSn7jwHUKLux6LU+5DxvOaHFEjTLNT1B/VBGDpzwrY1rBTcuqfcZe2vX34CrCYVeie77+2Y9g0GfCPOMSQ8x0WOWB6MKck+JEWHtQXpOptRMz/o8fYfoGgmmXa5drkLiaS5r/UlQvrpZzRauePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiHpB3Xk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiHpB3Xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706738740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvN2ppWJkyIhYehXgsltN42vtenq7KBOYikNZNfCvh8=;
	b=DiHpB3XkucIqwnKl2c+T6UvZL8mPSOlzvWsQ8/0xqO5UHCAvEg5vL71K5M2Pv4CLjkVRoT
	EKbf+GX0eKScFQ2sj2tV4P81LRlWmJGKB6ek33bpmRxxV/HleI/XyUW+C5Hlbz0i5h66Su
	w7fBOhqF8bNioXuAhiai57fckD8kZKQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-F_M87fa1NYeSOLemXo9Pcg-1; Wed, 31 Jan 2024 17:05:38 -0500
X-MC-Unique: F_M87fa1NYeSOLemXo9Pcg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33af5879edfso99429f8f.2
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 14:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738737; x=1707343537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvN2ppWJkyIhYehXgsltN42vtenq7KBOYikNZNfCvh8=;
        b=JO8VEp3GPPwZu5hqpy+1I7x/IVAle9vddLvYAyn6+GPNqLn8AiNbMComWDxU+7xehZ
         spWebXqdiQlRLIESem2tMkDTE5fQhNIgwKkWNv8b2lpqCxUrJPy2/YpTU1g/rZTpLiT0
         w0FdgNnda4GwrLRt5d3/rLW2vqvbrq4aAK1amKau/DDEdqkObTnbVG7fTRGVvn0998/A
         hgKAeSCZ9W1hhirK3FC7j9teg04tWt9BWeZXhjrzEPhP37a/1sJLdzeKGc/wk7isYMY0
         AJ9qaeKfs+VXqhxBai28ucW9y1X6I1P3p+VRl8RxLB4Qze8u02yb1DzsRF132CcJG3yh
         WG1g==
X-Gm-Message-State: AOJu0YzLf37AGUATx6iKAgc2jzEiBqN7ESBFd2C6f7MW1/1jA0/7ham8
	DSDD3+YeW4QDirch2VnJdkZhEteFmfIUu9WRK6ijxE/rv4VN18oKlf7XAvazFE4eRIXCCn5uAbG
	Xt7jupNAPGLfwXHdIUN76TVY/WFFMEvFGcx3C7BUgNA58W1QtY7XFjFQlFREnFSGX4dbKFhhMgL
	/8pLYavLr1QPWabEk4k6ISsV8OGCXMiARfIIVQHnk=
X-Received: by 2002:a05:6000:1887:b0:33a:e746:4ef0 with SMTP id a7-20020a056000188700b0033ae7464ef0mr2644952wri.46.1706738737503;
        Wed, 31 Jan 2024 14:05:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdn+mupJudxWNnsucLhVxc7A0A+RsGlSiSgLr84f47kQBRdM9EJu0NgNQgp46BeNhcihGd37pMzayteU9yCuk=
X-Received: by 2002:a05:6000:1887:b0:33a:e746:4ef0 with SMTP id
 a7-20020a056000188700b0033ae7464ef0mr2644933wri.46.1706738737245; Wed, 31 Jan
 2024 14:05:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170561158585.591793.15929255265114320850@demetrius>
 <20240124094843.K-b1_mn7@linutronix.de> <CAMLffL8qyNCocBGtxfDO49dORs_QFdv-6ZrvBEbhxjoBBk4rrw@mail.gmail.com>
In-Reply-To: <CAMLffL8qyNCocBGtxfDO49dORs_QFdv-6ZrvBEbhxjoBBk4rrw@mail.gmail.com>
From: Clark Williams <williams@redhat.com>
Date: Wed, 31 Jan 2024 22:05:26 +0000
Message-ID: <CAMLffL9fVw4M7b4cnQdy7KwHJGQNyiM6SvR-3zHkGKrkzV3mEw@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.6.12-rt20
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Daniel Wagner <daniel.wagner@suse.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Pavel Machek <pavel@denx.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To be clear, I'll drop the referenced hunk from the RISC-V commit and
revert c15abad8f7159

On Wed, Jan 31, 2024 at 10:04=E2=80=AFPM Clark Williams <williams@redhat.co=
m> wrote:
>
> I'll revert that commit and re-release the 6.6.14 I just pushed
>
> On Wed, Jan 24, 2024 at 9:48=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-01-18 20:59:45 [-0000], Clark Williams wrote:
> > > Hello RT-list!
> > Hi Clark,
> >
> > > I'm pleased to announce the 6.6.12-rt20 stable release.
> >
> > I've been looking over it and it looks okay. Then I compared how it
> > would do it vs your outcome and noticed this:
> >
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -575,12 +575,6 @@ static int check_unaligned_access(void *param)
> >         if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MI=
SALIGNED_UNKNOWN)
> >                 return;
> >
> > -       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SI=
ZE));
> > -       if (!page) {
> > -               pr_warn("Can't alloc pages to measure memcpy performanc=
e");
> > -               return;
> > -       }
> > -
> >         /* Make an unaligned destination buffer. */
> >         dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> >         /* Unalign src as well, but differently (off by 1 + 2 =3D 3). *=
/
> >
> > You shouldn't allocate that page. Nobody will free it, that page is
> > passed via an argument now. Please drop hunk.
> >
> > While at it, do you think you can drop patch
> >    preempt-Put-preempt_enable-within-an-instrumentation.patch
> >
> > or revert commit
> >    c15abad8f7159 ("preempt: Put preempt_enable() within an instrumentat=
ion*() section.")
> >
> > I've been looking over it and it is fixed as of v6.6 so this patch is n=
o
> > longer needed.
> >
> > > Enjoy!
> > > Clark
> >
> > Sebastian
> >

