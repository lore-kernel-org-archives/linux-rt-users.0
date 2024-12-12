Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E7259485
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987841; cv=none; b=FNR3kaEmekYg3hbt1Idr98bwZAvJg4TQrBP6AHJ9tNheQImUb/QbPI0jepu47LdeTHHBEUYVNsSrEGdXahFhbp2P3GwyKzRqZqpBAUQDc/Kmxk4OVeAsdcFO1IgiiZavoRLJQa5MxgbmCKE1EBv7Z+2kqC4Wg33PeNzq/22AKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987841; c=relaxed/simple;
	bh=rCCanhydis+3w8eQWOFY3+6XbNkQfT8pN+51GseIgp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n33yn0jJyvv5AseImPIGiAA/o5EbaRz49G8or8sR6Fh4+IWlaj6lBsXPrlMuMlfmEbv2leL+rY/Um5QJiWJN4DMmnmtrV9296eqKiUGAuDBa+2u7zHU2FDu2D6SMypigXfG44bR9gKRxSPidBCl5tEvOs6C3uaQ+h74fLt+Clj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inBwEUJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inBwEUJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733987837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ummkdk2R+lEQgT3L25vz0oylL6zj1zlRgySzcgDwl7I=;
	b=inBwEUJD/qtJRSQ7C1BR7Zl0G6cCVLvBfieYHNSk7LhH70kteFJwlAxwMuZxWsjvrkDTtZ
	B1O76nEoX/yawZmpd7tu72jKoH1X6YkJPFU3V4h2I73DB5PtRZjA7OeIGhPrUCM8m73AJ+
	SnlhM5y9u4v2OLolD1o+cV01ZtPXRhs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-bF1iwu_xNdWd7oilvViasQ-1; Thu, 12 Dec 2024 02:17:16 -0500
X-MC-Unique: bF1iwu_xNdWd7oilvViasQ-1
X-Mimecast-MFC-AGG-ID: bF1iwu_xNdWd7oilvViasQ
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6a7bea04cso18515666b.3
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 23:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987835; x=1734592635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ummkdk2R+lEQgT3L25vz0oylL6zj1zlRgySzcgDwl7I=;
        b=Hm4rkAWebTrhVOMAtOiWyaRlHpRDY+5cO5YPahZCotsz6sh8WyM86YU7ukFzCLsVbQ
         bTJknBYjomiExXTMOnz5drAj9A+l5ll9E1tbJwWQBoV1razAEoSBQ3XBDCReW4TBcLcq
         hWmOoRAGRjmGGJ4vBTtG2MGAssxaLCUInNB3JxuasPxPADMWb+NM0gg6QDgPhkhnAZ16
         Q/9VpNt8Cu7IBmX20ivOefE2fXYP1xbl3S/fbPzPCpSQ8jdlZF4Y5KGbm8aI85FpJWob
         vNO60Ts4YcGknPP0RdBmYYoMTzOjEMB+uVI6LCSRIXANkZcbh8CWC3bTLvtddaMtVWCu
         odLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw7sliPYAURjI1HU05iXva1Amw4R80KBVwfudTcVOBePInA7VlGaL/cssLu+DUhFoQcmMtStRdjSv6uOLL1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyht56DV+AVi3YR2ItTI8r0fIpHwp6Z4zPCpkyTu2F/EgJdigU0
	EsRoIYe/wvEhIltnH8OgI56FE8SREgiNd6GSumTLZB0MwD5CCNIRj7704Ad10wQA6riBsptN7cS
	lszMj/VqVK+hP6wOueoP6lZ5Cs8nNFUFM9oZB5fJPXPq/wrFiJNZrGhlYwgaZ8cNMhSGMgl0Wyt
	3++KdQd845veGw4Vhvij6Ym5b1790JjbJ8YS3bL+4=
