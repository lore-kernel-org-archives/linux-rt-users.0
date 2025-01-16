Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FC3A8C1
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jan 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060980; cv=none; b=SvwugkGi3g67qQVGNWCMMxGuib6hdkVBLbJHdKzPk3DumbLyeCWF0doqO6+MSFalqryFnGCuLXJ8Q6S1qsQ6xwtE22DzEtc3M2fDdkIYoQ0aNvL0x1V6vD03P+5x9AgaCF4tzHcRC0ZLFqPAnzYWsVvXiVpRAVQOJZSpB+i6n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060980; c=relaxed/simple;
	bh=skfmaln/2eeC3Y0PzHOJQl939qDTIE+KvsTDMESUuEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzZe6wvaV4vcs649pDZfmELa1Dr7IYEHRSVws3oaj9KIVXdN0tMsoqS7nj6+TPJKveGucFbQ8Fjzr/x6g+DrBQdVnkcSuQOsmceioETd7K7ChnoPKyDdOn6j3DeKBnpNuQUiAzi/+R2IBNFAE91pAcH6A4Sy7jKxSC+GNhA3ekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avxQRNh9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avxQRNh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737060977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ/puOQbxI31zedQdKyen9riKAJvgdaIMws+FUbPfW0=;
	b=avxQRNh9m0GMDR6hZEba/F7jbv3c3qp3BBl1GRdJjdata5ODvgxlYcZb7twR/eDnzk8CPf
	bIlnPnfQUNn+O9eqFIzLhD9sgU/1+m6jQS4dKqyqmWOD1+V5KOeRsCQU+g/j7Jl3qbHMQN
	fO29rJQej/jLp2X1Pc8hdobi6CHHx8A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-8V1efz1pPHiKWR4jrxW4kg-1; Thu, 16 Jan 2025 15:56:02 -0500
X-MC-Unique: 8V1efz1pPHiKWR4jrxW4kg-1
X-Mimecast-MFC-AGG-ID: 8V1efz1pPHiKWR4jrxW4kg
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467b19b5641so29704061cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jan 2025 12:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737060962; x=1737665762;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQ/puOQbxI31zedQdKyen9riKAJvgdaIMws+FUbPfW0=;
        b=BEZBnX9z98nMcS7h/ais2TykSwwHivoQv9s9SKl0EBjePCtrg7sDyQafALVkkraG06
         HpbZXAllTbrs5CfhqayOtBsXBmT4PbOCDZIK8oAU+OUbJwnyOU6bz599c8tg9C/hUOiN
         fy3WSDHY6N4KedqSkdaRpZkxpUGX1oD/mKRMPARAg0NgdjUqwHBJbX08xl8DSEhfliZF
         A97n05Q6rmx7X18foPtMHi3XYXHqYbJuJ8d+v73iK/ZyHWD/V0XJFZaxp7fW3j1wSgOC
         Z1uqY7gokpExoZAHcbKjQX2GWr65+TBaj38Vzn9JmvlNt6nfqzibdUbMBAa0d+SVvwSj
         lEMw==
X-Forwarded-Encrypted: i=1; AJvYcCXwI9DF5XRxqHrcGzBMsJyrp4q73MjD739mSuoUiR6qxlHqHd9LFVy+qkxpqD1Xf3p/XbaqLRXAJqmBG+CYLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGNlaqLmO3fBqwge+VnB5nKECQwqGgpbUQ/guweuNJnpU6/Gt
	6QpVJvXMapf51AD94E4HgXze1sgAdj3CFF2zNOhEOk0xEuQeN7oX3fQtP82qyGwnZvAnZkMIqLL
	QCQsOzpY+wssh4TNiJkfSmChefxrS1a0tvf3bxGnnyxA9zP/QK5ZXyh6BcBpIkZMq
