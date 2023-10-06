Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049928DCF
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlYA+ha4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B6BE
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696617873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UePO6tNF7Qn/DmzhFhlLbu+ppD5IUsAFzjFIUEX43Rs=;
	b=QlYA+ha42y5/SPx98kEtG15AE81J0xB2Y5U1ruCRwxtEtGqWAZJg/30Q4HjwcNlejCck8Z
	btZjofPrWeb+AZua6AO9/+pkGMj4e8nansGg2z8WAZ6Nmi0TQqFemnVIBqI+bcdy9Nn7EN
	16r05raB5zBXo+OHknYpu7mkBHxpmlw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-S9WywWGyPbGTTB6tnDs6ug-1; Fri, 06 Oct 2023 14:44:27 -0400
X-MC-Unique: S9WywWGyPbGTTB6tnDs6ug-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-417f94d6938so25796031cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617866; x=1697222666;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UePO6tNF7Qn/DmzhFhlLbu+ppD5IUsAFzjFIUEX43Rs=;
        b=ZGhblBU1rpIWjaT/R1Yqtxh7Tgnykxpi5yNeJwKVWpQv8lE9iZprR8bfup7Sqzh4oi
         uAidTYyMKKKqOG+CvN5+i8DBLLV7GHQ/c2HK4Bn720n+5oTVu2cZmPF2sVbsDNcg2Nwz
         n2G36hNREwm0AFW+DP+vJPz52b3Kw/FkkbJZeYrVKqJj9Wfb+TEuWPUTzM22pwKIgYAX
         Evn+eOOQMl5A2je5nbxYAbQ7m7oKujc/nODRhacVKH/rtAJ/nUhJBzGMWsvhTUW6F8vZ
         e1glYw+DEm0hzMer6iWaJV5motvkZHwyHzL8R2mgmZscfAYnZUfb7Biy2LQAKmW06MRz
         32FQ==
X-Gm-Message-State: AOJu0YxWKTt/IL5/rPhbyXIXTaQLHX1FBGrDMx+PvTroD3h7+ekuqwLD
	mYu0mYBwmBnXMqsUaiAK47MGEIgGoLuPFKRGAw2QMbGI3tHQ300F7mAF0oJhcqNtystNWB61x5c
	/pA7aiiDHLtH5esHcKD/yOV+Uv3IO4QSlvco=
X-Received: by 2002:ac8:7f94:0:b0:418:157e:e3af with SMTP id z20-20020ac87f94000000b00418157ee3afmr11266840qtj.14.1696617866588;
        Fri, 06 Oct 2023 11:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHrs02pBDlgrFiWYPyTdpKUYh6H7vhDWts7Kng/zo2XQ5gIEZ/lFRQUcjqsXriSuWRVqF6Kg==
X-Received: by 2002:ac8:7f94:0:b0:418:157e:e3af with SMTP id z20-20020ac87f94000000b00418157ee3afmr11266829qtj.14.1696617866331;
        Fri, 06 Oct 2023 11:44:26 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-15-174-88-88-29.dsl.bell.ca. [174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y20-20020ac85254000000b004182037f655sm1460458qtn.14.2023.10.06.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:44:26 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:44:23 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Yann Collette <ycollette.nospam@free.fr>
cc: linux-rt-users@vger.kernel.org
Subject: Re: rt-tests build failure on Fedora 39 with Python 3.12
In-Reply-To: <95ddebbf-25cf-d692-17f4-a7ecaceb9f6f@free.fr>
Message-ID: <fc9828e0-8269-b85a-a732-1be188939b41@redhat.com>
References: <95ddebbf-25cf-d692-17f4-a7ecaceb9f6f@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Wed, 4 Oct 2023, Yann Collette wrote:

> Hello,
> 
> 
> Rt-tests fails to build on Fedora 39 with python 3.12. The distutils module
> has been removed from python 3.12.
> 
> Is there a place where I can report the problem ?

This was fixed upstream, are you using the source from Fedora?

John

