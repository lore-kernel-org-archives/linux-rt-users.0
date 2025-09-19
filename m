Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916614A3E
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305923; cv=none; b=WfYSEJWX00sgnJOGQMJlzuw0DtrAfjAvpeF5gR9QwA+ZY4JtBrWbT7UndWy8c767A80tYjZJ0dahBOOHJMo1a23epQH89Cp6Moc5ecoXusVKBiB2AuQ0rdihSeaZLYStpam2pz3sD9Ixp0CAt3FOyoAM06KOtu/Jx+SH8XfR0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305923; c=relaxed/simple;
	bh=3vid9Kmx1R3jhuCOg9ETBZqqQMxZb84MX9nCRvjErGg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QDlT7TcWFZFuCElYZ6WQIGldFz8nh9vRWv7rPLOYVKE1+mdbAmJ+QWemq+zmWYzYQ+QHMi0yV/Zk/9pUWkJHCq4dc708n5OoR2fIiUjOR2W9Xf2lb3yxUGPVV9aBBh5K5tdOJID09w6CNptmFXEn0h3L7z96++toI5uKS3DDJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y67E73ka; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y67E73ka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758305920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqX8juXw00RZc2BVx6HXi4OM1OMjtbV+RWK0msFXddY=;
	b=Y67E73kaLgW7XeoR+79smYtYe1nDVrLZAQvMHNsg2I+XsKLwrHkvSKLDyrbODYffTKnrLO
	slPiQj1P48S/qNYofPX/NJd/kDTzTKyh0DdnpTsBVnD87PmVQa48yMwlOBHdvgMsbI505k
	IzAX70ePH67kElxGtLqqrHZ+xaIuRFM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-_ocp_mFAMS-xeQ9ez0U8VA-1; Fri, 19 Sep 2025 14:18:39 -0400
X-MC-Unique: _ocp_mFAMS-xeQ9ez0U8VA-1
X-Mimecast-MFC-AGG-ID: _ocp_mFAMS-xeQ9ez0U8VA_1758305918
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f112dafeso57450971cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305918; x=1758910718;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqX8juXw00RZc2BVx6HXi4OM1OMjtbV+RWK0msFXddY=;
        b=ICi8ysjzsig3U0UFhWWeBL42hIdGyjdIjmtxDVbMYv6jvI1uPeHosmqaeHyGg7K6rs
         mZ1uNj+gBuKPVFb7ci0KKKoV0QaK9lP/LFta+5R/8FQ8KpRApCi7ncXid1V0hBsosryX
         XuZXT48C7rsHNRC6SDo+JFrigqqV06xUMMZTa6BBCStGINTQQubI6JBWclU+uvcj2z62
         WuJYKB3l3pYGF3CkFCYQPlgklUVCXoi78KiL2szA/LgIB/+WtbWQHSbjdmpEykOmw2PH
         HkjQEQQh1Epg3e8BADqZZzUf5z4CDIykKNPSoJU8mJO0FHwjy3l/+tINX35ViAm3m/7I
         x1kA==
X-Gm-Message-State: AOJu0YzuCCXpunJ/HkkEgeUKa2vJUfO0wS83RwYalR4u4Vg4VE9N9v51
	6ChXNRHEpJsJi2aigombhCWvYty6YmqAMxgc5xpHX5WsuZtGirKIwR9LvpI4A25gty5I/Hz+4I/
	XRsw9aDq/DILfnL5jvjQvno64n7rRJ2WpAD90rn0kyiXObuo5ZTAGYIzhblKIZERRBJNn
X-Gm-Gg: ASbGncsBc2/JcNohIstAGLEbli9FaAUcav8f5nJvvlzsKtNYzwyKxAwlq1ilnkCuD1j
	bAoCW/NQqTBeF45afpIwM4MJ5QPIPGdX3gpG9qt1UX3enuI8IDuBqr1hAGDI8pKjBWP+1Wj6E+/
	21Gk8LY1NwPFKvpGT31rGS18YHlwf+v5RS/0W+oapBO8YiwU5WjMVGIy5+0R6bpoiECVE/m8BIv
	u21oJqBXbimySyXjrolatL8ZSxotzA1XB6ASmJl0mME63sfwBBJN/P6lDxZpo/QUXA7YLT9myOf
	kOkTNKwY53zyHVq9Q0upQqZYWA==
X-Received: by 2002:ac8:5d4e:0:b0:4b2:edae:9df2 with SMTP id d75a77b69052e-4c06cdd7df0mr44458471cf.5.1758305918238;
        Fri, 19 Sep 2025 11:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA2fZXLLjF5mwiT6RyBRlLgNrcSZGtxwIZuRW4m9I5MJpTdlYxLf2r6IVu/FZCwJmxYZTh+A==
X-Received: by 2002:ac8:5d4e:0:b0:4b2:edae:9df2 with SMTP id d75a77b69052e-4c06cdd7df0mr44458161cf.5.1758305917718;
        Fri, 19 Sep 2025 11:18:37 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda1220e29sm33199341cf.9.2025.09.19.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:18:37 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:18:26 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/10] README: Drop "debug" from the tracing path
In-Reply-To: <20250903111717.1391196-2-bigeasy@linutronix.de>
Message-ID: <4a599a1f-51f6-da15-0cfb-02b22a526cb5@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> The tracing interface moved away from debug/ configfs. It moved one
> level up and the debug sub folder has a compatibility mount which will be
> removed.
> While at it I noticed that the -f option is long gone. Take the
> opportunity to update this, too.
> 
> Update the docs accordingly.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  README.markdown | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/README.markdown b/README.markdown
> index 3ab6ddf53c7ed..617b57e88614f 100644
> --- a/README.markdown
> +++ b/README.markdown
> @@ -57,15 +57,16 @@ then probably be regarded as real-time capable.
>  
>  What, however, if the latency is higher than acceptable? Then, the famous
>  "*latency fighting*" begins. For this purpose, the cyclictest tool provides the
> -`-b` option that causes a function tracing to be written to
> -`/sys/kernel/debug/tracing/trace`, if a specified latency threshold was
> -exceeded, for example:
> +`--breaktrace` option to halt tracing if the specified latency was exceeded. A
> +tracer must be configured upfront. The resulting trace can be invastigated in
> +`/sys/kernel/tracing/trace`, for example:
>  
> -    ./cyclictest -a -t -n -p99 -f -b100
> +    echo function > /sys/kernel/tracing/current_tracer
> +    cyclictest -a -t -n -p99 --tracemark --breaktrace 100
>  
>  This causes the program to abort execution, if the latency value exceeds 100
>  microseconds; the culprit can then be found in the trace output at
> -`/sys/kernel/debug/tracing/trace`.
> +`/sys/kernel/tracing/trace`.
>  The kernel function that was executed just before a latency of more than 100
>  microseconds was detected is marked with an exclamation mark such as
>  
> @@ -80,7 +81,7 @@ latency.
>  If the trace output is not obvious, it can be submitted to the OSADL Latency
>  Fight Support Service at
>  [latency-fighters@osadl.org](mailto:latency-fighters@osadl.org).
> -In addition to the output of `cat /sys/kernel/debug/tracing/trace`, the output
> +In addition to the output of `cat /sys/kernel/tracing/trace`, the output
>  of `lspci` and the `.config` file that was used to build the kernel in question
>  must be submitted. We are sure you understand that OSADL members will be served
>  first, but we promise to do our best to help everybody to successfully fight
> -- 
> 2.51.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

