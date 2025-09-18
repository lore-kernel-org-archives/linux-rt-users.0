Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07452D29DF
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223331; cv=none; b=g3RkDtnHJC8rCSIvxEGZLF+yu8tJAuqNfZL4DdfwC1ikeuNoPu30/Zhdug1PUNsHYKVqI3iXv+BP2jYvGO9+Q4h08SLA73HhsKVoCoGkontKbjhfbhKR63uz4CvNDNyLBaZ7qtUIzU3qO/CoN9bQ7Pyqtr9LFHk9OCWrRDf5EcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223331; c=relaxed/simple;
	bh=balqFjz2kMW0w/zIuR+Kq4wdU4f8/AdZ4Se44OlcqBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uug08jBQiGd2/6xpiumT2j494PjkPcZc4kme/g+DJJFUp08UF/Rqh+kwrrJ+eDzv9RXs1AHqXqP3yF+L18bf13DDv5EGl5Gnm1ZdFJcYXRiE87AztdpIC7YzCn9UBwsnzUsxE+MkKWODpmpewjwr7thvjVd9w8QfpRIoAwXcGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z29d4NUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z29d4NUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758223328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ0FeaagCw1XXrl/+AAH5fgDOBZb7jhIlvah9BkbPM8=;
	b=Z29d4NUZXGhP37aOAGBjDoFHAHiCZgIJ4p+YNYjwPY7t+61OuXwdFgNqgduRiDgGkxwYr4
	SaBqbHMcY3/sb9OTqOkApjAN73+wc3+njcxpw2fV9oX3wNgwwIN92d5sJF9Q+VFmKhynvx
	RWtD03c1GdV0V/4gto8z6qWffwepsLA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-uqnT13tVONaOimc7jyv1VA-1; Thu, 18 Sep 2025 15:22:07 -0400
X-MC-Unique: uqnT13tVONaOimc7jyv1VA-1
X-Mimecast-MFC-AGG-ID: uqnT13tVONaOimc7jyv1VA_1758223327
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-893656f5776so150325539f.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 12:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223326; x=1758828126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJ0FeaagCw1XXrl/+AAH5fgDOBZb7jhIlvah9BkbPM8=;
        b=R/Ar8YRUK8hW7h7T0NzpwQriOiimc7kGrQnm7MG+VeVxYmRL4HPVM4T+JWsR2ztVnT
         3dMIyvP9akBufeaHOXUvbOqz8jTwrs2P7BYIcyhpWE9F1h5yeZWud+8BzLxYHeegzZVA
         c9qlvv/HROoY6Qm6X/xfdOnbe0tbxnw8ASJIuKUv5LAM/E8MieGykIb/4P2o4wmw8xkP
         Wu+HWgUOOOGV1S56B3z2ujUXaDHrPIcvgi4Oh3oBtWvT4AoauX9giCizloI58+skin1H
         B/59m1pZz0NtXH5+nPUJiXnYj/XaX4qyHLehDBLx9S9Hg4k38T0NqFko2HHbGCbhy30O
         gwoA==
X-Gm-Message-State: AOJu0Yx1UbLBo8gO/+iA5zZfDMErn11l5JiWP2Vg4+QDYU5Fe7oARjVb
	melsnikzvSgCV6+MM6oXUOo3aW6lQSrzPpKlz8t0gHdKVudC8KhcNQiNbU4Gir3BGOr0ARGtXLT
	sctzLxIiiHDo1acrkjNYcTGzGMTbCRYj8GuR60qG7PHyhXGX2bCrUOhc3r0hxfVtzLG7wbygdmj
	Js
X-Gm-Gg: ASbGncuT4mL17igr+pvoyP0LcePi1asdvHh2ecmVp4wRRi3sqV7aN00biZZObPEXg1D
	x1gNM2/W/CO8p/rRXtASn15rFToWr1Z1arhEX7P2mS1FeMH3OM8lFLIe/ZgNTjnSDqhTazaWnDH
	nnXiHS6JoUyN9K+OY6F8ERwrp74BGHQNjH6Axctgywwprjca2Gy3CmWAjEkOU7mJOKNkuF4SWpC
	su6QaIQVJAP4lqiZo7cib5+tEP2ONP4cvqHurMnLXa1MLyfp26i4fceVT61BdHCExDOY3lq51mt
	pGr0HgeO38B3JgpNhlLQcHmn7GZNaWzBmYGeOwWiK9d4n3SSwUWduqXeCiGTE8jBEh+DpgE=
X-Received: by 2002:a6b:7e48:0:b0:893:dd5e:abc0 with SMTP id ca18e2360f4ac-8add342dbfdmr103642939f.4.1758223326539;
        Thu, 18 Sep 2025 12:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkisLCiTv2aLzSk3REyl5/Dun00z1nCaixaXCGFHsQjYkMErwEGmndJ+IVje5K4ebDFwwy6Q==
X-Received: by 2002:a6b:7e48:0:b0:893:dd5e:abc0 with SMTP id ca18e2360f4ac-8add342dbfdmr103638539f.4.1758223326164;
        Thu, 18 Sep 2025 12:22:06 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3405sm108515239f.1.2025.09.18.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:22:05 -0700 (PDT)
Message-ID: <43c97d17c3dc4c97a4ec47968c1c52d58c57e4ea.camel@redhat.com>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Clark
 Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
Date: Thu, 18 Sep 2025 14:22:04 -0500
In-Reply-To: <20250725090201.32656-1-tglozar@redhat.com>
References: <20250725090201.32656-1-tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-25 at 11:02 +0200, Tomas Glozar wrote:
> Currently, rteval has two kinds of tests:
> - Unit tests, embedded directly in code, and run by
>   unit-tests/unittest.py.
> - End-to-end tests, implemented in Makefile targets runit, load, and
>   sysreport.
>=20
> Introduce a new test suite in folder e2e-tests/ (analogically to
> unit-tests) that uses Test::Harness ("prove" command) together with a
> simple test engine adopted from RTLA.

If we're going to use this, please mention the dependency in the README
along with how to install it.  Don't assume familiarity with the Perl
ecosystem.

Can we just put all the tests in tests/ rather than making this
distinction?  And have the unit tests be something that can be run just
like any other test?

> +		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
> +		then
> +			echo "ok $ctr - $1"
> +		else
> +			echo "not ok $ctr - $1"
> +			# Add rtla output and exit code as comments in case of failure
> +			echo "$result" | col -b | while read line; do echo "# $line"; done
> +			printf "#\n# exit code %s\n" $exitcode
> +			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
> +				printf "# Output match failed: \"%s\"\n" "$expected_output"
> +		fi

Any reason to not take the updated version of the engine from the rtla
consolidation patchset?

It would also be nice if there were a way to just run specific tests by
number, rather than a whole .t file.

-Crystal

