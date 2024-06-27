Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C08188CD5
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493929; cv=none; b=LYpnOPfUuBUUovTmHgWh69gaxux5xyOmkJhSZBEpZW1Duecmjx/CST1x4iiuozjC9OSEuxgA7SwaBZLuObmxnV16iy0UtqtwBvNAqdPc983lez1MiY7fnmmI8efi7LlOf+HrKnDBLXnDNKbsQbNTSBmM2J9wZL8CQJcFCIJy/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493929; c=relaxed/simple;
	bh=bh574OC0hfnfP2s+XmATt7Z/PY4du1JCkROQcPySJVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4rGp1a6jGvOJ+lN9IBHg6x9M+tq7vBbRCIxbHmfcptDgoDYjN6JBaXKxltLR03tmuexRaFkFGIa9ibczVd9w7XLV16xtO+iADAM6rGOf0ZOJScV8VF0sSvN8Oug3rq559n1Ll9vbTHBGDZq2vgUgdaRuME+FSPzfHW+Wow4uNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=ZZX0jrmn; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="ZZX0jrmn"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64789495923so27622537b3.0
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2024 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719493926; x=1720098726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1YNOJVqJAnO5y/qedAP+u6aRxm7l8CEybZJa45UdrI=;
        b=ZZX0jrmnoRtTOym7GoEQZQqlZhEw2SfnwkGAetZ9LfAqxu9Hhq3Wr9+HiLigOFlURg
         BNz00LuD4tfvfkV+6N6XYHpJ6tdaAJvNgGsFP6oh57Q5eyCw1Ix9FM7/5ROyF617zL64
         WFLe3qlH/xx/CyW8kJU6K3oUDT0kPC4hRFkwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493926; x=1720098726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1YNOJVqJAnO5y/qedAP+u6aRxm7l8CEybZJa45UdrI=;
        b=pndiRcNDLBsJQpXDC8otrBJWOme8rfb8nNUrHcklvDb4gB/N/y4G8eQGwmQxgODh+h
         RsmHwE2Oh30+13TUQ/bxDQoOuqGJW3pbXlRs5GelyDE3NmUtHRJFaAG3P6KvkDnO/dsV
         Iorz8f1WdRJPYH7PxL5NUE5qWLBVL/z9CNxDlXjyGSAZ0Ptac7D4hBxOteMccbL2wyIg
         dkUHG2/DON1dOFJ/cgcHxng2K2nVAa0ckkek66dACVaOIIhj98rq6Psuo8V5DrKnhfmo
         XFKqx1N6gpkLr+xONBZOmY/Bb1G4/gJNm7zyQQIpeDL3rDOUq2tZg4XN+SSRMGfpksC2
         dU4A==
X-Gm-Message-State: AOJu0Ywq7PGbGePik1hYSZzeYWiXck+R6aWP8epo0ToMOD4xdC39ApRG
	QMfZ04xhsLKAyuFbr6OkQ7A2J4pA/4saOKygWMNxbVETzEQvNO6qc+Bd9RJmvZ3B/euQj1jtLQe
	us8VjaL+fSCjnUkHASjvvA8mRPVn3m8cWT6d1+Q==
X-Google-Smtp-Source: AGHT+IFZ5kE19qmzmCXBIGk/Hhbs3ZSOZ/xYjtZTolHKpYipi2Qke2/1LpvEWAUHAsfxGm6LLw8z6UQUBjV6NVbgHi4=
X-Received: by 2002:a81:e204:0:b0:627:a7ad:ba64 with SMTP id
 00721157ae682-649db4f85eamr11128717b3.49.1719493926401; Thu, 27 Jun 2024
 06:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718966972-17507-1-git-send-email-skappen@mvista.com> <20240627065309.e_MPmlKm@linutronix.de>
In-Reply-To: <20240627065309.e_MPmlKm@linutronix.de>
From: Sam Kappen <skappen@mvista.com>
Date: Thu, 27 Jun 2024 15:11:55 +0200
Message-ID: <CAJ9FNxuWXSDh70W-944+e7mD3g05RvOs-WxyMc4Bhy6vEAQY5Q@mail.gmail.com>
Subject: Re: [PATCH RT v4.19] tcp: md5: Add a serialization in tcp MD5 hash functions.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tom.zanussi@linux.intel.com, zanussi@kernel.org, sam.gsk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:53=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-06-21 12:49:32 [+0200], Sam Kappen wrote:
> =E2=80=A6
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const =
struct tcp_md5sig_key *key,
> >                              __be32 daddr, __be32 saddr, const struct t=
cphdr *th);
> >  #endif
> >
> > +static DEFINE_LOCAL_IRQ_LOCK(tcp_md5_lock);
> >  struct inet_hashinfo tcp_hashinfo;
> >  EXPORT_SYMBOL(tcp_hashinfo);
> >
> > @@ -1224,6 +1225,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, co=
nst struct tcp_md5sig_key *key,
> >       struct tcp_md5sig_pool *hp;
> >       struct ahash_request *req;
> >
> > +     local_lock(tcp_md5_lock);
> >       hp =3D tcp_get_md5sig_pool();
>
> Instead of this, could you please move the lock to within
> tcp_get_md5sig_pool()/ tcp_put_md5sig_pool()? That way it will also fix
> ipv6 in the same way.
Thanks. I will update the patch and submit again.

Regards,
Sam
>
> Sebastian
