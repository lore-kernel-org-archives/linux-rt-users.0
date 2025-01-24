Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C01D5AAE
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jan 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737703876; cv=none; b=Bg5NBE6u+yUIKeOlwoSASwDpvcQgFyoH4SedHHFlgU3unSYp/LKkOE0wN1kQV94cbtq7T3GcqIiIKgZqV/LyZmZG9OPc+JaJllc3iSc+m0sobnFIEItdW1fhsY96A78lPEL7KTUuqmAb7Ve+g3rhGI+juyzJs0ovPbYZpn0SybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737703876; c=relaxed/simple;
	bh=rfeEw8N1aLX2Ueksidy3++3aeBsxrU00WriVIvWqyCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHbRkDRP+nrhbhBA+9EC0e2VrZ1jE1cz+C7w9KHauq2hFPUXZB4I3XPaaj54YibcbNFY7f6+le55Qk5QURm2LDOuHm5dPKMHhmTtMpuMFW5y/CNxq8CCfPCc9bQfZ8B1cn0JhnW4LJyBqBSnmtBaCI7PU4wpfMbt2WSDNht5uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvJt8WbT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvJt8WbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737703872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03g+fQTLCTrdjg+guzYZMOP4eeQ+D9hhN6Yh1GMzFvo=;
	b=VvJt8WbTy0bM8XAQTH5QiCfvVtDSJ4ZjaBgjZiHN/DhiVynAUEUDnYSYcebr6QHB3b23eP
	pPVZY7tLcqVJI4+lxlXBNpn2PeFG/e9Aw0Ewmp4Nf/0cmHLrK6lpOC0FVX1uIfAAzQkdCW
	VdRmxknnCCfFCIpeSu+oX2COKxO43EU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-wE8dam3mO76q4xj7Hhpeyw-1; Fri, 24 Jan 2025 02:31:10 -0500
X-MC-Unique: wE8dam3mO76q4xj7Hhpeyw-1
X-Mimecast-MFC-AGG-ID: wE8dam3mO76q4xj7Hhpeyw
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53e396834daso815742e87.2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2025 23:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737703868; x=1738308668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03g+fQTLCTrdjg+guzYZMOP4eeQ+D9hhN6Yh1GMzFvo=;
        b=S1mr1jsVQhx4LtUEKW4sTYo8kZQZKLL/ppV8VmVZQUWtwSGeYWa21Foh9u3BTBPLea
         PuLer7OSvYd4anZs3zLSJLtiUp869sVxClxq9t0jRtG/knWUS+biorR/i57J559tG234
         3jxvw87VMvbM0RmKmzYwPbVzJkA0oRMmkcN7z9q4M0IT7Kb0wmf+/7gJXGRitnt5bYG2
         Yr8XElPTWxfJk1MK+Rbt+rgmMMG4e5xOj2vxbZ/KSznFKl1MbIDHB/chn14Pq6rooYOk
         XuMaAirVdwAhGU/OnJySqrKOJNtTTDgLBci0hL5aBKaUQllALAp+apWTVPFFzS4ymlfE
         WmvQ==
X-Gm-Message-State: AOJu0YziO9CrvXKYWWHT6HQ8eIr1mBwnZhkabstiYcFnDjQqw3FS9g6j
	VKEGFlltVCe4BK54vsR0keCbbp0BneDetejx5t1Z0BJXmZWC4hNeh+0Efy61OKGlKQb963pX7hW
	qGizyeTmBMG2JtT2qKGf0tFOqjYPXd1YGn3MftztHA83N4ZubjtdTkJHGIe1XYsFtVaZYNMLwKX
	Tbi31Ehw/a24ojYx4Z3EThFsHBAWv8LPzZBA7rESYR386r+SaEQg==
X-Gm-Gg: ASbGncsYh94O+AMv27MXNQktLcc2L6xi6kfo5Lu90b0+8Xpvq+2foTf24qoMcGDzva8
	NKrE5GRvfpN63njKXqjIxZYeX40vubCHky2MaxLkWuRPrYiHA07eE
