Return-Path: <SRS0=Qk+l=Z4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E517C43603
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1924924670
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 18:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXXS3L/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLFStS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:49:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfLFStS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Dec 2019 13:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575658157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RjneYL86zxVRWZ7hSOGs/tSwo4GNBTmrivRcDCeKOE=;
        b=AXXS3L/Lf7adHf9TeygB1XOIXGKZRVvPNhqyVS8u2XWiO5Xiet4AKPmpr3TLH5meEgWKOz
        aVuMJUEAYE1bPpzsT5Or+V66FTjKsEhioQIpzcpOFMOZMsBZHgbjX2kzyHBUBeY7H8E1Hp
        /ckKAYQBmA2o5StVm/MIe3JSt0dPsl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-8Zk95cTxPoS0kJ4Iuw1mkg-1; Fri, 06 Dec 2019 13:49:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E31618B6380;
        Fri,  6 Dec 2019 18:49:13 +0000 (UTC)
Received: from ovpn-116-192.phx2.redhat.com (ovpn-116-192.phx2.redhat.com [10.3.116.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C1FC5D9C9;
        Fri,  6 Dec 2019 18:49:13 +0000 (UTC)
Message-ID: <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
Subject: Re: [PATCH] lib: Check for migrate_disable only on SMP systems
From:   Scott Wood <swood@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri, 06 Dec 2019 12:49:12 -0600
In-Reply-To: <20191206142103.29647-1-dwagner@suse.de>
References: <20191206142103.29647-1-dwagner@suse.de>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8Zk95cTxPoS0kJ4Iuw1mkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2019-12-06 at 15:21 +0100, Daniel Wagner wrote:
> In case the kernel configuration is UP is, the migrate_disable member
> in task_struct is missing.
>=20
> linux/lib/smp_processor_id.c: In function =E2=80=98check_preemption_disab=
led=E2=80=99:
> linux/lib/smp_processor_id.c:26:13: error: =E2=80=98struct task_struct=E2=
=80=99 has no
> member named =E2=80=98migrate_disable=E2=80=99
>     26 |  if (current->migrate_disable)
>        |             ^~
>=20
> Fixes: 425c5b38779a ("sched: Lazy migrate_disable processing")
> Cc: Scott Wood <swood@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  lib/smp_processor_id.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
> index 5f2618d346c4..a914f73e3652 100644
> --- a/lib/smp_processor_id.c
> +++ b/lib/smp_processor_id.c
> @@ -23,8 +23,10 @@ unsigned int check_preemption_disabled(const char
> *what1, const char *what2)
>  =09 * Kernel threads bound to a single CPU can safely use
>  =09 * smp_processor_id():
>  =09 */
> +#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
>  =09if (current->migrate_disable)
>  =09=09goto out;
> +#endif

Won't this give false positives on UP with CONFIG_PREEMPT_RT_BASE and
CONFIG_DEBUG_PREEMPT?  If we have CONFIG_SCHED_DEBUG then we can still chec=
k
migrate_disable.  Without that, we don't have enough information to tell
whether it's safe to do smp_processor_id() and would have to skip
check_preemption_disabled() entirely.

-Scott


