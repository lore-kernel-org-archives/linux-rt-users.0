Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF92AB36
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt1U5hKY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB1BF
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696617798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=og81b9S2JFzeIk6YqFZvBVN80z+WCRUNZkx3CpCgTcE=;
	b=Zt1U5hKYIX0DPEl0sRWtPwIFrMU0nxkaAjz85pc0IcqPRqVIrIfXuWqsT/oMrhUuomDDDT
	5/DhpVmXSTLb8ft317mOXXEeUMtNx4ZT4vbI+1DF4vyyZNlgG98M96tCZLeZ0kjiESIAuo
	vVPuMHckYM/478AfFGsL6HTT8HdnD9o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-A2tH_ZDNNMq7ErdM5VMjwA-1; Fri, 06 Oct 2023 14:43:16 -0400
X-MC-Unique: A2tH_ZDNNMq7ErdM5VMjwA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-59f7d109926so35432657b3.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617796; x=1697222596;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=og81b9S2JFzeIk6YqFZvBVN80z+WCRUNZkx3CpCgTcE=;
        b=pcrLh4VY7QNGviQA5RBx1wmQc4YPrzXHz8qUHPNCCq2aLdjM2aoQ5jF/EASTV0QU7Z
         KnnKD5uywRHvVS8U6G4hKaVbuQclBPgtCRMmKYdP9zrF4Uqszp6WXjG4EU+WJTy6wmhm
         X+VfqXud17E3+o/VNC84gUu3NNmWna22u/7Kp2H5EJzI/dWIy8i8pJcKWtwDldXDFDBH
         33lnJQfiYPt4Hi+dYJk0PK5j/n/IropGjZXFEpvFAe5OYcBtC+aARHsYbHLshGEusO57
         Cm+Ng4/fIaLF1ME9kYBX1SmUdMRiv9hMeNPUpRS02HtZNmxU90Jq/306mZKnZo0eMk0O
         ydYg==
X-Gm-Message-State: AOJu0YzrUsk+zoidiRiOWykZ8PnxDYQTIZoSajaFPYTQYynz5X9V591w
	GRvolYVk4d1Y2fGlnwyHxVSdBnOo8OcoI69PE4zh0xqcyipWeBjE0vr17QY3qrrjmiWTAoQLdbu
	iDWj5ok3fMCbj2O8nsotd9488ReyZt4fSrhI=
X-Received: by 2002:a81:a18b:0:b0:5a1:d4d4:a312 with SMTP id y133-20020a81a18b000000b005a1d4d4a312mr8862236ywg.5.1696617795945;
        Fri, 06 Oct 2023 11:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH29ZHAW9gkd33nV1c2Aceha/22Vmu5RUf5Cq23IYvkySOCQeH3+uHWUnFKsJUlHlxUkyxXMg==
X-Received: by 2002:a81:a18b:0:b0:5a1:d4d4:a312 with SMTP id y133-20020a81a18b000000b005a1d4d4a312mr8862225ywg.5.1696617795708;
        Fri, 06 Oct 2023 11:43:15 -0700 (PDT)
Received: from fionn ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id he24-20020a05622a601800b00419b67d2823sm1469060qtb.34.2023.10.06.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:43:15 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:43:05 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Yann Collette <ycollette.nospam@free.fr>
cc: linux-rt-users@vger.kernel.org
Subject: Re: rt-tests build failure on Fedora 39 with Python 3.12
In-Reply-To: <95ddebbf-25cf-d692-17f4-a7ecaceb9f6f@free.fr>
Message-ID: <3e7ac039-5678-bab9-63a3-f61785d293c@redhat.com>
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
> 
> 
> Best regards,
> 
> 
> Yann
> 
> 
> 
This was fixed in the upstream version. Are you using the source from 
Fedora?

John Kacur

