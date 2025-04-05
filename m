Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413F18859B
	for <linux-rt-users@vger.kernel.org>; Sat,  5 Apr 2025 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743820522; cv=none; b=hzxr+NyWx6yX3DwDFx/SzdTVFk8MPtyMvr9Oevqvx1QC1M0hbeqXm3y8QuBMselIsqxrekcpcOs4XZohdP7j5/9QHZDzZdjRQIhVOIaV3cem5sG3JzNzDVtl95jNtmBnG+sraN0+Cc9cFrW2ww3grsU8WtxX4tBUWTS+8Wm9lds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743820522; c=relaxed/simple;
	bh=i40JngivmbTklxZpsERYVWvF09fIA8imGisGH6o1ehU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QJgnpwlN62qN870zKrhE7o+Smm4C6UolRsOKtVuDCBdtn8nAW6MrXoY3a1ls+UUvTRs0CurHrBNSlIthlG/sJRx9wgAbDlvOW5q+En8XeRedlJll45Z+h0oIKUiVcrzRb/Ypd0y1OZEi0znC6tZfhzMc24XS+nu2GdjI0Lxsp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUEP3ESZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUEP3ESZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743820517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64RuQQgL5Ga/IqzbqoJLPHY8eF1uh3qDUq/vrH/0SOY=;
	b=WUEP3ESZQg+ZtPXMHEOJYjedFPUWmxKu9hkoiYeuRITUrV351uwTsuOvkatSBPemfF6DSA
	4LuEbM/9ysECtCq22FMOxpr4AqFxnfQWxr62t3+M/dPOol2Spq3bCdbcRYyr7tzOW2IACS
	slrfupFTPRSVg/cMXobTlsLA74aaxIA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-GT5n-fO3OLKGqV3--Hew5w-1; Fri, 04 Apr 2025 22:35:16 -0400
X-MC-Unique: GT5n-fO3OLKGqV3--Hew5w-1
X-Mimecast-MFC-AGG-ID: GT5n-fO3OLKGqV3--Hew5w_1743820515
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5d608e6f5so649917185a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Apr 2025 19:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743820515; x=1744425315;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64RuQQgL5Ga/IqzbqoJLPHY8eF1uh3qDUq/vrH/0SOY=;
        b=NoLTjJD4RJ7Nujwv6+nR8gXQxbFb9Eenb1vlIOrvELCVdvjwDryxi72k7BGH4AmU7K
         WNTWJLKowdKJsrutrD6WPRVcmsFFxeJXNQpnnbZBRrjqDteaBfV4n4OkK7EJ0Xs1icOB
         4AA46E1h7UuGi3hTTra03Z3qGsyatr+z6GKgWF2JtkANIvhI52ZHoxxJf0AbMKBmT0S8
         0KNcF8eUWopHPWAoKrW+N0cVWM+9+LDrA8r/3b9sKL/6SBL5pwKjeyrY2vrtilZ0Z+FI
         J9TDrPdfufmha0nIA/lDHYIcSuTumLe1ZIpGmR1nuHpn+xkWm0Ou64qDMQiZjsa8qzGr
         +cpw==
X-Forwarded-Encrypted: i=1; AJvYcCXU93ItjhQN1FdXihtDwChbFSRkykFHOVSprHMHOMPqzIEt0f7C+MLs/6ViVjDgic3OwJvAQxo9Kphc+olRIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSyjuSuH83tMNn7v+ebVDSzKNsFPnSbN8HXEL8Wr3QZGYGNmb
	QP+V8Xwq+YbugsnY01znTndNKDIIkysJQOJoqhSfPysdolv309PPGws+Hvl1KR6k0g+VzPNFNf5
	WBjaqi9eX98PEjWw3+HCVPlY55qttW5KHypKOfg75b41Wf/nqxRd5unqe7M/vkVgjeESTVKmH
