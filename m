Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4F213245
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896030; cv=none; b=tm/K2Hhf9s9V6ELtK3/KiZhIu+lBB6sfIBsLaFHG7+w9KAfPWyLJdiZZeqdYBrTWb8dgp6pnHJbHyYrrIjoZKtRxBsQF3SwLNmx+miJQXdduwjZhhk+mTbEPcRh0RE4al+w+ejKrd4BsYUvhoZWacbHVZuG1vqHM455A6S8JjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896030; c=relaxed/simple;
	bh=GysQtUtHlhDpqtfi9WE72xaZXxlN6Bn+iKIpupF6mAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=He4oduuFPghAIRvmb/Jqhl3kgE9pHhNHzimDCJ8Ia6HTyAx7O2WFHIYgKu3dODNkquGJJz4KYnFkDJCwY0VmyjJ+NHXTSkdL4vBcUpmQ9OV3KD4ogo+xW42Bj0BfykKWa6ThgPW/YlypLpumcZ9O3g1U2voNTevRyVjhuX76Mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVQVec+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVQVec+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736896028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4FfIdqJth47o5/wGGDPbh7mIyyuNcowLt13LLsJSTs=;
	b=LVQVec+7VviFqQlnlpPSli2GczlIq4xqaRx/C+GQrCaOQjOA3HQMkVBcbYtJ5/25IPEboN
	CCZdp8pPIzuUs3R1zHz6UNv9PvFtdBExS+bPZYRgNzlEPAqEe4+St8SU82ljq7lPN00RHg
	bWj+IQ8gFfesIZ6qkVdv4466GVLdAdQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-kvI0y1BxPB63sA0qV01RgQ-1; Tue, 14 Jan 2025 18:07:06 -0500
X-MC-Unique: kvI0y1BxPB63sA0qV01RgQ-1
X-Mimecast-MFC-AGG-ID: kvI0y1BxPB63sA0qV01RgQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8844560e9so127885316d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 15:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896026; x=1737500826;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4FfIdqJth47o5/wGGDPbh7mIyyuNcowLt13LLsJSTs=;
        b=rHoOqV9mpoGw7nSmWejYyRfO1KWWus7txwNMUwxEoPWs8BrJvI2YQIRWFl8wnj6u0C
         4OaiYuq9GDWHxhrZEOIKby+8lAGbxlRnodFFo0RjJ07X2Dk3x9bZEMNbDp4yyWlFRCPI
         pKXjGKb0unvz8zZSFyJfuB+NqcOAPg1Bie59j+AE6gGGiHETd7iqEUzX1dvM7OwVup/y
         dsz5gyejYCsN25cnuntNaRPA8AHX6J5y9pmx6g3PH81J/Y42bJnFy3a5iZ0D7PWS2fX+
         bC/eZJDgizj58yoOnxgo7/TyQFIlq0JrwK/Utij41ioO9xUK3wsVXCAhYdpX8ywmuckV
         CkGw==
X-Forwarded-Encrypted: i=1; AJvYcCUblu8qCaoYeRdc/LSCkUsrnbbQWEYlgeKgEoP2S0u3ZGhrWqTXjFEh0jLzROSaj3Gj/nPcEZSWms72pHLH3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXp6B/JRz1uSULASpsIuOsPBGQgZs2iWSHRPtpWwKF3KPm4FD5
	xhBnznoG0pm02jw7Y95KvRzGxASOHjcZKhZ6PReGB2vCLwr8HhZ2OFui9gq4zyaSFJZ4Vb1v0EL
	iEC9LHxS1Ur5V/Ue30bIgWQixyGdb2aEf6HPbFTOrTrjZreRJI1+myXaRbWGzWwsz
X-Gm-Gg: ASbGncsrIXOYwejtWHO7MghMQpBAUItsXPi4F1l4IXO+LJoVvSI6GpzCgW36KQI50t0
	7PV3pqf73gmBU74UVQ2/AShgBTPV1SDQ8+7DcqYM4z2YPx7t3KLT4Dla5q/6InacmF3X/JCnJtL
	E9KOgQiTS5vwjvL5FRr+qSJT/oXzHj0THnwgqJekah+EHV8oQy238QwSFpVWomVBqLlmoI/7OdU
	DvK2gAl1i5YIAbEGycHkjacu2plaG2UD0qAi1/pR9nY82I=
X-Received: by 2002:a05:6214:483:b0:6d8:aba8:837b with SMTP id 6a1803df08f44-6df9b3253afmr311844586d6.41.1736896026427;
        Tue, 14 Jan 2025 15:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHprM+BZCAEMkIuWlNu6kh5kyK/vhlxFekO7PGh/pRnO7ti8I2eVALnckkZazQOmZ4MqDIkw==
