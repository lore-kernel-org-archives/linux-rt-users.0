Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592DC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F369E60EFD
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 14:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhG3Oof (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:44:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbhG3Ooe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 10:44:34 -0400
Date:   Fri, 30 Jul 2021 16:44:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627656268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Obk0xlNGFeWJnjxke9mybnv4Sy0S07S5bTZ07uUrtpg=;
        b=p3qho+YRTkEeuKJAtLBH49nE3aaKsbFR5DqQzVryI06WDqDTKrc2VjrfZbrPQClF0RBEJz
        qK2odHkmd4mBGHwWHOScIbn8WBGL/5zasHObtod8Vf9gD1cdL9y0eRyAHXXRhyYhHo9vX7
        OISeo2zt+OixN+7DaoVzVvj8KhBF/dF5H0VeTe0ve89uYEyxKZk3sdkmXhcRcfwybtBtwa
        O2u6b9nUtjbV2SziGyp+RlJDwfZKOSoQ+13xaUVuOM37Zfhk+9rOOramxxt5R+lxPDuEoD
        AcbY6mJZF5H8K8BhYT4dQ0rMx9XtDYd1Mdi5sCJlpikFWS29uoWTobqjT7oK7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627656268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Obk0xlNGFeWJnjxke9mybnv4Sy0S07S5bTZ07uUrtpg=;
        b=6RpHHKGV+DyKik911GktwQ3F2LpkESsoSDBi63TGC9prK7lDvpHcpnawZofDGpitpK9M8W
        8Ty4yQaEVIQYg/BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Question on (locking: Make spinlock_t and rwlock_t a RCU section
 on RT)
Message-ID: <20210730144427.357annugmfjap24e@linutronix.de>
References: <BL1PR11MB5478DB9FA9C2BEF56FBFF6AAFFE89@BL1PR11MB5478.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5478DB9FA9C2BEF56FBFF6AAFFE89@BL1PR11MB5478.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-07-26 07:43:33 [+0000], Zhang, Qiang wrote:
> Operation of sleep is not allowed in RCU read critical area,  If
> after acquiring a rt-spinlock , try to acquire another one
> rt-spinlock,  This may cause sleep, and trigger RCU warning.  
> 
> Is there a problem with my analysis or something I missed?

This warning is suppressed on RT. Same as on CONFIG_PREEMPT when a task
gets preempted while in a rcu_read_lock() section.

> Thanks
> Qiang

Sebastian
