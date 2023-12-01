Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxW6SJNi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AB2194
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Dec 2023 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701444918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsjGSOYFgl6bCPMlmbPKHSuXPWM19efMk5kmhq6NZWE=;
	b=LxW6SJNiSH2eouJ04/pxv3DkL0gHK1GdRhr3ZDGmggx0psy3pu2ITiWe5Hynwenp1EVGmy
	TlsG8LiT7db1kqeOAHcpdYcxMoKDjvWr/CkLR2ATaEKK3AioLJbiPiR+irZ/sW2D346Qts
	JSl198bnkubTpzEUsiV18UJv3tuFeNc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-dCN5HxgGN8umSPclU5xYWw-1; Fri, 01 Dec 2023 10:35:17 -0500
X-MC-Unique: dCN5HxgGN8umSPclU5xYWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33174d082b7so1583768f8f.0
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Dec 2023 07:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444916; x=1702049716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsjGSOYFgl6bCPMlmbPKHSuXPWM19efMk5kmhq6NZWE=;
        b=v87SlxquegqyOD6xNsRkwi50WXiwnNC0C0Q8hZRIyxZVSGgf1zmbkYmktPQ5fJp+5s
         sCH8e9lMjJ9fqB2VwVgRMAEf2seaBQQ7o9zQ+7gkUdPFCwxa0C+EXuMbmaikhHpg63co
         EWA07wnmN0X3pFQaAr0CojprQ12/ulbj4oCPkz/6k4I5gkj0iPOmZ4H0BdB9XdqkT77Y
         izJ1AzfdnQlj2//Qn5ChYeFQZybWrJGkzJhi666/XVdiowWTvdbe0CrE30VxBR9USBm8
         J4zHaQ8DfY4qF1rvc1Zmxip1omwbvdrJvP7Fd94MsS0olejgabROZSWbn9HC1l2+Q36R
         2Cjg==
X-Gm-Message-State: AOJu0YyANu2I6GMSEBTi7r4RNHHNEvQ+njAHVIFXeVYSSLCrFfwM/lhr
	yKCkK2rwIOriLrXUK3eBLft605Og9KJZcZSbr9Zy4metxq7hTLjGFd36eTmCd557/D5lN9ztuhB
	AyeUQ2QTOT6c2XV4SNRxNPFkx83WRD3upPoeE6dbfJgk=
X-Received: by 2002:a5d:54c7:0:b0:333:2d34:3ef4 with SMTP id x7-20020a5d54c7000000b003332d343ef4mr965972wrv.9.1701444916124;
        Fri, 01 Dec 2023 07:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMxld/P6Ep7Ts48kNdUIEhlNH5IuBjgjyNuxuJuLeyrfLAReZ3kUO2FrhzFpuKR1USJXhJldpEuSSF+mfQ9jU=
X-Received: by 2002:a5d:54c7:0:b0:333:2d34:3ef4 with SMTP id
 x7-20020a5d54c7000000b003332d343ef4mr965958wrv.9.1701444915844; Fri, 01 Dec
 2023 07:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169783215859.257534.17071765559550518745@demetrius> <ZWhgT8s2BDZ566F6@duo.ucw.cz>
In-Reply-To: <ZWhgT8s2BDZ566F6@duo.ucw.cz>
From: Clark Williams <williams@redhat.com>
Date: Fri, 1 Dec 2023 15:35:04 +0000
Message-ID: <CAMLffL-kJzqGBAhWyNEixz_HMNzDfmi=94Ltux-L-5iC=kUK6g@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.1.59-rt16
To: Pavel Machek <pavel@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pavel,

I'm working on the v6.1.64 update now, should have something for you by Mon=
day.

Clark

On Thu, Nov 30, 2023 at 10:13=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote=
:
>
> Hi!
>
> > I'm pleased to announce the 6.1.59-rt16 stable release.
>
> We'd like to -cip-rt release "soon", so I'd like to ask what are the
> chances of -rt release in next week or so?
>
> Thanks and best regards,
>                                                                     Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

