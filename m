Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C82D78A
	for <linux-rt-users@vger.kernel.org>; Fri, 15 Dec 2023 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQFtx+s2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702665421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpnyiFSz8mXCIvvQQQvQEKdnKMiFL64gWt5teP0LjJg=;
	b=GQFtx+s2pfLQvQaKjVoLbzzNmr5wAI+7z2td0tmU2J542Ooq5K0Oek14N5pnT0OENGwDpV
	F9gOoNPOvZqCY/2AR5NxtSAy554JXH7gOHEWXwxBiEkyL5h7IUlobl7qzflq08YdzhgLxT
	MZecqLoXOVS96qAoP/rhhBlu4UWn2Ns=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-PLxRhcvpN1W1JZuFg8wayA-1; Fri, 15 Dec 2023 13:36:59 -0500
X-MC-Unique: PLxRhcvpN1W1JZuFg8wayA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67ab20f3073so14331936d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Dec 2023 10:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702665419; x=1703270219;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpnyiFSz8mXCIvvQQQvQEKdnKMiFL64gWt5teP0LjJg=;
        b=KQJz07KsCyN1kPG2bdjWta2e5/5zlZxHcCsFPJKjNPSsRclhIBYmig/IdFUNM5fCen
         9JWMl4z7/fnEjOEv5utOC8E6VxH/rjuIz0svcwmKEsKdfA9Mh6aVMlLlxi8U/UxaVSD7
         vpLGLTgO/oQMsWQmcLEU/HfM+3cX+oFV1yNdRXZ+nXHM8Ev+LqD5n7jVeaXJzSRDjsq3
         m9DKuPwjidsOTo7JeN6RRKzxfsRsiZdGuxS7raSUIfE/+prmF5rX/hqV7V06ZvrNEHB3
         I7knsesJlQDb2N1vIC2g/6MHmYZWC6lFNmveU7hsZ/0xCLxhWcPbURXYnACAtX/bKOct
         7smg==
X-Gm-Message-State: AOJu0YxrqjqkCRELdGctApPqymYXVuI37WlV25TxiiM7zMWJbmgpQS04
	KfuyDfpcwn++kzizvpX8qIK7UfVSvBPEQ+ByZzMDafPALHWCuXEOCv/jMWNsxyDF/L+vLIjt6P5
	BJlLwaV4aBpnbQMT+d7LF2lsuuM5kFRvESCY=
X-Received: by 2002:a05:6214:19cc:b0:67f:2254:1629 with SMTP id j12-20020a05621419cc00b0067f22541629mr798086qvc.86.1702665419208;
        Fri, 15 Dec 2023 10:36:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMFGNl+4Gv6v5mw6P8EKziKTTqfyyUQVuWUn1j3uMf3mZE2K1prrW1Vsf/vcmi+K8ROpBfjw==
X-Received: by 2002:a05:6214:19cc:b0:67f:2254:1629 with SMTP id j12-20020a05621419cc00b0067f22541629mr798076qvc.86.1702665418983;
        Fri, 15 Dec 2023 10:36:58 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id l7-20020ad44bc7000000b0067f229f4248sm237762qvw.55.2023.12.15.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 10:36:58 -0800 (PST)
Date: Fri, 15 Dec 2023 13:36:49 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/4] rteval: Minor improvements to CpuList class
In-Reply-To: <CAP4=nvQ40NChnECdgLUJ7o4E_kwT3uTtfJ9kcxwEmuE_Dz5Hiw@mail.gmail.com>
Message-ID: <674c29f1-c3a8-9c2d-7c31-9cfb0961a321@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-3-tglozar@redhat.com> <28c8961f-fe4c-4ea2-7cba-55e1cde2f68e@redhat.com> <CAP4=nvQ40NChnECdgLUJ7o4E_kwT3uTtfJ9kcxwEmuE_Dz5Hiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463771134-664716873-1702665418=:61066"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463771134-664716873-1702665418=:61066
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 14 Dec 2023, Tomas Glozar wrote:

> út 12. 12. 2023 v 22:23 odesílatel John Kacur <jkacur@redhat.com> napsal:
> > Oops, your code is correct but you left in the old wrong explanation
> > you need to fix this up before I can apply this.
> >
> 
> Yeah I completely missed that!
> 
> > Are you sure you want to remove this? We have three states,
> > 1. cpu is online
> > 2. cpu is offline
> > 3. cpus is not legitimate, ie, we have 12 cpus and the code asks
> > whether cpu number 1000 is online
> > I think you're trying to write more elegant code than the original
> > implementation, but is it safer? Should we maybe check if the path
> > exists before calling sysread()?
> >
> 
> What I didn't like about the original implementation was that checking
> if a CPU is online has little to do with the CpuList object. Thus, I
> made it static and removed the CpuList argument (self). I agree that
> the proper solution is to check if the CPU exists in the system
> (instead of in the cpulist), not removing the check altogether.
> 
> Tomas
> 
> 
> 

Alright, I amended the commit message to fix it.
I might make you check for the file's existence in some later patches
but I'm applying this for now to move forward, but I'm waiting for
any changes in patches 3 and 4 from you.

    - Removed incorrect line from commit message
    Signed-off-by: John Kacur <jkacur@redhat.com>
---1463771134-664716873-1702665418=:61066--