X-Gm-Gg: ASbGncsHbIsCnI6ZePqMI2ncSa6pBjT9wwcDKKF2XivcR7eNU/zit42x0Nc90ddwHAs
	f7eW515zfPj2yx7E63W+GBZWXqpjcwCvGZd3g1Q==
X-Received: by 2002:a17:906:1ba2:b0:aa6:7165:5044 with SMTP id a640c23a62f3a-aa6c1cf0671mr249983566b.44.1733987834976;
        Wed, 11 Dec 2024 23:17:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3ENi/naEl3EYb7Ep7CLRNdjMvFJY/7GVWFg8AoBA7OF6q3Nxhxwx6FtRHbBp0m3YoHGKFP5pJMDtItxLCJpw=
X-Received: by 2002:a17:906:1ba2:b0:aa6:7165:5044 with SMTP id
 a640c23a62f3a-aa6c1cf0671mr249981766b.44.1733987834573; Wed, 11 Dec 2024
 23:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204203201.8145-1-jwyatt@redhat.com> <66e0ea75-d388-ae24-cc2c-f9016c85836f@redhat.com>
In-Reply-To: <66e0ea75-d388-ae24-cc2c-f9016c85836f@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 12 Dec 2024 08:17:03 +0100
Message-ID: <CAP4=nvQPxwzbAqctuXOkxUQFJGYxSbELdLrg=+_oKkt2k70i6A@mail.gmail.com>
Subject: Re: [PATCH v2] tuna: Fix help.py syntax warnings
To: John Kacur <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>, Clark Williams <williams@redhat.com>, 
	linux-rt-users@vger.kernel.org, kernel-rts-sst <kernel-rts-sst@redhat.com>, 
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 11. 12. 2024 v 20:17 odes=C3=ADlatel John Kacur <jkacur@redhat.com> naps=
al:
>
>
>
> On Wed, 4 Dec 2024, John B. Wyatt IV wrote:
>
> > Fix two syntax warnings with what looks like should have been a new lin=
e
> > like the other help entries.
> >
> > I am struggling to reproduce the scenario that caused them despite it
> > was after running ./tuna-cmd.py. The warnings do not appear most of the
> > time.
> >
> > Regardless, these are an issue that can be trivally fixed so sending
> > a patch.
> >
> > Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> > Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> -edited commit message
> Signed-off-by: John Kacur
> ---
> Please don't include what should be a discussion in your patch,
> just tell us what problem you are fixing, and how if it isn't obvious
>

I agree, additional notes and information that does not need to be a
part of the commit can be put in a cover letter, even if there is only
one patch.

