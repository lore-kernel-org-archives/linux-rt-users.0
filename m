Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489352B9A8
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127628; cv=none; b=nhbQdjWmd/SbKuS0cx+Nmx3UOcdSwEMRTjSYAT9INBZOAuYORBZHwkgAzPSokCg9Rcq6qM8cphnIMeZKTREls+pEd4Yf/Vl4vZU43lLNKGpp2Kw+n0GH/VEHkEDFbHuWDTTT1sTijOsFBuJL+Vk6KvAWi45Wr1dgct059bz+wiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127628; c=relaxed/simple;
	bh=os+h+oHT/wiLj5ZbIYfICa9keAqVNnJmxC1gJxqWL8E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FyDVu1cmCllqit2Jy+DJbf8BaPdw6jbJGr/An2ymF4/C8xJwlDHBIDaocw04zA+Cde5OEJSQdescnadaQ0lUlhrppavyB6HqitUE4iAz+fLG98wxSy+ZAX/CoUJZ+FsNR+yI9P7JnLubjVutZB0nTswDKnyJDXbXX685ARMPik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWmqTnlV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWmqTnlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753127623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwiFwn4P8x2ZB9NO2W8ZfBRMk1tYfkXXPLwfU2+F1kk=;
	b=HWmqTnlV0xKkdORW4mOAl2M4LETYxU0nzNIESO61gayEermKbJcLWWSOih/93jR5FA04Wz
	k3QmpqTxZq0S1OBsRZzm9MmJ8WYcCb8QQQbRBxhspf1mFBxpS2qJZOi4EgccUSmi0eQA3s
	95s6Na3borVfs7cTamYai/bbvglsXZY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-w4Rk-K8XPRuWbtB50t_isA-1; Mon, 21 Jul 2025 15:53:40 -0400
X-MC-Unique: w4Rk-K8XPRuWbtB50t_isA-1
X-Mimecast-MFC-AGG-ID: w4Rk-K8XPRuWbtB50t_isA_1753127620
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6face45b58dso74209676d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127620; x=1753732420;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwiFwn4P8x2ZB9NO2W8ZfBRMk1tYfkXXPLwfU2+F1kk=;
        b=obuoXUDcJoprdNWgisHyxMJv4hr+MFW4FdfU/8cZiPuPTmnQHuCULGUIZ7Kju7nAFW
         uqknrBi/sJeSJRIqt/dc3XtgRbpvy3MXnhvAZBI8lQnZlwlWXBEH9LhqZcN0/IrwTUA/
         JrTnKTDpHJMqRUEeJyg7R+m7Y7xTqUSKnYJ8VEZ7P4/NoSZGRXBVtn2kTa/srKjS2IO3
         hE0RH3Y7DBVALdmPbYa/RRB5D4C/gwqaIllHkz84dFlqKGuXT1rqgen3GYhxwyJr0SEO
         TAJxosMMI6x7VBkc2GYkI3tpgdseIpiowZ+k7D5BTw+9P6JVSV8QREYFHteVPO7PAJnU
         3dow==
X-Gm-Message-State: AOJu0YzD2BR0/uxnOyyAapFCLtSLqe0DqfcVj3OO9JNBvI732IknuJfT
	WyE2LY6TyUDCbaFC8y26WCXSEZiSmxdV7/6+iXZ7yQ/4quiGI8TIXUQK62OYDqm2mnGUhAR6Bvm
	ZQHJXMfeamy4KVJD9BkfTH/RP3+C5iThGBHL0rRgK36S0l6TlbnPk9ANSCO/B+RNYumib
X-Gm-Gg: ASbGncvlLZaX7zVmj6W1G7erHwaAdGVBOeYPrM3fwcQleP97TLnpXCl+s1zpX3aHKCR
	5alB+/JG9hc9HDPoE7S6nQuFBmKo4umgfyNKO70MXJALOiSetaMmz4WMuhb2sYnls0kDd8kFHY/
	XpsmPTW8Mnq9HXOu0Yrt/pIyHq95tefU/6pet+I0Q1vEWgxQrEzrFfzeNwsw2tf53M5MMjoz3zA
	RAj4Lki/HmOQPutg1g8mNzNTtorv28n9UzPee/dDiBNcc85QSjkYjmYDPiG+O05pYNgCAYZNtss
	RaqWNyUXbIs1u3hC7CITI6kAiE/h7A==
X-Received: by 2002:ad4:5aad:0:b0:6fb:6775:4fb8 with SMTP id 6a1803df08f44-704f6a577bdmr366252716d6.13.1753127619796;
        Mon, 21 Jul 2025 12:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfr9x9jw/OV7QQ9aBGg/q6+N/VWKsXr44NjOOWBWUcP7ZJ4McSQzx3r44p/6qVWBDyjz2sZg==
X-Received: by 2002:ad4:5aad:0:b0:6fb:6775:4fb8 with SMTP id 6a1803df08f44-704f6a577bdmr366252386d6.13.1753127619324;
        Mon, 21 Jul 2025 12:53:39 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051bab471esm42338316d6.105.2025.07.21.12.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:53:38 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:53:37 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 11/28] cyclictest.8: Synopsis: Fix parameters list
 rendering
In-Reply-To: <20250704132721.13325-12-darwi@linutronix.de>
Message-ID: <d15cc17b-c056-9a64-ef15-3a06e2b80aa3@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-12-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Follow groff_man_style(7) parameters documentation style.  Namely:
> 
> - Order cyclictest flags in the form -abcCeEgGijklNpRsStUVXzZ
> 
> - Present the flag and option names in bold to cue the user that they
>   should be input literally.
> 
> - Use the non-breaking adjustable space escape sequence "\~" to prevent
>   the line output from being broken within the option brackets.
> 
> - Use the output line continuation escape sequence "\c" to allow all
>   three font styles to be set without breakable space among them.
> 
> - End the parameters list with .YS, the "End synopsis" macro.  It
>   restores indentation, adjustment, and hyphenation to their previous
>   state.
> 
> Beside just following the standards, this makes the groff rendering of
> the cyclictest's parameter list way more legible and comprehensible.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 7f1bd39..f093677 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -7,9 +7,34 @@ cyclictest \- High resolution test program
>  .
>  .SH Synopsis
>  .SY cyclictest
> -.RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
> -[\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
> -[\-p " prio " ] [\-t " num " ] [\-D " time " ]"
> +.RB [ \-fmMnqrsMv ]
> +.RB [ \-a\~\c
> +.IR proc ]
> +.RB [ \-A\~\c
> +.IR align ]
> +.RB [ \-b\~\c
> +.IR usec ]
> +.RB [ \-c\~\c
> +.IR clock ]
> +.RB [ \-d\~\c
> +.IR dist ]
> +.RB [ \-h\~\c
> +.IR histogram ]
> +.RB [ \-i\~\c
> +.IR intv ]
> +.RB [ \-\-json\~\c
> +.IR filename ]
> +.RB [ \-l\~\c
> +.IR loop ]
> +.RB [ \-o\~\c
> +.IR red ]
> +.RB [ \-p\~\c
> +.IR prio ]
> +.RB [ \-t\~\c
> +.IR num ]
> +.RB [ \-D\~\c
> +.IR time ]
> +.YS
>  .
>  .SH Options
>  These programs follow the usual GNU command line syntax, with long
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

