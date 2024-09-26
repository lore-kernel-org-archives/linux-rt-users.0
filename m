Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E161A42AD
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Sep 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340591; cv=none; b=T6UD77fLvveItek8QLFhdhmFQOlKF59Uw74hAM8zsGuDi49t3pkbkAWDJCnsbZe6v40lqKA/CPcF2XAMLCLGL2C2tmPiyByc0OVcs2QfxHdaF9HC1ESJErjF3vQKDa91TfKj6dEXX5ViHjU0nMJswHJIkGpwlQH92RUlTMukYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340591; c=relaxed/simple;
	bh=9jhmH5KgcOboD5TXgR86mtAZI4JAd8CtMQnY376iGfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hrt4LUci+Iqv2HXDLTxuvZ8xC74BRIeG4GxgYC4hBOTOjUROO8SdzTIBb8+HnxkWZ5ghphlQ0Wau4n+lQWIKaKk0S/PVTyFHHLeUukhB96CJULmAqj597kzf47OLOELr6k1k1RqTw5gnLVtOEveFmBkDeEPI/X1AUSF36/p0ZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S811mk1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S811mk1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727340588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3ErmlGlLT2ELVM2x5M704t3p9s7JigVj3WOjsQPzJU=;
	b=S811mk1UcmSpoCEGOSZQHeMuqsm6QwuuuVCc7n2ldGzmb97QL45Siw7+WoEW7e1l36OtvF
	XgOliuz5F9lyBByc1RGVKG/7eyrCAGi5u/gawYz1y0am9CglBGZBvjn/MwqLl9402u2fOf
	zFR3qdoYk6dzCt6+GvcSHIVE8/jnbjg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-Ds8lX66ON2GhQlzXSxrDzA-1; Thu, 26 Sep 2024 04:49:46 -0400
X-MC-Unique: Ds8lX66ON2GhQlzXSxrDzA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a93bac20fccso24123866b.1
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Sep 2024 01:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340585; x=1727945385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3ErmlGlLT2ELVM2x5M704t3p9s7JigVj3WOjsQPzJU=;
        b=eKP48t/9G3iYxwMvS1gIKXfRx9DWyRVIBeLnVTPfi1YM7kxkTmDHj4KhtbDw5i1NdI
         I7IpQVQo+dhf15kVlv74GORzkeaNH3dr5WodJ0OoWy1I0r97X0fD6r/oPVhOYx8OiQVC
         iMnEJj+KVXlKmgdc7hc3NtyJmMDZC63eAgPQsWBT2CHQAKVs8OMyI0bfXq18RhwTZmE8
         ybA5tPVVUlL1afo6Trgnq3dPukD4buKVywhKXyImrnJQn4ECt4ozHqAIeDqd4cMVUX5W
         TTh7MzD1RB58zAJabbnPokSPRG5Kjx6Fvc4CHRbuSQT//16XpaqlWmQd2HHhvmO6fvtf
         VCuA==
X-Forwarded-Encrypted: i=1; AJvYcCXbdAzuvieIMV296Vi9OpNgWBPLOaGjO74FmjseLmROubXbv9X1Rs4cIbRpJGog6u2z9PxfS6VTMJ5oZFt6Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwofhkgSjgULkpXaFB1AAdTcOuOunjH3QWgqRTain+67rnifmhz
	quAPd6mbEGO01onI8Ki63pfD6ND6ELS2u73/qHTNjychZHwZBZf9P295Cbf1qZOBKyw0kVnSHlH
	avl+mq2K6oLCD/6nsEmZimDpVFue8/qNAPGNckqEZkZBU2fXhVa+nY5rhfAwmxvfJyEyY7NIlYg
	MckxJRdEQxcrKbwrur5XVB/nauvarvEWL8sFLPl/M=
X-Received: by 2002:a17:907:9488:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a93b15a7b94mr275581566b.4.1727340585559;
        Thu, 26 Sep 2024 01:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz6awPElpN5NjRI+aNtdcjAEtdxWk3wGh3HZy7W0Kvcof+PXcXpr8mUmozGnJ26j9bhgVwLNMOn+rG3E62waw=
X-Received: by 2002:a17:907:9488:b0:a75:7a8:d70c with SMTP id
 a640c23a62f3a-a93b15a7b94mr275578166b.4.1727340585074; Thu, 26 Sep 2024
 01:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818194216.299176-1-jkacur@redhat.com> <20240818194216.299176-2-jkacur@redhat.com>
 <81d7939730423517d16c770fc299f26c5cd729b6.camel@redhat.com>
In-Reply-To: <81d7939730423517d16c770fc299f26c5cd729b6.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 26 Sep 2024 10:49:34 +0200
Message-ID: <CAP4=nvR6JS_W5cXo3gp-QzVSwCDL=dP58FEG3gbvxbP0LGckMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rteval: restore all load module options
To: Crystal Wood <crwood@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>, 
	Clark Williams <williams@redhat.com>, Chris White <chwhite@redhat.com>, 
	Anubhav Shelat <sanubhav1000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 19. 8. 2024 v 22:40 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> nap=
