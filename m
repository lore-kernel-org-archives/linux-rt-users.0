Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9CA28C037
	for <linux-rt-users@vger.kernel.org>; Mon, 12 Jan 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212608; cv=none; b=D9yVyqmc57w/V0EvS8C00Npf9mlF21mN/6031W0RxtL4YdfNnBYUWJ8mP2/XSupHG+9UyNVnY44+vSp5OuLZixwdpcCBc6OSGymCtNFkbKZVTEgDV5MbbJ790WgF5mGQjJu6DRoBfqC+W0ikYxA09XdxBxUeslhfPID5+OPc5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212608; c=relaxed/simple;
	bh=iDFXfwWSoRhROG/Vq0Ji69eB6IojPN4EMOINzPWp4nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzYe6aMa6orQoZ6TNLpQmHG9Zoaf1u+A4wp7X2BLhbygUm/UjUgEV+S1gqm8AiqvOqO7uQwOHCuSldgQS5z8YjIRH93Cb5odvaYHvmwwLvQcp7l03utLQ2eB5yTAVVbxQ73vNCOO8I3ijGcXXzi8kZesMgVYk6nfcFXQj8fWbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRanc8tu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVO+Uwz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRanc8tu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVO+Uwz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
	b=ZRanc8tuDBUSAZkvZjkf8D9ZvqxL3jJLQhtfzULfDVhn7GUUR4Lo2VdVWK+aYD59Lg+aMb
	arsphN80FsJldLDsZ6WpStUfPh9pumxZfGkW/7R83riVAU2vGz7OSYN9SXNBWIsSeA5DqE
	jU8tP/QyWguos9dm+vQ2KycCbUTgcH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-QsrL3rgRMnqik5oZc53nAw-1; Mon, 12 Jan 2026 05:10:04 -0500
X-MC-Unique: QsrL3rgRMnqik5oZc53nAw-1
X-Mimecast-MFC-AGG-ID: QsrL3rgRMnqik5oZc53nAw_1768212603
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so58314505e9.0
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jan 2026 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768212603; x=1768817403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=DVO+Uwz3KQoGJMRrvhMReupkOeciWpQhBLtfQSbbK7anl1+oZMq2g7J6emo/51H1X9
         9DeI9eNjGYUC/3GpIPup7MKzKwq1mgmKkBmgfEdyG0ei2f2ZtQXq+oOfxQtN70Eu4NQv
         MCkwBTe4iPWV/BMt7yguYZU7oAuxYCy0seQ6oQwqMG/80vhqtmIuch/xpDPDKRmbWYzr
         CEQgk3pEh+6fNAfMutG5EOQm3UUvNk4W1DGlr7Tgy1eRvUcjMqwU/W6Vo3CMjRcY8A3I
         8bptRGqubjZQFN+uDFnRPaa0tMyQJ2D6rAaZqZLM0J2CdUJqbVQrVKvKmeUdLxYNw+N6
         I5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212603; x=1768817403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=lihXZnm7RH6OnX0cshVKNxvQj1DnNaz/LJwAzX/NWsdCTUT3iT06iG8PcwTwRn75Dc
         UY8q3k+Donb7Lhz2wHXoN4OIxpKGipIjrYZm8Nvfrli3UwRz5brn6XXrpbNq+J2bm5Z8
         +32dELQ8oSFb2PpzhYhO84+a3GwGHiy5tjB+BflmJCuKpnuFgJdI8RgHaQIdCuXUX0z0
         aw7Do//ElD+vTLRr/9BS+5BTZt6W18QxUYTEk7iNB8aLNpPQFyXhqFOEm+bcTqMc239z
         3cV/g9fV+ArMftb5gCtARFTCWB7WTmYwitCpSZKmQvzZPICXfIDt5Q8rXRSPnSRJUH11
         78pg==
X-Forwarded-Encrypted: i=1; AJvYcCUHw+9Noifssl3AOANxvpWqi7kOiAwRlto3LK6rjsV4GsvtAB/o3H2OnpND4d1PU/qtdF/27H4JKaOAFCKudQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9WRAmhCFgYoUz1SC04WvREWWpSQr/Q8fZk/YEGmOzHc4I+UE
	b5A0bYxm42Co1neb7o0+qIZDqrknSTvPTkHC7vsxsoLcktXbqoA1EBVuMByY3ER3n5CK+FoR0o7
	RiozhkUH7+fMO9ryah9WvTiK4C5GybJd4ZEJevgIP6ZFr54jQ4c3qxPwHrKeXI/FVpzK0
X-Gm-Gg: AY/fxX7gJNG8GBliVuvjFKZyp1MeTIQQSesPvEnO4grta96uwMUqagt7uZPeTHTnHNc
	pr2kqy5yqUvvlZRjB5kyQoF6fFa7Shj9pOQexz3SDfNJ4AWQaO2u2byTiy7Ber+AjqV1VJ/YWP9
	A1hHGk1t3rJa+t9BxZa72YvCiHldMMKhHpUlMRMI1QE8rJ7uCuwPfPdBAQPg3Nq3QEAER/uppZM
	0gQUhyYmqAHooEvGeCWowtln5ybUGegNDj7C1wT/6rDSPhIc9fHzd8Gk2d0LedIiExrhrvp9HMf
	mlAjhY2BoURvxCZPNXxEuKmPZFsF/L6PvdzrlQayBzeUI8/VPAIMR4zwFC21vthXl1o53UpTq9y
	Fx/WoLfA4SAtR6oKc5ctmnLQ6SYyX4u2aAAVwv9ye
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390545e9.21.1768212603455;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHxXn/UA4trykZ5T+SQc9F6yA7v1dNyRS4eMXq4oY/fXdGhX4AlgW2jGMNsGOSw5qPOxfWew==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390185e9.21.1768212603022;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm17906870f8f.27.2026.01.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:10:02 -0800 (PST)
Date: Mon, 12 Jan 2026 11:10:00 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VIII edition (OSPM-summit 2026)
Message-ID: <aWTIeLbQXalZtOGc@jlelli-thinkpadt14gen4.remote.csb>
References: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>

Hi All!

Happy new year. :-)

On 17/12/25 15:52, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII
> edition
> 
> April 14-16, 2026 - Arm, Cambridge (UK)
> 
> .:: FOCUS
> 
> The VIII edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. The summit will be held at Arm in
> Cambridge (UK) on April 14-16, 2026.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 

...

> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation use the form available at
> https://forms.gle/dR5FuzQRFNXZEQBb8.
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> 
> The deadline for submitting topics/presentations is January 30, 2026.
> Notifications for accepted topics/presentations will be sent out
> February 6, 2026.

Quick reminder that the deadline for submitting topics is approaching!

Also, I'd like to mention that the proper event website address is

https://retis.santannapisa.it/ospm-summit/

Don't hesitate to reach out if you need any help.

Best,
Juri

