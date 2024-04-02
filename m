Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEF12BF20
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091165; cv=none; b=OcpXSdEKQDG7TT3UbKh2La4itynoXxgx8Qiw4w61UsWNJsrQWzmn3RLDqAHjtLyUy1pDSwbt6clMFXcYzh5dAKuRlHJZA70EJz715fUx91ZuFfNCTv0MmQZMuNoz8cGRyJACsSj4PijvRI61+Urx2TACZONmy9Y6loBtsBvMfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091165; c=relaxed/simple;
	bh=o3wZl1K/56Kr5TqlodZWLZghY1ufqt7eloxN04ssVlk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TraDmbt58R/dMkKBZXIjd1o0PnQ0uWZyoXYjL++iW78OhRwfjsDzQ6xfn3kU4fxfcPQku1lrnzF2QM6k0XMfFZSDO2aurB8GITvkkqKvFENwQXySbHdfF+dPq9OLTOyGXOdR6dCTF6ROS60pxwzH9GCaj9cx5xQ5N9Gwrff+Whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sp36+V26; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sp36+V26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712091163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHNZF2mCDjU43wYeS/UJKNYKho3n0zpN6CGvkogOsrs=;
	b=Sp36+V26CjNkhCk0Py6ePpgxdEx1Nm23JVu71eM7j2chgo/Pvyuz9+w0VTgHsyfy55f3nn
	hOiM8upO+1uzbesewHrPERs5g65lyf7D+oRbVux2r6ggr5oSswaHQsrIn+bIXWVLxxEO0S
	QNOAc8fHVinhnfVkQsNgH8E6ODzLHas=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-V9WfxNLzP_S6W2us3q4TAg-1; Tue, 02 Apr 2024 16:52:42 -0400
X-MC-Unique: V9WfxNLzP_S6W2us3q4TAg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6968a5b3557so59186196d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Apr 2024 13:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712091161; x=1712695961;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHNZF2mCDjU43wYeS/UJKNYKho3n0zpN6CGvkogOsrs=;
        b=qNUocujppcMr3uDlvOL+s/3qGs+FroTdmGc3f/cyxYvruYuwyteWy2yaUis0x1TMq9
         5qo4xKAThmvuthspqp8gF3gvKKDY+A1Z7wMfZ0Llc8CLZo8jxBaS8JB5UFIPALLsZGNj
         7CvDBfhuat+8ofWsNnLwIHQr5cdXf+pyQ3OSy2CMN50RZbUQxL6GsRg3jqaCNJw1jhn3
         QhaDDvDDl6PYehYssxsZExqyq8hPutnd/tyWScMyl0mQyKe3mMYK8c4fM58RS9Etd68g
         5uZ+f3fKez1METoecusQDwgeeyKfOKSLtPXindFx3jEzIPWio6o31xw9aZxniY6Gb435
         lDiw==
X-Forwarded-Encrypted: i=1; AJvYcCUQf4Nvik7SmnxGhQmuu8emsPxEmqp3B+Ps1iS97VfuXslf2F5jt0Q8fJ0ahU+nF0sKV7iH1dgtP+eYFg3VATIbY1uHsT2BeEn9GrWm8fE=
X-Gm-Message-State: AOJu0YwKo6fngX2ixUeBR9cmaqlrUf9XXYAdMM8VA/L4vop79cYKeLvm
	TrcFkg3iT0P4RymdYTWVaf05ByECDzUpoysD9UWSatcdris5pGShsR1x9NL+Bbf1CEB1NbiUsNW
	k6TZ5RvfKOAqKEpyGTv/AJCa1+nr8VTXSzeq7XQk8Eghirmi+YovYdATMqykM34Wi
X-Received: by 2002:a05:6214:2b47:b0:696:9cef:4d51 with SMTP id jy7-20020a0562142b4700b006969cef4d51mr372205qvb.33.1712091161461;
        Tue, 02 Apr 2024 13:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEIcacRezKiAmSgyfTChLLL7MT5db7aVS1ekHcXcXDZ+JzDBfPVsgY2UtTqdmOH713SV5W1Q==
X-Received: by 2002:a05:6214:2b47:b0:696:9cef:4d51 with SMTP id jy7-20020a0562142b4700b006969cef4d51mr372192qvb.33.1712091161022;
        Tue, 02 Apr 2024 13:52:41 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-166.dsl.bell.ca. [184.147.142.166])
        by smtp.gmail.com with ESMTPSA id lx15-20020a0562145f0f00b00696b176ddd1sm5805969qvb.3.2024.04.02.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:52:40 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:52:39 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5/5] rteval: Remove 30 second "settling" period
In-Reply-To: <20240304211655.20174-6-crwood@redhat.com>
Message-ID: <1b890661-fba5-5e71-05d5-d9a55a43a5d5@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com> <20240304211655.20174-6-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Mar 2024, Crystal Wood wrote:

> Waiting for 30 seconds for loads to "settle down" adds unneccesary delay
> to very short runs, besides being a giant hack.  Load modules already
> have the opportunity to do setup beforehand.
> 
> Even if there are a few seconds before the loads get to their expected
> "heaviness", that shouldn't meaningfully affect the output except for:
>  - very short runs where you either
>    - don't care about the latency because you're debugging rteval itself, or
>    - are debugging a latency that reliably shows quickly, in which case
>      consistent behavior is enough
>  - latency spikes that only show up during load startup activity, in
>    which case measuring it is a good thing
>  - minimum latency values, which are not really the point of rteval.
> 
> ...and the 30 second delay is *especially* useless if loads are disabled.
> Currently there's no official way to do that (as far as I can find), but
> it can be done by disabling all but stressng in the conf file, and not
> supplying stressng options on the command line.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/__init__.py | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index 72e3412a860e..2c1dc1a7a22c 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -194,8 +194,6 @@ class RtEval(rtevalReport):
>                  nthreads = threading.active_count()
>              else:
>                  nthreads = None
> -            self.__logger.log(Log.INFO, "Waiting 30 seconds to let load modules settle down")
> -            time.sleep(30)
>              measure_profile.Unleash()
>              measure_start = datetime.now()
>  
> -- 

kludge begone!
Signed-off-by: John Kacur <jkacur@redhat.com>

