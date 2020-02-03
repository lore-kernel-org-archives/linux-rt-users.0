Return-Path: <SRS0=b5ha=3X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7276DC3524F
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Feb 2020 08:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACDE2070A
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Feb 2020 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXLYQ1Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgBCISH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:18:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727137AbgBCISH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Feb 2020 03:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580717886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrlD/wgdUBtVzwn2ikuTQOIVSG3OPC/dcn0ZKFc6/Gs=;
        b=IXLYQ1UmQAnq1ZXwoircpVvfaNnexl7EaZZz5eiOtGaOOmMUpR2o4IjlVdkIo0XJqHiwsR
        /SdOs/rFaq+Z7paLWfKn0WntuphV9AQ7/ZW8qmAypTgvj2VIM4p41LFs0YrIzKei2nlqBC
        C9JgiJYiMs0X+tYFMAatrbQXdY6szAc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-NVouPPbeO_CchfL0Xz81qQ-1; Mon, 03 Feb 2020 03:18:04 -0500
X-MC-Unique: NVouPPbeO_CchfL0Xz81qQ-1
Received: by mail-wr1-f72.google.com with SMTP id v17so7788410wrm.17
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Feb 2020 00:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrlD/wgdUBtVzwn2ikuTQOIVSG3OPC/dcn0ZKFc6/Gs=;
        b=ZckAAoJ8GOFJr8tcuPZypNcf9wf01fhqmUjZw1fVLxXunY+/cq83w+NjiQGbBPlqsY
         q8Ecb10oi1U1m2dYTFJXyMg1upUCnKRmZv+nZuhtYGaENSx3tnTihPedGSYb3nFOVU4f
         pjJjbC/kCMvaBUsX0znmz8KUBmN7xRp0CrSbUmrd1MUiXIpaLnj2u3nT/Q3eGRxtyXar
         Kks7SuZiRFJox0l6CeXfqKYCKQJJOelcVD6d7VopVIgOeapr+szupwqN8GyPHDJtsUDM
         w2R7gEAaaksBRHhJdz6VLEAXPYfCKVvXJNupm6mh41kzOmt50q0ETwoaNKfeahfAL7wl
         7kBw==
X-Gm-Message-State: APjAAAXK2k5DvEqn5y7XTPvZmXsvoQCVaW/qX5d2YpuQcuPOe6uNJyk4
        no/ImAcnu7/mKEYRdv0gm+AlgrzhvlaTY25+6cIj+YysVX90EMVAuYdffX3tpRZ2tmRUq7tCkpl
        6JecMQDck4U17xoetBPpYo3sObKc=
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr3034918wro.359.1580717881767;
        Mon, 03 Feb 2020 00:18:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9FVGQu5t2tcyaJhvPoLSS22q7NWyktDP3a+A/plvQOaRTXOMjAlgdnv0obzO54kAOXWlZ3A==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr3034870wro.359.1580717881333;
        Mon, 03 Feb 2020 00:18:01 -0800 (PST)
Received: from localhost.localdomain ([151.29.2.83])
        by smtp.gmail.com with ESMTPSA id r3sm24850786wrn.34.2020.02.03.00.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:18:00 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:17:58 +0100
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
Message-ID: <20200203081758.GI8582@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2020
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---

[...]

> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/1pPU2ybHHoQjqicYLTaNanPz9H5fv6mQTtrzOqwP9uHs/edit?usp=sharing
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
> - 30min or 50min slot
> 
> Deadline for submitting topics/presentations is 10th of February 2020.
> Notifications for accepted topics/presentations will be sent out on 24th
> of February 2020.

A quick one to remind that deadline for submitting topics is
approaching.  Please take time to think about what you'd like to discuss
at the summit and to add the topic to the list.

Best,

Juri