X-Received: by 2002:a05:6214:483:b0:6d8:aba8:837b with SMTP id 6a1803df08f44-6df9b3253afmr311844216d6.41.1736896025962;
        Tue, 14 Jan 2025 15:07:05 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad85f956sm58203736d6.3.2025.01.14.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:07:05 -0800 (PST)
Date: Tue, 14 Jan 2025 18:07:04 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Gabriele Monaco <gmonaco@redhat.com>, Clark Williams <williams@redhat.com>, 
    Tomas Glozar <tglozar@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Allow configuration from stdin
In-Reply-To: <8abfe0115fc4e7824f9d92743d9d41b5dbbdb50a.camel@redhat.com>
Message-ID: <a37f794b-fb11-417f-3131-f0d61c8e077d@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com> <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com> <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com> <8abfe0115fc4e7824f9d92743d9d41b5dbbdb50a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463748606-576305827-1736896025=:67323"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463748606-576305827-1736896025=:67323
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 14 Jan 2025, Crystal Wood wrote:

> On Tue, 2025-01-14 at 07:40 +0100, Gabriele Monaco wrote:
> > On Mon, 2025-01-13 at 16:34 -0500, John Kacur wrote:
> > > 
> > > 
> > > On Mon, 13 Jan 2025, Gabriele Monaco wrote:
> > > 
> > > > Modules can currently be set only via configuration file, if rteval
> > > > is
> > > > called from a script run on different systems, the only way to make
> > > > sure
> > > > the loaded modules are known is to provide (or generate) a
> > > > configuration
> > > > file and pass it via -f/--infile .
> > > 
> > > The config files are almost obsolete.
> > > Everything has a reasonable default, or can be set from the CMI
> > > The one exception is for the measurement module.
> > > 
> > > What would be useful would be a CMI interface to switch from rtla
> > > timerlat
> > > to cyclictest.
> > > 
> > 
> > Mmh, that was actually my first idea, something like --measurement-
> > modules=timerlat,cyclictest --loads-modules=hackbench
> > Basically behaving just like the measurement and loads sections in the
> > config.
> > 
> > I opted for this as it was simpler but if the config file is getting
> > obsolete, I think you can just ignore the patch.
> 
> It's a simple enough patch that it might be worth taking anyway...
> unless we actually do want to deprecate the config file entirely, rather
> than just making sure it's not the only place where certain things can
> be configured.

I'm tending in the direction of deprecating the config file, I don't find 
it too useful. In any case, I don't want to add to it, we will then end up 
having to maintain that.

> 
> > 
> > I could start drafting a patch for the CLI options to specify modules
> > if they look alright to you.
> > 
> > Another not too different option could be kinda like stress-ng,
> > specifying the modules just like --cyclictest , --timerlat , --
> > hackbench , etc.
> 
> It fits the pattern of module-specific parameters, so I kind of like it
> from an interface perspective.  Implementation wise, though, something
> like
> --load-modules='cyclictest,sysstat' or --load cyclictest --load sysstat
> might be easier (interface wise, I prefer the latter).
> 

Note that cyclictest and timerlat in rteval jargon are measurement modules
The current way that load modules work is that most are implicitly 
implied. stress-ng is not among the default implicitly implied load 
modules, but if you choose stressng-option then it sets itself as
an exclusive load module and turns off the others. If a person tries to 
run with a stressng-option and an option for an other load module, it is 
an error condition.

It is possible to run both the cyclictest and timerlat measurement modules 
without using any specific cyclictest or timerlat options. (so that 
doesn't work as a way to differentiate)

There are some measurement module options that will apply to either one.
For example 
--measurement-cpulist CPULIST

will run measurement modules on the CPULIST whether that be cyclictest or 
timerlat.

I think the simplest thing to do would be to implement these two options 
without parameters.
--cyclictest
--timerlat

Now, you wouldn't HAVE to use them, currently timerlat is the default, so 
if you don't specify, then it would use the default.

Like with stress-ng and the load modules, if a person tried to use a 
cyclictest and a timerlat option at the sametime, it should create an 
error and exit.

I like the above idea, because other than the optional option of 
--cyclictest and --timerlat, nothing else changes, so it wouldn't break 
anybody's scripts in any kind of major way.

John

> > 
> > Both would require a bit of refactoring how we load modules.
> 
> That could be a good thing, if the new way is simpler.
> 
> -Crystal
> 
> 
> 
---1463748606-576305827-1736896025=:67323--

