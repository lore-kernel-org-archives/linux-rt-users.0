Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CB1CAA72
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771442; cv=none; b=Q7k8pLJzTtgeJxYMJ2y94XJdSlYApnkygdjX71OWfnDLHKV6krP+opaBA8mEZhTtF7C7ML+BLledfEXFzI2avlHGUA6ogPX6FDClSbIZCFQMnspUmuizmi+5CWCqNNjDpL8EjiNL4cqI/xXXVU6OX5z6oWSY28Scvgck538PO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771442; c=relaxed/simple;
	bh=E3bDIMGDYSKxGHIGv9aPPtROswfVWsVC1C9nz/KcMcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZZMpEhdPr0FjBhvaC3i8Ce5tLgakLJUfoQMO1fPu/fi3Al4zX1xCh80BUbUpWgXuP6WIrHesmtAq1rkR09UWQ5EzljvhQXdtL05oc7CSvrduH6mw0atWl+3uo61DHWhfYQTeNtnxN4kQUXwfet/yh6uQWHkO+9h3haKUihAbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnbmzwOJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnbmzwOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736771439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqi7q3466XGx059jejHH5GdzygKkmI6P8dhA+Q79/Jo=;
	b=XnbmzwOJARzVd1LCFExeEvhK59mGeI+4bQIRPXRngjO4V6EQMyWtzKzt90mi/puieT1KV2
	BonD5l+Yb2nwzO4VdQjsnK2r/RSoQ/2JphKDT64aElR/R+ms5R6ntBOsgq+SH23dcAeDxO
	WQSx+fcX/IfR3j/AzM2GSo55zGJLtV8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-8CS60_rBN5WxaJCtQe3YMA-1; Mon, 13 Jan 2025 07:30:38 -0500
X-MC-Unique: 8CS60_rBN5WxaJCtQe3YMA-1
X-Mimecast-MFC-AGG-ID: 8CS60_rBN5WxaJCtQe3YMA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf8f016bb1so400074666b.2
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 04:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736771437; x=1737376237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqi7q3466XGx059jejHH5GdzygKkmI6P8dhA+Q79/Jo=;
        b=VNDFSYDwtxFGUVDRVDGhGZkgWY3J4KJb4T2JkJgqGhRnN+cGwRcpXG7or3PlHi9Dq3
         OL0nK6OMUwr/8fOHLMuGr2Cgfd7ZphT4otcUEnxAxbRkTgPPZm4Twn+zjcTzZMWAyoRP
         gT+Jrid8IK+Xfti4DbT2Pcl7dnMlvd8ekxqH9CdCopsXKy/vsxh4u3IZkqDJ68w4NBCO
         fcg6wOuqUNDNINTJ1xJ3OoHikEPgQxw9lW20k49qg2ICYQ3mg4dlvDMkkf0Q1mibMIrL
         oXNum8FL11fde5Fu4KHFe7S1UULQeBLLcMeMP2Mbk6pgJ/3XHzkTyM+caOCLE4JQJukF
         +n9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDhOgvaMKIUQyxYnxUIth4JjYDT62Xh1lfoNjzU5XcoUgBuEin6udW7yb6gHIBc/1YPH7jti41Kh/50uiTVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTnsM00eW7eFh1CPKtFPedhnX5Lq9gL4nHnflk00d7OHD72UQ
	EUsnLj0c0oKGHKPXibuZtMlFB2Ssqy/RHo2Q+vCvbvfnK8JCAQRziFXpHUo9URlIMlIEXNTzU+/
	VMIKMldG/gCYMH+vOs848h1eyS0VBE2IbMcTtLYIHmQM9uaQmLs+GzWdwzCH3ojYtmABXX2qCfp
	mMwtb3CY/ZLp/aqCUQRQiAEGyXpooYnnHUfK8Z42o=
X-Gm-Gg: ASbGnct8mYCzgNcDE6MXzvOYmaex+yNNfGAlGWryMQ9R7W2khF18Bcll2023McUPJBU
	6knEZzs2YS93WA+O+yfB7s5UNKK+WNXcjwZ6x7zilWL2zSpV7YpDkJT2jz0gl+dqL83+JkA==
X-Received: by 2002:a17:907:6d01:b0:aa6:730c:acf with SMTP id a640c23a62f3a-ab2ab6fd01fmr2035934666b.13.1736771437166;
        Mon, 13 Jan 2025 04:30:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWES/Ui02QcuntMbXZL7fcXer/h8RuY27cX788OY8Yg0gCEmqDiDpRQj5Zc3PaSPQM7MMb5m8tOiJ6ptOb1W0=
X-Received: by 2002:a17:907:6d01:b0:aa6:730c:acf with SMTP id
 a640c23a62f3a-ab2ab6fd01fmr2035932266b.13.1736771436823; Mon, 13 Jan 2025
 04:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113121856.225406-1-gmonaco@redhat.com>
In-Reply-To: <20250113121856.225406-1-gmonaco@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 13 Jan 2025 13:30:26 +0100
X-Gm-Features: AbW1kvZOLM2hNKNyyMlTsplwqvLRdVIBYGHOIugT9sLmqwcHuzlIERFeQIi3DX4
Message-ID: <CAP4=nvT=n8wScH1wZJzozeGQ+uh0x6riNX3+U+1NJcJGseGLgg@mail.gmail.com>
Subject: Re: [PATCH] rteval: Allow configuration from stdin
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>, 
	linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 13. 1. 2025 v 13:19 odes=C3=ADlatel Gabriele Monaco <gmonaco@redhat.com>=
 napsal:
>
> Modules can currently be set only via configuration file, if rteval is
> called from a script run on different systems, the only way to make sure
> the loaded modules are known is to provide (or generate) a configuration
> file and pass it via -f/--infile .
>
> Add the possibility to use - as input file to read the configuration via
> standard input.
>
> This allows something like:
>
>  # rteval -f - << EOF
> [measurement]
> timerlat: module
>
> [loads]
> stressng:  module
> EOF
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  rteval/rtevalConfig.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index 0c2fc6b..4c41ed7 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -238,10 +238,14 @@ class rtevalConfig:
>              # Don't try to reread this file if it's already been parsed
>              return
>
> -        self.__info(f"reading config file {cfgfile}")
>          ini =3D configparser.ConfigParser()
>          ini.optionxform =3D str
> -        ini.read(cfgfile)
> +        if cfgfile =3D=3D "-":
> +            self.__info("reading config file stdin")
> +            ini.read_file(sys.stdin)
> +        else:
> +            self.__info(f"reading config file {cfgfile}")
> +            ini.read(cfgfile)
>
>          # wipe any previously read config info
>          if not append:
>
> base-commit: 5edb31a58bea3c2433e817439e053b79221a06df
> --
> 2.47.1
>
>

Sounds useful and simple.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

