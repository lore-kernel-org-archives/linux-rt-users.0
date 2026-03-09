Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C1217659
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Mar 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096854; cv=none; b=SAxokznMma0PKoBHWUT72aj5mvw9yzhQxdy2kMGmjYzNiSgIhIBdYi9R2Hwlmkmb+uDyjbExEww1JVxsODYcTIK4h6HJ28S07DUdyV+1aeXM0irIjcxXrXpCicYfcEMFAPaa4T9Z+DlJ3TLiMoZLqvl6nU11Gcf94CaSpA/qXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096854; c=relaxed/simple;
	bh=hXXNERDFg0nvT0ekNEuMpDDEUYibgJYSFmcPvKj/nNA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HkW8pkW33FE0T7qSiFzV6cmOrx5EUfEx+NFt0reAEepFui3xl/gF2FDB1FI/HujyJxta/h68OfoPhqUFwV5beC4K8gx/+d2+bvVcu+cDSwG0iIhC1NC5sd9AdhRnJ249jQD9ypT6MmagPwSYjMXpW3J1T6ied3hg+dSj7oScz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoaJzmiy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoaJzmiy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899fb030812so123503006d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Mar 2026 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773096853; x=1773701653; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKX6xu6AzOmH1xG1jEMxVknHhdETs0/aXjbtJJRHXTE=;
        b=CoaJzmiyOn/xDgragW5H2PruBJ9dDk9lZ30Z4a3b0TF2ozIQsknWQmv2FOGIpkFPin
         wBNCT6Xbbv4Q56PiKcvDLdWjBu1VR3AMZ7noJlYhw2xDkY5nXtbHKdNLrvy8cCTUQ+PP
         2cbH7g7gUCDT+cuT1eGdNtEPPCki9UrknLx3a2oXvOLJbU2Q/niZrARP8hwHDBGDYevF
         RC6N5vadxXaFc2IFz3jMQ90EIUpzWzuvl/kbdgNT0Z5Uc+YyL8czoetqUxfDS2S8PZRB
         l1MHSjDAAdQsG2x7Ny1qAZJzag32xCDE+gYK1u98p7WxomeuLPkd021RNQua+2vGMGug
         XHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096853; x=1773701653;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKX6xu6AzOmH1xG1jEMxVknHhdETs0/aXjbtJJRHXTE=;
        b=enPAcW7kbuHF1jVY6zd+rXKyHVjQs3KBG1ZNXmgmLFFLGR+wGBNEetc4OkEpFfKBfK
         mjjZCCIak3g5FqIO+N+sdIKXpSgblEsqTy0VuMr3cfGKGqdKyOu6AU2GjMXkyyQCSgDn
         k59WCCgvmpDcQ/JU0yqiFfHg4OTpTu8lkHvfLsgZfq5N1y7eOTj6zN6uZs6igtWKf73X
         DS2k6gzeoyUSVHdXxXGXgqS+P5v7m7YdjupCI6Rd6h5t6wHQcvcHX/Ne1YOzzFP2jasK
         xbXCbKsoOpg+PIz7dWgS3J5lbRqZx7rtsILjTSWN9r9eIG8Av1BT4WUVXGVwGSSqBu+S
         101Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtFwg884cyT826u3e6+ApUJbNhRBjy2Oio8D3kn9MpGDaZ6m4tbhbuZvwIJZ11x6oIttbns1LHFA3N4QkX+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK33AR08G9tlNip/blCWhMKS8TDE30jZbSPrkWp8BZ2PwbvQAJ
	FcpzbW9G6AwOJWUqBebyKxj1sYOhwVhyWvQPOV6rF9ZYYxbwC5kc7B0wZgL3uA==
X-Gm-Gg: ATEYQzzeu9wCDnt8yEUYTxtrp9KPBcoAgUpQ5D/0DxszF11VO6Es+hxTx/tXtVkbD2Y
	pChDYlVYjVkaP/xxBUiKVttnyiAnYxVR+1aICYboxWW+LypyXl1y4kgAHlaf8mkpx/VVpS7ayaM
	gN4MvGQlWMh3hwj7E53z6DYroyhnEjLD8BWCloaR5kZknHw0psfZSC2l3pTFy4WvWQFmLH8Rahp
	tg67JraxurHXhtfRRvBZrXMV7MbEFCxlugEElhqM7oWcarllIDh+Unsv2NnoKLQR+EWpJ0FiwgP
	aMB/4vnNd0QPEIrE15yAJOYMNY62edqjB1wFH1DQgYPNk1HkOJotDj56v213f2pZQ8l4bejYffD
	2WL7Ly0YtQvVe6eFvJ5UnXiBkcN4mxwKG69/PBW3r6VHUKrKYfcacL42NQFrVI+vqIaepDkNUo6
	StivBIQFdaPZHa75gKU08RHXek5xqoz20ZC1sE3gvMSI+/kqvAS/5jXfr8Y1XLNUtVD2ctXzbZ8
	g==
X-Received: by 2002:a05:6214:cac:b0:899:e9bf:3744 with SMTP id 6a1803df08f44-89a30b1505dmr181396426d6.63.1773096852514;
        Mon, 09 Mar 2026 15:54:12 -0700 (PDT)
Received: from Cumhall ([70.50.116.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a1aec5sm7338846d6.8.2026.03.09.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:54:12 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:54:01 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Lukas Beckmann <lbckmnn@mailbox.org>
cc: John Kacur <jkacur@redhat.com>, rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] cyclictest: fix growing shm stat file
In-Reply-To: <20260301212407.3146506-2-lbckmnn@mailbox.org>
Message-ID: <5356ca11-53fd-656b-d934-cf91dfb44e39@gmail.com>
References: <20260301212407.3146506-1-lbckmnn@mailbox.org> <20260301212407.3146506-2-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 1 Mar 2026, Lukas Beckmann wrote:

> On a received USR2 signal, the current statistics are written to a file
> in shared memory. Before that happens, it is truncated to zero to clear
> it.
> 
> However, currently the shm file keeps growing with each received signal
> because the seek pointer is not updated by ftruncate.
> 
> This is fixed by calling fseek after truncating.
> 
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
>  src/cyclictest/cyclictest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 191945e..960c905 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1472,6 +1472,7 @@ static void sighand(int sig)
>  			return;
>  		}
>  		rstat_ftruncate(rstat_fd, 0);
> +		lseek(rstat_fd, 0, SEEK_SET);
>  		quiet = 0;
>  		dprintf(rstat_fd, "#---------------------------\n");
>  		dprintf(rstat_fd, "# cyclictest current status:\n");
> -- 
> 2.53.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
