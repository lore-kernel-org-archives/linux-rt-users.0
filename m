Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3419AA56
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865640; cv=none; b=DvIWQR2LhdduEyhubv1Sl9E2kJ2Q0VRHXBNFDpr/Q0GB24/zfPir2Sjht+ZZ59h+078eBTY3KLfU3RwVdWX8TN0NyPbrwhozXTbUq8X4MzWhlgFQTd/M/6Nivk99xId43w2XpALzQTdphQVjwyGmK1j/SBeUwr6jSrHMfxxnrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865640; c=relaxed/simple;
	bh=Kb49N/ygzi+dd01HS64bk8JZkBRxW6IVVbZExzK04zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZdcbHmTcytAG3jIOxUR9XNgAQw+ScBdzRoiMJcuXi3pQaMT7tR6zqOwVyPNeAzYN2hhNh5LixYYJP4GGITXUUA7FaywCZEvQlQ1O5Hs6TUVYT0/ERiOAK7BOaDNlLziZkjTO9U+UB4hs3vstP57CkRL3menC50T1Wh1VJ3Q2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edEx7qHK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edEx7qHK"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9c3ef6849so2230872a91.3
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2025 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865638; x=1739470438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb49N/ygzi+dd01HS64bk8JZkBRxW6IVVbZExzK04zQ=;
        b=edEx7qHKz+pH41z8TtWmVTZuavv5AGmhpnsckO1p+VxdnIeya3VrUpGtPlTq3VhS9Q
         UljX7JlulclnmAEx4mnuX+k4rOAopvnjQpkoEnHnkP4h292/7B+qGkQXfxJcbTZgQ8cZ
         M+ikBuhAUKZjcdeNZ8oLpxu9ZPkEl6AAdYrc59FqARbfyT1mBMzbUQA5oSLELK2Y/11l
         MvJ/RWZnk8657n3WixL4/e+glqMF4pUrEk40WVbMLAFLC+XzT3c3ymAPbVN/qjCIBofK
         av85h77u59pkBAT0zE0iJoRUmH2/binXIauHPyACyxT0c0LEP2evSrqnJDM/NsU1W5IU
         XR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865638; x=1739470438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb49N/ygzi+dd01HS64bk8JZkBRxW6IVVbZExzK04zQ=;
        b=IMgm8wXkghJNmQQZT1XvvQZ7YxQZ7V8ZUrrE+IinADYDachHOjhcMyofrrW09qw/nk
         7fDXrYhX42CBi/7NEMYtE2wFNyCnEJRtVWhFv+wuPEDPTefqBa8Tc24XMNrid6HgUn+9
         pa0XkB/DCx11iqTcuCdRAs8ew48+tNxylZih45oXYk6OMgW7QEOH2WFBmPUBGZOQNULm
         yoM6kCUavibnNcDAmrzA5f5CbkULYyDD7jD4hO5NX6LR1sNQkyyeGgRNQeHaFfuxcjhH
         9Qzb67hPpSWas2p9/scXxTMGZkU/+9e4N0BK2avhyQR9dQLX+nbKTvthPM34htpt5EEo
         i/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWSyzGNO3JE42J1UcJ9I47zlOKSvMFJlPr5hqXCrEoBUz+mphmvt56GJhrhyFrrlpZCE16CLpgfvjhbWIPkLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hXe3pMZ49ELA/fpIaJc0QvzkdplQxGabktHGZoKPphzXc/Y3
	+zRqibLF/3E7DUlOmUSMbB6OWjWNREYGy4E0cn7M8ewRJj2HflmkLfIApKFd48d4qciisuBJRss
	Rdhl51VQSrN1T8H5NcIr9WQBrQfQ=
X-Gm-Gg: ASbGncsL1oiAFcWSYTn2LIpp/rK00IGNLbgcxuW9mYPXE6gIuCmqhMR38zoxyF6F3M7
	CZ/W5OqOV8Eh3HxccOcegAL2Q48Xgm4CKEZU87NM7tffbiNjA+ald/LUXMSsi8364uQ9iGFo0
X-Google-Smtp-Source: AGHT+IFayUo3S6+q8WTNdvxr85NrnfnDVZHLb2oZRmHJuKaGZK4zPv21rYwpV1m6AOgiTuvW7InsmLn1ni1LNfc0yxY=
X-Received: by 2002:a17:90b:3588:b0:2ee:f80c:6892 with SMTP id
 98e67ed59e1d1-2fa23f5ad9fmr22287a91.3.1738865638028; Thu, 06 Feb 2025
 10:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz> <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de> <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
 <20250130075026.RVen6mGf@linutronix.de> <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
 <Z6C6ZHQh3jc_iJLk@uudg.org> <20250203132232.ZLq9fj5q@linutronix.de>
 <CAArt=Lgo=mXXoFLZx1b0pGruiP2r9g-dmTnfEGzX5N6=+3cmcQ@mail.gmail.com> <20250206120525.3yeIJrEw@linutronix.de>
In-Reply-To: <20250206120525.3yeIJrEw@linutronix.de>
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Thu, 6 Feb 2025 11:13:46 -0700
X-Gm-Features: AWEUYZkyv6QbQorsBmRyMq3xGpCeI9jT4rO-WEHVhYRJgxW0QR0KNUXokUZQ28c
Message-ID: <CAArt=Liy6BNUYDq31d3ZBaf4w0Ozvq9Q5v97hGaTNTDw-mP4fQ@mail.gmail.com>
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petesarik@suse.de>, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for your patience - this is my first time writing and
submitting a patch. Will send to the proper channels shortly.

Jill