X-Gm-Gg: ASbGncu2Fjp+sjDmp3N9q0pwe+4qWG5qDMijCJ9Z/xUxRv63x6zg5tm7xsWGn0PZF9Y
	/uVS2HG6/B/FpLq9j7jTJrDOfPtLzaRF20Qg8x2nLot//HPq4AvsDPeCItYchsCfCSP+KQBC7X8
	keZdh3tyOTXblRg4nwhlA6GM1CkrWOQHqw0okIvFGj0TBtLtSDPmfVr2ZLoQB6gR300pwIb5bvy
	/hMAMKPA1PU4vMgtZwUM4Ms8o9VQXHzvxGeQJKypNm1YQ9GG+8NThZDkJB7/LOnOot9IpguwNSW
	qpkIFsXGuO/x
X-Received: by 2002:a05:622a:1306:b0:466:a6e4:4c1a with SMTP id d75a77b69052e-46e12b918a4mr1713801cf.31.1737060961997;
        Thu, 16 Jan 2025 12:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9OnrHPeeZRdasvypA+wPl0p05UcGSCclhz8474izsJOXrY9yLV1fwmnEwHAzBRs7BLnTL3g==
X-Received: by 2002:a05:622a:1306:b0:466:a6e4:4c1a with SMTP id d75a77b69052e-46e12b918a4mr1713471cf.31.1737060961689;
        Thu, 16 Jan 2025 12:56:01 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102ec138sm3592381cf.1.2025.01.16.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:56:01 -0800 (PST)
Message-ID: <775f239d3485831f19499b8defee56e25ddc8d14.camel@redhat.com>
Subject: Re: [PATCH] rteval: Allow configuration from stdin
From: Crystal Wood <crwood@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
  linux-rt-users@vger.kernel.org
Date: Thu, 16 Jan 2025 14:56:00 -0600
In-Reply-To: <01904166f9337db39745149e53ef0d410c2cbcef.camel@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com>
	 <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
	 <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com>
	 <8abfe0115fc4e7824f9d92743d9d41b5dbbdb50a.camel@redhat.com>
	 <a37f794b-fb11-417f-3131-f0d61c8e077d@redhat.com>
	 <b16d675a16d3592e14af07a58954f4eb9de991e4.camel@redhat.com>
	 <01904166f9337db39745149e53ef0d410c2cbcef.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 07:45 +0100, Gabriele Monaco wrote:
>=20
> On Wed, 2025-01-15 at 20:14 -0500, Crystal Wood wrote:
> > On Tue, 2025-01-14 at 18:07 -0500, John Kacur wrote:
> > > Now, you wouldn't HAVE to use them, currently timerlat is the
> > > default, so if you don't specify, then it would use the default.
> > >=20
> > > Like with stress-ng and the load modules, if a person tried to
> > > use a cyclictest and a timerlat option at the sametime, it should
> > > create an error and exit.
> > >=20
> > > I like the above idea, because other than the optional option of
> > > --cyclictest and --timerlat, nothing else changes, so it wouldn't
> > > break anybody's scripts in any kind of major way.
> >=20
> > None of these proposals should break existing scripts, assuming we
> > don't
> > change the defaults.=C2=A0 Removing config file support, OTOH, would fo=
rce
> > people still using cyclictest to start specifying it on the command
> > line
> > one way or another.
>=20
> Strictly speaking, enabling timerlat as the default measurement module
> did break existing scripts, that's what brought me to start this patch
> in the first place.

By "these proposals" I meant the command line stuff in this thread.

>=20
> I agree that we should try to keep the same behaviour with respect to
> default values, no measurement module specified via command line should
> be the same as no measurement section in the config files, as
> specifying only one should disable the other. Specifying both should be
> allowed.

Why should specifying both be allowed?  We go out of our way to prevent
that, because they'll interfere with one another's latencies.

>=20
> I see the command line as another setup that should override the config
> file, while behaving exactly the same (where the notation --
> measurement-modules would indeed be a bit more familiar, but I still
> like --cyclictest/--timerlat).
>=20
> The order could be: command-line > explicit config file (-f) > default
> config file (/etc) > default values, this wouldn't affect the behaviour
> much.

It's not the same, since the command line would only override individual
options, while a config file replaces all defaults (at least when it
comes to enabling modules, not sure about other defaults).

> I see the simplest thing for now is to start with command-line options
> for measurement only. After we consolidate that, we can do the same for
> loads (with or without special cases).

What makes loads harder?


-Crystal

