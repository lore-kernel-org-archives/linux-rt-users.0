Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0B1F0E3E
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Oct 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550362; cv=none; b=k83JjpmEk+2V1xmD/zhfqpELm1mR0y6OnLuFHrBSjeGUeUeZqbRHbthqcEjcx1xNmDjD4jBq6ZoE3vbOgIj+FNsTu1WB8OtHxHhINRIij8L2Z8QocF5EzT7yHKPLUcjK17oz28b/0U/oZqF8wpZ48u3sIOfyElPreT5K1GrPA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550362; c=relaxed/simple;
	bh=I53scYr54QhSuyHzXsYpOJrelIb1NeEmtOdlqjq4Lb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbdDrFIYFCoO9ryURh58dEOh/jMjqrYF6JSLgiiiXJZ2w/LZQSzY8pKn6cWFk8XxdLaspJw1wTtQ0N8FhNy65X78bvgsgb0O5ujUDBxzQNIBuO8o4TMq1bBaOEtQasm3aO/Wr/uCfch9Hqn9LBr6IFCUDs9o0jec3mEu03vIVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6lCYNtY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6lCYNtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761550359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqI51aksTPrt6gygluAmQiB6rLpaprfFwbV1NKmqGlE=;
	b=F6lCYNtYaTH6qCd1mv2f1bL34iNQ542/mqhlyoIE7p0OhsNR+9SkEXJKQTLOgmLBw6IHm1
	/vCr8npokfpQKHIOq6SyPAkr/mgY+2YoVTiJ+ROP0mSgzZWiRCks6zGExJ4R8cOM7lF2ZW
	ZHAcjwlm5q8kJHoimY4PFvyW8XEDunk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-DaH5P0iVOtygMAdqw8ImSQ-1; Mon, 27 Oct 2025 03:32:37 -0400
X-MC-Unique: DaH5P0iVOtygMAdqw8ImSQ-1
X-Mimecast-MFC-AGG-ID: DaH5P0iVOtygMAdqw8ImSQ_1761550357
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d77165ce3so185783666b.0
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Oct 2025 00:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550357; x=1762155157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqI51aksTPrt6gygluAmQiB6rLpaprfFwbV1NKmqGlE=;
        b=oGQtsYBQ77cF3MJtEAd/msv4juKCCvkRpQz4luXqfl4N/PDJCxPhsnS/wCyuUXCT+K
         Lgouxh/YHmSAiyaLAKDljrZ0NMy87omf43o62QSVZE12zsF0Bm6dNhob2uLfwB50x6Zy
         SlwcW3ItPkK70UjGCN2tJDgKRCtuGRwUn/BRZqAiPmfukMp6AgS0UWArb1hF+PHtK2N2
         Fo/8ZzcCW7gJ8tkwlmUAyBW0pVpX/HNhs+UYMOy4odWaaPg6kCOqM7Yu8cnm7mvNQcXp
         lBQVG+AhOvjBGdyf1gSHTjg8OaRORFNrHXPNn8p3wZy+vkVLswTg588brf2fCxMO36Sd
         jmPA==
X-Forwarded-Encrypted: i=1; AJvYcCXqBUIDYKBd3Epm9adAVkO6e21h9Lwx0Y4CdoKMDRNQ29u8TAKdzp+mVmEkxO5xkHipy5Iv8cmLwssbEG+65g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdj+aCm4+xf++Zt5sp9IAtmrYOx0LzuofHdasc+2fliuUNyyz
	amkjkEVWQ7r3Je/VhvDtDyJ5m9s1mD7uiX++X+ecPy9K17+f0IwRLWaVVED4CFtjWLaratAPuIc
	922kAGoZPfP0oQhHWmrs8y4BiA+NymDPpY2SiE3efzDFcfl8hx2Q3Tqx2mrWqG/dC0kSUGo/Xfv
	IXiQmfb2HiUQqyotBzIGgZs8Wloi0IoX+TAdk7tqhOBL0=
