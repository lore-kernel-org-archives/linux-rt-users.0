Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EC4B53E5
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472992; cv=pass; b=hc3KGUHqB9jwRXPJZAvgQgHoUTJhfpx6nMmH1MbaWtRmW3cla9oaaKhv2UJU27me3XCLFNs+B4+IFc8fMgLLZjsMAPQtwKsRyCw83oQtTtYBB5FsB+bQLLytEE5SeS5bp5ZRgrBYzF2+ibaYqYgdQrSdX9mJErIuF+5VE5eEqwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472992; c=relaxed/simple;
	bh=EXOR4iOdzDdbw9BTRVpZHAce2DHAJqhWRvXI6XbY3Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJQM7jz3Zg9DPSMXO9J2XGnRZekrsAXUZyzRPVVXfiEZHwBaNfVj8VqGiDgE34OsRYWd3H3MAfX+/Xb8ejqFqaHApmlpPBIbssLmqyzyDYrmb88dCpwWxdJuPOY86T0vT+ooKl7Tl96SFehagrwitIBeSMF7q9fs0pgX7dtaOig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIt1xOWt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xgru4m2U; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIt1xOWt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xgru4m2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789472989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwN5kKXtiI2fFHRY/jnsK7ZerPTkGN9nebVXUIX40nM=;
	b=fIt1xOWtLJ0EiFFS7pK6W+Zx6LhaEy6Nfcp+l3lfxG407bi54npgqwGF0rUUgG0yqJxhBQ
	7q5lCB2J6CyjoXp+suMcTuCzWCaOdSnobB+ga4eafdkaYwcwSJw/+TbAoLn+Qdb7Fuu1i/
	5vPpnaaHOGP82E2xt6UIbmBahViwIdE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-u4qUsyCJP6m4xFI9q5mgNw-1; Tue, 15 Sep 2026 07:49:48 -0400
X-MC-Unique: u4qUsyCJP6m4xFI9q5mgNw-1
X-Mimecast-MFC-AGG-ID: u4qUsyCJP6m4xFI9q5mgNw_1789472987
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29d3ad6b74so24853566b.3
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 04:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789472987; cv=none;
        d=google.com; s=arc-20260327;
        b=faI5aagArwJhM9iAgNIS/4QaU0z7MSc6QYir8pEzYvhNsLg/26UteAkvCnnrSmjqxr
         V23qYH9fjZfWm6DWF8nP4VCKQvt0wqxdXNpNGRkQAJjKj44rVYluqlUEFoSoMjUmrHsJ
         rp4f0hTFLW1TYnz6Q91ijMTXXboMYlRIvhJNzecXglYiIdV14TmCB9pGopUVSEg3Bzj+
         dnsz2WSXUXd4HZAYrL3Y4xOoRQuqFT8OxZy0L80M+eYbC8IMeKRjzdgI6n27IHEG2PRL
         k/fSbPduZg0kItmZBCsJWkHoquvgvXpdYgI6t7jVPr3GQDQxsvtewni33RFPShZqjEJ0
         uR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwN5kKXtiI2fFHRY/jnsK7ZerPTkGN9nebVXUIX40nM=;
        fh=+r61a1sXDgDuLY/QW00HXrcGWXuas0PAoY1MasiGOYc=;
        b=oPs5SbegwUMnpLWooxyVKviE6ZrpbBxIpR+WpD1ZFrKL9IxzXf30I6Mxfxva6s/C8e
         5jJe95lHTeHz8Xwgh+1zUE8GGlA0kOpkZ8sVu26vrlBSUkeYqxbA/nM4SXwCX8z8NGbJ
         R+FLL/P32CCoVgV50hINQgziFdUKDXsf8LNC0iIUy23VW8Tej7FubLkFcfMJ8knUwWDl
         kSyDdoiF8Dqci21yFxBt+xQCS82bw06tpEy1IHgcFwrwMX0IUcx7Wr5KAHwHAa+YoERX
         xtaChlbCYejbt5nw+OMTuSh3uD7n9QYaND2VYp3qxF+Jlq0PXIpNGNMgLQOIQ5QpGD1X
         q3+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789472987; x=1790077787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwN5kKXtiI2fFHRY/jnsK7ZerPTkGN9nebVXUIX40nM=;
        b=Xgru4m2UEAGicxKRM2xadQYpq0iztW7fN6X0Kc47zXSOAp2NpaHEQTc07fHb/M7C+x
         0bMGz3+q69beaI8TqRbYjkTQpp6Pm1m/NluAI39dr0zUMduVr0WOIK72Qzc3IZ9qUNBo
         W5S6DmWoF0ptpEwpFIxJsLQxjseuhS+2EKAiCaj3dSPgFJ3p9n3gUqAaEdysXdmGIg4C
         Xwi09kxjxtcp2rEdo7aHIJ7eif6DgGvnrbsecZYw5u99XSOs15Mp6HDVZ2Fsr6VbxFQW
         A8q/+3pKcwT1EH2GGNfcg2P1GBbMpC4XUt5GdfRakjbh5Z1mfQWvUs+oPm8SOuMY/lut
         deYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472987; x=1790077787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwN5kKXtiI2fFHRY/jnsK7ZerPTkGN9nebVXUIX40nM=;
        b=yQxjfO8FO8oDC9zShyfoPuNXbUwGdu64Tgp1927KOkFTcpPXEt5A8Dht32oB0tB/gL
         kIoOox3WprYv3nbYcxh73o2TlD0+do/cw8TVJD8lAzSiEasFEwD9X4wkshT1dmTRBeAZ
         kfiKp6Uqpa2y+KpdTnjHamXwFJjJpmfVNKhALw/j6bEBpiCHWROhqlF6+0KcGRCJFn6D
         wKVSmCslXInlBi9qlmkEgSD5v+BkG8av6FOpNGllZvW9ijRsSnhW17AJpmMU/YK/6gHx
         S/oUVxs3o2f8G+ekEjcT2pT734uDLfm5IVjayqhGLd83mKjZuObSrpiIY6ITDEB7XLnu
         yfbA==
