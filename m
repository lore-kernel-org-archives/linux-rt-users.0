Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66544238C0A
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Nov 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203420; cv=none; b=rN/x+D1pX7CURb92N40+xr4CGdtOidHZgrmWmvyrKQjlAs/R1rpdOfwkAnCWgRaq/KD0/8yIg0az590lR6AADyhWPx3E2BR84ewvFM0g7Fhm3/gidYoviYvxp1fPeVc4RulbhkJ8WKhyMYafiqOokKg6iiUZITXif+Hni4SLHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203420; c=relaxed/simple;
	bh=aq3BSRHUbHd+clGJpATpXh0ZpkWPHkUIM1ZYbjdjVWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hO7XlCdeqtxih9nDuG3r35LYtfyzibME8nSKvHW0mVyesDTR/05UyWZ0hCovbYAuwowKuLOlArx55RkSboj5qkWcgIACd1ZzrKivOaVnPkYSXRNdrnR+PvME9RhHrtPg6uzIwY7jwsZADkhVK/oNjP84BLyz4r4E9Foaz8He2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkhGGRud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkhGGRud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762203417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OutHjXAdF06QnLp8FJEBII8pNRHZGRqCNOjaKIRsiW4=;
	b=BkhGGRud/6gYRs+AGVCz1/JGcgjCQoDUrN415Qi6M3BDPqEo/ghJCTL/xbSNThiDUzXAYZ
	VFBoMX+/yM3goPOJyoCTilHb2L6g76qWm2u3cwVEKC2r0igqX0VQR7GHgVBOrucGjv6gp4
	gVsZLVVA0zf0u3lnyMDujciL3oq0wKc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-v4KP5cpqNoGM7s_ifs-Fcg-1; Mon, 03 Nov 2025 15:56:56 -0500
X-MC-Unique: v4KP5cpqNoGM7s_ifs-Fcg-1
X-Mimecast-MFC-AGG-ID: v4KP5cpqNoGM7s_ifs-Fcg_1762203414
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-592bd7da031so2271297e87.2
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Nov 2025 12:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203414; x=1762808214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OutHjXAdF06QnLp8FJEBII8pNRHZGRqCNOjaKIRsiW4=;
        b=NOl4zZGqx5RIJVcc2iHOtBhYtf7S8M8zw4aVUPcjQlfYi+Q13JD8xjVB6j9acI7+R1
         JVc41ZLsYfgCFLCfLPx4ArgokryIu2hiIq16Y/EvQeoA81p1JSOuX0K1N09TFcbp77pM
         kp5uN0yIvi7bbTVj6/zN8W+4Wm2cdeiqz8IcDcRqLa7YfyZsN6REehdTU93hgAynTEiG
         GCeURHt9gDOqiCrRRyaa5v9TmRO6d+P++6imhyexW00bVZY3cKhhCZIS4KCEksYHRFqT
         kZmBoLAv1xpRBT78eVfetYzlZq8CO5HmNK+ijYkPHA54dQXSQ64Lw4OZED5Z8mVIzLqe
         Rsrg==
X-Forwarded-Encrypted: i=1; AJvYcCUuIWy3CwYH7f7tbWzsyvyMhJIzfmt2la7oxRQiENEGWPsYBpt6bToLZX+RRs11Oe1PPzYLjFMLUD8LjqzJYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOZxPqfDlBofDhSQ0jlk6xYxRMIdmBO9f/5v7Pcs/7XGsL3aX
	zpPxEvmbRC/eWTwwOVFyDVv6AWme8xgbsxIlVuEkUpou95vYBwL0FY4Vkgh0LZMyZv8JZewL27j
	04oS+QTsrYwwb/JRDsNfXbhYk+HZ7dQ/Fo+fCVwz3jKCijG2dCHBoUAW6zxal/xB6yqV5Fe3/Qo
	kvwbvg2ffeayr+Y6+2fpzRRrptBySFL6OYYpP34i7vac0=
X-Gm-Gg: ASbGncsNGs6WM5Yh+y9S/lG2YlfH5SM3XaOUzefbAWz5X/H6QXDJ1SN/+So/005wWHn
	+cFDJnjBD/z3CRyXykRCwK9FX5jCooGCxEVqUkpizuiExCDWt+Q4Jn6fRKeY4pyzer937Fc2BRV
	gqSOZ6ME+abHUKs4HzM5BjSlI8aJbYitipQSi7L3KXgw8KNv8dKT6cSs4HCcIc1/0sGkz93o/Pg
	KaENcN5gBLdpaj7
