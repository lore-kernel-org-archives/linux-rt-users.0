Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3301F4CBC
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456367; cv=pass; b=XnELGvpzrZde53tLKCgiNEf03HggD6D87mcbeJnEbA1zC99P3PdOemCadhpzaP4oglqnfm6WPPK9LBW8/3owIedWUfmCKoBr7kPPRnz8ti4GHtfQ4W53Wcy+UntAp6i/NMyf1o6htwZE8OtHhFavtQ9f9TtGb34RhoUoK8ju+5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456367; c=relaxed/simple;
	bh=ZmNES0rQ9ISNgr7uZALBNDPgZnHFKUvbIrrvQjPUu9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtGnz+kB8PPqeHdbqTHiKjjWZ1WHn1TttDpt/p3D9CxSoAtZJONw9SGDzFjFGs327wxaDqdmS5UZniFsrDTEKAvKq+/ZevcpcAd64WxhrEcEqtDiQuEcVzoBADDTh3gtqIMs01M/ryDGIKw4szObWc0CpAAvmcICnIP90YMnmUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRCo+l3q; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRCo+l3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769456364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmNES0rQ9ISNgr7uZALBNDPgZnHFKUvbIrrvQjPUu9U=;
	b=WRCo+l3q/bcG/2ii23ferH66//QTcwPVVB8K+WU/zkv25Bq8ZNQLM4uE2Xb097zoU46Kwf
	NJm31D22PUFOaeRLC0jSNoq1izQAbOjeCYcK2/z9H1h9czX/aAitvFUSFLc7xzdZ6KrDok
	SX1l/+DmPhnYhBURqtm7X/8ojVmiL88=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-JogUHOWaN06PEhGZy6I6Ng-1; Mon, 26 Jan 2026 14:39:23 -0500
X-MC-Unique: JogUHOWaN06PEhGZy6I6Ng-1
X-Mimecast-MFC-AGG-ID: JogUHOWaN06PEhGZy6I6Ng_1769456362
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-385d4c511e4so26388371fa.1
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 11:39:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769456361; cv=none;
        d=google.com; s=arc-20240605;
        b=ViOeCT+Iz5QvM75RhwqWpgi30uK6Dqi9JxWsXQN28C24k6Nv4L/LzTYesuQbcjkmUb
         uHSxYytOgj++++JK5a4kvqPs2+eq9wGUbvdysbvC8Is/LdjNWyc6VLMPOx2omgPJvcgu
         QiC0hhd2LHxC1ESDj1AhSQMYs4ChM/aeBiyYneFfSmyoEanN4JxDIkCcQYClChDNMome
         0AUXdA6RPksXtsqeXSgJ/a8v9Z71pf+ss9piWMaW3os4C353kF8h3azEE8tsKW1oxpqr
         WPGpHwm1gk+JbeSjaDp+L3u3i2BRQmlp7n+iTXN1qNlZWJPYuEaL9NrYJPccy7xd8ozL
         hohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ZmNES0rQ9ISNgr7uZALBNDPgZnHFKUvbIrrvQjPUu9U=;
        fh=GQVtVDOr4LmQh3AXE5mtlG1IrXqWnNJOXTt2uOVDpxs=;
        b=iN4Yx5P39vVTvF/lawOvPyvtnZVDc4vMLSbdn0DyoLf5Boo8yPI82DxyM4jskqgQmi
         Fyz44ri9QczIqZnKMZdk01b26Luf17kTl5EyT0WbqKEOE21gQiZUp96tqIMCJ2z8BiNG
         7dbvmoSnY33Ma6v2dIID2nYy+Ad0Zli+tVYlc7GNLsiiUOI3NM9uGy3+ZG+wJIDPwB/9
         EWN32Et+/dpY5ZzYSUyLFKmo1GxCu0MrXOJd1J4uqhyoH15CREqZUTIYvy1ZmHsFG2ZO
         NMKRZgYB8h9GOJNo8TUDtBRdIBxqXQUYHkhSqYIWVevUdE9bTQ9HgPkWLNx1BabDha8V
         Oajw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456361; x=1770061161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmNES0rQ9ISNgr7uZALBNDPgZnHFKUvbIrrvQjPUu9U=;
        b=iOAqhe5CfxWYMny6JuvB4jKBK5HEObo09wVU/VOYMS+kHZA2HusGBnwbm7a0ZH7jby
         zALpK7m8k41bWFt1NjP8r1xl5vibmV/kApYCJEoHWwxTxPudumHni/OperrSYCwmV1PW
         toSZHRpCNM6hNQGodAXS4nsWo1neYLdnmq73PYrW8r5xOMnl0pw3MoMqnP5woywdqLfS
         id98PzPt1IvcBkiOdhCWK++4Ocv2CmpZcjkF1CyPgARgVBuu5I+LbAKMXo74LNhZ60xF
         NdVAtQrNv/M4II8jd8NWrwHkKg0WvL2YWJDpDbwRkONHPtk4aMPodhV9yZaBTI9DF/v/
         L/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVjG+kHdJDtdCJSxlSEBawmaiz68yfB8eXIte0qKltDF6n65BipDcaAEsSVd8vaMgPsAExkOFj3bEfFU9b10Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVHM2e0E0JOoa5jjzAeAD3zys51LwVhUx06QSWiz7RZpAYX5I
	wm79z08KSGEeOo3Sn9e7F1Ru0C4gQo0yitwgRcogEKCZW+FT4jwr6gQvCu5X31G7XdXRXFOcnow
	/a69X3ijtMyZsennC/liQ968uoLu0YU7nWpiahOLMGY7i5t52lL//t6gwXdk26F23Yt2G4E9Vow
	WUrZiNQU5KU77FZjwv7epoewf1C+h3JmDVMtmUdInkZfFDV+QQoeQ=
