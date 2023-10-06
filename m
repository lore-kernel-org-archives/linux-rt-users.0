Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC538F90
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpdyMOru"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B959F83
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696620790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7T4WIX8f2DoU/3FGo0Esr5y1o8zcldnkEtpbLsxuTI=;
	b=GpdyMOruIjOHo+gT5CBVWdMXKgXxP4WOGN3QEbokDTTGgF4sIaXKlnhlEe8uxAhhAcz+/2
	ug8Yf29R0kw6oEK8gnH56wZdCaA0wZvo7T1mi2ouyaXMbOK1NQcsSG3TTCMQx88GNOhftV
	CCFpayapR9PWdy0WFZww6Adbs+TsySU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-R9Zw94dDPvO3CKKR3e-z_A-1; Fri, 06 Oct 2023 15:33:04 -0400
X-MC-Unique: R9Zw94dDPvO3CKKR3e-z_A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65b0249818dso25392496d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 12:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696620784; x=1697225584;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7T4WIX8f2DoU/3FGo0Esr5y1o8zcldnkEtpbLsxuTI=;
        b=WwIIDyMJaf8slbXYuLeqZ/W8nsSPYQbs8LgICb+ckZZmohFbq+FKFLBzwGvoVtxvG2
         z9BoMGEe+SGT4Fp8IwudLqjuuYPfUZ3GW2KSlvsEYUN4UVIAYFX43crktxxLfKybpALr
         L7zDWW7YWoVF4/ySH/n7nadyyc2iZXQNPXy/+cKzSl9kB17IZIAJJ6Ev8OJL3LLau36N
         CuBmHif/KEgIgxRLzvvzefNkrEjKNG42u7ZSSiPpu9eyPqFJDJUwaAy4W8Q/6lcu+V57
         IkhMfjAbtmJE0prlPDZo7EDXPKluMzkWx72/XHQ/+KiKbOBB84ZuDgrf4U7kaLnzpnLQ
         dd7g==
X-Gm-Message-State: AOJu0YxDpVp0xFz5JHWGVTafeO7zHY/wI0UNIm4hzut1S7m9b4m5iZ5F
	dFpH7JI1BUXjDdOiRq+Hyz8boNeXuK+VIeflKJlJRTR1RXZOhE+GagnpJxGerfCVNOYRti2aHeG
	vDw3MZ98FvNCa2h92pv5DbdfdSBX7SsQhrJ8=
X-Received: by 2002:a0c:aa9a:0:b0:65b:771:f2ea with SMTP id f26-20020a0caa9a000000b0065b0771f2eamr4073532qvb.53.1696620784114;
        Fri, 06 Oct 2023 12:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9JglcXyGL1bnYZpONW7Rig0eZZtu+M04Ywjy3spPTfkHI3KRgkaOFWvP488GGDdHC2vzijg==
X-Received: by 2002:a0c:aa9a:0:b0:65b:771:f2ea with SMTP id f26-20020a0caa9a000000b0065b0771f2eamr4073517qvb.53.1696620783808;
        Fri, 06 Oct 2023 12:33:03 -0700 (PDT)
Received: from fionn ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id e9-20020a0cf349000000b0063f88855ef2sm1588196qvm.101.2023.10.06.12.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:33:03 -0700 (PDT)
Date: Fri, 6 Oct 2023 15:32:54 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Yann Collette <ycollette.nospam@free.fr>
cc: linux-rt-users@vger.kernel.org
Subject: Re: rt-tests build failure on Fedora 39 with Python 3.12
In-Reply-To: <32e50f01-ec19-74b5-227e-06f27af0f174@free.fr>
Message-ID: <38ff8847-e8bc-517e-484d-16702d99dae5@redhat.com>
References: <95ddebbf-25cf-d692-17f4-a7ecaceb9f6f@free.fr> <fc9828e0-8269-b85a-a732-1be188939b41@redhat.com> <32e50f01-ec19-74b5-227e-06f27af0f174@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463756542-476287246-1696620783=:8283"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463756542-476287246-1696620783=:8283
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 6 Oct 2023, Yann Collette wrote:

> I was using the source from the 2.5 release.

Just go ahead and compile from the main branch in git and
you should be fine

John

> 
> Yann
> 
> Le 06/10/2023 à 20:44, John Kacur a écrit :
> >
> > On Wed, 4 Oct 2023, Yann Collette wrote:
> >
> >> Hello,
> >>
> >>
> >> Rt-tests fails to build on Fedora 39 with python 3.12. The distutils module
> >> has been removed from python 3.12.
> >>
> >> Is there a place where I can report the problem ?
> > This was fixed upstream, are you using the source from Fedora?
> >
> > John
> >
> 
> 
> 
---1463756542-476287246-1696620783=:8283--