> Thank you
>
> John
>
>
>
> > ---
> >
> > Changes in v2:
> >       - Add my signoff.
> >       - Small correction: ./tuna-cmd.py
> > ---
> >  tuna/help.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tuna/help.py b/tuna/help.py
> > index fa47ae8..c913a16 100644
> > --- a/tuna/help.py
> > +++ b/tuna/help.py
> > @@ -44,7 +44,7 @@ PROC_SYS_HELP =3D {
> >       'net.core.rmem_default':N_('The default setting of the socket rec=
eive buffer in bytes.'),
> >       'net.core.rmem_max':N_('The maximum receive socket buffer size in=
 bytes.'),
> >       'net.core.rps_sock_flow_entries':N_('This controls the maximum nu=
mber of sockets/flows that the kernel can steer towards any specified CPU. =
This is a system-wide, shared limit.'),
> > -     'net.core.somaxconn':N_('Limit of socket listen() backlog, known =
in userspace as SOMAXCONN. See also tcp_max_syn_backlog for additional tuni=
ng for TCP sockets.\Default: 128.'),
> > +     'net.core.somaxconn':N_('Limit of socket listen() backlog, known =
in userspace as SOMAXCONN. See also tcp_max_syn_backlog for additional tuni=
ng for TCP sockets.\nDefault: 128.'),
> >       'net.core.warnings':N_('This controls console messages from the n=
etworking stack that can occur because of problems on the network like dupl=
icate address or bad checksums. Normally, this should be enabled, but if th=
e problem persists the messages can be disabled.'),
> >       'net.core.wmem_default':N_('The default setting (in bytes) of the=
 socket send buffer.'),
> >       'net.core.wmem_max':N_('The maximum send socket buffer size in by=
tes.'),
> > @@ -118,7 +118,7 @@ PROC_SYS_HELP =3D {
> >       'net.ipv4.tcp_reordering':N_('Maximal reordering of packets in a =
TCP stream.\nDefault: 3'),
> >       'net.ipv4.tcp_retrans_collapse':N_('Bug-to-bug compatibility with=
 some broken printers. On retransmit try to send bigger packets to work aro=
und bugs in certain TCP stacks.'),
> >       'net.ipv4.tcp_retries1':N_('This value influences the time, after=
 which TCP decides, that something is wrong due to unacknowledged RTO retra=
nsmissions, and reports this suspicion to the network layer.\nRFC 1122 reco=
mmends at least 3 retransmissions, which is the default.\nDefault: 3'),
> > -     'net.ipv4.tcp_retries2':N_('This value influences the timeout of =
an alive TCP connection, when RTO retransmissions remain unacknowledged. Gi=
ven a value of N, a hypothetical TCP connection following exponential backo=
ff with an initial RTO of TCP_RTO_MIN would retransmit N times before killi=
ng the connection at the (N+1)th RTO. The default value of 15 yields a hypo=
thetical timeout of 924.6 seconds and is a lower bound for the effective ti=
meout. TCP will effectively time out at the first RTO which exceeds the hyp=
othetical timeout. RFC 1122 recommends at least 100 seconds for the timeout=
, which corresponds to a value of at least 8.\Default: 8'),
> > +     'net.ipv4.tcp_retries2':N_('This value influences the timeout of =
an alive TCP connection, when RTO retransmissions remain unacknowledged. Gi=
ven a value of N, a hypothetical TCP connection following exponential backo=
ff with an initial RTO of TCP_RTO_MIN would retransmit N times before killi=
ng the connection at the (N+1)th RTO. The default value of 15 yields a hypo=
thetical timeout of 924.6 seconds and is a lower bound for the effective ti=
meout. TCP will effectively time out at the first RTO which exceeds the hyp=
othetical timeout. RFC 1122 recommends at least 100 seconds for the timeout=
, which corresponds to a value of at least 8.\nDefault: 8'),
> >       'net.ipv4.tcp_rfc1337':N_('If set, the TCP stack behaves conformi=
ng to RFC1337. If unset, we are not conforming to RFC, but prevent TCP TIME=
_WAIT assassination.\nDefault: 0'),
> >       'net.ipv4.tcp_rmem':N_('Vector of 3 values: min, default, max\n -=
 min: Minimal size of receive buffer used by TCP sockets. It is guaranteed =
to each TCP socket, even under moderate memory pressure.\nDefault: 8K\n - d=
efault: initial size of receive buffer used by TCP sockets. This value over=
rides net.core.rmem_default used by other protocols. Default: 87380 bytes. =
This value results in window of 65535 with default setting of tcp_adv_win_s=
cale and tcp_app_win:0 and a bit less for default tcp_app_win. See below ab=
out these variables. - max: maximal size of receive buffer allowed for auto=
matically selected receiver buffers for TCP socket. This value does not ove=
rride net.core.rmem_max.  Calling setsockopt() with SO_RCVBUF disables auto=
matic tuning of that socket\'s receive buffer size, in which case this valu=
e is ignored.\nDefault: between 87380B and 4MB, depending on RAM size.'),
> >       'net.ipv4.tcp_sack':N_('Enable select acknowledgments (SACKS).'),
> > --
> > 2.47.0
> >
> >
> >
>
>

Tomas

