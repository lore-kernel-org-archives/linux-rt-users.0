Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8045003
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Sep 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358438; cv=none; b=rAc5k9UuHCVKVzRFh33ejHC0UAuO20I03/T5gVLstG5PveyVFwVjoY1j1BXki8NkE7csub5vghiPlILIfBeexhJ4FMLZxoTcNaAc0zZhWkIQ8pSPHu8ZUxgvv6DRZFi8MxK9OhKbD0j5eRr0DBoZMIlZtvWiO0VtxrcWEeIsnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358438; c=relaxed/simple;
	bh=7NVt0WI8WonQFSQD2fP3AW5DISeaYMFJR8bC6SEE49o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMhbUZhJek3seFflyyVb0IEQCJ3iF504z4F+vIViq4MuMUAErC+RPvF6eOjNkPgmVSmx35ESr0DrW0XUR4STUh7OhH4nKgLxQGWIa32CR/rzriwwYg9iFQRn5pmC5vkyloYK9gC1YZkNIl/H6Y/UYDt1ctZ70eF7hiEdrtEJoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+2mwKQI; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+2mwKQI"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so1453662276.3
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Sep 2024 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358435; x=1725963235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTyRAP6ldYm/RIrG1GDBeY32AFoUsfEcUDOM5nLfoPM=;
        b=M+2mwKQIaXRLptTXV2JJfosYmBdAxJ9+PVfb6fiI2ubcvm0djFRzzzBAZC8ar2GNgj
         wkLGGyAxNIWTukb2MeFjUru68iDMdqifQFQzJPLExnDV413EGmBrHmKnTlZw0UNud5Rw
         tulSKFk4H5SYBaNmLnXML4qw3dbmWRbq3Xw+Bhoy2ZPyfujQ2Eg+TiD12t3iYuUy5wp0
         JELtzKHiXjnaw8BEvtANmhHu3pPDmZu8IlxiT52UsgamwSptap7dXnQlhK1skIuvfZuh
         X4nxarDipONLNOdzPr9qJInhh3nwBT9a8W8QydWYLHUyeX+S/7M1ypgLDnA5kg9B3btR
         BvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358435; x=1725963235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTyRAP6ldYm/RIrG1GDBeY32AFoUsfEcUDOM5nLfoPM=;
        b=gO4DaWwrD20SpU+7B4Mtn09UsT2tCc9RveRxwiNkj2QACgM18e6zR4TOOi7uo28ACv
         De1RNYXB2xLXy5pt99LoECwM2xJnDsvrTkzLvQJOHYUGImtlzMHbCvOulKpwuqtSdvfD
         lrddaPY53jbzvWeykXlzNclKTvyfzAFnB5svVCr/zfVX+3g8KZIdh1ca3EZGhWXz5Wb+
         t8s2lecnlUUsVMhU3x1Kad7++/DQkqQ2+EaGba5UUgbtcuP3kUm8DXTmKHapE8yg+8/f
         4tMvS8+udz2ld8TsgXAmuJhY25G+4ZruQQbzIBioDdHcoaeWi53RwpcPO35B0kt5y3Oe
         wvBA==
X-Forwarded-Encrypted: i=1; AJvYcCXLNZWq4NShvZl1DMIJRUXl4JR9Qy3w6Z0q7x9gEqb5IyW2+Q2bbZN3JBE23oWXq09C0UfOoy1GBFndUl27zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FR6Kbi+sfx8/Wi/rv1a9IXuLSXr3y60vPVj6jwC3pEtf3a0e
	3x6HuS4V1BCnz8g9dvST32mi5YYbs1grNP7ignsOHrf1cHOeF1cHYAETeaFDneyeOT2Z1TwILtN
	P26E1gwa/b7k2SH6D/RO8QZl46djoE49V/6+F+Q==
X-Google-Smtp-Source: AGHT+IGmBgAMdjyJQyb7ftI6XxxA+1QlmiUelprGDLPAvCd56X4ObgoWFCUQwy4jbPJIBtOUmXURC4/vS8qRlSXuSmY=
X-Received: by 2002:a05:6902:1021:b0:e1a:7033:73a3 with SMTP id
 3f1490d57ef6-e1a79ffa19emr15943149276.27.1725358435204; Tue, 03 Sep 2024
 03:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-4-ulf.hansson@linaro.org> <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
 <CAPDyKFqcpxUJWL7FoRSXLXVhS5B9PjcTY5ryG8HAY_E1Btgwag@mail.gmail.com>
 <CAMuHMdWB2zjF1jajkQzFpt2=4oj25myG1CJ5i6450gkUVX19+g@mail.gmail.com> <CAMuHMdXM2qHGzcLDfZQNC1Zqj_vh72S9+rV6-xuM+p=w7-oHyQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXM2qHGzcLDfZQNC1Zqj_vh72S9+rV6-xuM+p=w7-oHyQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 12:13:19 +0200