X-Gm-Gg: ASbGncthwl6N2MqrKjffkB+d3z53p+V3vSAEbUJsaTamrG1y3gxMEIAJNt2fkspypUH
	AR1PN3fJejksm24Al0EcusE7bdVLPFtoPQ2Qhs2c5D8t8YjN1Ziu1hW/tHR1gptgx+BNWT25igv
	1hl06Qu9y/lUmhEAY7hHuKpDWeiSKhRcpQwA88qn4WHO4AHUJmtx1KBAlDZV9mQaAmFKm60/hRk
	IjufURI4bG6CQ==
X-Received: by 2002:a17:906:c156:b0:b6d:6d5a:58f2 with SMTP id a640c23a62f3a-b6d6ffab0b2mr1109249466b.32.1761550356638;
        Mon, 27 Oct 2025 00:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOA8qHP7VSxMFX6cqNS3bgvxdJiFSusTIaVvwKLR8t6k2jL8oUE4BVUVL0oarLPu/3sScznb8edYDlVK12GLk=
X-Received: by 2002:a17:906:c156:b0:b6d:6d5a:58f2 with SMTP id
 a640c23a62f3a-b6d6ffab0b2mr1109247266b.32.1761550356170; Mon, 27 Oct 2025
 00:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024172115.73224-1-wander@redhat.com>
In-Reply-To: <20251024172115.73224-1-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 27 Oct 2025 08:32:25 +0100
X-Gm-Features: AWmQ_blUVVyizt7umyQgO4o1yai9vnAzpYnSPKoqDyPLxQZZ8TosNSKkg22QcLY
Message-ID: <CAP4=nvTHb566uAjuVm_gvBO3t9r0=o2MAKR7dfh6ZWRp0dvDmw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Make BPF compilation verbose
To: Wander Lairson Costa <wander@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
	Derek Barbosa <debarbos@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Chunsheng Luo <luochunsheng@ustc.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 24. 10. 2025 v 19:22 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> Remove the '@' prefix from the CLANG and LLVM_STRIP commands in the
> Makefile. This makes the build system print the commands to the console
> during the BPF compilation process. This increased verbosity is useful
> for debugging build issues.
>

This makes sense, since the BPF program compilation can fail, in that
case, it is not clear where the error is coming from:

$ make
ARCH=3Dx86_64
GCC_VER=3D15
IS_MINVER=3D true
USE_BPF=3D1
FCF_PROTECTION=3D-fcf-protection
MTUNE=3D-mtune=3Dgeneric
CFLAGS=3D-DVERSION=3D\"1.24.1\" -flto=3Dauto -ffat-lto-objects -fexceptions
-fstack-protector-strong -fasynchronous-unwind-tables
-fstack-clash-protection -fno
-omit-frame-pointer -fcf-protection -fpie -mtune=3Dgeneric -m64
-mno-omit-leaf-frame-pointer -Wall -Werror=3Dformat-security -DUSE_BPF=3D1
-D_FORTIFY_SOURCE=3D3
-D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=3D0 -g -O2
LDFLAGS=3D-ggdb -znow -pie
bpftool btf dump file /sys/kernel/btf/vmlinux format c > bpf/vmlinux.h
<--- no command here
bpf/stalld.bpf.c:17:1: error: unknown type name 'c'
  17 | c
     | ^
bpf/stalld.bpf.c:162:37: error: use of undeclared identifier
'stalld_per_cpu_data'
 162 |         stalld_data =3D bpf_map_lookup_elem(&stalld_per_cpu_data, &k=
ey);
     |                                            ^
2 errors generated.
make: *** [Makefile:157: bpf/stalld.bpf.o] Chyba 1

Perf and RTLA use special $(QUIET_CLANG) and $(QUIET_GeNSKEL)
variables that print just CLANG   file.o and GENSKEL   file.bpf.h in
place of echoing the entire command if V=3D1 is not set; they are
implemented in tools/scripts/Makefile.include.

Tomas