X-Forwarded-Encrypted: i=1; AKwUvBzO638F6csmN/+hmYZO30WI7aRatvYUio+/jBO3rp9ziSrAsMdhlMYroIq+0i4z0KvYATrxtSke4O5snmgrEA==@vger.kernel.org
X-Gm-Message-State: AFuF++kDxbaqASOnZEI+YRSECEgY0rFMHUfo7EjcjKm9o52A4tytVSEX
	yrlOZqg9g3iWu7VHGFB/ocaRFT8TomNq78bv8cvL6U87p39Gly49UoNzdig+qxPVIf8QkY0yc6u
	H4KYsA2Hg/JPH/V/HIyJB7CAty2qkH6DtGkJK9ByJPjO3FtRoMcLiZIR+ZqkJ+nK84gVQV+v669
	aCeZ2JS1eQN47+sdu3ElLDKI/EBBOyUZXuDvrRMl8eBxPGWRR4/hk=
X-Gm-Gg: AYBFou0aD3u2njsmeK9ouEg0v5kKz/unJevo4CuxQC9wtGXf6am/hB1Hug2erRo2wNg
	sn6APwzijENC8rkDe3zMLUwDUxLjJmAETJS+3C6NMEddn0ag6ZZJP8G9gG7M6CoM2WlRq3PiZ4R
	uQ/XiU1qsQUkZRKct5gTBo/siiQ94NOVami3/IvvaPL+Fsm/Oj8BWv/YSn
X-Received: by 2002:a17:907:c18:b0:c25:8e53:45ca with SMTP id a640c23a62f3a-c29b87655b6mr775840266b.21.1789472987325;
        Tue, 15 Sep 2026 04:49:47 -0700 (PDT)
X-Received: by 2002:a17:907:c18:b0:c25:8e53:45ca with SMTP id
 a640c23a62f3a-c29b87655b6mr775836566b.21.1789472986919; Tue, 15 Sep 2026
 04:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915012154.2172762-1-jinnan.a.li@ericsson.com>
