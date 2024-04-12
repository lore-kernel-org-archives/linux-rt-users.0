Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004E56B73
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924421; cv=none; b=R7RPL7oq7HyS4y915+7j75RKl98SVJTzXWCap2VqzYCZ9GWeT/myQP7J9Jxc9iBT8plEhgExfWgY1QOcwAG/8BG1jw0/kGE9WkAQrRdE7ng3Ch1/A35igdRuTqK+LFPSo6JTXTxReihg+GkxxgdGv/QNSCBVI29+QwRll8GKJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924421; c=relaxed/simple;
	bh=WFmjjSrbeFjEmhLlBiWpRUSOMUY8KYm186SmcYNgeYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKBuZucUCrNFS6UabsP4BB0RuwvFQzid+4eQp/El6R0HsXxNeMWiMVSwerh8cKjUMkhUF03uQNMsQfVlfWUkOpWEKciO8sbbTFF1fb+2V7PnNQ6Q9dOFq9omJcjfHU4jQWZJD5Xeprh/3y75Lv2OBtR+k9Oq5OhPpXvNoenM5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnwvDbSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnwvDbSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712924419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFmjjSrbeFjEmhLlBiWpRUSOMUY8KYm186SmcYNgeYs=;
	b=KnwvDbSyCCN6150R11tW8lCAVfxfezflU7itrHTMDV5xWelNbu8HMC3S46Ghml7Gv8MufI
	4BZRa7PHAwLWDl/4hYO/KMrxB4ShUbO4u46y50Ein/DhWyW0i+jCYrBGYJ+cSLBoPtahdM
	S/t345Gp+H3+KbL+qXqvZqm1O/dCyh8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-9dudrlbaNHCHdDeE7mzl0A-1; Fri, 12 Apr 2024 08:20:18 -0400
X-MC-Unique: 9dudrlbaNHCHdDeE7mzl0A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d678a5a1aso79780685a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 05:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712924418; x=1713529218;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFmjjSrbeFjEmhLlBiWpRUSOMUY8KYm186SmcYNgeYs=;
        b=fc2AjLl0oatNLX1BDvn6RfqAhWsZEcjnVpJ8A3rdbT5QA0ew2ZIZJJw0/MNx+yia4j
         yR+Gx5N6mK325Yivj6OMDL2xjDgCH2DN4WizFPJnDB/zBV32SvThPTRUVqJgx4lbNT4k
         uy3cKz1ipEslItnxHEtQ2QEHqFff/Li8GPb6+LHCdkSLUvmyOaB5KZGwggd56eHsgWOt
         ObhQfrXT06OcMOPxMONaOqn96gUwMCKmqza5eh7XPdlQIuAP4wAptsESXm4jFmi+9BBd
         uvwRe9TQ/smRoqx5rdIqPbWfalEAB5MwNyeiF9uhPoe9cgVXXIHZ66QI4hxWgfrOm/QO
         gGXg==
X-Forwarded-Encrypted: i=1; AJvYcCXyFmDzBTniY2DzvUe4ByHVn9gvOX8Hhwp6tB4gxwfH84BpKt5g2a2Gy4W3WBy5VhUkpM2KjG1/UQiLxFsHz46+UUBMiUpKnaaSE+kR4lo=
X-Gm-Message-State: AOJu0Yx2PFvzw5Jyu8Q3XRYMc5OQ5+2Q+D8ulGlWaepej+fy2Q1PFL4R
	/zeN8O2zWG4yt5/An0UnU8cyhqIwA9hMyiys0IOXkOvP3+er/39NJRze0LucNJhRkYLSp9ru9YJ
	GilyetMCBOul1a+SF1y+btqlUT+n0zY9OXqb04qefXi+iFfRfki7OP/1O/QgccPJ+
X-Received: by 2002:a05:620a:394d:b0:78e:cc24:f3fe with SMTP id qs13-20020a05620a394d00b0078ecc24f3femr1810324qkn.2.1712924418005;
        Fri, 12 Apr 2024 05:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl1RGrNpjG++v4K183eeVV70SCzpHYcpeio2nSYQsNbwwZxjYJTxzbIAebB5VpqAVwSeJLGQ==
X-Received: by 2002:a05:620a:394d:b0:78e:cc24:f3fe with SMTP id qs13-20020a05620a394d00b0078ecc24f3femr1810306qkn.2.1712924417731;
        Fri, 12 Apr 2024 05:20:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id m29-20020a05620a215d00b0078d65a42db6sm2319340qkm.95.2024.04.12.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:20:16 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <20240411100536.224fa1e7@kernel.org>
References: <20240411120535.2494067-1-vschneid@redhat.com>
 <20240411120535.2494067-2-vschneid@redhat.com>
 <20240411100536.224fa1e7@kernel.org>
Date: Fri, 12 Apr 2024 14:20:12 +0200
Message-ID: <xhsmhy19i93ib.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/04/24 10:05, Jakub Kicinski wrote:
>
> Some new crashes started appearing this morning on our testing branch,
> quick look at the splats makes me suspect this change:
>

Thanks for the testing! Seems like my own testing wasn't thorough enough,
let me have a look at this...

