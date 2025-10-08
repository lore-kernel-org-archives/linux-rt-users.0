Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1A4A06
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Oct 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959536; cv=none; b=E3F6VeMab5Fc6UgdZsHsqLVSPH5i0uxFYMg73nYpyBr62HK1an3z+KQAWNCP5k1ZOe6nsfAnunLUZ8fKjRfzL4phHxAE9OCCvi5kP/I/eEvlxB2gmvF3tDaN6dHifpGwuf9obfd2HR9rOwGmz/0AJox6/IMJp5Ijc2CKGGUFtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959536; c=relaxed/simple;
	bh=mLHO5pHChVIckwa4ywX1slhfgkqAirfbnb1uOcPXOPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KaEey/zZytdAGq3YTqCqWrYCE0wRjnMnmF3iBrFoUOaeXqi3B+H6fzFkjzipO4aQkL3h5PojOctHCZ44dhnFLsU0vMqRygmyvuuRo1OEoeRfBI2/bE4WRQo4QHR/H0diGhAa+k55BAneFdjUErmI7OYP9dDfAsCabUXIojrWPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xk5txtQ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk5txtQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759959533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bv0xSBO30PY/0+AAnX25ZbBIBvhzwF0Y2DaCHrZtKmE=;
	b=Xk5txtQ7EwSiSbOsT1Ats+bINMG9sxBvXPfLGWjCPxlY59WD3bS8NB6mtc5sq6DK86Bjo9
	kfv9FkrZF82iMRJRZsH5Cdd2Na8Xttw7/tsIWW+wfrHvjiom0+oGOxc7jjnFCpXBdbO0D5
	05q2JGXyWgIeLiC0L8iosm6iojpviXQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-HaJzsXS6PWCvc72YwWkW7A-1; Wed, 08 Oct 2025 17:38:52 -0400
X-MC-Unique: HaJzsXS6PWCvc72YwWkW7A-1
X-Mimecast-MFC-AGG-ID: HaJzsXS6PWCvc72YwWkW7A_1759959531
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d7c7e972eso12128896d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Oct 2025 14:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959531; x=1760564331;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bv0xSBO30PY/0+AAnX25ZbBIBvhzwF0Y2DaCHrZtKmE=;
        b=oeeN8Yn6rndDomm9D1eZjjfdfriwSxdHwFdx7mjGAXh+evvhYTqq3MkbNA7pXJ1+Nx
         ZAMsJmEwXoq9AoRq5LJ+GKyPIjeqG0nZ1KHtMp07WOiMazcpgeiBAUDvl7moyLEDAJoe
         7UIP12bnSBfaJUWci2I4pEcZ+NRHTezKP1y5FJG0J78c68PQSX7QmKjc8QB22ftIFnii
         zKpIAD9eQPctMEwOnsSV3ekyLpG8pLjAWbxQCI/Zv1BjFSRdBZr16M6VYVrr2BJr6d8w
         DeG6hD31ZLwbTUvVAoIh0MgKqVixqc57Dlmqp0r0RYk+07dMWdBp/xmREkInkkg11VW7
         /WHw==
X-Forwarded-Encrypted: i=1; AJvYcCVWTSmMj7KGbpcx+CLv86wTrKG73+tgyKG+iSs9eSXVX3O/iX5tjh0w5eAG6Vap7RULWiE2ZnP5fcxC+vMucg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynRBiU0xRdJSECgOKKfFt3m9+qidNr4y8fSsfUMrXhgrgUF9qY
	cyGcfVICnC2INaNjXszxwMnLL4Lj+uXr/EvPt/Gn51o3cEkwJmFeg3FCp+WExHKiRPcwThEf1sP
	Zy1yZeygL7v8QbT1RJidXeiuBi9vHFDIgC1kKPC3y8se15nZjaBjTNa6+auCkfgCzOOPyUJDIz4
	AY
