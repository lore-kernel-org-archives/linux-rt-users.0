Return-Path: <SRS0=MKa8=2J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD1C2D0C1
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E8F24672
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 13:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMGe8Auk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLSNVL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:21:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbfLSNVK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Dec 2019 08:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576761669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=YMGe8Auk09W0JY3cX6XRrb5q7VUvG3JiRylPfUJy33gRZImS0cIU3VvOOMtWmnsepzY5Bw
        Qb9KjRk6VJ7v76DIEjsu7ALRcw6OEfMQ7dT+0HsNTKgmR/zRB9hHZsxRTlXOKW0+7YK7+k
        7cR8KMk5Wdx9F6QV2qiWI6pBzv+ioPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-_y0YEi4JMJG4iKsxESzfZA-1; Thu, 19 Dec 2019 08:21:08 -0500
X-MC-Unique: _y0YEi4JMJG4iKsxESzfZA-1
Received: by mail-wm1-f69.google.com with SMTP id 18so474881wmp.0
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Dec 2019 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=Ui/KTwMmoxyz7m2WCiYgtf9uKQPMT2XNjG72To5AQqFcbeEuutvHlBvdlswNIbTIdu
         1zbJSUmllMkdtQuJALjXtONAtJ/xYPV0awIczLehJyTCcVeoZ9HWCOE/P7PYSJpu4+Nw
         XeuaPPCB0YslpVi8TFvyv9m9opbfX/VdbobEEAbfe8tXBS8tgHsYpaEesBKCRhSfZ5NV
         l6iCGJW0ALeUohp1V7UVgrw+/Vre+MpTwgZtY9gY9UvC6Z12Ms4L/CyrgkZ2KZgYDVaW
         EhdZ9VxgVUhzgpFuIJnem6Ey3ROQxV6Xmaoq1gWuLu4sOtcmFIWvxxBu7tgq8PO3lQHp
         46DQ==
X-Gm-Message-State: APjAAAXovpjRRrrFOULK56JlikOWzUUZX7K72TZ8Nr2DLActMKq1MzEp
        6kfM8N5dZP8RGkDuRB5I6pGwXFldQ3i2zISndFEoepZ6yRFbjdPsDWvQ8ryjsXbJrQWBfsXXjjG
        lvrlr8/3uzp7en+hSCkznLVvmF3c=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922290wrv.269.1576761667271;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYsmkicq1CgpePFwwJNc2lMQupRm5P+aon/r1P4LvdWHpza4ghagzA9OygT/h18nUeOHn+jg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922266wrv.269.1576761667016;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id 188sm6488919wmd.1.2019.12.19.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 05:21:05 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:21:03 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20191219132103.GD13724@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019

Argh! s/2019/2020/g of course. :-/

