Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4722820DA
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218198; cv=none; b=Fbu+FLOvtTu/HDhIhGP/Y4b+yXv2tKKB6jZJ+ZMkhSDIXUqywqpD2R9SNRvdcEvttd8J04UteiNQbFNi51XqvkhhQC2l26lvu26ghlgUWvlpLYH9kk/+3jBXbi854i/MDR9K2dAk1h1/Jl2ePgt6vJhS+qcCLtg5mGH0HoYbDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218198; c=relaxed/simple;
	bh=gONnM9Uk9ggkNDV2JEkqgXQyiyFy+wwGt5W5121C2g0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qrun2c6b3La1J7VjOOAyQdV/ToQeBdb+7RQbRofiFBeI8CyNBDZvfffMpqGchwCE2El5OP29Bkm6ExWpkHk9cV/sQDqGz3gCjp1JJ92qkjmup1M5wi451ZEhEptQjiAwBUqAbMabQyRf8FRGU7jzjLTtp+Hhfwc4WhWRkEXdZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wz9ukkKX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz9ukkKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758218195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXyvGViztE+p6D5wH0bih4ZQvMjJSTec04FIr/MKvYw=;
	b=Wz9ukkKXVbqIrRYydenOAuvxwiLNduAT9K8aCauhYQ7Sm7i4lMb8ckSzgzyN3dfZ2B6Qh4
	IlKXJoj1zgkEGDeosMhE1+VD3J2vR8q5T0A7kuJnctDnspfo5kyrL2l5+49BvPBrMndZn0
	c1DKXBzyHU+5Si/XmK4nkR50P+1tBpE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Z4WjHSFaOuurvUCe9mV-zg-1; Thu, 18 Sep 2025 13:56:33 -0400
X-MC-Unique: Z4WjHSFaOuurvUCe9mV-zg-1
X-Mimecast-MFC-AGG-ID: Z4WjHSFaOuurvUCe9mV-zg_1758218192
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b7ad72bc9fso24789101cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 10:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218192; x=1758822992;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXyvGViztE+p6D5wH0bih4ZQvMjJSTec04FIr/MKvYw=;
        b=k4FCkQBj89xXHWSTnvB/ZnmQ/+fwtecEveXAkRdmfMJeYHelBACW4P/ZKgWAKfoFNF
         mf2IphFC/BFO5ReN5E3XYVBY1scWouxHk9K3XdbU1sInGH4HM6lBsfiEWlBYWxKPTWmz
         tuNjdR7kOq2UwPll/8WlitxTcv+EPBu1mdT7JKoP0dermHs4J3w1IrVTPtm+wc/tKCTh
         Fo5HVybsVUIuEG8ZWyVRKHRcH5YNZY4N9CzqNHq9KSp/PGDqWtXF0A+lAznwbnhfGB2L
         8xnnhVTzIudLq7gxdYwG9S6/KCujj+6MIE97lTNYzd496XYHZ8FTttOkNezk3jvqg/VB
         ivuw==
X-Forwarded-Encrypted: i=1; AJvYcCXH8zWcX5ESURc87q0BWRgFZmtEYLEq0NK6l74nIgSyNSculq8qPupax+TX2Ss5oP+GhBDl9fkFeYOGOxCxAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWENMKScIMwepEKDSF7pxnzFkvlA2HcO74twdfZ+8OLTzQVfEF
	jgPN9llhrr73Y9VkDQoyrSZQuLl021zm7JQ/Uv2uZ5IvXSDU4RTL55TYxS1qvIz8SKLKGsM+LKX
	Chaee8O5PzjjxjCT7l4nz9q9R/BZTv5tgW7Hc79ZhyU6FGd6rXCNVa3vpoVI/Rihop4ce
