Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69F224AF2
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097539; cv=none; b=aOoZdedCfTKH5BJOeC0oKAwG/NHWm94B8x3R2haI0j/F0gW+gdjEunWteqPkGxloekJXftyGaN7FnyaKSPmf1XdoZV9WtoGa3NeJLw6jRwhBKuJCpZAukFcIfemnYWtOZx0attkRdna1xvyJTKbTqY4ABVzIWdOlctzRGRKpDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097539; c=relaxed/simple;
	bh=UlakOXNUnWlui0O8dl4fWbSfnugCwIBoGqmonJy+VZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C9Z6UPrKp1jMVB6VQFUyoVIMqjoJh7feWMHTeGYMtS0y8XpF7cf1dWwJzAs9K08b/eRlZj2F/Js+a6GtXJT4WwX7qi6ia1m/PHgYD9CLN5GN/q0SXwoHiX791OITO5VW9r90MCMazy7W4SZouQW8V7rxg4QCIudTcxpz/DZ+Rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvxbxOe5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P06cn9EV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvxbxOe5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P06cn9EV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764097535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8yKzxdHS76ZuWerGVDIj6ks/2C9gpOysjNueka2j3A=;
	b=AvxbxOe5dv+E6rLuQ2BjIs97OVie5Gg4zg+InrufyM6ng7E2EB4c25NdGzpnuIo4XMbgZz
	6oOJogRlcGQq4ucDtQ1V3N8j932ElggTrP62WF6lkQ0a25QMkVbZWs7kPMdJTOq2VO19MW
	O0+bZ+Q4HZt76JahEt8FTWqMrRD38fg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-41XI3pGINhi0M7T7k4PYMQ-1; Tue, 25 Nov 2025 14:05:32 -0500
X-MC-Unique: 41XI3pGINhi0M7T7k4PYMQ-1
X-Mimecast-MFC-AGG-ID: 41XI3pGINhi0M7T7k4PYMQ_1764097532
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-882529130acso151653296d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764097532; x=1764702332; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8yKzxdHS76ZuWerGVDIj6ks/2C9gpOysjNueka2j3A=;
        b=P06cn9EVrVLWyJAW4Jr+mFRgb1PzJokdqJ+SI/hTea8weI9u6Gp5arrNiZ0k3UdmN/
         Fru8W0R2KimTPi4WLlvLFrDKjyMVBFzt+1FEiX0cwUi08irDDZwuTO9J6Qtt/HTEFvMQ
         43VDnmNM4XhiVTpFEKWWy5oGt025AGzBc4kshv86SlZlwD3PaFdebkCajrnOfZhjp4am
         BGw7H7eD/q33ro6ey82wD8/Dc4MRr+NrGjN6lo09Hs4wZzbQbxa93Y5+Jtw47nQhr6CT
         UJF5ljXuHeDqbyQmjlB7Qvx+RZNMpkprpLgfnumk4U/g+Xr2GC73Hb2pu2bV7VUmWefG
         Xk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097532; x=1764702332;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8yKzxdHS76ZuWerGVDIj6ks/2C9gpOysjNueka2j3A=;
        b=MXHIH/dvjw99Ydp0Vk2dVYYAzkMZc7HkjuHcQwIP2ixgOfDb0db4IrSusV8qbcz1im
         6NjJY77QmxbQNxjK/MV4IqFqVoz7RAQOSfHYQAvydW4pWjbcgyPBn/TTurCpCNYtBZep
         ytKWXveLgG/P9SKTACnIm2O+a5lf2DRlYFkMDp5VBTunLvGtbA2SPpNEbmf1bKMWKCHV
         kau4Y3k0G5IalYkeNSYq9I8mL22TzHLElSKVwbQsQjFrVEdk9hhP2k2cnWQPPq91GVIZ
         84XHDeWn85pGk4Je4ZLZ2frJHp25ii9ofGOjpVW6MfzNNsZlPC6kY05N0D6HiK45BVFd
         i89Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy2RJ00LtTtTwHgp4BXwfkzfJqRSzC0A+GhOShNw/2QCc57J3rrHogEPtnVSVZ+BUFfNldsRRvTwp2fW51Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJq27kKo6pUSmmmbQXqSzeDjC0oVew35BdzkQQKsvOC1puQfu
	Q1bqHnBkn7Mw2exd+GLyc2rCfvBdtgurXRlAD7OOu9M7wRekBghwsHSFkXwkVAO3XXgjDH+b3Bk
	D2PRocLioj4425xJJIpqrZigmE289k4QcqNw7zYiLLXiF1CwgNE7Afs3Q4p2KccJM2htU
X-Gm-Gg: ASbGnctq63oV2AmiIhistwNzTJnBh/UUCPovXUQF94O6lh1Y08NOHWnjFeSrr7YJwi7
	mDVi/QtRaFKnv24QoqFSRcZykGMF+2RB+kH//i9e8dft5DTWBwGEX5Br9AYG6kg4al+vPz0qw6z
	HLp8fdc0Yzqk1sqzEB/DZTtYETZGgtnSs/rAcSv+MNzqEAvIT3fzKGTZsn01fK43Rgsm1qlZZnX
	9+nmM7AOWOgeoT6mCCLqLiAeDvUh+IeQzQV09gxulxqXVw7NySIXm9kqhQYfdpg56YojMsTysBX
	4cgN7uTvqZjJbmd5NX0DYdr2wveyKGYNEB3U3yt9C7asuHCdedPbUUwWWQ==