Message-ID: <CAPDyKFo=GP+uBhGDkYWsLTf+XBmyZpmuu123SGMGeeyOge5x4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pmdomain: core: Use dev_name() instead of
 kobject_get_path() in debugfs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 16:43, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Fri, Aug 30, 2024 at 5:50=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, Aug 20, 2024 at 10:58=E2=80=AFAM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > > On Tue, 20 Aug 2024 at 10:55, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > > On Mon, May 27, 2024 at 4:27=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > > Using kobject_get_path() means a dynamic memory allocation gets d=
one, which
> > > > > doesn't work on a PREEMPT_RT based configuration while holding ge=
npd's raw
> > > > > spinlock.
> > > > >
> > > > > To fix the problem, let's convert into using the simpler dev_name=
(). This
> > > > > means the information about the path doesn't get presented in deb=
ugfs, but
> > > > > hopefully this shouldn't be an issue.
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > > Changes in v2:
> > > > >         - New patch.
> > > >
> > > > Thanks for your patch, which is now commit 9094e53ff5c86ebe ("pmdom=
ain:
> > > > core: Use dev_name() instead of kobject_get_path() in debugfs")
> > > > in pmdomain/next.
> > > >
> > > > > --- a/drivers/pmdomain/core.c
> > > > > +++ b/drivers/pmdomain/core.c
> > > > > @@ -3215,16 +3214,9 @@ static int genpd_summary_one(struct seq_fi=
le *s,
> > > > >         }
> > > > >
> > > > >         list_for_each_entry(pm_data, &genpd->dev_list, list_node)=
 {
> > > > > -               kobj_path =3D kobject_get_path(&pm_data->dev->kob=
j,
> > > > > -                               genpd_is_irq_safe(genpd) ?
> > > > > -                               GFP_ATOMIC : GFP_KERNEL);
> > > > > -               if (kobj_path =3D=3D NULL)
> > > > > -                       continue;
> > > > > -
> > > > > -               seq_printf(s, "\n    %-50s  ", kobj_path);
> > > > > +               seq_printf(s, "\n    %-50s  ", dev_name(pm_data->=
dev));
> > > >
> > > > While some of the old names didn't even fit in 50 characters, the n=
ew
> > > > names need much less space, so perhaps this is a good opportunity t=
o
> > > > decrease the table width?
> > >
> > > Sure, it seems reasonable! Do you want to send a patch?
> >
> > I started looking into it.  Then I noticed that on some systems
> > (e.g. TI am335x) the device names may have a longer format than
> > the typical <unit-address>.<nodename>. So I wanted to verify on
> > BeagleBone Black, but recent kernels crash during early boot.
> > Apparently that platform was broken between v6.8 and v6.9-rc1.
> > And during bisection, I encountered 3 different failure modes...
> >
> > To be continued...
>
> The longest generic node names documented in the Devicetree
> Specification are "air-pollution-sensor" and "interrupt-controller"
> (both counting 20 characters), so a typical device name needs 8
> (32-bit unit address) + 1 (dot) + 20 =3D 29 characters.
> However, I assume some devices lie outside the 32-bit address space,
> and thus need more space?
>
> With the BeagleBone Black boot issue fixed:
> "/devices/platform/ocp/5600fe00.target-module"
> resp. "/devices/platform/ocp/44c00000.interconnect/44c00000.interconnect:=
segment@200000/44e3e074.target-module"
> are now shortened to "5600fe00.target-module" resp. "44e3e074.target-modu=
le".
> However, "/devices/platform/ocp/48000000.interconnect/48000000.interconne=
ct:segment@200000/48000000.interconnect:segment@200000:target-module@0"
> is shortened to "48000000.interconnect:segment@200000:target-module@0",
> which is still longer than the old column width...

Should we really care about those silly long names? And are those
really a problem from genpd debugfs point of view?

That said, I don't have a suggestion for a new value of the table
width, but I am certainly open to adjusting it to whatever you
propose.

Kind regards
Uffe