X-Gm-Gg: ASbGncsd0tdaa+76Bj2oQWpeNg5n7vaI1HWsqpeXqXQ/28WVFqtfzYr+SnCWGXjciNW
	F1K/7gH0NNTKy9Qc4TUOEqOEQkpCul/SRN41jVhjzz66SWSW2uWC2FkLOPIVy6CyaS4/kkIylsL
	fv7uO8JEWdS+RW8ZOAfJ/xVbFdrUjZLS7kvoIzyPh1REc33a/daGJGruRu3fGd2z5ni1AlFghAH
	yF9cVLJBVzu3IReyqVgZ1xuFDOor+TF8911jcxF23fuQelQJKyrDeUwmsQJ4TDKMmEjVJXTZ9sd
	/Cw2l4GjCBMQ7pvLjEwnN6Snhw==
X-Received: by 2002:a05:622a:5:b0:4b7:5de3:3046 with SMTP id d75a77b69052e-4c0720adaddmr2687151cf.49.1758218192172;
        Thu, 18 Sep 2025 10:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcYeXU6PAjM93gbgN7paIo1VZgIrXll1wWGx4yomzIdmDV3dXJ6ywzC4IWliSBXR0FwiTSgg==
X-Received: by 2002:a05:622a:5:b0:4b7:5de3:3046 with SMTP id d75a77b69052e-4c0720adaddmr2686801cf.49.1758218191751;
        Thu, 18 Sep 2025 10:56:31 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda1fc418dsm16733371cf.12.2025.09.18.10.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:56:31 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:56:19 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
In-Reply-To: <20250725090201.32656-1-tglozar@redhat.com>
Message-ID: <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
References: <20250725090201.32656-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 25 Jul 2025, Tomas Glozar wrote:

> Currently, rteval has two kinds of tests:
> - Unit tests, embedded directly in code, and run by
>   unit-tests/unittest.py.
> - End-to-end tests, implemented in Makefile targets runit, load, and
>   sysreport.
> 
> Introduce a new test suite in folder e2e-tests/ (analogically to
> unit-tests) that uses Test::Harness ("prove" command) together with a
> simple test engine adopted from RTLA.
> 
> The test suite runs rteval in a temporary folder for each test case,
> collects its exit value and output, and validates both according to the
> test specification. grep is used to check the output, optionally with
> custom flags. rteval.conf is generated individually based on the test
> specification of each case.
> 
> Three test sets are implemented in the commit:
> - "basic", running base checks without any specific modules or module
>   options. Replaces "make runit".
> - "loads", testing various kinds of loads, including their options.
> - "measurement", testing both cyclictest and timerlat.
> 
> The latter two check in rteval output whether the command run by rteval
> corresponds to the rteval options and to the specified load or
> measurement, if possible.
> 
> "make runit" and "make load" targets are depracated with a warning;
> "make sysreport" is kept until sysreport tests are added to the new test
> suite.
> 

Interesting.
Note the correct spelling is "deprecated"

I'm not sure we want to deprecate runit and loads, they have different 
purposes. I often run in a non-rt environment and without tuned if I'm 
just testing functionality and not performance, and I got this after 
running make check (skipping some of the output before that)

# Output match failed: "Command: rtla timerlat hist -p1100 -P f:95 -u 
-c[0-9|-]+ -E3500 --no-summary -T1 -t=trace.txt"
e2e-tests/measurement.t .. Failed 6/19 subtests 

Test Summary Report
-------------------
e2e-tests/loads.t      (Wstat: 0 Tests: 8 Failed: 1)
  Failed test:  5
e2e-tests/measurement.t (Wstat: 0 Tests: 19 Failed: 6)
  Failed tests:  13-14, 16-19
Files=3, Tests=33, 308 wallclock secs ( 0.06 usr  0.00 sys + 146.20 cusr 
281.79 csys = 428.05 CPU)
Result: FAIL
make: *** [Makefile:22: check] Error 1

How do I identify which test is test number 5?
Am I failing tests because of performance reasons or because the tests 
expect an environment different from mine?

Thanks

John Kacur