In-Reply-To: <20260915012154.2172762-1-jinnan.a.li@ericsson.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 15 Sep 2026 13:49:35 +0200
X-Gm-Features: AcwNN1WS8YwUQF_AEIpMvSWB12_hoaR-6tkVe9_7rMR11SqRlJoJhX0c0p_f_FM
Message-ID: <CAP4=nvRU3DAm2dg-TM8-6+QQ+0gNNhvFXp3Tu9rfM=2wbwJ-Ew@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] cyclictest: add --warmup option to skip initial cycles
To: Jinnan Li <jinnan.a.li@ericsson.com>
Cc: jkacur@redhat.com, williams@redhat.com, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:25=E2=80=AFAM Jinnan Li <jinnan.a.li@ericsson.com=
> wrote:
>
> Hi John, Clark,
>
> This is an RFC for a new, opt-in --warmup=3DN option for cyclictest that
> resets the Min/Max/Avg statistics (and excludes samples from the
> histogram) after the first N cycles, to keep one-time startup transients
> out of the reported steady-state latency.
>
> Motivation
> ----------
> On a multi-threaded run, e.g.
>
>   cyclictest -m -p 80 -i 1000 -d 0 -t18 --affinity=3D6-23 -D 3s -q
>
> only the first setup thread shows an inflated Max (e.g. 7us) while all
> other threads report Max 2us. The first thread absorbs the one-time
> cold-cache / TLB / page-fault cost, which then dominates its Max for the
> whole run. Discarding the first N cycles removes that artifact.
>
> Design notes
> ------------
>  - The option defaults to 0 (disabled): with --warmup=3D0 the behavior is
>    unchanged and the histogram path is identical to before.
>  - When enabled, Min/Max/Avg are reset once at cycle N, the average
>    divisor excludes the warmup cycles, and the histogram excludes exactly
>    the same warmup cycles so all outputs stay consistent (verified: 1999
>    vs 1699 samples for warmup 0 vs 300 over 2000 loops).
>

Wouldn't it be easier and less error-prone (from the implementation
side) to simply suppress the processing of the results during the
warm-up period rather than reset everything afterwards?

> Questions I would like feedback on
> ----------------------------------
>  1. Is this worth having in cyclictest at all, or is "just run longer so
>     the transient is diluted in the sample set" considered good enough?

I think yes. Running longer "dilutes" the average value, but with RT
measurements, one is usually also interested in the maximum value over
some period, and in shorter runs, the startup spike can pollute that.

>  2. Is defaulting to 0 (opt-in, no behavior change) the right choice?

I believe opt-in is the right choice not to break existing workloads,
e.g. someone might want to deliberately measure the cold cycle.

>  3. Is "--warmup" a good name? Should it get a short option?

In RTLA, the option is spelled --warm-up. I don't think a short option
makes much sense, that should be for core settings.

>  4. For the corner case where the run ends before N cycles complete
>     (short -D, or --loops < N), the stats are never reset. I currently
>     warn in the --loops case; is that handling acceptable, or should the
>     -D case be handled too?
>

I think the warm-up should not take time from the whole duration /
cycles, but add time on top of it. For example, -D 1s --warmup 10 will
run for 11 seconds. That would resolve this issue, and it is the
behavior of RTLA as well, so it would make it consistent with that.

> Not yet addressed (would fold into a non-RFC v2 if the direction is
> agreed): factoring out the duplicated effective-cycles divisor, and a
> guard for printing when min was reset to UINT64_MAX but no post-warmup
> sample arrived.
>
> Jinnan Li (1):
>   cyclictest: add --warmup option to skip initial cycles from stats
>
>  src/cyclictest/cyclictest.8 | 22 +++++++++++++++
>  src/cyclictest/cyclictest.c | 55 +++++++++++++++++++++++++++++++++----
>  2 files changed, 72 insertions(+), 5 deletions(-)
>
> --
> 2.50.1
>
>

Tomas

