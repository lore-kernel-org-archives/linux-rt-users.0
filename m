Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331BB350D5E
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347268; cv=none; b=cdKjhSUD2HshxgNxpbanEESQHAy0wVl/S0x9LCph/Z+2TxMP8Oie+EYDNhNfnZgk/uyGiLhUvViOKnYq/jQbMeE6o5RuTwl7FArMK3KCK2SQSRJZrHmPF043fXFWQMzwbEeNsnwCtGCIHZOCPLZw5V5MmO6A53Vm57SuE24Sn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347268; c=relaxed/simple;
	bh=R/uo5rCRgxg39bjNECMa6pcKfocpUebBYviS4UgBS+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuzbDBySjOE6KrxUPXlDG9MEaocQF50U25RmVgrNQ7C6DPwsbNhBb+YEjTIWgEDHeZm9ut3T5kD99VjGBb2If1dQzZSvBI+bZK7qK1cY04hQPFQCM1dC5UFusI6sj8GI3sWeWSCqKxVcFbqSCp6+czY76DESUvbLBOzGze6J0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCVr64kt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWKWGXtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCVr64kt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWKWGXtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768347266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPdfNh1NTGkRciDrnCZSILO71r4LPms6MlSZ21mNGKk=;
	b=RCVr64ktbZWk0B8/Mi4LiRFRPYQ6GGxM5kcVODeLahSBunjP8GgJsTWPHV5LZ5fESjZAla
	w6CtfF1FEx4FSCkC4jUGz22dPxgVDOSbqRYNX1mmpsWaBJOX8VtlFSvjgHWC2YVTvh5d4w
	SQcYV1kKYZmIdMXeRPutpMfpRlwBBsw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-XI-OlmDHPaGPm2p9VI2S9Q-1; Tue, 13 Jan 2026 18:34:24 -0500
X-MC-Unique: XI-OlmDHPaGPm2p9VI2S9Q-1
X-Mimecast-MFC-AGG-ID: XI-OlmDHPaGPm2p9VI2S9Q_1768347264
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a316ddbacso208828796d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 15:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768347264; x=1768952064; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dPdfNh1NTGkRciDrnCZSILO71r4LPms6MlSZ21mNGKk=;
        b=FWKWGXtL6IWQ3STSpagYUVY5lBMzuav73hZ6bROMx4t8Xb6bMXGbLsCsP8C8dJNjFG
         RCDyruyqGxFm/7s3tx9NB6esYXwuAqQ0hcscBnqygT4P773mHN29JjOuHOHNgXC/HDAT
         I9DEgA8hsX9HmaK3KDFkmBzVm+rR4sd6SCUEDZA97xtFqm5D0yg0bz2/45dFeUWgNhhW
         uehEBVKUtauOxI93w5SqkOgUQxGSDshbdldoDdvT/l9YiVUskkjE1oBYqDtiUGg3MN7U
         SqjLnDFRV1ycjgo9+Tv7ZAxiqt7UBe8+zfwm2ErjD4BnuJZkjPIqZXk+F80OUZNyfUTl
         EJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347264; x=1768952064;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPdfNh1NTGkRciDrnCZSILO71r4LPms6MlSZ21mNGKk=;
        b=tHox7t0MePpBEh1Kk68keTEC/bMNUd9UB0BCk6VWO/UqKquZCiDceRnezuisdTVjWt
         viNwnr+G5OOced9D46ISJH3BBWRKVPsFV7ejK9y47Pg4UZ/giRqcetL9bqYb2X6YiBKe
         LMqLUavev/G9qvemkSlmF8bZIC4g9frzuSivAd9Fv/eI08t5DiWUzTguZ3wopcDuv/iO
         gFr2QQfks+CfcwyLh8SOkJ14IrWAF1rvMiWTzSTI0uq7tywm7lCKZT78mzm70C2QQV4R
         tmL078PR4kuySFSZfROxXtY+Ou/AhSNFx2CKxY0oPheMaKALguFE9/rzELeVTQAJ30Vy
         lV0w==