X-Gm-Gg: ASbGncuZVqiF8tapEeNs5eViCNbUuktmJBrfowRn6ozappqvP40Ro/4ysjPaYLH1Qfk
	s3mhOGxZjbJcbAMNuGg3hX03zUPT5SyL5tRgknfKWCjGTo04Ag9RfMPFJMKULM+wEEJ5bjkdcoK
	rGajdEwFxEQQ72GlQqvi11QQTt1stFf6dZlfczOrHpgb8z0+19SzuXLuVW2ZGifrhFzkii+aNIk
	FI/a8X+1whMUUGSFQOzRnKRQ/w0XCaYBJ3qzas+1VYnpsNnLdE5XsOg/Yvnc/kYk8iaaqZW3C0r
	47vApg==
X-Received: by 2002:a05:620a:172c:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7c774d51695mr811106485a.14.1743820515279;
        Fri, 04 Apr 2025 19:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETYqFG+wmRbMQ3k30wG1OL3xpZCEaJqDNYRdJWqvASLfgt43ZEmiSVowW613SfZdR0V2p+hQ==
X-Received: by 2002:a05:620a:172c:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7c774d51695mr811104385a.14.1743820514896;
        Fri, 04 Apr 2025 19:35:14 -0700 (PDT)
Received: from fionn ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc0d42sm28672146d6.13.2025.04.04.19.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 19:35:14 -0700 (PDT)
Date: Fri, 4 Apr 2025 22:35:13 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Wander Lairson Costa <wander@redhat.com>, 
    "John B. Wyatt IV" <jwyatt@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v4 2/2] tuna: Add idle_state control functionality
In-Reply-To: <443670473eaf9e9aff5a9314dec21b728eaf4599.camel@redhat.com>
Message-ID: <f66fdd92-54c8-c298-3657-2704d4687bae@redhat.com>
References: <20250311203034.8065-1-jwyatt@redhat.com> <20250311203034.8065-3-jwyatt@redhat.com> <erlhf5eul3ozro2maafv5josmrhd7xjzx7gue5ndjriabbmzgh@wcquadlmss5x> <cb55cb771373e22a8a1f64c11bebbc42a8ac4034.camel@redhat.com> <85674b73-2f87-7203-6384-664393da7133@redhat.com>
 <443670473eaf9e9aff5a9314dec21b728eaf4599.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Apr 2025, Crystal Wood wrote:

> On Fri, 2025-04-04 at 16:36 -0400, John Kacur wrote:
> > 
> > On Thu, 13 Mar 2025, Crystal Wood wrote:
> > 
> > > On Wed, 2025-03-12 at 11:41 -0300, Wander Lairson Costa wrote:
> > > > On Tue, Mar 11, 2025 at 04:30:19PM -0400, John B. Wyatt IV wrote:
> > > > > +            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLE-STATE', type=int, help='Disable IDLE-STATE on the selected CPUs.'),
> > > > > +            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLE-STATE', type=int, help='Enable IDLE-STATE on the selected CPUs.')
> > > > > +    }
> > > > >  
> > > > >      parser = HelpMessageParser(description="tuna - Application Tuning Program")
> > > > >  
> > > > > @@ -127,6 +132,9 @@ def gen_parser():
> > > > >  
> > > > >      subparser = parser.add_subparsers(dest='command')
> > > > >  
> > > > > +    idle_set = subparser.add_parser('idle_set',
> > > > > +                                    description='Manage CPU idle state disabling (requires libcpupower and it\'s Python bindings)',
> > > > > +                                    help='Set all idle states on a given CPU-LIST.')
> 
> s/it\'s/its/
> 
> > > 
> > > s/Set all idle states/Manage idle states/
> > > 
> > > I still don't like the "idle_set" name.  This does more than setting,
> > > unlike the standalone utility that we're apparently reimplementing.
> > 
> > I agree that idle_set is not the ideal name since if you look at the
> > cpupower tool, this is just one function, maybe cpupower would be a
> > better name.  It's a bit unfair to say we're reimplementing the tool. 
> > The functionality is in upstream kernel code and John Wyatt created
> > python bindings for that, and that is what he is using here.
> 
> But (as of now) this isn't using the python bindings to implement
> something higher-level; it's exposing them as a command line tool that
> has very similar functionality to the existing one.  I'm not sure what
> being written in Python has to do with it, other than a motive for
> reimplementing, to make future features easier.

