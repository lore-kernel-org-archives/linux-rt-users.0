Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AED3588A
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Nov 2023 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz2ee/MC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992A93
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Nov 2023 13:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699650256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pK2WeJE/P4eNb2lOm/+iFiXlEP9adU28JudIZ4Mq3A=;
	b=dz2ee/MCQCiaHb4dofIaOZSrdSeiv9yjIYV0zabnclaU1bak7e2s28op3SagM7M+GrEA2C
	IUWCUWM+a3KRyaNC1hQu1HORSvj+vkwr6oDxb+Nhkza3chV5o8U7rV+ADIu+ofh9YAJQMg
	ssNfLjsXxe+dV1KR2kDIka86QIkIJUo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-ZjJbwCkiMEeUXCh-eXYE2w-1; Fri, 10 Nov 2023 16:04:14 -0500
X-MC-Unique: ZjJbwCkiMEeUXCh-eXYE2w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77892f2ee51so252309985a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Nov 2023 13:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699650254; x=1700255054;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pK2WeJE/P4eNb2lOm/+iFiXlEP9adU28JudIZ4Mq3A=;
        b=XXHF3N8PC5hzzWq1ZtZ8b32DRC4VpzGAqrsrUKf7yZsLM96XEhwgdDEKYH299zgggy
         VqBcG1SqM0FLPWadkXCsIgE5DDtwh3+PEqVIILOwrruS8ik0D57Dd2oezsEifPN06zVt
         ConZd8Ypgd1Uhc1QyaAbqCSWS7rX0q1rD+FmeFjWPOqKlztXg9Twslpi19/HEyZqeWS7
         gJMk6T4MgwQ9aRUGRJH9OSlRjo99zczPpUhsylxjNM9Gv5JOim9hjhD9EmJxz/21QoEB
         52ILLaW9l5z3173aM7iuqoxaa1937hdwJDrn+uxIM/FiwvdGDXYh+DKCQ0iDquKzZ0lQ
         KcOA==
X-Gm-Message-State: AOJu0Yz3z2AhgylhhU3FRD7Jru0tOsqF1BMYf6SJTGRg10Cw6AWV6+Ez
	Hv5s1DV+azPlcO6ScZrg8aCK9Ni+FTYzMiCj2zu6ij8/PZIM72Xo10H67roNHBALOUmkN5vw+91
	t87jvNlAUAMMSrJTmIkgqayllgBc=
X-Received: by 2002:a05:620a:2682:b0:76c:af30:3281 with SMTP id c2-20020a05620a268200b0076caf303281mr442825qkp.10.1699650254084;
        Fri, 10 Nov 2023 13:04:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbAKz8ahgmxEGDZe4mYyxrzrfc7FYIBTw9vBsW9QcbaASAcEqhOX8ZKKXV3blkHr+vSCeWzQ==
X-Received: by 2002:a05:620a:2682:b0:76c:af30:3281 with SMTP id c2-20020a05620a268200b0076caf303281mr442805qkp.10.1699650253788;
        Fri, 10 Nov 2023 13:04:13 -0800 (PST)
Received: from fionn ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id tn12-20020a05620a3c0c00b0076cb3690ae7sm85750qkn.68.2023.11.10.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:04:13 -0800 (PST)
Date: Fri, 10 Nov 2023 16:03:40 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: RT <linux-rt-users@vger.kernel.org>, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rteval: Change the default kernel for kcompile to
 linux-6.6.1
In-Reply-To: <20231110102041.EN_qugjR@linutronix.de>
Message-ID: <3cec72ea-5997-6d25-cfbf-fe23b86b265e@redhat.com>
References: <20231109204554.98770-1-jkacur@redhat.com> <20231110102041.EN_qugjR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 10 Nov 2023, Sebastian Andrzej Siewior wrote:

> On 2023-11-09 15:45:54 [-0500], John Kacur wrote:
> > diff --git a/Makefile b/Makefile
> > index b73e8c13f3e5..14f74e087eff 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -18,7 +18,7 @@ PREFIX  :=      /usr
> >  DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
> >  LOADDIR	:=	loadsource
> >  
> > -KLOAD	:=	$(LOADDIR)/linux-6.1.8.tar.xz
> > +KLOAD	:=	$(LOADDIR)/linux-6.6.1.tar.xz
> >  BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
> >  LOADS	:=	$(KLOAD) $(BLOAD)
> 
> Instead of doing this every now and then you could first limit it to one
> place and then build the remaining version coding from that point.
> Once that works, step two would be to grab the current version number
> from
> 	https://www.kernel.org/finger_banner
> 
> \o/
> 
> Sebastian
> 
> 

We have to use a default kernel version that we know works with our 
current tool chain. Usually when I update the version it's because the 
older kernel doesn't compile on the latest distribution. For that reason 
though, we also can't just fetch the latest and greatest that we haven't 
tested.

We have added tools in rteval to make fetching the kernel easier, 
especially for upstream.

rteval -S [kernel-version]

will either fetch the kernel-version, or if that is omitted, it will fetch 
the default-kernel version for rteval from kernel.org

I guess what we're lacking is an option to have kcompile use an indicated 
kernel-version. This could be useful also for testing the version with 
rteval.

John

