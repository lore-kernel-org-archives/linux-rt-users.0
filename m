Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8intwGA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628535B3
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Dec 2023 06:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701700088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipCYBfsq07gJkV6QGZ5UqNjU2TxbagzWDddbF1Rf4zM=;
	b=E8intwGAgGAhyNnGRdcq/76cLBdyjgPaaNpBeaE55HjJu5trQmdfVtarISBiTws2NwUgYZ
	BMqkfBORcbW6ZtPfjC7n0dSP1tkgZmfjp3h1EKx8E+TJmmDYekIup1Wx4Dtj0h3/XJPePH
	uvdtIDDBKHs3QoRFw8s6Xu50Tu3EywU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Ftyr9A_nOGW09S5bNLfwIA-1; Mon, 04 Dec 2023 09:28:05 -0500
X-MC-Unique: Ftyr9A_nOGW09S5bNLfwIA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332e11a22a0so4080013f8f.2
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Dec 2023 06:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700084; x=1702304884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipCYBfsq07gJkV6QGZ5UqNjU2TxbagzWDddbF1Rf4zM=;
        b=JBOUOKdPmrlT6VVBlIRoJh1xamI4acdJDcOEfexjfLQJchU0G7Kj09g2FdzhCKjmYD
         6dC9BRYoclyar6k4xqmO5fKK3V2DFmPtNTdTkbN/1uoLHnCs//AJ/OkPZXDlvMxO6cyu
         7z4ux072IQxaNaKAdE+jjmU0yLYdx03QxVSARF5qUB8LPbSL0pAZWwYZ6Ghq4A7CvjBZ
         MWKrqqI75slKGyEeJLLXenUi0ESM42FsZWVFqcEI5SZ12Xdy8x9/kRo+J50Reczw61uE
         jMEzI/ILmQqC36rm9ZD+Rfu3zzGzeukVaW9YLLbUBvFQdRxMPorLrdTpmIX//u3c6vBQ
         Y5TA==
X-Gm-Message-State: AOJu0Yx0ozygivoyoBUnqC8CgwxwGwnowd9ekk2PqekH2InVbJBsiFri
	kFBjJlFWuYBgPob1fsgJlLGlS2bvSuZ5OxsKoEPdwHld9khpLM4fr5PkeJ7WZ+Xv94/oDEAfE0Q
	WNmDdd+qdNszZvtlFuojvR6FVJOTUPenrbZovpDuVDNM=
X-Received: by 2002:a05:6000:1109:b0:333:1888:99da with SMTP id z9-20020a056000110900b00333188899damr3132971wrw.5.1701700084527;
        Mon, 04 Dec 2023 06:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/5f/bgJXXDtImCPQ+Vinmh68Z9+KKa3OT0wsJjvUdWSCsNCs+Rtu8tslJpCKBP83m653vA7Y6WpEiG1SM1u0=
X-Received: by 2002:a05:6000:1109:b0:333:1888:99da with SMTP id
 z9-20020a056000110900b00333188899damr3132968wrw.5.1701700084285; Mon, 04 Dec
 2023 06:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170147003175.315432.12322961896739098066@demetrius> <ZWzNMjnF4NgNoKTu@duo.ucw.cz>
In-Reply-To: <ZWzNMjnF4NgNoKTu@duo.ucw.cz>
From: Clark Williams <williams@redhat.com>
Date: Mon, 4 Dec 2023 14:27:52 +0000
Message-ID: <CAMLffL_4r8M9wAaR2azEQeykA0VWHpN6LEO3dHRX+X=osCZ++Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.1.64-rt17
To: Pavel Machek <pavel@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're quite welcome!

On Sun, Dec 3, 2023 at 6:47=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > I'm pleased to announce the 6.1.64-rt17 stable release.
> >
> > You can get this release via the git tree at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> >
> >   branch: v6.1-rt
> >   Head SHA1: 10278c5eac700351db2dbfcce88be2df51725931
>
> Thanks a lot, perfect timing and made my life easier.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

