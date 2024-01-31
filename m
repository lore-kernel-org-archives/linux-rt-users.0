Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5305374F1
	for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738675; cv=none; b=Fx3phIGS5MG4KxKjHpJBdsNnTghLhu42uI2DKHXCzq0NoKjrsDnivTuAdFhGMYnTlmE/+f/DsPp0qZcyPrS0WpISQU6+AlN2hHTosWJIRnt8LUPY1SCBugM6MFyTKFhRV7FAPJlc40awSHwkgE1LTfxwwAju8TTEVxYfkcA31AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738675; c=relaxed/simple;
	bh=xlAN2QLDnWTPrzGA96Nc3PWumrZqgEr6+/uaJjDOMBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJoC2ykY6Tu4COnBFI80RwgAxNPJzJJVe38yce0MfX09MqVOxHfOvmV8FW2zgK2X21tVaUgF/F07l5aL16VYFrNMCd8A4rdlkv4GfhtQGIe3qizryYbCkrbUvafY7oAdpTA5znre/SHx3joKwnEukaB32TGpaeShnLOvsC7FsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anneqoVf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anneqoVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706738672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2B+y4zcCSl6e8cZoEf8NGUQNYqPAkNPFv+7JRkypuQ=;
	b=anneqoVfEykxQRmLS7ev84UnxOcErR2zODi7xf2BDSnNQlxmfdK8nchDq46A5blAC3nlg1
	8/yMb4jbH6jIEudB9fJIkU+jpEoPX4rC00ZhAcdkr5xsLF0fVA0V6lq2yXFdypYg2vBIX7
	nLVZTBkXR2fddxktOf5/ciTYSXFNSeo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ANKu-j4kMdG4TfU7DQJ2oA-1; Wed, 31 Jan 2024 17:04:29 -0500
X-MC-Unique: ANKu-j4kMdG4TfU7DQJ2oA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40ef6b8d0f6so1818405e9.2
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 14:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738668; x=1707343468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2B+y4zcCSl6e8cZoEf8NGUQNYqPAkNPFv+7JRkypuQ=;
        b=oAHRccHxEqqtPhD5UW0gHuB/p+osccV3q2b6GKP6ONIFzZUOqdjauRTWPTvz1pAREA
         u1I5SgZHWjpWmfBt+bl2dee35wuIoRmyQiYU4ssUKCmT+Y9dn2BkVsOblp9n6cBrggEL
         iXECZve9gax/ocy2LbL+oK7v8NiKdZ1II0TwdGLqhI4D1eMrZIvUSEJxqucX+UoNfmUj
         748N2SdrS2Llg+ueM0ytGELbn+mK89EGqNMumrEahLswXMME3qsmj2nLzuHhTGsd4dol
         3FtWHAZ0Srq4PxAf324oJwiJIEM6kP6Y7OTRDa85gb5D43+HkmJVt7IX6CI4HhKHdasF
         bStA==
X-Gm-Message-State: AOJu0YyIwSAQEedENK5CYuBD8vg8MTXXpdHQt9+Sk0vrSsjXUMk/JYuK
	Lg0tXM1NqB6Z3ncwK1+zx9bYRwzWIEp8fG2FyyXNurc0aL77JGrhhnILfy7rOf9pQOJ8jovujjg
	Dz86xyC46fpE/cYLrJRnZtwTA+GnU8KOv0/hlcX5JhAexHqfVDfPfBtt1+W/3cK5xA3qjwse+5s
	blVXmKkfIiEq0rOY2iuS7aZ4J/GYEUXBnGpYDRZvw=
X-Received: by 2002:a5d:4e83:0:b0:33a:e52b:b70a with SMTP id e3-20020a5d4e83000000b0033ae52bb70amr1797958wru.52.1706738668733;
        Wed, 31 Jan 2024 14:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUSR+gKqKBrSwFxjGQplhODAFtwIlGGnvArNv3hse5pGus1FlrI6TWmmcrVEpdOnaHl9kI7lavlY04wu9cQHU=
X-Received: by 2002:a5d:4e83:0:b0:33a:e52b:b70a with SMTP id
 e3-20020a5d4e83000000b0033ae52bb70amr1797935wru.52.1706738668099; Wed, 31 Jan
 2024 14:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170561158585.591793.15929255265114320850@demetrius> <20240124094843.K-b1_mn7@linutronix.de>
In-Reply-To: <20240124094843.K-b1_mn7@linutronix.de>
From: Clark Williams <williams@redhat.com>
Date: Wed, 31 Jan 2024 22:04:17 +0000
Message-ID: <CAMLffL8qyNCocBGtxfDO49dORs_QFdv-6ZrvBEbhxjoBBk4rrw@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.6.12-rt20
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Daniel Wagner <daniel.wagner@suse.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Pavel Machek <pavel@denx.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll revert that commit and re-release the 6.6.14 I just pushed

On Wed, Jan 24, 2024 at 9:48=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-01-18 20:59:45 [-0000], Clark Williams wrote:
> > Hello RT-list!
> Hi Clark,
>
> > I'm pleased to announce the 6.6.12-rt20 stable release.
>
> I've been looking over it and it looks okay. Then I compared how it
> would do it vs your outcome and noticed this:
>
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -575,12 +575,6 @@ static int check_unaligned_access(void *param)
>         if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
>                 return;
>
> -       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
> -       if (!page) {
> -               pr_warn("Can't alloc pages to measure memcpy performance"=
);
> -               return;
> -       }
> -
>         /* Make an unaligned destination buffer. */
>         dst =3D (void *)((unsigned long)page_address(page) | 0x1);
>         /* Unalign src as well, but differently (off by 1 + 2 =3D 3). */
>
> You shouldn't allocate that page. Nobody will free it, that page is
> passed via an argument now. Please drop hunk.
>
> While at it, do you think you can drop patch
>    preempt-Put-preempt_enable-within-an-instrumentation.patch
>
> or revert commit
>    c15abad8f7159 ("preempt: Put preempt_enable() within an instrumentatio=
n*() section.")
>
> I've been looking over it and it is fixed as of v6.6 so this patch is no
> longer needed.
>
> > Enjoy!
> > Clark
>
> Sebastian
>