People seem to be interested in testing rt with some power savings
enabled, so we're trying to make it easier for people to do so with 
the tools they are used to using. I'm not really open to debating this.

> 
> > I think it is better to have all the tools for manipulating the
> > environment through one tool and not make the user go search for
> > multiple tools to get the job done.
> 
> "all the tools for manipulating the environment" is an extremely broad
> mission... :-P

:) how about all the tools for manipulating the environment that I think
are important.

> 
> So far it doesn't seem to align very well with the rest of what tuna
> does, which is managing processes/threads... is there a plan to tie
> them together so that you can have it set idle states based on what the
> tasks running on a given cpu need, and/or move tasks around based on
> that?
> 
> > > Or just use "if cpu_list:" like the existing code does.
> > > 
> > > That's also pretty obnoxious behavior of the code that sets
> > > args.cpu_list...
> > > 
> > > > > +        @staticmethod
> > > > > +        def print_idle_info(cpu_list=[0]):
> > > 
> > > This default is never used.  cpu_list is only ever set to
> > > self.__cpu_list.  Why is this a static method?
> > 
> > This is a different cpu_list than the instantiated one.
> > This is which cpus the user wants the info from. I think
> > the name is confusing here. 
> 
> The only call (so far...) is literally "self.print_idle_info(self.__cpu_list)".
> 
> Where are you seeing a different cpu list?  When (even with future

All I meant is that self.__cpu_list is not the same as cpu_list.
Since the names are confusingly similar, if a different variable really
is needed, it would be best to rename the one local to the method / 
function.

> patches) would the instantiated cpu list be anything other than what
> the user asked for, and does that say anything about whether the class
> design makes sense?
> 
> > > > > +            for cpu in cpu_list:
> > > > > +                idle_info = Cpupower.get_idle_info(cpu)
> > > > > +                print_str = f"""
> > > > > +CPUidle driver: {idle_info["CPUidle-driver"]}
> > > > > +CPUidle governor: {idle_info["CPUidle-governor"]}
> > > > > +analyzing CPU {cpu}
> > > > > +
> > > > > +Number of idle states: {idle_info["idle-states-count"]}
> > > > > +Available idle states: {idle_info["available-idle-states"]}
> > > > > +"""
> > > > > +                for state in idle_info["cpu-states"]:
> > > > > +                    print_str += f"""{state["Idle State Name"]}
> > > > > +Flags/Description: {state["Flags/Description"]}
> > > > > +Latency: {state["Latency"]}
> > > > > +Usage: {state["Usage"]}
> > > > > +Duration: {state["Duration"]}
> > > > > +"""
> > > > > +                print(
> > > > > +                    print_str
> > > > > +                )
> > > > 
> > > > nit: I don't think we need three lines for this statement.
> > > 
> > > Why not just print each state inside the loop, instead of building one
> > > big string?
> > 
> > valid, but I think John Wyatt was thinking the string could be 
> > useful for other purposes.
> 
> The json stuff I assume?  Is this even in the right format for that?
> Is there any plan to json-ize other tuna functionality?

No, there is no play to json anything in tuna. Look, agreed, the string
is messy, we'll fix it, I'm just saying he probably had something else
in mind when he coded it.

> 
> It's really hard to review patches when there are vague or unstated
> notions of "this could be useful in the future"...  especially when
> recent experience with rteval has highlighted the importance of
> avoiding overengineering.

rteval doesn't have anything to do with this, the original coders were
completely different people. However, rteval has stood the test of time.
I don't like the multiple layers of inheritance, but sometimes I find
suprising benefits to the original design. Anyway, you can discuss that 
with me separately, that doesn't have anything to do with this.

What we are talking about here, is a single file that wraps the code in a 
class, this is fine, it often results in cleaner code even when object 
oriented features aren't used a lot.

Your suggestions are fine, now, give him some time to implement them.
 
John Kacur