X-Forwarded-Encrypted: i=1; AJvYcCX9E+mhBnNPO9bME1lu4Fej3HZcrYJ7vNr2+jHjBI6o7229rX39SsHKQNwB97DRFNlDk63GYVK8J6gGI9E4vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzI2Ddo+/i3q2o10LuSaauPbmQWGvi3bLKsEP7lDrOP+kilkC+
	BldsFGoQLhe3CDEQ8lgLuK+fnL2ZQZQT/ypm6DSfF8wM5P08x2HrDQZCv0EofyUjloo/1z7e2ym
	JaoqmxEyx92s6wfH2uAOKhksjChN1x02Zt9w3MGr8vAJBtaeI3yWH80kj+eFUsuzqNjEH
X-Gm-Gg: AY/fxX55QeG8uSc+qtLFWjFnrVuJIg5/XlBF9BkMjZF8RoHSA+y7hiPCeCCz/M7N/uw
	RTSAfRm3bv6X5KQl4OWCPrScD4QRO9h+qSFM+tpuTlC8fQvyAbpElxQuTtRmiYi7qQNsp2xg6do
	S1B8IFDaZMALCMWLq+sWzhFD+yowuVrBorlIQMyZk8FYp4VBUMTdsSLnrpCTuad5osMEUovQ/VW
	cLksr9zzRK5c0UxF+PsSAMa0eH0zvh00bqx63/VvL5sbGTO62HhW3rr6YANMvvCuqovzhwvyyjC
	7il//KZciXgnowlFx+ntU3KE+uuPIckn9o3QjsWbum8K51C042CR8GorFFBDo4e4l/4qv27PnsW
	3iEvdNLwJ4iUoVs/KjWX1YVT702U74fsx+fxUq7gm2g==
X-Received: by 2002:a05:6214:29c1:b0:882:3f45:c819 with SMTP id 6a1803df08f44-892744116f7mr11435436d6.53.1768347264428;
        Tue, 13 Jan 2026 15:34:24 -0800 (PST)
X-Received: by 2002:a05:6214:29c1:b0:882:3f45:c819 with SMTP id 6a1803df08f44-892744116f7mr11435146d6.53.1768347264063;
        Tue, 13 Jan 2026 15:34:24 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077234c96sm165691376d6.27.2026.01.13.15.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:34:23 -0800 (PST)
Message-ID: <3f92def31ba2533104fb8294a4f3e16234b99f56.camel@redhat.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from
 long_options
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Costa Shulyupin <costa.shul@redhat.com>, linux-rt-users	
 <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Tomas
 Glozar	 <tglozar@redhat.com>
Date: Tue, 13 Jan 2026 17:34:22 -0600
In-Reply-To: <20260113081300.s3s115wU@linutronix.de>
References: <20260110113738.2376456-1-costa.shul@redhat.com>
	 <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
	 <20260113081300.s3s115wU@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 09:13 +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-12 15:13:22 [-0600], Crystal Wood wrote:
> > > --- /dev/null
> > > +++ b/src/lib/opt.c
> > > @@ -0,0 +1,29 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +#include <stdlib.h>
> > > +
> > > +#include "opt.h"
> > > +
> > > +char *build_optstring(const struct option *long_opts)
> > > +{
> > > +	char *opts =3D NULL;
> > > +	int n =3D 0;
> > > +
> > > +	for (int i =3D 0; long_opts[i].name; i++) {
> > > +		opts =3D realloc(opts, n + 4);
> >=20
> > I realize this isn't going to be noticeable even if it ends up being a
> > copy each time, but linear realloc like this makes me twinge and think
> > of how just about every other language in common use would have a
> > readily available growable string implementation :-P
>=20
> and assume you never run out of memory=E2=80=A6

Exceptions are a thing, though in practice a small allocation failing
means things are pretty screwed regardless.  And it's not like each of
those error paths is getting test coverage...  For most non-critical
userspace code, might as well keep things simple and crash out on OOM
(with top-level exception/atexit cleanup in one place, if needed).

-Crystal