sal:
>
> On Sun, 2024-08-18 at 15:42 -0400, John Kacur wrote:
> > Commit 56c7cf63942d  rteval: Allow arguments specific to module group
> >
> > intended to allow group options to the overall measurement modules with=
out
> > applying to the load modules. It inadvertently disabled options for mos=
t
> > load modules such as hackbench and kcompile.
>
> How did that happen and how does this fix it?
> (not saying it doesn't, just that clarifying that would help with reviewi=
ng
> and not introducing something similar in the future)
>

The bug in commit 56c7cf63942d is that the "return grparser" command
is indented one tab more than intended (no pun intended), putting it
inside the for loop iterating over list(opts.items()). This leads to
only the first module's arguments to be applied in the case of both
measurements and loads, since the return exists from the loop before
the rest can be processed.

> >
> > This patch reworks the overall group mechanism a little bit to restore
> > these menus.
>
> Menus?
>

The module command-line options, as defined by ModuleParameters()
module-level functions e.g. in rteval/modules/loads/hackbench.py.

> > +        # Set up options for measurement modules only
> > +        if self.__modtype =3D=3D 'measurement':
> > +            grparser.add_argument(f'--{self.__modtype}-run-on-isolcpus=
',
> > +                                  dest =3D
> > f'{self.__modtype}___run_on_isolcpus',
> > +                                  action =3D "store_true",
> > +                                  default =3D
> > config.GetSection("measurement").setdefault("run-on-isolcpus",
> > "false").lower() =3D=3D "true",
> > +                                  help =3D "Include isolated CPUs in
> > default cpulist")
>
> You already know it's measurement in this section, so why {self.__modtype=
}?
>
> Why does this need to be here rather than in rteval/modules/measurement.p=
y?
>
> >          for (modname, mod) in list(self.__modsloaded.items()):
> >              opts =3D mod.ModuleParameters()
> >              if len(opts) =3D=3D 0:
> > @@ -296,7 +310,7 @@ reference from the first import"""
> >                  # Ignore if a section is not found
> >                  cfg =3D None
> >
> > -            modgrparser =3D parser.add_argument_group(f"Options for th=
e
> > {shortmod} module")
> > +            grparser =3D parser.add_argument_group(f"Options for the
> > {shortmod} module")
> >              for (o, s) in list(opts.items()):
> >                  descr =3D 'descr' in s and s['descr'] or ""
> >                  metavar =3D 'metavar' in s and s['metavar'] or None
> > @@ -311,7 +325,7 @@ reference from the first import"""
> >                      default =3D 'default' in s and s['default'] or Non=
e
> >
> >
> > -                modgrparser.add_argument(f'--{shortmod}-{o}',
> > +                grparser.add_argument(f'--{shortmod}-{o}',
> >                                           dest=3Df"{shortmod}___{o}",
> >                                           action=3D'store',
> >                                           help=3D'%s%s' % (descr,
> > @@ -319,8 +333,6 @@ reference from the first import"""
> >                                           default=3Ddefault,
> >                                           metavar=3Dmetavar)
>
> Wouldn't "modparser" be more accurate, since this isn't for the entire
> group?
>
> Or we could reuse the mechanism for both group and module level (maybe
> s/ModuleParameters/Parameters/) if it's not introducing more complexity t=
han
> it eliminates.
>
> > diff --git a/rteval/modules/measurement/__init__.py
> > b/rteval/modules/measurement/__init__.py
> > index 9314d1cb6bbc..44708ce0b035 100644
> > --- a/rteval/modules/measurement/__init__.py
> > +++ b/rteval/modules/measurement/__init__.py
> > @@ -29,17 +29,7 @@ class MeasurementModules(RtEvalModules):
> >
> >      def SetupModuleOptions(self, parser):
> >          "Sets up all the measurement modules' parameters for the optio=
n
> > parser"
> > -        grparser =3D super().SetupModuleOptions(parser)
> > -
> > -        # Set up options specific for measurement module group
> > -        grparser.add_argument("--measurement-run-on-isolcpus",
> > -                              dest=3D"measurement___run_on_isolcpus",
> > -                              action=3D"store_true",
> > -
> > default=3Dself._cfg.GetSection("measurement").setdefault("run-on-isolcp=
us",
> > "false").lower()
> > -                                      =3D=3D "true",
> > -                              help=3D"Include isolated CPUs in default
> > cpulist")
> > -        grparser.add_argument('--idle-set',
> > dest=3D'measurement___idlestate', metavar=3D'IDLESTATE',
> > -                        default=3DNone, help=3D'Idle state depth to se=
t on
> > cpus running measurement modules')
> > +        super().SetupModuleOptions(parser)
>
> Why is this method still here if all it does is call super?
>
> -Crystal
>

The super() call is there to get the parent class. It should rather be
RtEvalModules.SetupModuleOptions(self, parser) so that the parent
constructor does not get called again redundantly.

I suggest reverting this commit and going back to my original
implementation, which does not have the issues you are pointing out
here (measurement options outside of measurement modules and
overriding the grparser variable). We will discuss this offline and
give an update soon.

Tomas

