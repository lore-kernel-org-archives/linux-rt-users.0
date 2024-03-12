Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F35F18
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240368; cv=none; b=k46SEP0S0zpdQ6Z2B9eNvPcY9NvFA908IXYLgTg3rkkVmnmtdPGsWtdvaJbgfYMv7vc4ixTbkIA83eofGaLsS6e4HAk44sLnqM83d7AUCCD54EdJph1CeWhq4h45/apnDZYu6ccpAHCPCe83/LiFxebDC79U5tuMFk49CiLQLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240368; c=relaxed/simple;
	bh=FUv0c1f4AqIptRlTjGNA80NCZIpci4pATRR+/CUV5ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P72FDnp6tZvz3+KTIOCFibqofLc2sV9knMuu3CHjH7nctqn+ukVwJ5J37CXnzk7YL+TZRvt7T6oPHrOS0axoqUyBhwgcfiXDihTU5SOLsboroD7MWZJIALus+wKMhISNRIN0ywArQ1RXFRXBE6THhvILMz8EfTCAOx0U7qZq33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmOR20jk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmOR20jk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710240364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUv0c1f4AqIptRlTjGNA80NCZIpci4pATRR+/CUV5ls=;
	b=NmOR20jkT4xeFUKrGhVR3QXpG2I5naySPgL37yA7h9/SBxoG2jhdWjNLxx36KXCoEjH5s2
	boV0PNVwP9FBZCUJRTjheiVgYswKzcEah0opVWo3nQxH6BTBPiuTWmqjlqI4J/TWg3q0S9
	S0dOYujO6rkTeDrlmMcc1N55lMWEgxs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-jaf4Jw89MAiSnE_CXSK5kA-1; Tue, 12 Mar 2024 06:46:03 -0400
X-MC-Unique: jaf4Jw89MAiSnE_CXSK5kA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a464789439bso25353266b.0
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 03:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240362; x=1710845162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUv0c1f4AqIptRlTjGNA80NCZIpci4pATRR+/CUV5ls=;
        b=PPfflSSzh+7Vf6kp7TVDEg2Ae7h+PPbvshxUibce7YEotbYHKJ/Cu5K6VRgkuDtEO1
         ZhB6a96Flpwa0KVWZG5IuQc4bnB8N7ZUuOIVyL6n9eq1oEuOUp0xGjLgOURrHzNpK7ui
         9nsFkjzR7djmRpWGSPP790l20MGtcLpzHFcQc7vN7YeChsUKosdydLTwf/KHmGQjTeYY
         xKMo0+krS3NaGPOG8dlE6M0F+Q2b2PzWUGLKTLdBmdgpjSTmX9b8WGNYfEr+zJcWK6Ij
         toBfQG6SI7Pf3mrdcoafbLZWJSJzO3Ev5qY6s3Sq5Of6wMi0CCUrtJSnLHLafeN1nxYA
         rSWA==
X-Gm-Message-State: AOJu0YyuLzsxUSO9JWZSAY20/4I6cvwYvEkftnO8uH65eWxooEMUvwqJ
	pc7PCrRU6ai7peaZhPCnwuZIC1zPOrOHa0fyqQNWjv6mJ3OFTDW8fTDDtkeKVt64AU7N48rFrmC
	Mh1ZMuzI3TGWoa/nMmYoYP5fvaxAzceEsV9lHEblxrWJxAxNZpEV0nGUW7uBZ6iW5
X-Received: by 2002:a17:906:bc98:b0:a3f:2f67:4847 with SMTP id lv24-20020a170906bc9800b00a3f2f674847mr5317096ejb.19.1710240362647;
        Tue, 12 Mar 2024 03:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENzjsTPjxVeLw246lXWNH6tcBFVa8V5SvQLBsykepwJzJlj3s/kN9p5jF7ihLC18MTVLDB9w==
X-Received: by 2002:a17:906:bc98:b0:a3f:2f67:4847 with SMTP id lv24-20020a170906bc9800b00a3f2f674847mr5317086ejb.19.1710240362123;
        Tue, 12 Mar 2024 03:46:02 -0700 (PDT)
Received: from [192.168.0.182] (host-95-247-0-105.retail.telecomitalia.it. [95.247.0.105])
        by smtp.gmail.com with ESMTPSA id ws7-20020a170907704700b00a42f6d17123sm3667191ejb.46.2024.03.12.03.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 03:46:01 -0700 (PDT)
Message-ID: <7c7eac77-4964-4e4f-a194-4c56e35f58f1@redhat.com>
Date: Tue, 12 Mar 2024 11:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Alternative to updating has_smi_counter?
Content-Language: en-US, pt-BR, it-IT
To: Rodrigo Queiro <rodrigoq@google.com>
Cc: linux-rt-users@vger.kernel.org
References: <CAMnS4ZDigjkexNdJT3ZhLcmAMeodTKsPi+b91sSjE5sky7ZfqQ@mail.gmail.com>
 <7f10669d-fffa-40f1-86e2-db3033957b19@redhat.com>
 <CAMnS4ZALUHVuH7YAGNA1+A8n7Tc+pLpso0Ywr4Z39UcC4g6e5w@mail.gmail.com>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <CAMnS4ZALUHVuH7YAGNA1+A8n7Tc+pLpso0Ywr4Z39UcC4g6e5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 11:43, Rodrigo Queiro wrote:
> Thanks! Are you aware of a complete beginners guide on how to send
> changes for review? I'm afraid I've only used the GitHub or
> company-internal workflows, so I'm not sure how to submit the attached
> change.

I'd say that the same workflow for kernel works. like:

git format-patch -n<NR of patches>
git send-email --to=<maintainers> --cc=<otherpeople> --cc=<list> <patches>

should work

-- Daniel

