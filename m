Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E5BC64ED6
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Feb 2023 09:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBQJHe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBQJHc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Feb 2023 04:07:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03860FAA
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Feb 2023 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYBgjTMjZdGOtt6bx76zu2DLo3upoWvpTnwIk+crChA=;
        b=MJYEyiF0DlcH4iSDNPo7sck/zdLnvcws0KFt+ACRsPys1lCuhFz7u8QKXRSa3Ol2aqvNjH
        jvnPP7YG/0s5vl3/5E9tjOFRtoV81xgkbAUZ050QdDRwnCP73WAydMOkrr3iRgePCBJZ95
        zwcWX/BaW3UcLYzGoK1q2szKjvf8+js=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-84-zJRrqYCBP7yG24skwHJPrQ-1; Fri, 17 Feb 2023 04:06:33 -0500
X-MC-Unique: zJRrqYCBP7yG24skwHJPrQ-1
Received: by mail-qv1-f71.google.com with SMTP id z16-20020a0cfc10000000b0056f0794632bso1593374qvo.18
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Feb 2023 01:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYBgjTMjZdGOtt6bx76zu2DLo3upoWvpTnwIk+crChA=;
        b=yWMr3Ysy705wYctQ0NRuXgCBDOYkYksw0Q98vFag2hwXinrrGC1LyMCRGBgxYZtTh1
         lyAHx2dkpDw3qX1Y6YKc14+np2xekBPzeSeRk1SOTHn//kwHOLs1MJmg4imE4GB1kKd4
         q4aGwn1Waz/DmdlGqu4aj/o+CchmOwcs+2N574zRerZxRdrbk0rlgJViaTcA9cZZKHWp
         VbX2uUk1z6G2SEpQTxZCIdpTV5QsFcp69k4B1EwkAfSyHuuOnoCKOHtqS7edHolvdmrN
         uv56uqpGWy77NRbbnUrQAuxFkBu3tejsE4+BwdLTWCE5bU4yCjXU2ViK2Ml8vSYi8pI6
         8YXQ==
X-Gm-Message-State: AO0yUKWjfhD9oB55D0K+Hlu6CS5+dglo666fcHarVbWGf+xB9ADho5Rr
        ItgMgD+7OikznB9pEySJKjRg7R2TqQkvU4y4F+IOlIzHFQ0I/GiObfbGzrINpTvCtEthyAIRgqb
        CSYQflB/QRaE8Wrbh8ILe5alfe84=
X-Received: by 2002:a05:6214:21a9:b0:56e:fef4:7ff1 with SMTP id t9-20020a05621421a900b0056efef47ff1mr6224984qvc.21.1676624792394;
        Fri, 17 Feb 2023 01:06:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9dksCLRvkGtOCr4ORausUUH6GVWvsZbSk/a25QvYMl9pl4wePTorQHv5gsaTW5qe3V949j8g==
X-Received: by 2002:a05:6214:21a9:b0:56e:fef4:7ff1 with SMTP id t9-20020a05621421a900b0056efef47ff1mr6224956qvc.21.1676624792049;
        Fri, 17 Feb 2023 01:06:32 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id i65-20020a37b844000000b00705cef9b84asm2814791qkf.131.2023.02.17.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:06:31 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:06:27 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel V edition (OSPM-summit 2023)
Message-ID: <Y+9Dk69B/PSMp3Lp@localhost.localdomain>
References: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi All,

On 19/01/23 14:28, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) V edition
> 
> April 17-19, 2023
> Universita Politecnica delle Marche, Facolta di Economia
> Ancona, Italy
> 
> ---
> 
> .:: FOCUS
> 
> After a couple of years break, OSPM is back! In a different venue.
> 
> The V edition of the Power Management and Scheduling in the Linux Kernel
> (OSPM) summit aims at fostering discussions on power management and
> (real-time) scheduling techniques. Summit will be held in Ancona (Italy)
> on April 17-19, 2023.

...

> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).

Registrations are now open. Please use the link below to register. Don't
hesitate to reply to me privately if you experience problems with
the process.

https://forms.gle/QbRhGS3HWXinKBZq7

Also, website of the event is now online. Refer to that for logistic
information.

https://retis.sssup.it/ospm-summit/

You can find below the list of accepted topics.

https://docs.google.com/spreadsheets/d/10AJFQporrCPH9Gn6-MaRotdfO4Hm4LG6dVAoDrQdj5A/edit?usp=sharing

For registered attendees, a draft schedule will be available in the next
couple of weeks (tentatively :).

Looking forward to meeting you in Ancona!

Best,
Juri

