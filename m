Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lyl0kq7J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AD11D
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702566317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wH7HbVrtY1pXGV5VxKYPf02/FvPwaTJtnnrflVFbvg=;
	b=Lyl0kq7JbavlavdtwHHXiZ8xaMTlsORDpG/mWia7zLg5Ihol6jKcqAPsRVerSVxjr08hus
	1XNAy6J0KEUuxWjoXTxpTl9GtPexLP2hWSwNczBCE43dJsToKdS4J5z7bYSWt6XN7NaeAx
	w9wwO8sA1+kpjbS9offLtBcymBrr4Bg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-IbgwpVRdNNuJz7ZL0xPgsw-1; Thu, 14 Dec 2023 10:05:15 -0500
X-MC-Unique: IbgwpVRdNNuJz7ZL0xPgsw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a9a237908so73827926d6.2
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Dec 2023 07:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566314; x=1703171114;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wH7HbVrtY1pXGV5VxKYPf02/FvPwaTJtnnrflVFbvg=;
        b=ux8PrLlelC4iiAhvOk4ke04jj3f1ZYuMr6mOmOfvOxQAgiIpRjSk5bXswyzRnGYRvL
         0mgbwf49TApmf0XdPK3jG8glULa0VNPEUicxuwoqE0zYWbKUzxAH0nzKCPtPviTFoAE0
         kvw2EAcbMrl4E8ekegfL/Zh2vksf8mpbk79RpJLquHuBqlqkCvy8LkJg3Haf0hv3vgyF
         kiuxLHxW1HTxTeK6CZr5tUq/aQbuqAZaB1k8QLgIWK3YFknyOu/V2tVg+YzWB9AaBGaf
         L+EixkyJqb31Mklv1vs787N8Nscf896nNNe6WqQU2MOGseqmQX7/L2vyB35kb4lbJfZg
         7XSQ==
X-Gm-Message-State: AOJu0YzczcNzAl8f83U3LIaVIGOmT0a3DPcEI79L1TLXWom6vtr0z9Yv
	2hjv6SzVq/90T/BKp9oy5z4zGgqR5KKiDdTv1XA6gsMXYzOzi872yaF6Ys1A625K+2OkXus6q0r
	p4GRClftJM9/XTG4S6Ww5f8SLbjYZx3dTW+w=
X-Received: by 2002:ad4:5c62:0:b0:67f:539:b64 with SMTP id i2-20020ad45c62000000b0067f05390b64mr1923933qvh.35.1702566314387;
        Thu, 14 Dec 2023 07:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgrkt00sQkCQJcEzOIFZIuM1owX2HzvWeOhu6xrDmtDZ3jVvRfKicMO+dFBoCNwL4Q0WM7bw==
X-Received: by 2002:ad4:5c62:0:b0:67f:539:b64 with SMTP id i2-20020ad45c62000000b0067f05390b64mr1923917qvh.35.1702566314091;
        Thu, 14 Dec 2023 07:05:14 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id a17-20020a0cefd1000000b0067f082a2486sm658611qvt.73.2023.12.14.07.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:05:13 -0800 (PST)
Date: Thu, 14 Dec 2023 10:05:04 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/4] rteval: Convert CpuList class to a module
In-Reply-To: <CAP4=nvQcqF+mfvdaM8tUChBH9TXM8LNJ6FbiKL+e1SViAE519w@mail.gmail.com>
Message-ID: <6a2ffb2b-84c7-3667-7bf7-dd174f12c0f6@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-4-tglozar@redhat.com> <2ba0bf80-818c-6277-1a3c-f8e007a738ff@redhat.com> <CAP4=nvQcqF+mfvdaM8tUChBH9TXM8LNJ6FbiKL+e1SViAE519w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463771134-628916627-1702566313=:12108"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463771134-628916627-1702566313=:12108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 14 Dec 2023, Tomas Glozar wrote:

> út 12. 12. 2023 v 22:46 odesílatel John Kacur <jkacur@redhat.com> napsal:
> >
> > You don't have to do it in this patch, but some builtin testing would be
> > nice under this
> > if __name__ == "__main__":
> >
> 
> Yeah that's definitely a good idea, moving the cpulist logic into a
> separate module will allow for more elegant unit tests directly in the
> file.
> 
> In the future, we might also consider moving tests into separate files
> using some kind of unit test library like pytest [1] or the builtin
> unit test [2] module. If I understand it correctly, currently you have
> to run tests manually for each module that has them, and you also have
> to check the results manually; changing that to a more systematic and
> automated approach should make development easier and prevent bugs.
> 
> [1] - https://docs.pytest.org/en/7.4.x/
> [2] - https://docs.python.org/3/library/unittest.html
> 
> Tomas

Indeed, that would be welcome, but I still wouldn't remove the 
quick and dirty tests that are already available.

John
---1463771134-628916627-1702566313=:12108--