X-Gm-Gg: ASbGncuCHhQqYGz+rmjANN8EjrFDsH6QvsEoptQxXXBOdbNiiiMtkwr36feicsNjpTh
	EkO6oP9Zj2qtGA/oiqf5zlQoPJ7XrCWh/BkHlDXhoQaF6aNzWW8gNw+qBhPTYRihyJ7yNxusZz9
	E/n0x47yfBFp8LRkpO+stY+XcNzYfTStvbhRb2VQI1Y52bzUap30S39u1yzKYpZnlZUDB8VAaCi
	YZjz0Lh2IDJbtrwiOGvJNLAmA5DaURH/dzfifPPAo5SxE9PC9ImGAESiuxlXxbnWxxYXQcOReEi
	92PnCFO5Wh67O0dYsZumUSwgiAqWJnwJO4TwTMb4EmtGZJFGCT1bsEiMJCytPe+belvcV0cw4Hy
	wSQ==
X-Received: by 2002:a05:6214:f67:b0:877:97d5:e4e5 with SMTP id 6a1803df08f44-87b2efc423emr71956406d6.67.1759959531347;
        Wed, 08 Oct 2025 14:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5hmwFMKlJJ6xdvsXvphPu5VTWncKy/1/DIXWkTlp/XZkD0yCrBp1eveTAVN0tu6HVOWpihQ==
X-Received: by 2002:a05:6214:f67:b0:877:97d5:e4e5 with SMTP id 6a1803df08f44-87b2efc423emr71956106d6.67.1759959530947;
        Wed, 08 Oct 2025 14:38:50 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60dfbsm170895176d6.14.2025.10.08.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:38:50 -0700 (PDT)
Message-ID: <20cee89c557ca65b99637d49508c62f8a636f846.camel@redhat.com>
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
From: Crystal Wood <crwood@redhat.com>
To: debarbos@redhat.com
Cc: clrkwllms@kernel.org, linux-rt-users@vger.kernel.org, wander@redhat.com
Date: Wed, 08 Oct 2025 16:38:49 -0500
In-Reply-To: <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
References: <20251002205515.1299816-1-debarbos@redhat.com>
	 <20251002205515.1299816-3-debarbos@redhat.com>
	 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
	 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
	 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
	 <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 14:41 -0400, Derek Barbosa wrote:
> On Wed, Oct 08, 2025 at 11:50:11AM -0500, Crystal Wood wrote:
> > The default, if no C language dialect options are given, is -std=3Dgnu9=
0; this
> > will change to -std=3Dgnu99 or -std=3Dgnu11 in some future release when=
 the C99 or
> > C11 support is complete.

I meant, why can't we specify c99 regardless of legacy (which would also
help avoid introducing new stuff that breaks on legacy)?  Unless
something in queue_track.c already does need newer than c99.

