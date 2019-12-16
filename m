Return-Path: <SRS0=nOM3=2G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B56C2D0BF
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF4720717
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcT5yNGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLPRHV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:07:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbfLPRHF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Dec 2019 12:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576516024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qnp2LvVtXecvLaj8OdWuS4c+ef0EeC1JGsyDnvy3Yu8=;
        b=CcT5yNGkqlqR+JZTV4LtANyw76RUBGNIkgGBGzCnVH7V8E9As5fB72C9/v4D839ULBSWRN
        FmMUqLW6ObejIZ/WJy/E8XDz5DB7y8unt0uWmmrTSWcX2pF5c6tR+jhtPCVGEWMiv63Nmv
        eUvcBXz4gEO64Wm6s22gEa1/E7zObnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-tQapaIhlOAeKEAAqGeOM4A-1; Mon, 16 Dec 2019 12:07:02 -0500
X-MC-Unique: tQapaIhlOAeKEAAqGeOM4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DE708017DF;
        Mon, 16 Dec 2019 17:07:01 +0000 (UTC)
Received: from ovpn-116-192.phx2.redhat.com (ovpn-116-192.phx2.redhat.com [10.3.116.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE61D10013D9;
        Mon, 16 Dec 2019 17:07:00 +0000 (UTC)
Message-ID: <4a8207893353c2802f05ebb467749d54a68d2c15.camel@redhat.com>
Subject: Re: [PATCH RT] lib: Check for migrate_disable only on SMP systems
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Date:   Mon, 16 Dec 2019 11:06:58 -0600
In-Reply-To: <20191216152140.bjaohifj43gn22sz@linutronix.de>
References: <20191206142103.29647-1-dwagner@suse.de>
         <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
         <20191206193954.yi5hac366agt7k3o@beryllium.lan>
         <3ce4699f987e784e84b2030aa3a1c529b274b498.camel@redhat.com>
         <20191209100447.codml4nop4ibbjkz@beryllium.lan>
         <1db9c7c960570e975ac0d684d6313ca35a3b1450.camel@redhat.com>
         <20191216152140.bjaohifj43gn22sz@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2019-12-16 at 16:21 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-09 18:40:37 [-0600], Scott Wood wrote:
> > Actually it looks like we're saved from the false positives by the
> > following check for nr_cpus_allowed == 1, which should always be true on
> > UP.
> 
> we currently don't.

Currently don't what?

-Scott


