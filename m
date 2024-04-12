Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79884596F
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962975; cv=none; b=K/lTs7T8ZCzL40gk8Yt24N2btXoS6/cVeoUfmJwzuld7Y4PplldQVlyzjVhzr9yYkaJnzWui2y6JIYrWchBm/vQ8AaxaRMCx2Imt8mrDkG1KNmisIm619FITgPRudW0sJgppcv+JmRjeUzXGl8Pj45U7xjK7zv1va6yPceYPrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962975; c=relaxed/simple;
	bh=zIlQaHbXRW2y9zzL7YE4NlkUsuQvAJTVjuWcmdiD6Ac=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ULyJwQPuvguOqjkuolO3pfFX3OdWlvK4vQAj63ApdpFUlON1LVj6trJcNA/ZTGKVulRDkjde/JofbkLJkxzboHJOuL1KaboFDkTQzveSKJ5Lv+Xc47scy8S1G7UGaIfh0XwgKC7KzPh1roCv6PSXzR/PFt+RbQlEX4EMots3hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2fvAju5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2fvAju5"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea22016864so852983a34.3
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712962973; x=1713567773; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4632qNzEKYNnUp/oCDdomXlBDoSenCcjxL1PENNrcw=;
        b=k2fvAju5IuWgVVIXK4cHJX0DKcB9lHDmdOALTP5lYJJYvkhH0lWSBZIG3cA2ucTY1p
         UbvRL58frj730Lj3ZhfUECqJdkPTDgYiqM5UQBuUUU3UvAZPHce7tH2f/+P4QuJU2Yvd
         f7/jG5t6wphinsHiz0YcYwA5EbfbSrL5gJdRiT5wNhEzNGVEqTgQFNcCurt0NyReEKT4
         YibKGas+v9vG4FeEhSt/wGOAnaFjDYdQ7oXdzeYYXC6aqwwpBLMP/O8c9cSrVTaZQ6TC
         Ys6ILz+RRfl1JjLeogBLHLmS2N+8tERlnJpfts4nwoadoq9N6VxvINAB8N58YXz1IOff
         ZgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712962973; x=1713567773;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4632qNzEKYNnUp/oCDdomXlBDoSenCcjxL1PENNrcw=;
        b=bz+5SJbYsxcuXZfUNHS7cJ/AZ7Bq2P1M5MZ3BONQjhXI4gpw+PSjIfGIElc0KwfJEP
         lfFjQoA4fihYitdbKo6FUa/QqayA6fWMdZewFuSfTv2r23oHgzdXwVw+GBoIXcaKiAI3
         RB867ei9j5aWiNikqqxrwNBVdzH37bRkBomSvcJsS9aCYTR9dCbW/D7SvnoqFsHVewUp
         We+rePR6+X2uFDwjCx+jUH4IQCLBNrOgWdN6xs9lcuH4qfElBpJVgY8g+t1Keue9l2SR
         xHsl4QNgktwhfofq3Pu07KholIiB0iGSGOKE8vCHAHdBbOv3GPAYQEtXX+NuPUfxC7qN
         HhOw==
X-Gm-Message-State: AOJu0YxTK0gZDA0+tBKXaWyD2wWP3wtAJcwVkHVgi0aHOPG3ciWC9mX+
	A5MX3K6pIlqhtS3YCoUDJhiyfJarKtgsea11rFgaOtaKXsCU9y4NwAicuQ==
X-Google-Smtp-Source: AGHT+IElIPmQ9lPZbCOgChvAjky6il9QMtYmUCfIafiMJgsiH4GMQDmHA2fJnzOubevMJqY033THJw==
X-Received: by 2002:a05:6830:1613:b0:6ea:1ed8:573f with SMTP id g19-20020a056830161300b006ea1ed8573fmr4544113otr.1.1712962973579;
        Fri, 12 Apr 2024 16:02:53 -0700 (PDT)
Received: from [192.168.1.88] ([189.141.16.57])
        by smtp.gmail.com with ESMTPSA id i24-20020a056830011800b006ea349e8a22sm861437otp.6.2024.04.12.16.02.53
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 16:02:53 -0700 (PDT)
Message-ID: <27cfdcdc-f0d0-42ae-9b53-937828a4fd7d@gmail.com>
Date: Fri, 12 Apr 2024 17:00:39 -0600
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: RT <linux-rt-users@vger.kernel.org>
From: Miguel Miranda <mmikernel@gmail.com>
Subject: Seeking input on beginner-level bugs related to preempt_RT
Autocrypt: addr=mmikernel@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I am currently looking for beginner-level bugs related to preempt_RT for 
the Linux kernel Bug Fixing Spring Unpaid 2024. Although I am not an 
expert in RT, I have been trying to identify some bugs and our mentors 
have suggested using ring testers such as syzkaller and test frameworks 
like kernelselftests to find and reproduce these bugs on our own.

I have a few questions and would appreciate any input you may have. 
Firstly, is there a specific CI ring or channel that lists KTODOs, or a 
preferred platform where bugs related to PREEMPT_RT are reported? 
Secondly, I have been following the LKML and have seen some 
console_blast.sh results, but I am not sure where to find this 
console_blast. Lastly, I have come across some recent discussions about 
printk() related work, but I'm unsure if there is a list to avoid rework.

Thank you for your time.