X-Received: by 2002:a05:6512:e8a:b0:585:1a9b:8ba2 with SMTP id 2adb3069b0e04-5941d50a45cmr4704937e87.17.1762203414384;
        Mon, 03 Nov 2025 12:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+1Od/bBcMtFAZYKAlITOUx4ZykCF0iPEKXQuhXX5K0XP26RLJFAORJ5fU67KIaif3WXDd4oWftbYZROPHoYU=
X-Received: by 2002:a05:6512:e8a:b0:585:1a9b:8ba2 with SMTP id
 2adb3069b0e04-5941d50a45cmr4704923e87.17.1762203413755; Mon, 03 Nov 2025
 12:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024172115.73224-1-wander@redhat.com> <CAP4=nvTHb566uAjuVm_gvBO3t9r0=o2MAKR7dfh6ZWRp0dvDmw@mail.gmail.com>
 <CAMLffL-16SO1oue7o8Jhb+Cz-PTauAnNtFAjE=B9V8qpS+dY+g@mail.gmail.com>
In-Reply-To: <CAMLffL-16SO1oue7o8Jhb+Cz-PTauAnNtFAjE=B9V8qpS+dY+g@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 3 Nov 2025 17:56:40 -0300
X-Gm-Features: AWmQ_bmlvepynj1JhTkvmWPukmDnqnXtCxE16myJaR0FmXhg5U0yj3Vaqr-HEFg
Message-ID: <CAAq0SUk+2uiRZN7WvYaam7tWyk4LkSCv_AQ2zLP9xdEmfzNfYQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Make BPF compilation verbose
To: Clark Williams <williams@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-rt-users@vger.kernel.org, 
	Derek Barbosa <debarbos@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Chunsheng Luo <luochunsheng@ustc.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:22=E2=80=AFAM Clark Williams <williams@redhat.co=
m> wrote:
>
> Applied.
>

I don't see it in main:
https://git.kernel.org/pub/scm/utils/stalld/stalld.git/log/?h=3Dmain

> Clark
>
>
> On Mon, Oct 27, 2025 at 7:32=E2=80=AFAM Tomas Glozar <tglozar@redhat.com>=
 wrote:
>>
>> p=C3=A1 24. 10. 2025 v 19:22 odes=C3=ADlatel Wander Lairson Costa
>> <wander@redhat.com> napsal:
>> >
>> > Remove the '@' prefix from the CLANG and LLVM_STRIP commands in the
>> > Makefile. This makes the build system print the commands to the consol=
e
>> > during the BPF compilation process. This increased verbosity is useful
>> > for debugging build issues.
>> >
>>
>> This makes sense, since the BPF program compilation can fail, in that
>> case, it is not clear where the error is coming from:
>>
>> $ make
>> ARCH=3Dx86_64
>> GCC_VER=3D15
>> IS_MINVER=3D true
>> USE_BPF=3D1
>> FCF_PROTECTION=3D-fcf-protection
>> MTUNE=3D-mtune=3Dgeneric
>> CFLAGS=3D-DVERSION=3D\"1.24.1\" -flto=3Dauto -ffat-lto-objects -fexcepti=
ons
>> -fstack-protector-strong -fasynchronous-unwind-tables
>> -fstack-clash-protection -fno
>> -omit-frame-pointer -fcf-protection -fpie -mtune=3Dgeneric -m64
>> -mno-omit-leaf-frame-pointer -Wall -Werror=3Dformat-security -DUSE_BPF=
=3D1
>> -D_FORTIFY_SOURCE=3D3
>> -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=3D0 -g -O2
>> LDFLAGS=3D-ggdb -znow -pie
>> bpftool btf dump file /sys/kernel/btf/vmlinux format c > bpf/vmlinux.h
>> <--- no command here
>> bpf/stalld.bpf.c:17:1: error: unknown type name 'c'
>>   17 | c
>>      | ^
>> bpf/stalld.bpf.c:162:37: error: use of undeclared identifier
>> 'stalld_per_cpu_data'
>>  162 |         stalld_data =3D bpf_map_lookup_elem(&stalld_per_cpu_data,=
 &key);
>>      |                                            ^
>> 2 errors generated.
>> make: *** [Makefile:157: bpf/stalld.bpf.o] Chyba 1
>>
>> Perf and RTLA use special $(QUIET_CLANG) and $(QUIET_GeNSKEL)
>> variables that print just CLANG   file.o and GENSKEL   file.bpf.h in
>> place of echoing the entire command if V=3D1 is not set; they are
>> implemented in tools/scripts/Makefile.include.
>>
>> Tomas
>>

