Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B5C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Jun 2022 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiF1Qae (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348442AbiF1Q3s (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7F33AA7A
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1k3CBwOlDNKLLgVJWLqKeFaKpZTZnO4zAu76Qx9GG0o=;
        b=T6SUE3v/UmAusFMCs/XvzNt4AwfIQypqqoPAeajwWcziDRZIp5QnB4wnUIRexk7BNFsWGy
        HxC0IeJtn0UeVDLsZbrfeRqWIYHKz0asRIbEtoP0TCkCjkQa/J4sFufTA4Zuv6jMtjtMqZ
        Hup7rQqwDP85jBAzoI7gVaZuZYifl0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-60LwNF-dOoqC-tzyN2uarg-1; Tue, 28 Jun 2022 12:21:24 -0400
X-MC-Unique: 60LwNF-dOoqC-tzyN2uarg-1
Received: by mail-wr1-f70.google.com with SMTP id z11-20020a056000110b00b0021b9c009d09so1934093wrw.17
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1k3CBwOlDNKLLgVJWLqKeFaKpZTZnO4zAu76Qx9GG0o=;
        b=Gnb3ENKWAU1bYOZM5yEvv0nV8HLONMITrnWE/RzBkB5JvZy3/K4Zdq3nZ3mz6DV+zJ
         1WJ4RgPSA2vgy+e18KL+Jz+kTNxUQGVEyT/T1IWVx12qgxE+81BLk97gfSLoDg3Ns549
         RdBD3WatAYXatcsvlsKKrYrtpGdTNOpAfVSRBM8dcERBxARJakEMewErqMytPVoM1X4w
         1BQzjuvSsr5ldoRPgZMc5FJlh33B8yo9TvRr+QVDJ5HnfZ3wzu1VUuvLCdCjcyqe5ypr
         /i2f+t7LBXa5zfFYA6FEbNAAlX/yEsygbOoxMRMASuXpaJ/vzYwK9PwhBPatgbRxQH8I
         mpfw==
X-Gm-Message-State: AJIora/DBlt0PrTqGEAan0dyuEQf/i48+aGvqJhplZaa5upGGVaMio+3
        beCt5/nvksFKMtjTcYebcbE/dfJpFs/VzYYkj27hmrQadPC2zq5Q6A3akQ3mlDCvUX2ZJRqTHkN
        hssXISvpoduYZUs8yQmZ8C7nFxQ==
X-Received: by 2002:a05:6000:168b:b0:21b:a2c1:c93d with SMTP id y11-20020a056000168b00b0021ba2c1c93dmr19798234wrd.358.1656433283821;
        Tue, 28 Jun 2022 09:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uu+nFvJHR79Zm6a20l826vX97rS7XFvJDCMz5epAWBPHZ04E38/KxhS9TcdigmR+mZjbPDqg==
X-Received: by 2002:a05:6000:168b:b0:21b:a2c1:c93d with SMTP id y11-20020a056000168b00b0021ba2c1c93dmr19798215wrd.358.1656433283636;
        Tue, 28 Jun 2022 09:21:23 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b0020c5253d907sm14249763wrr.83.2022.06.28.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:21:22 -0700 (PDT)
Date:   Tue, 28 Jun 2022 17:21:22 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v11 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220628162122.v7s3z24icwavur6y@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-11-atomlin@redhat.com>
 <20220627235612.4796c837@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627235612.4796c837@gandalf.local.home>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon 2022-06-27 23:56 -0400, Steven Rostedt wrote:
> > +	preempt_enable();
> 
>         ^^^^^^^^^^^^^^^^^
> 
> This just introduced an unbounded latency and will fail PREEMPT_RT.
> 

Hi Steve,

Sorry about that!

If I understand correctly, there is absolutely no need to explicitly
disable preemption in this context. I will use: rcu_read_lock() and
rcu_read_unlock(), respectively, which will then be suitable for the
preemptible RCU implementation.


Kind regards,

-- 
Aaron Tomlin