X-Received: by 2002:ad4:5bc1:0:b0:880:22f3:3376 with SMTP id 6a1803df08f44-8847c489826mr239694276d6.10.1764097532346;
        Tue, 25 Nov 2025 11:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElXmBZd/XdftIbKBhrphpo//TTS01R1rZa1//cd/hMEQS4MdKYbVlhaN+juYIl2ZOLOqGbbw==
X-Received: by 2002:ad4:5bc1:0:b0:880:22f3:3376 with SMTP id 6a1803df08f44-8847c489826mr239693576d6.10.1764097531813;
        Tue, 25 Nov 2025 11:05:31 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c32csm129309056d6.37.2025.11.25.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:05:31 -0800 (PST)
Date: Tue, 25 Nov 2025 14:05:20 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] rteval: Add README-tests
In-Reply-To: <20251125110241.277542-2-tglozar@redhat.com>
Message-ID: <2137aa07-113c-3d78-af8c-7ac6559f07ee@redhat.com>
References: <20251125110241.277542-1-tglozar@redhat.com> <20251125110241.277542-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463748606-880049690-1764097531=:65893"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463748606-880049690-1764097531=:65893
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 25 Nov 2025, Tomas Glozar wrote:

> Add a README-tests file describing what tests are implemented for
> rteval and how to run them.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  README-tests | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 README-tests
> 
> diff --git a/README-tests b/README-tests
> new file mode 100644
> index 0000000..802d4eb
> --- /dev/null
> +++ b/README-tests
> @@ -0,0 +1,102 @@
> +There currently exist four kinds of tests for rteval:
> +
> +- Unit tests
> +
> +Unit tests reside in the tests/ directory. They are Python modules which import
> +the Python unittest library.
> +
> +The Makefile target "unittest" (or, alternatively, just "test") invokes unit
> +tests:
> +
> +$ make test
> +Running unit tests...
> +./run_tests.sh
> +=========================================
> +Running rteval Unit Tests
> +=========================================
> +
> +Running: test_measurement_module_selection
> +---
> +test_argparse_rejects_invalid_module (__main__.TestMeasurementModuleSelection)
> +Test that argparse rejects invalid module names ... usage: test_measurement_module_selection.py [--measurement-module {cyclictest,timerlat}]
> +test_measurement_module_selection.py: error: argument --measurement-module: invalid choice: 'invalid' (choose from 'cyclictest', 'timerlat')
> +ok
> +...
> +
> +----------------------------------------------------------------------
> +Ran 6 tests in 0.003s
> +
> +OK
> +✓ PASSED: test_measurement_module_selection
> +
> +=========================================
> +Test Summary
> +=========================================
> +Total tests run: 1
> +Passed: 1
> +Failed: 0
> +
> +✓ All tests passed!
> +
> +- End-to-end tests
> +
> +End-to-end tests reside in the tests/e2e subdirectory, in files with
> +the .t extension. They are written in bash and produce output compatible with
> +the TEP standard.
> +
> +To run end-to-end tests, the rteval kcompile source tarball has to be present;
> +see LOADS variable in Makefile for the tarballs used by the current version of
> +rteval.
> +
> +The Makefile target "check" invokes the end-to-end tests under Test::Harness
> +via the "prove" command:
> +
> +$ sudo make e2e-tests
> +PYTHON="python3" RTEVAL="/usr/src/rteval/rteval-cmd" RTEVAL_PKG="/usr/src/rteval" prove -o -f -v tests/e2e/
> +...
> +All tests successful.
> +Files=3, Tests=33, 288 wallclock secs ( 0.02 usr  0.00 sys + 127.59 cusr 155.27 csys = 282.88 CPU)
> +Result: PASS
> +
> +Test::Harness here serves the purpose of measuring time, counting the total
> +number of tests, and verifying if each test suite reported the correct number
> +of test results.
> +
> +Note: rteval requires root privileges to run. All tests, with the exception of
> +a part of the unit tests, thus require root.
> +
> +- Pre-defined rteval commands for manual testing
> +
> +These are accessible under the Makefile targets: "runit", "load", and
> +"sysreport".
> +
> +"runit" tests both measurements and loads, "load" tests only loads, and
> +"sysreport" runs both measurements and loads while also generating a SOS report
> +at the end of the rteval run.
> +
> +- Legacy unit tests
> +
> +Legacy unit tests are embedded directly in rteval source code. The test engine
> +to run them is located in tests/unittest-legacy.py, and may be run with
> +the following sequence of commands (starting in the root directory):
> +
> +$ cd rteval/
> +$ sudo python3 ../tests/unittest-legacy.py
> +...
> + --------------------
> +  ** TEST SUMMARY **
> + --------------------
> +
> +  - Modules:
> +      Declared for test:      4
> +      Successfully imported:  4
> +      Failed import:          0
> +
> +  - Tests:
> +      Tests scheduled:        4
> +      Sucessfully tests:      4
> +      Failed tests:           0
> +      Missing unit_test()     0
> +
> +Note that some of the tests require root and will fail if run under normal
> +user.
> -- 
> 2.51.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463748606-880049690-1764097531=:65893--