X-Received: by 2002:a05:6512:4808:b0:542:2990:6e9b with SMTP id 2adb3069b0e04-5439c246187mr7793004e87.14.1737703868561;
        Thu, 23 Jan 2025 23:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZGZSHHlZxY6aJ4OAfLBlRLXgsP9rIPBbxbILz/7DgZeSGdMch6pynuidAQnxDotkZezPIxK1FU5XQ92c7W1U=
X-Received: by 2002:a05:6512:4808:b0:542:2990:6e9b with SMTP id
 2adb3069b0e04-5439c246187mr7792995e87.14.1737703868184; Thu, 23 Jan 2025
 23:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123060443.31371-1-shichen@redhat.com> <f26e28d358931624986dc304c5cb0bfce2dfd498.camel@redhat.com>
In-Reply-To: <f26e28d358931624986dc304c5cb0bfce2dfd498.camel@redhat.com>
From: Shizhao Chen <shichen@redhat.com>
Date: Fri, 24 Jan 2025 15:30:57 +0800
X-Gm-Features: AWEUYZlgDm7-Y0G0YwVlvEgv10MgN6pBEAst2A8EiW6p5iVv9zu2WbYZJpLPHXg
Message-ID: <CADm5pWf1p-SJAWp6fyOhynpxz7gJx6542d+ZPt3e66WC9JSbyA@mail.gmail.com>
Subject: Re: [PATCH] rt-tests: pip_stress: Add option --usleep
To: Crystal Wood <crwood@redhat.com>
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:06=E2=80=AFAM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Thu, 2025-01-23 at 14:04 +0800, Shizhao Chen wrote:
> > Different hardwares have different threasholds for usleep_val to
> > reliably trigger an prio inversion, add option --usleep to allow
> > specifying it at runtime, to facilitate testing of prio inheritance
> > on different platforms.
> >
> > Signed-off-by: Shizhao Chen <shichen@redhat.com>
> > ---
> >  src/pi_tests/pip_stress.8 |  6 +++++-
> >  src/pi_tests/pip_stress.c | 10 ++++++++--
> >  2 files changed, 13 insertions(+), 3 deletions(-)
>
> Hmm, looks like there was an earlier attempt (53956b6712fef1,
> "pip_stress: parameterize usleep value to work-around platform issues")
> that was missing the actual call to getopt... and then another commit
> (1325cb7e9e3af08e, "Daniel Wagner <dwagner@suse.de>") that added getopt
> but removed usleep -- while also adding a "-s" option that does nothing.
> :-P

Yeah I kinda stole the option from clark :)

>
> Some minor nits:
>
> > @@ -41,6 +42,9 @@ merely increase the time that the low priority proces=
s sleeps while
> >  holding the lock. (usleep);
> >  Also note that you have to run as a user with permission to change
> >  scheduling priorities.
> > +.SH OPTIONS
> > +.IP "\-u TIME,\-\-usleep=3DTIME"
> > +Specify the sleep time of the low priority process. Defaults to 500(us=
).
>
> The unit should be part of the description, not the default:
>
> Specify the sleep time in usec of the low priority process.  Defaults to
> 500.

I hesitated several times whether I should add the (us) at the end,
your version looks much better, thanks!

>
> > -            "-h      --help                  Show this help menu.\n"
> > +            "-h       --help          Show this help menu.\n"\
> > +            "-u TIME  --usleep=3DTIME   Specify the sleep time of the =
low priority process.\n"\
> > +            "                         Defaults to 500(us).\n"
> >              );
>
> Likewise here
>
> > +             case 'u':
> > +                     usleep_val =3D (useconds_t)strtoul(optarg, NULL, =
10);
> > +                     break;
>
> Why is this cast needed?

It's not needed - just me being unfamiliar with C. :P I'll remove it.

>
>
> -Crystal
>

