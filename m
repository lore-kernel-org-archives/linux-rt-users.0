Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3AC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 15:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiF2Per (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiF2Peq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 11:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8389D22B07
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656516884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zkvmbeVaXkF1LA4USENkp4tstnqeqnVcevIGaPbKujU=;
        b=J5ta8pRiD8hf4xk7823xafNpSjQ441rdCWJAKZkS9x0R/Xx94aG4aHVq1K4HTnxpckd+Us
        HBvFU+pytbe4Os19qevFBazZIWaIdRxMRWz7hIssE95Fj74WjI4UUDD2hC/G/ua6xnWZAw
        BNHwlCVXGgwpzRy4SbYEOWumXk/8D+Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-nYv6kCoqPditmyPXMHghlg-1; Wed, 29 Jun 2022 11:34:43 -0400
X-MC-Unique: nYv6kCoqPditmyPXMHghlg-1
Received: by mail-qv1-f72.google.com with SMTP id s14-20020ad4438e000000b0047084e1931dso15602565qvr.3
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 08:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zkvmbeVaXkF1LA4USENkp4tstnqeqnVcevIGaPbKujU=;
        b=fOGriDxraUyDozWiqc2PKwL8ihqm3Px+IbtmqJkif+tbxCUzD+SJckgM35LBaU4i8N
         FOpc1w493ye04MM7QeSlF/YMAcWC4FV5LUlOF8GRiudKFvXOmb32frq06nYI26ag1fks
         mHJgmsevvSIiYUK50IDcvzeNpjySoEd0Cn0JTAgEClGu11OylX6/Rvr59tvkKEQB63OV
         QJkmH8EYnrCL1tLrB+MCX0VrbDtQb+ER14xBQ0xGc6G7PfFBRFRj6Ck+Duyn1w46+wcX
         7tzdyklhhUVo2BlGsTyNVXGYo0u1qpF5Z1BCCHVQe6acSJaG+YHijKS8Is9d5BzPxlx2
         zP+Q==
X-Gm-Message-State: AJIora8iKEo3gsaACH8JKyKyJdkvvGH5uOjgMWj+XXxGjo8h7OVr/HjG
        7Pb5ReSg67E4tna3vlEBena1Gd+iHGfGoaigcG4GVWW/IvpPO6WSMVPLx9Z/gf/9AydlIVNgVnK
        vP5vCz+SHa6pk0wvYx2+SqWiuK0Y=
X-Received: by 2002:a05:622a:586:b0:319:4544:8ea7 with SMTP id c6-20020a05622a058600b0031945448ea7mr2923511qtb.255.1656516882560;
        Wed, 29 Jun 2022 08:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ux4PMFZStEq9RtQwlOmyXgiidBr6KjzPVFn6fLKNd0wDyd8dEvdeQk21pqMqhVWTXWB9N+4g==
X-Received: by 2002:a05:622a:586:b0:319:4544:8ea7 with SMTP id c6-20020a05622a058600b0031945448ea7mr2923492qtb.255.1656516882347;
        Wed, 29 Jun 2022 08:34:42 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a414c00b006aefe22d75bsm12995168qko.80.2022.06.29.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:34:41 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:34:40 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Song Chen <chensong_2000@189.cn>, linux-rt-users@vger.kernel.org,
        williams@redhat.com
Subject: Re: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
In-Reply-To: <20220629065848.zpppngaem7qqazzf@beryllium.lan>
Message-ID: <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com>
References: <1655448052-12537-1-git-send-email-chensong_2000@189.cn> <20220629065848.zpppngaem7qqazzf@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 29 Jun 2022, Daniel Wagner wrote:

> Hi,
> 
> On Fri, Jun 17, 2022 at 02:40:52PM +0800, Song Chen wrote:
> >  static void usage(int error)
> > @@ -689,6 +697,7 @@ static void usage(int error)
> >  	       "                           (default 500us).\n"
> >  	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
> >  	       "-q       --quiet           print a summary only on exit\n"
> > +	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> 
> Please also consider to update the man pages.

@Song Chen, You can send that as an extra patch, but this is a good point, 
please update the man page as well.

@Danel Wagner, is that just a comment or would you like a Reviewed-by ?

