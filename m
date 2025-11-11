Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34434D39F
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847563; cv=none; b=DI4PTzQJfehPujrIDhAh6aFwrMzLnxgRWRIYgwYR+V+47OBcEz25tDAvLEdXwys0iH6j38e4bxbJ/nLJqwhhW/LnT2hgTcouYiWX7KqL17cP50OnFkXROaSNLnTwL5GjcE+NjqERx/Vak2pdrC7NwHxjEzJMOKXgpvEskTihKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847563; c=relaxed/simple;
	bh=8PPKF/kATw3QfVhll47GYX0OYUI8uzsmnoFKOPFEwNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IV2MLJDBdtmsEU853UxMTtTRubKebP3ox0446Oe0nqElFkfkNSkk/nttn87sjhvLH/W8YzboWYuLjbmRMHK7U4psXiPC8PfbtPIDuNbSVEW2SNBH0oP55MjUJKk8NFNsXWu706mhA+tn5Qfi2U3uQzKKSpxO//63+6X2gafZutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFTI/EDY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VD70V9DM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFTI/EDY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VD70V9DM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762847559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PPKF/kATw3QfVhll47GYX0OYUI8uzsmnoFKOPFEwNE=;
	b=ZFTI/EDYnKDZ+sOarX5qezu3GReMTCHIAQh2n+jCJHzKn7CGzJ8QdWL2Rm+UjHMC/Xh9I7
	ZAF/bJODjyh7TE+nqx++Hb8Ol6M377XXcMmWpIIGXFmLclSzWwVbyvbGmQbW/8r/0IvQ+V
	n0FsbZM5+iTlwQA8CFGiULa3t47g+0k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-AwXIS2_XOK651NmiIw5VAQ-1; Tue, 11 Nov 2025 02:52:36 -0500
X-MC-Unique: AwXIS2_XOK651NmiIw5VAQ-1
X-Mimecast-MFC-AGG-ID: AwXIS2_XOK651NmiIw5VAQ_1762847555
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70c6ff2639so344096366b.3
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762847555; x=1763452355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PPKF/kATw3QfVhll47GYX0OYUI8uzsmnoFKOPFEwNE=;
        b=VD70V9DMiH/+RM3kBE9aJssz25+xrTdAzyForjR791p669esKgs00dPS+V5khysucK
         I6qMubpSYHCF73NwX6D8AgAnjc/OpV9IVxBSOrtbsE3gaX+kqS09KeV+WxqOqTC88L/T
         5T86yxS6oqluhVYMSwympucmykFQltYfRJPCB0jLxsLausba71Y2yTHmp6TVH1x1YsIo
         PlACC1VGazY4N9g+J2ixgF70F2/nH2IZcsJTAwcMGHnXZBJ16vebcHMROmzPGUP771V0
         ChN2isLNnuIrRlAL4+YFgQ5UidSHnI105RZHT22fgoj/ZcFryfL56M/o3X/tD8+Q8aCb
         68hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847555; x=1763452355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PPKF/kATw3QfVhll47GYX0OYUI8uzsmnoFKOPFEwNE=;
        b=H386qW3eqNJ9TbNR+XuvrNA9wfvmjJ+4X3FcTqbhLTacjpJ++9j5pgiGHJ++InduaC
         QmzLdzu8rqf4DL0sQ4FlHOSETDRluc3elLFFpEQeJNAc2j24igMrys/dhQwIgm0aG02X
         r4vV1Iwpiw5P/hh0+bzBzskaLrsF+S/OLX6KFMS2s6U+UL1wEoLnNX24ACkFkyCXV5rH
         lTGjYj7KhUqaXI6uEVzTFra3FvRvpcgRhDsizDcnxJk2CxdnYnrL5qHicQSUYpUiSGSp
         XEDhwf0W8CTRDe/3JS3k03P7clQB95IrCrI10X0snpRig1jjZ3hxANA9wkA8B00MtoY+
         VE3A==
X-Forwarded-Encrypted: i=1; AJvYcCXm5rD3ZaGQ0uRKSNiUE3mMI81zMe3TpyVweV7fOh8dmr/66ebgM5vfok+FCjNgYkNfkXjrMHo0JdeGbobhPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4+YLfCGDHFX0iGy+mBszFNGdvrDCd6sK8gX6cINpSQv3TClg
	H0K8Idcw7olsiB/6JaE5QwMUPAOqCdd6sllvrm69MDer8rDeGszCrKV/n4OkvGADeX82X5m2M7L
	gz1HqdAb8rZjgHmDAOv9P0PWRADhUF1Bcpdwqj3y8J6TSXojKeEUJCjiA5Znpb5RcYhhVDdXwBF
	sPb8QlIKce3Gx2RsCnGzZu/0rNbyLuGkCPAW7O8p5x0ec=
X-Gm-Gg: ASbGncv2K74eXR5obX9FhzLt00FM0gPQ7Ugj0NgXjVKvtMONvX8myXvk3prXszBx9PI
	wm0xSDSAH6nlY1d/qWataz5LbCQyzPt3FmjftScfsOi8u1GM6FkWsVVOW6wNx3x4dr7KrmbpwSd
	mQT34MzgSMO1EneHlI30nsiBcW9B9i3IMsOtPG+QO4BLglpr+ojSm1Ow==
X-Received: by 2002:a17:907:6d06:b0:b71:f9d5:70d5 with SMTP id a640c23a62f3a-b72e0313ccamr1149013066b.27.1762847555239;
        Mon, 10 Nov 2025 23:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo1bMeaW+USwdVxGGqF5FKt8RZyCai5MGVI7cAqJsbpfKeX7hNDnCX+7f8/oY9kKwSutrpCw9tjz+4VtltEIU=
X-Received: by 2002:a17:907:6d06:b0:b71:f9d5:70d5 with SMTP id
 a640c23a62f3a-b72e0313ccamr1149010266b.27.1762847554914; Mon, 10 Nov 2025
 23:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107134749.257350-1-tglozar@redhat.com> <20251107134749.257350-2-tglozar@redhat.com>
 <2eb2aab4-eb87-f88b-e979-9d4cce2465eb@redhat.com>
In-Reply-To: <2eb2aab4-eb87-f88b-e979-9d4cce2465eb@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 11 Nov 2025 08:52:23 +0100
X-Gm-Features: AWmQ_blU_3U0oePjuh6Tgm4SU5cIGJP6ifXP1h5vko5kOi6tzVCAxD0giaSYG3Q
Message-ID: <CAP4=nvTWzybc2s=FtXqde_FR0iOqij+0eJ6kz=iCmRqQ2zDZGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rteval: Move unittest.py to tests/
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 10. 11. 2025 v 20:11 odes=C3=ADlatel John Kacur <jkacur@redhat.com> naps=
al:
>
> Nack
>
> This one breaks make test.

Well, I sent my patch before you sent yours. But either way, the
conflict has to be consolidated somehow.

> this type of unittest is not widely used in rteval
> and was written before and conflicts with the unittest in
> the current python library.
>
> In short, I'm thinking of removing the old unittest and
> might replace it with the built-in version.
>

Yeah, I believed it was not working for some time, since I got
failures, but I ended up discovering it has to be run from the correct
directory as root, then it works. So I ended up keeping it.

Tomas