X-Gm-Gg: AZuq6aJi31pOvNF4m3Tf4eunz6JoCo6eb/Ozyek37xTEu2eLAkIlNzXBGiYQ6d4IB8U
	CgKOnVaBCq4dueppdQ6lAmNQiebr6eAhE7xP6MZLOtHy2691TmWQy0D887pysENN0TencnluHpJ
	UbHUI0chCmx0TR0y3ZhcSVHrDGT0OENP/xwJ5ZCJX41ZHkKsJfI6P92KM7tHPZJxOGdMP+hgwld
	f7RvFwvCw8wGaKzH5yVXwt4z5iB8+Qp6OYyUnzc4Z45b+HDO7nFvUk=
X-Received: by 2002:a2e:a54a:0:b0:37a:45b0:467a with SMTP id 38308e7fff4ca-385f9dbfe48mr19043471fa.5.1769456361597;
        Mon, 26 Jan 2026 11:39:21 -0800 (PST)
X-Received: by 2002:a2e:a54a:0:b0:37a:45b0:467a with SMTP id
 38308e7fff4ca-385f9dbfe48mr19043371fa.5.1769456361189; Mon, 26 Jan 2026
 11:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126130557.45950-2-wander@redhat.com> <6u67jhrwjfkhu3fv2vfr2ejwozruhafuo3xjdkasxiotum5trn@e3uhbogw5qt2>
 <CAAq0SUm03h=D39PLGzKG+bgPWBageM2VtR-RrSj8YHTTua+BTw@mail.gmail.com> <ot7ya4o2xzwyqynakh3z53ietdyhnoqqo3377ahf5egdsn6yvc@z4yb45rbucw2>
In-Reply-To: <ot7ya4o2xzwyqynakh3z53ietdyhnoqqo3377ahf5egdsn6yvc@z4yb45rbucw2>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 26 Jan 2026 16:39:09 -0300
X-Gm-Features: AZwV_Qjs0EMo_qNME5YHmpgXPKsLF64ModnJGHqrueCw0OVC68d1LqMKPoyrMhE
Message-ID: <CAAq0SUkNqiZv6JQLWR3s5GBNFXjTj68gmHOgFtW7y6dWEfxAUQ@mail.gmail.com>
Subject: Re: [PATCH stalld] Remove developer-specific configuration files
To: debarbos@redhat.com
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, jkacur@redhat.com, 
	juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 1:00=E2=80=AFPM Derek Barbosa <debarbos@redhat.com>=
 wrote:
>
> On Mon, Jan 26, 2026 at 12:54:23PM -0300, Wander Lairson Costa wrote:
>
> > Both Claude and Gemini provide the /init command to generate the
> > initialization files. I,
> > for example, always use Serena [1] and PAL [2] MCPs to improve the
> > file after I run /init.
> > This would cause changes in the CLAUDE.md file. I am unsure if any IA
> > related configuration
> > file should stay in the repo.
>
> IIRC, CLAUDE.md is in the .gitignore. Let's extend this to include .claud=
e
>
> Would a happy middle ground be:
>
> git update-index --assume-unchanged FILE_NAME
> or
> git rm --cached <file-path>
>

TIL git update-index

> on the upstream remote to prevent git from tracking any changes to the
> CLAUDE.md?
>

I think it is too much trouble to avoid a `/init` in a fresh
repository. Moreover, the developer may not use Claude or Gemini at
all. They could be using ChatGPT or who knows what will be the new
exciting AI of the next week.

> At the end of the day, it doesn't matter much to me, personally. Generati=
ng
> these configurations is pretty trivial on a smaller repository like stall=
d.
>
> --
> Derek <debarbos@redhat.com>
>

