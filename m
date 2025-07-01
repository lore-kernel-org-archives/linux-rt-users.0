Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3D26E6F1
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Jul 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379906; cv=none; b=k00Mk7ODXtr9zX7xTjMP4vrmDeygiBGPJIZCi8OXhRsg6Eh8KhC1rJxYHUblhzLcujfYsIxN6R767MXN+Q0yV3wCtwhtHOCR8In0DHz5vkPqddDtEF+GEtOUpXqowNcOSDRI2zdgGhmcjU0gLBPHxnjG9+3NxkL9SVK2C9micdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379906; c=relaxed/simple;
	bh=VbNtaSs2bIb/bU/qDXk0oYaWFh+Mcca/hK/Q1DHls68=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HJJgb9oxh/e+xyULujVX1CbnuDdQ8Zp65lC06ykcSVBvwzmrBMPdZ5UseksCDRss3ENXbayHRcCbd2kvlqQV4QaLMzeYd4JPYwcDwvlLGmOiCSaK/y7z28RrWpSqA3zikF5Y/S2n0gbvMcdBL4cxP2M6t+Su/SWJa26FcCmuXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnhPNwFD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnhPNwFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751379903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ad2CQkUmcLlf40Ri6m+aZ5kIZ4Ypvoq8jp3qC8IhpOk=;
	b=RnhPNwFDLpLeCvdXMsmqy9xCDY0sWhbViWFy9+okjKh5L7scQ8+zRgWGqXknrtXl+M+b/7
	JgxcXdWeDEWI7KMobqgMszyUiwX95b8yEobzsnE518kiS1BeKv5g7cfYtlbmmN6Sddd8TR
	Nm/iSpGyYfoAuqoUBEh7g0im1a5Wopc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-Mw7QWscUNy-k1LJDVHzWCA-1; Tue, 01 Jul 2025 10:25:02 -0400
X-MC-Unique: Mw7QWscUNy-k1LJDVHzWCA-1
X-Mimecast-MFC-AGG-ID: Mw7QWscUNy-k1LJDVHzWCA_1751379902
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3d3f64739so784713785a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Jul 2025 07:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379901; x=1751984701;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad2CQkUmcLlf40Ri6m+aZ5kIZ4Ypvoq8jp3qC8IhpOk=;
        b=XCuovfduKE70tbuUNkceG9aftJG1J0Fhwy8MMjPQx527pE3Yl1JjBNfjqtLn/Sp7H/
         nRNqNW2cIEPZBqcyLMtmR3YVWED3ItVsS8XxZBE1opaecsmkyvR4RpW7upD0GrC8k2wK
         4p0sm6Gr2hYnMj0JpbBjuyxngKpo/GLLFrQvNdvpzSACGTQQrH19wUsuoc7VlF4QJdBL
         +Vl1mZ788c4hYLjyLH78jNb58z/Ft+2wtHaDLNKUheNoaV8feRYwyDnTnbd4lal36pwq
         nPEvQZ7ctDwG0AmMcNn8cyrs8kxyV87OmH8REZ8uaRyVM2ttxPBANgC7dhTMrXsrobeN
         NIBA==
X-Gm-Message-State: AOJu0Ywy9YdKbelOICj507j6KAAp43KDbbhTjmVfO8Ai+eFkBB//B9hO
	vEnUxYqBLUnvTKoiTemVAVDx1+DMpJyIzkbqxPFJW9zOkUhLx57PdvT/I+Hp0Li/I4QqAYL+qq5
	NsB79RMB6R5Kyw2A4bjtVgC0fN3iiohZLJ4T774nplOPTnHjEH+c6ImhkUKBanPzHboGN
X-Gm-Gg: ASbGnctIOP6LenkMkLn9bspvh6pN0hxBlWJfdpeoeCd6ePrvQm07aaVBd/JOVaUAeEk
	z0dYuLMGcdOPe4S6FiUhps0kAcuW7N44QZYCeKJDOA7vimZzhqjpfb1OaQWKnW4Q5uuQStwteeY
	tVr44PLq9Cy2H4po0+q0HtHnwGnhdKl3Tlkk0HB6gt9orJXon+6Jpn4UTEOhCnKaqZ1Rg9OCLyh
	WEicx5yNYSPSLipo+yw5vkIH8S5WHy846hTKAlLMqhC7X8qw1DJA7GBe/hmjKiiQWjwJwFphQDm
	/Nj7xw8hAA==
X-Received: by 2002:a05:620a:1987:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d44390231dmr2464733885a.5.1751379900848;
        Tue, 01 Jul 2025 07:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzwdgKM5mxlWzVURUqoIVqOn7H5hOpvyuYdEfhCGHo4ZCowTsATsfdl+ZYsM7Gh5AkyvREFg==
X-Received: by 2002:a05:620a:1987:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d44390231dmr2464728985a.5.1751379900172;
        Tue, 01 Jul 2025 07:25:00 -0700 (PDT)
Received: from fionn ([76.71.123.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d4431345b8sm770784785a.15.2025.07.01.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:24:59 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:24:48 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH v3] rt-tests: hwlatdetect: Add a grouping separator to
 tracing_cpumask
In-Reply-To: <20250619150331.989973-1-costa.shul@redhat.com>
Message-ID: <e879611a-5c4a-51be-ead9-d3df72d0d399@redhat.com>
References: <20250619150331.989973-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 19 Jun 2025, Costa Shulyupin wrote:

> Writing values longer than 32 bits without a comma results in an error:
> 
>   echo 100000000 > /sys/kernel/debug/tracing/tracing_cpumask
>   bash: echo: write error: Value too large for defined data type
> 
> The bitmap_pars() kernel function specification:
> "Commas group hex digits into chunks.
> Each chunk defines exactly 32 bits of the resultant bitmask.
> No chunk may specify a value larger than 32 bits (%-EOVERFLOW)"
> 
> Add a comma as a grouping separator every 32 bits to a hexadecimal number,
> as expected by the bitmap_pars() kernel function.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> ---
> Changes in v3:
> - rename hex to num_hex
> Changes in v2:
> - rebased
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index dc28f38b751a..68f312db639f 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -33,6 +33,11 @@ def info(istr):
>          print(istr)
>  
>  
> +def group_sep(num_hex):
> +    """ Add a comma as a grouping separator every 32 bits to a hexadecimal number. """
> +    return ','.join([num_hex[max(i - 8, 0):i] for i in range(len(num_hex), 0, -8)][::-1])
> +
> +
>  #
>  # Class used to manage mounting and umounting the debugfs
>  # filesystem. Note that if an instance of this class mounts
> @@ -494,7 +499,7 @@ def microseconds(sval):
>              for i in range(l, r + 1):
>                  cpumask |= (1 << i)
>          debug(f"set tracing_cpumask to {cpumask:x}")
> -        detect.set("cpumask", f"{cpumask:x}")
> +        detect.set("cpumask", group_sep(f"{cpumask:x}"))
>  
>      info(f"hwlatdetect:  test duration {detect.testduration} seconds")
>      info(f"   detector: {detect.type}")
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