> > > When building on RHEL-7, it was though SOPTS still make their way thr=
ough, even
> > > though the comment specifies that these are variables that only come =
from the
> > > specfile for DNF-family distributions.I was getting errors due to ann=
obin not
> > > being present, so I stripped it out.
> >=20
> > Oh, I was looking for "annocheck" which explains why I didn't notice
> > that.
> >=20
> > So the issue is that when you *are* building an RPM, the specfile isn't
> > passing the right things for that OS version?  Wouldn't that be an
> > issue with the specfile?
> >=20
>=20
> It would be. However, annocheck/annobin gets invoked by default `make`.
>=20
> ```
> ifeq ($(RPMCFLAGS),)
> CFLAGS  :=3D      -DVERSION=3D\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $=
(SOPTS) $(DEFS)
> else
> CFLAGS  :=3D       $(RPMCFLAGS) $(DEFS)
> endif
> ```
>=20
> On `main`, with just disabling USE_BPF:
>=20
> ```
> [root@rt-qe-06 stalld]# make USE_BPF=3D0
> ARCH=3Dx86_64
> USE_BPF=3D0
> FCF_PROTECTION=3D-fcf-protection
> MTUNE=3D-mtune=3Dgeneric
> CFLAGS=3D-DVERSION=3D\"1.23.1\" -flto=3Dauto -ffat-lto-objects -fexceptio=
ns -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-prot=
ection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=3Dgeneric -m64 =
-mno-omit-leaf-frame-pointer -Wall -Werror=3Dformat-security -specs=3D/usr/=
lib/rpm/redhat/redhat-hardened-cc1 -specs=3D/usr/lib/rpm/redhat/redhat-anno=
bin-cc1 -DUSE_BPF=3D0 -D_FORTIFY_SOURCE=3D3 -D_GLIBCXX_ASSERTIONS -DDEBUG_S=
TALLD=3D0 -g -O2
> LDFLAGS=3D-ggdb -znow -pie
> gcc -DVERSION=3D\"1.23.1\" -flto=3Dauto -ffat-lto-objects -fexceptions -f=
stack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protectio=
n -fno-omit-frame-pointer -fcf-protection -fpie -mtune=3Dgeneric -m64 -mno-=
omit-leaf-frame-pointer -Wall -Werror=3Dformat-security -specs=3D/usr/lib/r=
pm/redhat/redhat-hardened-cc1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-c=
c1 -DUSE_BPF=3D0 -D_FORTIFY_SOURCE=3D3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=
=3D0 -g -O2   -c -o src/stalld.o src/stalld.c
> gcc: error: /usr/lib/rpm/redhat/redhat-annobin-cc1: No such file or direc=
tory
> make: *** [src/stalld.o] Error 1

Yeah, that's the "why is a basic 'make' pulling in Red Hat stuff?"
question.

> [root@rt-qe-06 stalld]# make USE_BPF=3D0 SOPTS=3D FCF_PROTECTION=3D
> ARCH=3Dx86_64
> USE_BPF=3D0
> FCF_PROTECTION=3D
> MTUNE=3D-mtune=3Dgeneric
> CFLAGS=3D-DVERSION=3D\"1.23.1\" -flto=3Dauto -ffat-lto-objects -fexceptio=
ns -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-prot=
ection -fno-omit-frame-pointer  -fpie -mtune=3Dgeneric -m64 -mno-omit-leaf-=
frame-pointer -Wall -Werror=3Dformat-security  -DUSE_BPF=3D0 -D_FORTIFY_SOU=
RCE=3D3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=3D0 -g -O2
> LDFLAGS=3D-ggdb -znow -pie
> gcc -DVERSION=3D\"1.23.1\" -flto=3Dauto -ffat-lto-objects -fexceptions -f=
stack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protectio=
n -fno-omit-frame-pointer  -fpie -mtune=3Dgeneric -m64 -mno-omit-leaf-frame=
-pointer -Wall -Werror=3Dformat-security  -DUSE_BPF=3D0 -D_FORTIFY_SOURCE=
=3D3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=3D0 -g -O2   -c -o src/stalld.o s=
rc/stalld.c
> In file included from src/stalld.c:39:0:
> src/queue_track.h: In function =E2=80=98find_queued_task=E2=80=99:
> src/queue_track.h:61:2: error: =E2=80=98for=E2=80=99 loop initial declara=
tions are only allowed in C99 mode
>   for (unsigned int i =3D 0;  \
>   ^
> src/queue_track.h:118:2: note: in expansion of macro =E2=80=98for_each_ta=
sk_entry=E2=80=99
>   for_each_task_entry(cpu_data, task) {
>   ^
> src/queue_track.h:61:2: note: use option -std=3Dc99 or -std=3Dgnu99 to co=
mpile your code
>   for (unsigned int i =3D 0;  \
>   ^
> src/queue_track.h:118:2: note: in expansion of macro =E2=80=98for_each_ta=
sk_entry=E2=80=99
>   for_each_task_entry(cpu_data, task) {
>   ^
> make: *** [src/stalld.o] Error 1
> ```

So I guess the makefile's definition of HDR is wrong, and it turns out
HDR isn't even used anywhere :-P

>=20
> Appending c99 to the CFLAGS on the command-line a-la `CFLAGS+=3D-std=3Dc9=
9`
> overrides the cflags entirely... so editing the CFLAGS to append -std=3Dc=
99..

You're saying that if you do CFLAGS+=3D-std=3Dc99 the only thing in CFLAGS
is -std=3Dc99?  That shouldn't happen...

-Crystal

