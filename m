Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50AB2030A
	for <linux-rt-users@vger.kernel.org>; Fri, 10 May 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365002; cv=none; b=BYDtijUvSXhroyUaJ103TrXMw3Dzf464Nu9Rk9rhivDJ1Yv62beEaY0EEPtwbXni8kj1z20ZcCMzAcYYuioFkOVWZvFz9Tmml+uCIho5XYi2Fwtqw/B3kqyrNX/oAQ5oJT93PdE5Nszj2whOVx1PUyTlJ2sIxH4NWXOx/i5upNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365002; c=relaxed/simple;
	bh=Q5MhOeWzkKDVHI9xQ3mo+PeGPEJxI20edmH+SVw6WvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLrwGtG4FApBM6bYi7N6vBBYFbYps/eIuoWGtK0NIl1O8HDhx+8I7zKW7zR4WhA71ByqNQe4k3GpMA0RbPmUhsWoIOhzGx/hFRD+AQtY1SXq4Lh2fsMhmqX3TijCcVDIyyxp63NozH4V6hUEfTiuyFiqdJuJKGD84vl73zeEiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0ryX71e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0ryX71e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715364999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZAj8p2ZBBdchUgkHruzN7zSlWFG0wuGu3gOCA7sEg4=;
	b=h0ryX71eGs1/4uWyu5AE7jINQs4NvBv2LhQIiB8skwK4GnuRWnIkhip2WKzTUbDnpF3twU
	gTkCPasGS4CLKgXY2bLy2W5yFwU7xtmDNlvZ08L1BEVMNRFdvB0OCw6iMUW4eSrwLwVJxi
	WbXyzrllo2X5WYPIcEHeXMPvlaV0sxo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-1DtmN12jPGy0nNgsWsa-0A-1; Fri, 10 May 2024 14:11:38 -0400
X-MC-Unique: 1DtmN12jPGy0nNgsWsa-0A-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c99c4e8e7fso594800b6e.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 May 2024 11:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715364697; x=1715969497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZAj8p2ZBBdchUgkHruzN7zSlWFG0wuGu3gOCA7sEg4=;
        b=GZEkESF3UIul5dDhBrgTeCRUyjLzcHPsdAxDXhCMJtkf9EGp0Hsw+wvgoslhdW4s34
         US1wHInaPAnYeJg1iFKZRlfeXgxAsdYwa3Nm+Xo3HHHzsWxIBBKkCezPN04Axfh5E+25
         pPEfueVN+mcPEvXytLlVT+sTJ29iGtBE4EUv5Vw0vlvf9X2plxS+LVear9STMGOyTb7/
         qMDrtKL62CPJUcTNyVLWZmNL1klccopuWKc5vHg5SX8rDrF97VqICZVWbZkVlPMrb1IH
         Y8MhLbEkADb5Q755HBQ0TSSbSx4nr+Sz8tBVkfD0tKAMIvOUjUd6k+ABu7BfRIUW04Ht
         0IrA==
X-Forwarded-Encrypted: i=1; AJvYcCWaLlfh6ay/ZfonVW5AxzWcGWyM4y14/klj6q2m7JlGGG59Im38h0nHv05oyc0FyvpLqMWWNoFhMH1H+uV1YolMWerBPb19CEZyymRRsX4=
X-Gm-Message-State: AOJu0Yz8cxvRj6F02XJeVhF4AiIVbs6RWc3067NyF/hDaklSOjVDbyd6
	KDm/IvEK0kP6UOLa3twtCgWQUXJE23xavbliZrX2hKtiqymaHJO/S1DTWss0QYJX81eNRkLg1TR
	SvQDWFIZTjPu3jOtq1m46Sm8mOM3fla5muA95fj7j6mRzOMaQ2/laYfzliAddUJP3
X-Received: by 2002:aca:2806:0:b0:3c9:6db0:bb86 with SMTP id 5614622812f47-3c997067d5fmr4017869b6e.28.1715364697584;
        Fri, 10 May 2024 11:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKbPdG7xXrJvkXOHTiaKXszT9+rvpH4qg2EXL4pH8xR0FiBibejsqd2RX2rebLwBs+rr6XIA==
X-Received: by 2002:aca:2806:0:b0:3c9:6db0:bb86 with SMTP id 5614622812f47-3c997067d5fmr4017817b6e.28.1715364696328;
        Fri, 10 May 2024 11:11:36 -0700 (PDT)
Received: from hatbackup ([71.217.38.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d73c8sm19389176d6.118.2024.05.10.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 11:11:35 -0700 (PDT)
Date: Fri, 10 May 2024 14:11:34 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.9-rc6-rt3
Message-ID: <Zj5jVqzDMXGZtp7y@hatbackup>
References: <20240430110347.LCK9LAJr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430110347.LCK9LAJr@linutronix.de>

On Tue, Apr 30, 2024 at 01:03:47PM +0200, Sebastian Andrzej Siewior wrote:
> 
>   - The selftest with the cxgb4 networking driver raised a warnings.
>     Reported by John B. Wyatt IV.

Thank you for your work on the patch Sebastian.

QE said it fully resolved the issue in RHEL9.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

